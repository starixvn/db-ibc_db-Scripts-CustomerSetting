 /*
	Created: Johnson
	Date: 2020-03-04
	Task: correct pt when update minpt for super under RM currency
	DB: DBCUST/CUSTDB
 */
ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_08]
	@CustID INT = 0
	,@SuperID INT = 0
	,@MasterID INT = 0
	,@AgentID INT = 0
	,@RoleID INT
	,@SportBettypeXML NVARCHAR(MAX) = ''
	,@Target VARCHAR(20) = ''
AS
/*
   clone from Acc_DynamicCustSetting3rd_04 

*/
BEGIN
	SET NOCOUNT ON
	IF (@target = 'REPLICATED' AND @@SERVERNAME  IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2') ) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only

	IF dbo.f_CheckRepTable('custinfo') = 0 RETURN
	IF dbo.f_CheckRepTable('CustPTSetting3rd_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustPTSetting3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustPTGroupSetting3rd_Member') = 0 RETURN
	
	DECLARE @tmpSportBettype TABLE(sporttype SMALLINT, bettype SMALLINT, islive BIT)
	DECLARE @_SuperID INT, @_MasterID INT, @_AgentID INT

	-- declare variable table to keep super's settings 
	DECLARE @temp_sag TABLE (custid int, bettype smallint, sporttype smallint, islive bit,
		a4 smallmoney, m4 smallmoney, s4 smallmoney, n4 smallmoney, l4 smallmoney
		UNIQUE CLUSTERED (custid, sporttype, bettype, islive)
	)
	
	-- declare variable table to keep master's settings 
	DECLARE @temp_mag TABLE (custid int, bettype smallint, sporttype smallint, islive bit,
		a3 smallmoney, m3 smallmoney, s3 smallmoney, u3 smallmoney, i3 bit, n3 smallmoney, l3 smallmoney
		UNIQUE CLUSTERED (custid, sporttype, bettype, islive)
	)

	DECLARE @a2 smallmoney, @m2 smallmoney, @s2 smallmoney, @n2 smallmoney, @l2 smallmoney
	DECLARE @im2 bit, @um2 smallmoney
	DECLARE @a1 smallmoney, @m1 smallmoney, @s1 smallmoney, @i1 bit, @u1 smallmoney, @im1 bit, @um1 smallmoney
	DECLARE @temp1 smallmoney, @temp2 smallmoney, @temp3 smallmoney
	DECLARE @s_new smallmoney, @m_new smallmoney, @a_new smallmoney
	---------------------------------

	SELECT @_SuperID = @SuperID, @_MasterID = @MasterID, @_AgentID = @AgentID

	INSERT INTO @tmpSportBettype (sporttype, bettype, islive)
	SELECT SportType,Bettype,IsLive
	FROM dbo.f_DCS_PT_XMLParse(@SportBetTypeXML)

	INSERT INTO @temp_sag (custid, bettype, sporttype, islive, a4, m4, s4, n4, l4)
	SELECT scs.custid, scs.bettype, scs.sporttype, scs.IsLive, scs.AgentPT, scs.MasterPT, scs.SuperPT, scs.MinPT, scs.MaxPT
	FROM dbo.CustPTSetting3rd_Agent scs WITH(NOLOCK)
		INNER JOIN @tmpSportBettype tmp ON tmp.sporttype = scs.SportType AND tmp.bettype = scs.BetType AND tmp.islive = scs.IsLive
	WHERE scs.custid = @_SuperID

	IF @RoleID = 4
	BEGIN
		INSERT INTO @temp_mag (custid, bettype, sporttype, islive, a3, m3, s3, u3, i3, n3, l3)
		SELECT mcs.custid, mcs.bettype, mcs.sporttype, mcs.IsLive, mcs.AgentPT, mcs.MasterPT, mcs.SuperPT, mcs.AutoSuperPT, mcs.IsAutoSuperPT, mcs.MinPT, mcs.MaxPT
		FROM dbo.custinfo c WITH(NOLOCK)
			INNER JOIN dbo.CustPTSetting3rd_Agent mcs WITH(NOLOCK) ON c.custid = mcs.custid
			INNER JOIN @tmpSportBettype tmp ON tmp.sporttype = mcs.SportType AND tmp.bettype = mcs.BetType AND tmp.islive = mcs.IsLive
		WHERE c.srecommend = @_SuperID AND c.roleid = 3

		CREATE TABLE #tblCust (custid INT, isFinished BIT DEFAULT 0)	
		DECLARE @tmp TABLE (custid INT)
		
		INSERT INTO #tblCust (custid)
		SELECT custid 
		FROM custinfo WITH(NOLOCK)
		WHERE srecommend = @_SuperID
			AND roleid = 1
			AND enabled = 1
		
		--*** START: update PT on member ***-----------------------
		WHILE(1=1)
		BEGIN
			DELETE @tmp
			
			UPDATE TOP (200) t 			
			SET isFinished = 1
			OUTPUT DELETED.custid INTO @tmp
			FROM #tblCust t
			WHERE isFinished = 0
			
			IF @@ROWCOUNT = 0
				BREAK;				
				
			UPDATE cs
			SET @a1 = cs.AgentPT
				,@m1 = cs.MasterPT
				,@s1 = cs.SuperPT
				,@n2 = acs.MinPT
				,@l2 = acs.MaxPT
				,@im2 = acs.IsAutoMasterPT
				,@um2 = acs.AutoMasterPT
				,@i1 = cs.IsAutoSuperPT
				,@u1 = cs.AutoSuperPT
				,@im1 = cs.IsAutoMasterPT
				,@um1 = cs.AutoMasterPT
				
				-- rule #1: s1 = min(s1,s4-m3) if i=0
				,@s1 = CASE WHEN @i1 = 0 AND m.i3 = 0 AND s.s4-m.m3 < @s1 THEN s.s4-m.m3 ELSE @s1 END

				-- rule #2: a1 = max(a1,n2); m1 = (a1<n2) ? m3-n2 : m1 --agent min
				,@a_new = CASE WHEN @a1 < @n2 THEN @n2 ELSE @a1 END
				,@m_new = CASE WHEN @a1 < @n2 AND @m1+@n2 > m.m3 THEN m.m3-@n2 ELSE @m1 END
				,@a1 = @a_new
				,@m1 = @m_new								

				-- rule #3: a1 = min(a1,l2) -- agent max         
				,@a1 = CASE WHEN @a1 > @l2 THEN @l2 ELSE @a1 END

				-- rule #4: m1 = min(m3-a1,u2) if master auto -- Recalculate AUTO MPT 
				,@temp1 = CASE WHEN @im1 = 1 THEN @um1 ELSE @um2 END			
				,@m1 = CASE 
							WHEN @im2 = 1 OR @im1 = 1 
							THEN CASE WHEN m.m3-@a1 > @temp1 THEN @temp1 ELSE m.m3-@a1 END 
							ELSE @m1 
						END		

				-- rule #5: m1 = max(m1,n3-a1) -- master min   
				,@m1 = CASE WHEN @m1 < m.n3-@a1 THEN m.n3-@a1 ELSE @m1 END
						 
				-- rule #6: check master max 
				/*	@x1 = min(m3,l3) -- mpt max
					@x2 = max(@x1-a1,0) --mpt
					m1 = (a1+m1>l3) ? @x2 : m1
					@x3 = (a1+@x2 > @x1) ? @x1-@x2 : a1
					a1 = (a1+m1>l1) ? max(@x3, n2) : a1
				*/ 
				,@temp1 = CASE WHEN m.m3 > m.l3 THEN m.l3 ELSE m.m3 END
				,@temp2 = CASE WHEN @temp1-@a1 < 0 THEN 0 ELSE @temp1-@a1 END
				,@m_new = CASE WHEN @a1+@m1 > m.l3 THEN @temp2 ELSE @m1 END
				,@temp3 = CASE WHEN @a1+@temp2 > @temp1 THEN @temp1-@temp2 ELSE @a1 END
				,@a_new = CASE 
							WHEN @a1+@m1 > m.l3 
							THEN CASE WHEN @temp3 < @n2 THEN @n2 ELSE @temp3 END
							ELSE @a1 
						END	
					
				,@m1 = @m_new
				,@a1 = @a_new
				-- rule #7: s1 = min(s4-m1-a1, i1?u1:u3) --Recalculate auto pt
				/*
					@x1 = (i1=1) ? u1 : u3
					s1 = (s4-m1-a1 > @x1) ? @x1 : s4-m1-a1 
				*/
				,@temp1 = CASE WHEN @i1 = 1 THEN @u1 ELSE m.u3 END			
				,@s1 = CASE 
							WHEN @i1 = 1 OR m.i3 = 1 
							THEN CASE WHEN s.s4-@m1-@a1 > @temp1 THEN @temp1 ELSE s.s4-@m1-@a1 END
							ELSE @s1
						END		

				-- rule #8: s1 = max(n4-m1-a1,s1) --super min
				,@s1 = CASE WHEN @a1+@m1+@s1 < s.n4 THEN s.n4-@m1-@a1 ELSE @s1 END	

				-- rule #9: UPDATE s1,m1,a1 in case s1+m1+a1>s4
				/* -- explanation
					@x1 = (s4-m1-a1 < 0) ? 0 : s4-m1-a1
					s1 = (s1+a1+m1 > s4) ? @x1 : s1
					@x1 = (@x1+m1+a1 > s4) ? s4-@x1 : m1+a1
					@x2 = (m3 > l3) ? l3 : m3
					@x2 = (@x1 > @x2) ? @x2 : @x1
					@x2 = (@x2 < n3) ? n3 : @x2
					@x3 = (@x2-a1 < 0) ? 0 : @x2-a1
					m1 = (s1+a1+m1 > s4) ? @x3 : m1
					@x3 = (a1+@x3>@x2) ? @x2-@x3 : a1
					@x3 =  (@x3 < n2) ? n2 : @x3
					a1 = (s1+a1+m1 > s4) ? @x3 : a1				
				*/             
				,@temp1 = CASE WHEN s.s4-@m1-@a1 < 0 THEN 0 ELSE s.s4-@m1-@a1 END
				,@s_new = CASE WHEN @s1+@a1+@m1 > s.s4 THEN @temp1 ELSE @s1 END
				,@temp1 = CASE WHEN @temp1+@m1+@a1 > s.s4 THEN s.s4-@temp1 ELSE @m1+@a1 END
				,@temp2 = CASE WHEN m.m3 > m.l3 THEN m.l3 ELSE m.m3 END
				,@temp2 = CASE WHEN @temp1 > @temp2 THEN @temp2 ELSE @temp1 END
				,@temp2 = CASE WHEN @temp2 < m.n3 THEN m.n3 ELSE @temp2 END
				,@temp3 = CASE WHEN @temp2-@a1 < 0 THEN 0 ELSE @temp2-@a1 END
				,@m_new = CASE WHEN @s1+@a1+@m1 > s.s4 THEN @temp3 ELSE @m1 END
				,@temp3 = CASE WHEN @a1+@temp3 > @temp2 THEN @temp2-@temp3 ELSE @a1 END
				,@temp3 = CASE WHEN @temp3 < @n2 THEN @n2 ELSE @temp3 END
				,@a_new = CASE WHEN @s1+@a1+@m1 > s.s4 THEN @temp3 ELSE @a1 END
				,@s1 = @s_new
				,@m1 = @m_new
				,@a1 = @a_new
				
				--PT values must be in [0,100]
				,@s1 = CASE WHEN @s1 < 0 THEN 0 ELSE @s1 END
				,@s1 = CASE WHEN @s1 > 100 THEN 100 ELSE @s1 END
				,@m1 = CASE WHEN @m1 < 0 THEN 0 ELSE @m1 END
				,@m1 = CASE WHEN @m1 > 100 THEN 100 ELSE @m1 END
				,@a1 = CASE WHEN @a1 < 0 THEN 0 ELSE @a1 END
				,@a1 = CASE WHEN @a1 > 100 THEN 100 ELSE @a1 END
			
				--------------------------------	
				-- done apply all rule, then update to destination table
				,cs.AgentPT = @a1
				,cs.MasterPT = @m1
				,cs.SuperPT = @s1								       
			FROM dbo.custinfo c WITH(NOLOCK)
				INNER JOIN dbo.CustPTSetting3rd_Member cs WITH(ROWLOCK, UPDLOCK) ON c.custid = cs.custid
				INNER JOIN dbo.CustPTSetting3rd_Agent acs WITH(NOLOCK) on c.recommend = acs.custid AND cs.sporttype = acs.sporttype AND cs.bettype = acs.bettype AND cs.IsLive = acs.IsLive
				INNER JOIN @temp_mag m ON c.mrecommend = m.custid AND cs.sporttype = m.sporttype AND cs.bettype = m.bettype AND cs.IsLive = m.IsLive
				INNER JOIN @temp_sag s ON c.srecommend = s.custid AND cs.sporttype = s.sporttype AND cs.bettype = s.bettype AND cs.IsLive = s.IsLive
			WHERE 
				--c.srecommend = @_SuperID AND c.roleid = 1 and c.enabled = 1
				c.custid IN (SELECT custid FROM @tmp)		
		END	
		--*** END: update PT on member ***-------------------------		

		--*** START: update PT group on member ***-----------------------	
		UPDATE cs
		SET @a1 = cs.AgentPT
			,@m1 = cs.MasterPT
			,@s1 = cs.SuperPT
			,@n2 = acs.MinPT
			,@l2 = acs.MaxPT
			,@im2 = acs.IsAutoMasterPT
			,@um2 = acs.AutoMasterPT
			,@i1 = cs.IsAutoSuperPT
			,@u1 = cs.AutoSuperPT
			,@im1 = cs.IsAutoMasterPT
			,@um1 = cs.AutoMasterPT
			
			-- rule #1: s1 = min(s1,s4-m3) if i=0
			,@s1 = CASE WHEN @i1 = 0 AND m.i3 = 0 AND s.s4-m.m3 < @s1 THEN s.s4-m.m3 ELSE @s1 END

			-- rule #2: a1 = max(a1,n2); m1 = (a1<n2) ? m3-n2 : m1 --agent min
			,@a_new = CASE WHEN @a1 < @n2 THEN @n2 ELSE @a1 END
			,@m_new = CASE WHEN @a1 < @n2 AND @m1+@n2 > m.m3 THEN m.m3-@n2 ELSE @m1 END
			,@a1 = @a_new
			,@m1 = @m_new								

			-- rule #3: a1 = min(a1,l2) -- agent max         
			,@a1 = CASE WHEN @a1 > @l2 THEN @l2 ELSE @a1 END

			-- rule #4: m1 = min(m3-a1,u2) if master auto -- Recalculate AUTO MPT 
			,@temp1 = CASE WHEN @im1 = 1 THEN @um1 ELSE @um2 END			
			,@m1 = CASE 
						WHEN @im2 = 1 OR @im1 = 1 
						THEN CASE WHEN m.m3-@a1 > @temp1 THEN @temp1 ELSE m.m3-@a1 END 
						ELSE @m1 
					END		

			-- rule #5: m1 = max(m1,n3-a1) -- master min   
			,@m1 = CASE WHEN @m1 < m.n3-@a1 THEN m.n3-@a1 ELSE @m1 END
			         
			-- rule #6: check master max 
			/*	@x1 = min(m3,l3) -- mpt max
				@x2 = max(@x1-a1,0) --mpt
				m1 = (a1+m1>l3) ? @x2 : m1
				@x3 = (a1+@x2 > @x1) ? @x1-@x2 : a1
				a1 = (a1+m1>l1) ? max(@x3, n2) : a1
			*/ 
			,@temp1 = CASE WHEN m.m3 > m.l3 THEN m.l3 ELSE m.m3 END
			,@temp2 = CASE WHEN @temp1-@a1 < 0 THEN 0 ELSE @temp1-@a1 END
			,@m_new = CASE WHEN @a1+@m1 > @temp1 THEN @temp2 ELSE @m1 END
			,@temp3 = CASE WHEN @a1+@temp2 > @temp1 THEN @temp1-@temp2 ELSE @a1 END
			,@a_new = CASE 
						WHEN @a1+@m1 > @temp1 
						THEN CASE WHEN @temp3 < @n2 THEN @n2 ELSE @temp3 END
						ELSE @a1 
					END	
				
			,@m1 = @m_new
			,@a1 = @a_new
			-- rule #7: s1 = min(s4-m1-a1, i1?u1:u3) --Recalculate auto pt
			/*
				@x1 = (i1=1) ? u1 : u3
				s1 = (s4-m1-a1 > @x1) ? @x1 : s4-m1-a1 
			*/
			,@temp1 = CASE WHEN @i1 = 1 THEN @u1 ELSE m.u3 END			
			,@s1 = CASE 
						WHEN @i1 = 1 OR m.i3 = 1 
						THEN CASE WHEN s.s4-@m1-@a1 > @temp1 THEN @temp1 ELSE s.s4-@m1-@a1 END
						ELSE @s1
					END		

			-- rule #8: s1 = max(n4-m1-a1,s1) --super min
			,@s1 = CASE WHEN @a1+@m1+@s1 < s.n4 THEN s.n4-@m1-@a1 ELSE @s1 END	

			-- rule #9: UPDATE s1,m1,a1 in case s1+m1+a1>s4
			/* -- explanation
				@x1 = (s4-m1-a1 < 0) ? 0 : s4-m1-a1
				s1 = (s1+a1+m1 > s4) ? @x1 : s1
				@x1 = (@x1+m1+a1 > s4) ? s4-@x1 : m1+a1
				@x2 = (m3 > l3) ? l3 : m3
				@x2 = (@x1 > @x2) ? @x2 : @x1
				@x2 = (@x2 < n3) ? n3 : @x2
				@x3 = (@x2-a1 < 0) ? 0 : @x2-a1
				m1 = (s1+a1+m1 > s4) ? @x3 : m1
				@x3 = (a1+@x3>@x2) ? @x2-@x3 : a1
				@x3 =  (@x3 < n2) ? n2 : @x3
				a1 = (s1+a1+m1 > s4) ? @x3 : a1				
			*/             
			,@temp1 = CASE WHEN s.s4-@m1-@a1 < 0 THEN 0 ELSE s.s4-@m1-@a1 END
			,@s_new = CASE WHEN @s1+@a1+@m1 > s.s4 THEN @temp1 ELSE @s1 END
			,@temp1 = CASE WHEN @temp1+@m1+@a1 > s.s4 THEN s.s4-@temp1 ELSE @m1+@a1 END
			,@temp2 = CASE WHEN m.m3 > m.l3 THEN m.l3 ELSE m.m3 END
			,@temp2 = CASE WHEN @temp1 > @temp2 THEN @temp2 ELSE @temp1 END
			,@temp2 = CASE WHEN @temp2 < m.n3 THEN m.n3 ELSE @temp2 END
			,@temp3 = CASE WHEN @temp2-@a1 < 0 THEN 0 ELSE @temp2-@a1 END
			,@m_new = CASE WHEN @s1+@a1+@m1 > s.s4 THEN @temp3 ELSE @m1 END
			,@temp3 = CASE WHEN @a1+@temp3 > @temp2 THEN @temp2-@temp3 ELSE @a1 END
			,@temp3 = CASE WHEN @temp3 < @n2 THEN @n2 ELSE @temp3 END
			,@a_new = CASE WHEN @s1+@a1+@m1 > s.s4 THEN @temp3 ELSE @a1 END
			,@s1 = @s_new
			,@m1 = @m_new
			,@a1 = @a_new
			
			--PT values must be in [0,100]
			,@s1 = CASE WHEN @s1 < 0 THEN 0 ELSE @s1 END
			,@s1 = CASE WHEN @s1 > 100 THEN 100 ELSE @s1 END
			,@m1 = CASE WHEN @m1 < 0 THEN 0 ELSE @m1 END
			,@m1 = CASE WHEN @m1 > 100 THEN 100 ELSE @m1 END
			,@a1 = CASE WHEN @a1 < 0 THEN 0 ELSE @a1 END
			,@a1 = CASE WHEN @a1 > 100 THEN 100 ELSE @a1 END
			--------------------------------	
			-- done apply all rule, then update to destination table
			,cs.AgentPT = @a1
			,cs.MasterPT = @m1
			,cs.SuperPT = @s1								       
		FROM dbo.custinfo c WITH(NOLOCK)
			INNER JOIN dbo.CustPTGroupSetting3rd_Member cs WITH(ROWLOCK, UPDLOCK) ON c.custid = cs.AgentID
			INNER JOIN dbo.CustPTSetting3rd_Agent acs WITH(NOLOCK) on c.recommend = acs.custid AND cs.sporttype = acs.sporttype AND cs.bettype = acs.bettype AND cs.IsLive = acs.IsLive
			INNER JOIN @temp_mag m ON c.mrecommend = m.custid AND cs.sporttype = m.sporttype AND cs.bettype = m.bettype AND cs.IsLive = m.IsLive
			INNER JOIN @temp_sag s ON c.srecommend = s.custid AND cs.sporttype = s.sporttype AND cs.bettype = s.bettype AND cs.IsLive = s.IsLive
		WHERE c.srecommend = @_SuperID AND c.roleid = 2 and c.enabled = 1
		--*** END: update PT group on member ***-------------------------		
	END	
END
GO