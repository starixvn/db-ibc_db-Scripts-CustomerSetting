/*<info serverAlias="DBCUST-CustDB"></info>*/

/*
	Created: Johnson
	Date: 20220419
	Task: Adjust PT NG for 755555
	DB: DBCust/CustDB
*/
ALTER PROCEDURE [dbo].[Acc_CustSetting3rd_18] 
	@srecommend INT = 0,    
	@Target VARCHAR(20) = ''
	
AS
/*
    Clone FROM Acc_CustSetting3rd_07, Acc_CustSetting3rd_01, Acc_CustSetting3rd_04
*/
BEGIN
	SET NOCOUNT ON

	IF (@target = 'REPLICATED' AND @@SERVERNAME  IN ('DBCUST','SITDBCUST','TESTDBCUST') ) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','TESTDBCUST')) RETURN -- run at dbcust only
	
	IF NOT(dbo.f_CheckRepTable('custinfo') = 1 	   
	    AND dbo.f_CheckRepTable('CustSetting3rd') = 1 
	    AND dbo.f_CheckRepTable('CustOverride3rd') = 1 
	    )
	   RETURN
	     
    CREATE TABLE #tblCust(custid INT, recommend INT, mrecommend INT, IsUpdatedS4 BIT DEFAULT 0, IsUpdatedL4 BIT DEFAULT 0, IsUpdatedN4 BIT DEFAULT 0)
	
	DECLARE @tmpSAg TABLE(
						sporttype INT, 
						bettype INT, 
						spositiontaking SMALLMONEY,
						slivepositiontaking SMALLMONEY,
						minpositiontaking SMALLMONEY,
						minlivepositiontaking SMALLMONEY,
						maxpositiontaking SMALLMONEY,
						maxlivepositiontaking SMALLMONEY
						)
	
	INSERT INTO #tblCust(custid,mrecommend)
	SELECT custid,mrecommend
	FROM custinfo c WITH(NOLOCK) 
	WHERE c.srecommend = @srecommend
	   AND c.roleid = 1
	   AND c.Enabled = 1
	
	DECLARE @tmp TABLE (custid INT PRIMARY KEY, mrecommend INT)
	
	DECLARE @PT SMALLMONEY = 0.85
	
	-------------------------------------------------------------------------------------------
	--Update s4
	
	UPDATE custsetting3rd with (ROWLOCK, UPDLOCK)
    SET
        spositiontaking = CASE WHEN bettype IN (81,83,86,88) AND spositiontaking < @PT then @PT else spositiontaking end,                        
        slivepositiontaking = CASE WHEN bettype IN(85,86,87,89,90) AND slivepositiontaking < @PT then @PT else slivepositiontaking end,
		mpositiontaking = CASE WHEN bettype IN (81,83,86,88) AND spositiontaking < @PT then @PT - spositiontaking + mpositiontaking else mpositiontaking end,                        
        mlivepositiontaking = CASE WHEN bettype IN(85,86,87,89,90) AND slivepositiontaking < @PT then @PT - slivepositiontaking + mlivepositiontaking else mlivepositiontaking end,		
		apositiontaking = CASE WHEN bettype IN (81,83,86,88) AND spositiontaking < @PT then @PT - spositiontaking + apositiontaking else apositiontaking end,                        
        alivepositiontaking = CASE WHEN bettype IN(85,86,87,89,90) AND slivepositiontaking < @PT then @PT - slivepositiontaking + alivepositiontaking else alivepositiontaking end
    WHERE custid=@srecommend AND sporttype = 161
		AND 1 = CASE WHEN (bettype IN (81,83,86,88) AND spositiontaking < @PT) 
					OR (bettype IN (85,86,87,89,90) AND slivepositiontaking < @PT) THEN 1 ELSE 0 END
    
	IF @@ROWCOUNT = 0
		RETURN
	
	INSERT INTO @tmpSAg(sporttype,bettype,spositiontaking,slivepositiontaking,minpositiontaking,minlivepositiontaking)  
	SELECT scs.sporttype, scs.bettype,spositiontaking,slivepositiontaking,minpositiontaking,minlivepositiontaking
	FROM custsetting3rd scs WITH(NOLOCK)
		INNER JOIN CustOverride3rd sco WITH(NOLOCK) ON scs.custid = sco.custid
												AND scs.sporttype = sco.sporttype
												AND scs.bettype = sco.bettype
	WHERE scs.custid = @srecommend
		AND scs.sporttype = 161
	
	--Correct PT when update s4
	WHILE(1=1)
	BEGIN
		DELETE @tmp
	
		UPDATE TOP (1000) t 	--8 rows settings for each member		
		SET IsUpdatedS4 = 1
		OUTPUT DELETED.custid, DELETED.mrecommend INTO @tmp(custid,mrecommend)
		FROM #tblCust t
		WHERE IsUpdatedS4 = 0
	
		IF @@ROWCOUNT = 0
			BREAK;	
		
		--u = (i3 or i1)?(u3 or u1)
		--s1 = min(s4-m1-a1, u)        
		--v161
		UPDATE cs3 
			SET spositiontaking = case when scs3.spositiontaking-cs3.mpositiontaking-cs3.apositiontaking >
									(case when cs3.isautopositiontaking=1 then cs3.autopositiontaking else mcs3.autopositiontaking end) then (case when cs3.isautopositiontaking=1 then cs3.autopositiontaking else mcs3.autopositiontaking end) else scs3.spositiontaking-cs3.mpositiontaking-cs3.apositiontaking end 
		FROM (SELECT c.custid, c.mrecommend, scs3.*
			FROM @tmp c
				CROSS JOIN @tmpSAg scs3 
			)scs3
		CROSS APPLY (SELECT TOP 1 isautopositiontaking,autopositiontaking
					FROM custsetting3rd mcs3 WITH(NOLOCK)
					WHERE  mcs3.custid = scs3.mrecommend
					   AND mcs3.sporttype = scs3.sporttype
					   AND mcs3.bettype = scs3.bettype
					)mcs3
		CROSS APPLY (SELECT TOP 1 spositiontaking, mpositiontaking, apositiontaking, isautopositiontaking,autopositiontaking
					FROM custsetting3rd cs3 WITH(UPDLOCK,ROWLOCK)
					WHERE  cs3.custid = scs3.custid
					   AND cs3.sporttype = scs3.sporttype
					   AND cs3.bettype = scs3.bettype
					   AND (cs3.isautopositiontaking = 1
							OR mcs3.isautopositiontaking = 1)
					)cs3
		
		--check super min
		--s1=max(n4-m1-a1,s1)
		UPDATE cs
		   SET spositiontaking = sco.minpositiontaking - cs.mpositiontaking - cs.apositiontaking
		FROM (SELECT c.custid, sco.*
			FROM @tmp c
				CROSS JOIN @tmpSAg sco 
		)sco		
		CROSS APPLY (SELECT TOP 1 spositiontaking, mpositiontaking, apositiontaking
					FROM custsetting3rd cs WITH(UPDLOCK,ROWLOCK)
					WHERE  cs.custid = sco.custid
					   AND cs.sporttype = sco.sporttype
					   AND cs.bettype = sco.bettype
					   AND cs.apositiontaking + cs.mpositiontaking + cs.spositiontaking < sco.minpositiontaking
					)cs
		
		--v161 
		UPDATE cs3 
			SET slivepositiontaking = case when scs3.slivepositiontaking-cs3.mlivepositiontaking-cs3.alivepositiontaking >
									(case when cs3.isautolivepositiontaking=1 then cs3.autolivepositiontaking else mcs3.autolivepositiontaking end) then (case when cs3.isautolivepositiontaking=1 then cs3.autolivepositiontaking else mcs3.autolivepositiontaking end) else scs3.slivepositiontaking-cs3.mlivepositiontaking-cs3.alivepositiontaking end 
		FROM (SELECT c.custid, c.mrecommend, scs3.*
			FROM @tmp c
				CROSS JOIN @tmpSAg scs3 
			)scs3
		CROSS APPLY (SELECT TOP 1 autolivepositiontaking,isautolivepositiontaking
					FROM custsetting3rd mcs3 WITH(NOLOCK)
					WHERE  mcs3.custid = scs3.mrecommend
					   AND mcs3.sporttype = scs3.sporttype
					   AND mcs3.bettype = scs3.bettype
					)mcs3
		CROSS APPLY (SELECT TOP 1 slivepositiontaking, mlivepositiontaking, alivepositiontaking, autolivepositiontaking, isautolivepositiontaking
					FROM custsetting3rd cs3 WITH(UPDLOCK,ROWLOCK)
					WHERE  cs3.custid = scs3.custid
					   AND cs3.sporttype = scs3.sporttype
					   AND cs3.bettype = scs3.bettype
					   AND (cs3.isautolivepositiontaking = 1
							OR mcs3.isautolivepositiontaking = 1)
					)cs3
		
		UPDATE cs3
		   SET slivepositiontaking = sco.minlivepositiontaking - cs3.mlivepositiontaking - cs3.alivepositiontaking
		FROM (SELECT c.custid, c.mrecommend, sco.*
			FROM @tmp c
				CROSS JOIN @tmpSAg sco 
			)sco			
		CROSS APPLY (SELECT TOP 1 slivepositiontaking, mlivepositiontaking, alivepositiontaking
					FROM custsetting3rd cs3 WITH(UPDLOCK,ROWLOCK)
					WHERE  cs3.custid = sco.custid
					   AND cs3.sporttype = sco.sporttype
					   AND cs3.bettype = sco.bettype
					   AND cs3.alivepositiontaking + cs3.mlivepositiontaking + cs3.slivepositiontaking < sco.minlivepositiontaking
					)cs3   
	END	
	-------------------------------------------------------------------------------------------
	--update l4 = 0.85, n4 = 0.85		
	
	UPDATE custoverride3rd with (ROWLOCK, UPDLOCK)
    SET
        maxpositiontaking = CASE WHEN bettype IN (81,83,86,88) AND maxpositiontaking < @PT then @PT else maxpositiontaking end,                        
        maxlivepositiontaking = CASE WHEN bettype IN(85,86,87,89,90) AND maxlivepositiontaking < @PT then @PT else maxlivepositiontaking end,
		minpositiontaking = CASE WHEN bettype IN (81,83,86,88) AND minpositiontaking < @PT then @PT else minpositiontaking end,                        
        minlivepositiontaking = CASE WHEN bettype IN(85,86,87,89,90) AND minlivepositiontaking < @PT then @PT else minlivepositiontaking end
    WHERE custid=@srecommend AND sporttype = 161
	
	declare @mpos smallmoney, @apos smallmoney, @spos smallmoney, @mapos1 smallmoney, @mapos2 smallmoney, @mapos smallmoney, @maxmapos smallmoney
	
	--Correct when update l4
	--clone from sp Acc_CustSetting3rd_01
	WHILE (1=1)
	BEGIN
		DELETE @tmp
	
		UPDATE TOP (1000) t 	--8 rows settings for each member		
		SET IsUpdatedL4 = 1
		OUTPUT DELETED.custid INTO @tmp(custid)
		FROM #tblCust t
		WHERE IsUpdatedL4 = 0
	
		IF @@ROWCOUNT = 0
			BREAK;	
			
		----------------------------------------------------------------------------
		--s1=min(s1,s4-m3) if i=0
		  --v161
		update custsetting3rd with (ROWLOCK, UPDLOCK) set custsetting3rd.spositiontaking = scs.spositiontaking - mcs.mpositiontaking
		from 
			custsetting3rd 
			inner join custinfo as mb with (NOLOCK) on custsetting3rd.custid = mb.custid --and mb.srecommend = @srecommend and mb.roleid=1
			inner join custsetting3rd as mcs with (NOLOCK) on mcs.custid = mb.mrecommend and mcs.sporttype=custsetting3rd.sporttype and mcs.bettype=custsetting3rd.bettype
			inner join custsetting3rd as scs with (NOLOCK) on scs.custid = @srecommend and scs.sporttype=custsetting3rd.sporttype and scs.bettype=custsetting3rd.bettype
		where custsetting3rd.sporttype = 161 and custsetting3rd.bettype in (81,83,86,88) and custsetting3rd.isautopositiontaking=0 and mcs.isautopositiontaking=0 and scs.spositiontaking - mcs.mpositiontaking<custsetting3rd.spositiontaking
			AND mb.custid IN (SELECT custid FROM @tmp)
			
		update custsetting3rd with (ROWLOCK, UPDLOCK) set custsetting3rd.slivepositiontaking = scs.slivepositiontaking - mcs.mlivepositiontaking
		from 
			custsetting3rd 
			inner join custinfo as mb with (NOLOCK) on custsetting3rd.custid = mb.custid --and mb.srecommend = @srecommend and mb.roleid=1
			inner join custsetting3rd as mcs with (NOLOCK) on mcs.custid = mb.mrecommend and mcs.sporttype=custsetting3rd.sporttype and mcs.bettype=custsetting3rd.bettype
			inner join custsetting3rd as scs with (NOLOCK) on scs.custid = @srecommend and scs.sporttype=custsetting3rd.sporttype and scs.bettype=custsetting3rd.bettype
		where custsetting3rd.sporttype=161 and custsetting3rd.bettype in (85,86,87,89,90)
			and custsetting3rd.isautolivepositiontaking=0 and mcs.isautolivepositiontaking=0 and scs.slivepositiontaking - mcs.mlivepositiontaking<custsetting3rd.slivepositiontaking
			AND mb.custid IN (SELECT custid FROM @tmp)
		----------------------------------------------------------------------------

		--update s1,m1,a1 in case s1+m1+a1>s4
		--s1=max(0,s4-m1-a1)
		--@mapos1=iif(s1_new+m1+a1>s4,s4-s1_new,m1+a1)
		--@maxmapos=min(m3,l3)
		--@mapos2=min(@mapos1,@maxmapos)
		--@mapos=max(@mapos2,n3)
		--m1=max(0,@mapos-a1)
		--a1=iif(m1_new+a1>@mapos,@mapos-m1_new,a1)
		--v161
		Update custsetting3rd with (ROWLOCK, UPDLOCK) set 
			@spos = case when scs.spositiontaking-custsetting3rd.mpositiontaking-custsetting3rd.apositiontaking<0 then 0 else scs.spositiontaking-custsetting3rd.mpositiontaking-custsetting3rd.apositiontaking end,
			spositiontaking = @spos,
			@mapos1 = case when @spos+custsetting3rd.mpositiontaking+custsetting3rd.apositiontaking>scs.spositiontaking then scs.spositiontaking-@spos else custsetting3rd.mpositiontaking+custsetting3rd.apositiontaking end,
			@maxmapos = case when mcs.mpositiontaking>mco.maxpositiontaking then mco.maxpositiontaking else mcs.mpositiontaking end,
			@mapos2 = case when @mapos1>@maxmapos then @maxmapos else @mapos1 end,
			@mapos = case when @mapos2<mco.minpositiontaking then mco.minpositiontaking else @mapos2 end,
			@mpos = case when @mapos-custsetting3rd.apositiontaking<0 then 0 else @mapos-custsetting3rd.apositiontaking end,
			mpositiontaking = @mpos,
			@apos = case when custsetting3rd.apositiontaking + @mpos>@mapos then @mapos-@mpos else custsetting3rd.apositiontaking end,
			apositiontaking = case when @apos<aco.minpositiontaking then aco.minpositiontaking else @apos end
		from 
			custsetting3rd 
			inner join custinfo as mb with (NOLOCK) on custsetting3rd.custid = mb.custid --and mb.srecommend=@srecommend and mb.roleid=1
			inner join custsetting3rd as scs with (NOLOCK) on scs.custid = @srecommend  and scs.sporttype=custsetting3rd.sporttype and scs.bettype=custsetting3rd.bettype
			inner join custsetting3rd as mcs with (NOLOCK) on mcs.custid = mb.mrecommend  and mcs.sporttype=custsetting3rd.sporttype and mcs.bettype=custsetting3rd.bettype
			inner join custoverride3rd as mco with (NOLOCK) on mco.custid = mb.mrecommend  and mco.sporttype=custsetting3rd.sporttype and mco.bettype=custsetting3rd.bettype
			inner join custoverride3rd as aco with (NOLOCK) on aco.custid = mb.recommend  and aco.sporttype=custsetting3rd.sporttype and aco.bettype=custsetting3rd.bettype
		where custsetting3rd.sporttype = 161 and custsetting3rd.bettype in (81,83,86,88) and  custsetting3rd.spositiontaking+custsetting3rd.apositiontaking+custsetting3rd.mpositiontaking>scs.spositiontaking
			AND mb.custid IN (SELECT custid FROM @tmp)
			
		Update custsetting3rd with (ROWLOCK, UPDLOCK) set 
			@spos = case when scs.slivepositiontaking-custsetting3rd.mlivepositiontaking-custsetting3rd.alivepositiontaking<0 then 0 else scs.slivepositiontaking-custsetting3rd.mlivepositiontaking-custsetting3rd.alivepositiontaking end,
			slivepositiontaking = @spos,
			@mapos1 = case when @spos+custsetting3rd.mlivepositiontaking+custsetting3rd.alivepositiontaking>scs.slivepositiontaking then scs.slivepositiontaking-@spos else custsetting3rd.mlivepositiontaking+custsetting3rd.alivepositiontaking end,
			@maxmapos = case when mcs.mlivepositiontaking>mco.maxlivepositiontaking then mco.maxlivepositiontaking else mcs.mlivepositiontaking end,
			@mapos2 = case when @mapos1>@maxmapos then @maxmapos else @mapos1 end,
			@mapos = case when @mapos2<mco.minlivepositiontaking then mco.minlivepositiontaking else @mapos2 end,
			@mpos = case when @mapos-custsetting3rd.alivepositiontaking<0 then 0 else @mapos-custsetting3rd.alivepositiontaking end,
			mlivepositiontaking = @mpos,
			@apos = case when custsetting3rd.alivepositiontaking + @mpos>@mapos then @mapos-@mpos else custsetting3rd.alivepositiontaking end,
			alivepositiontaking = case when @apos<aco.minlivepositiontaking then aco.minlivepositiontaking else @apos end
		from 
			custsetting3rd 
			inner join custinfo as mb with (NOLOCK) on custsetting3rd.custid = mb.custid --and mb.srecommend=@srecommend and mb.roleid=1
			inner join custsetting3rd as scs with (NOLOCK) on scs.custid = @srecommend  and scs.sporttype=custsetting3rd.sporttype and scs.bettype=custsetting3rd.bettype
			inner join custsetting3rd as mcs with (NOLOCK) on mcs.custid = mb.mrecommend  and mcs.sporttype=custsetting3rd.sporttype and mcs.bettype=custsetting3rd.bettype
			inner join custoverride3rd as mco with (NOLOCK) on mco.custid = mb.mrecommend  and mco.sporttype=custsetting3rd.sporttype and mco.bettype=custsetting3rd.bettype
			inner join custoverride3rd as aco with (NOLOCK) on aco.custid = mb.recommend  and aco.sporttype=custsetting3rd.sporttype and aco.bettype=custsetting3rd.bettype
		where custsetting3rd.sporttype=161 and custsetting3rd.bettype in (85,86,87,89,90) and custsetting3rd.slivepositiontaking+custsetting3rd.alivepositiontaking+custsetting3rd.mlivepositiontaking>scs.slivepositiontaking
			AND mb.custid IN (SELECT custid FROM @tmp)
	END
	
	-------------------------------------------------------------------------------
	--Correct for MinPT	
	--clone from sp Acc_CustSetting3rd_04
	
		DECLARE @_srecommend INT
		SELECT @_srecommend = @srecommend

		WHILE(1=1)
		BEGIN
			DELETE @tmp
		
			UPDATE TOP (1000) t 	--34 rows settings for each member		
			SET IsUpdatedN4 = 1
			OUTPUT DELETED.custid INTO @tmp(custid)
			FROM #tblCust t
			WHERE IsUpdatedN4 = 0
		
			IF @@ROWCOUNT = 0
				BREAK;	
				--s1=min(s1,s4-m3) if i=0
		
				--v161
				UPDATE cs3 WITH(ROWLOCK, UPDLOCK)
				   SET cs3.spositiontaking = scs.spositiontaking - mcs.mpositiontaking
				  FROM custsetting3rd cs3
			INNER JOIN custinfo mb WITH(NOLOCK) ON cs3.custid = mb.custid
											   --AND mb.srecommend = @_srecommend
											   --AND mb.roleid = 1
											   --AND mb.Enabled = 1
			INNER JOIN custsetting3rd mcs WITH(NOLOCK) ON mcs.custid = mb.mrecommend
													  AND mcs.sporttype = cs3.sporttype
													  AND mcs.bettype = cs3.bettype
			INNER JOIN custsetting3rd scs WITH(NOLOCK) ON scs.custid = @_srecommend
													  AND scs.sporttype = cs3.sporttype
													  AND scs.bettype = cs3.bettype
				 WHERE cs3.sporttype = 161
				   AND cs3.bettype IN (81, 83, 86, 88)
				   AND cs3.isautopositiontaking = 0
				   AND mcs.isautopositiontaking = 0
				   AND scs.spositiontaking - mcs.mpositiontaking < cs3.spositiontaking
				   AND mb.custid IN (SELECT custid FROM @tmp)

				UPDATE cs3 WITH(ROWLOCK, UPDLOCK)
				   SET cs3.slivepositiontaking = scs.slivepositiontaking - mcs.mlivepositiontaking
				  FROM custsetting3rd cs3
			INNER JOIN custinfo mb WITH(NOLOCK) ON cs3.custid = mb.custid
											   --AND mb.srecommend = @_srecommend
											   --AND mb.roleid = 1
											   --AND mb.Enabled = 1
			INNER JOIN custsetting3rd mcs WITH(NOLOCK) ON mcs.custid = mb.mrecommend
													  AND mcs.sporttype = cs3.sporttype
													  AND mcs.bettype = cs3.bettype
			INNER JOIN custsetting3rd scs WITH(NOLOCK) ON scs.custid = @_srecommend
													  AND scs.sporttype = cs3.sporttype
													  AND scs.bettype = cs3.bettype
				 WHERE cs3.sporttype = 161
				   AND cs3.bettype IN (85, 86, 87, 89, 90)
				   AND cs3.isautolivepositiontaking = 0
				   AND mcs.isautolivepositiontaking = 0
				   AND scs.slivepositiontaking - mcs.mlivepositiontaking < cs3.slivepositiontaking
				   AND mb.custid IN (SELECT custid FROM @tmp)

				--check agent min
				--a1=max(a1,n2)    
				--v161
				UPDATE cs3 WITH(ROWLOCK, UPDLOCK)
				   SET apositiontaking = aco.minpositiontaking
					 , cs3.mpositiontaking =
						 CASE
						   WHEN cs3.mpositiontaking + aco.minpositiontaking > mcs.mpositiontaking THEN mcs.mpositiontaking - aco.minpositiontaking
						   ELSE cs3.mpositiontaking
						 END
				  FROM custsetting3rd cs3
			INNER JOIN custinfo mb WITH(NOLOCK) ON cs3.custid = mb.custid
											   --AND mb.srecommend = @_srecommend
											   --AND mb.roleid = 1
											   --AND mb.Enabled = 1
			INNER JOIN custsetting3rd mcs WITH(NOLOCK) ON mcs.custid = mb.mrecommend
													  AND mcs.sporttype = cs3.sporttype
													  AND mcs.bettype = cs3.bettype
			INNER JOIN custoverride3rd aco WITH(NOLOCK) ON aco.custid = mb.recommend
													   AND aco.sporttype = cs3.sporttype
													   AND aco.bettype = cs3.bettype
				 WHERE cs3.sporttype = 161
				   AND cs3.bettype IN (81, 83, 86, 88)
				   AND cs3.apositiontaking < aco.minpositiontaking
				   AND mb.custid IN (SELECT custid FROM @tmp)


				UPDATE cs3 WITH(ROWLOCK, UPDLOCK)
				   SET cs3.alivepositiontaking = aco.minlivepositiontaking
					 , cs3.mlivepositiontaking =
						 CASE
						   WHEN cs3.mlivepositiontaking + aco.minlivepositiontaking > mcs.mlivepositiontaking THEN mcs.mlivepositiontaking - aco.minlivepositiontaking
						   ELSE cs3.mlivepositiontaking
						 END
				  FROM custsetting3rd cs3
			INNER JOIN custinfo mb WITH(NOLOCK) ON cs3.custid = mb.custid
											   --AND mb.srecommend = @_srecommend
											   --AND mb.roleid = 1
											   --AND mb.Enabled = 1
			INNER JOIN custsetting3rd mcs WITH(NOLOCK) ON mcs.custid = mb.mrecommend
													  AND mcs.sporttype = cs3.sporttype
													  AND mcs.bettype = cs3.bettype
			INNER JOIN custoverride3rd aco WITH(NOLOCK) ON aco.custid = mb.recommend
													   AND aco.sporttype = cs3.sporttype
													   AND aco.bettype = cs3.bettype
				 WHERE cs3.sporttype = 161
				   AND cs3.bettype IN (85, 86, 87, 89, 90)
				   AND cs3.alivepositiontaking < aco.minlivepositiontaking
				   AND mb.custid IN (SELECT custid FROM @tmp)

				--check agent max
				--a1=min(a1,l2)    
				--v161
				UPDATE cs3 WITH(ROWLOCK, UPDLOCK)
				   SET apositiontaking = aco.maxpositiontaking
				  FROM custsetting3rd cs3
			INNER JOIN custinfo mb WITH(NOLOCK) ON cs3.custid = mb.custid
											   --AND mb.srecommend = @_srecommend
											   --AND mb.roleid = 1
											   --AND mb.Enabled = 1
			INNER JOIN custoverride3rd aco WITH(NOLOCK) ON aco.custid = mb.recommend
													   AND aco.sporttype = cs3.sporttype
													   AND aco.bettype = cs3.bettype
				 WHERE cs3.sporttype = 161
				   AND cs3.bettype IN (81, 83, 86, 88)
				   AND cs3.apositiontaking > aco.maxpositiontaking
				   AND mb.custid IN (SELECT custid FROM @tmp)

				UPDATE cs3 WITH(ROWLOCK, UPDLOCK)
				   SET alivepositiontaking = aco.maxlivepositiontaking
				  FROM custsetting3rd cs3
			INNER JOIN custinfo mb WITH(NOLOCK) ON cs3.custid = mb.custid
											   --AND mb.srecommend = @_srecommend
											   --AND mb.roleid = 1
											   --AND mb.Enabled = 1
			INNER JOIN custoverride3rd aco WITH(NOLOCK) ON aco.custid = mb.recommend
													   AND aco.sporttype = cs3.sporttype
													   AND aco.bettype = cs3.bettype
				 WHERE cs3.sporttype = 161
				   AND cs3.bettype IN (85, 86, 87, 89, 90)
				   AND cs3.alivepositiontaking > aco.maxlivepositiontaking
				   AND mb.custid IN (SELECT custid FROM @tmp)

				--Recal AUTO MPT m1=min(m3-a1,u2)
		
				--v161
				UPDATE cs3 WITH(ROWLOCK, UPDLOCK) 
				   SET mpositiontaking =
						 CASE
						   WHEN mcs.mpositiontaking - cs3.apositiontaking >
								  CASE
									WHEN cs3.isautompositiontaking = 1 THEN cs3.autompositiontaking
									ELSE acs.autompositiontaking
								  END
							 THEN CASE
									WHEN cs3.isautompositiontaking = 1 THEN cs3.autompositiontaking
									ELSE acs.autompositiontaking
								  END
						   ELSE mcs.mpositiontaking - cs3.apositiontaking
						 END
				  FROM custsetting3rd cs3
			INNER JOIN custinfo c WITH(NOLOCK) ON cs3.custid = c.custid
			INNER JOIN custsetting3rd mcs WITH(NOLOCK) ON mcs.custid = c.mrecommend
													  AND mcs.sporttype = cs3.sporttype
													  AND mcs.bettype = cs3.bettype
			INNER JOIN custsetting3rd acs WITH(NOLOCK) ON acs.custid = c.recommend
													  AND acs.sporttype = cs3.sporttype
													  AND acs.bettype = cs3.bettype
				 WHERE c.custid IN (SELECT custid FROM @tmp)
					--c.srecommend = @_srecommend
				 --  AND c.roleid = 1
				 --  AND c.Enabled = 1
				   AND cs3.sporttype = 161
				   AND cs3.bettype IN (81, 83, 86, 88)
				   AND (acs.isautompositiontaking = 1
						OR cs3.isautompositiontaking = 1
					   )


				UPDATE cs3 WITH(ROWLOCK, UPDLOCK) 
				   SET mlivepositiontaking =
						 CASE
						   WHEN mcs.mlivepositiontaking - cs3.alivepositiontaking >
								  CASE
									WHEN cs3.isautolivempositiontaking = 1 THEN cs3.autolivempositiontaking
									ELSE acs.autolivempositiontaking
								  END
							 THEN CASE
									WHEN cs3.isautolivempositiontaking = 1 THEN cs3.autolivempositiontaking
									ELSE acs.autolivempositiontaking
								  END
						   ELSE mcs.mlivepositiontaking - cs3.alivepositiontaking
						 END
				  FROM custsetting3rd cs3
			INNER JOIN custinfo c WITH(NOLOCK) ON cs3.custid = c.custid
			INNER JOIN custsetting3rd mcs WITH(NOLOCK) ON mcs.custid = c.mrecommend
													  AND mcs.sporttype = cs3.sporttype
													  AND mcs.bettype = cs3.bettype
			INNER JOIN custsetting3rd acs WITH(NOLOCK) ON acs.custid = c.recommend
													   AND acs.sporttype = cs3.sporttype
													   AND acs.bettype = cs3.bettype
				 WHERE c.custid IN (SELECT custid FROM @tmp)
					--AND c.srecommend = @_srecommend
				 --  AND c.roleid = 1
				 --  AND c.Enabled = 1
				   AND cs3.sporttype = 161
				   AND cs3.bettype IN (85, 86, 87, 89, 90)
				   AND (acs.isautolivempositiontaking = 1
						OR cs3.isautolivempositiontaking = 1
					   )    


				--check master min
				--m1=max(m1,n3-a1)
				--v161
				UPDATE cs3 WITH(ROWLOCK, UPDLOCK)
				   SET mpositiontaking = mco.minpositiontaking - cs3.apositiontaking
				  FROM custsetting3rd cs3
			INNER JOIN custinfo mb WITH(NOLOCK) ON cs3.custid = mb.custid
											   --AND mb.srecommend = @_srecommend
											   --AND mb.roleid = 1
											   --AND mb.Enabled = 1
			INNER JOIN custoverride3rd mco WITH(NOLOCK) ON mco.custid = mb.mrecommend
														AND mco.sporttype = cs3.sporttype
														AND mco.bettype = cs3.bettype
				 WHERE cs3.sporttype = 161
				   AND cs3.bettype IN (81, 83, 86, 88)
				   AND cs3.apositiontaking + cs3.mpositiontaking < mco.minpositiontaking
				   AND mb.custid IN (SELECT custid FROM @tmp)

				UPDATE cs3 WITH(ROWLOCK, UPDLOCK)
				   SET mlivepositiontaking = mco.minlivepositiontaking-cs3.alivepositiontaking
				  FROM custsetting3rd cs3
			INNER JOIN custinfo mb WITH(NOLOCK) ON cs3.custid = mb.custid
											   --AND mb.srecommend = @_srecommend
											   --AND mb.roleid = 1
											   --AND mb.Enabled = 1
			INNER JOIN custoverride3rd mco WITH(NOLOCK) ON mco.custid = mb.mrecommend
													   AND mco.sporttype = cs3.sporttype
													   AND mco.bettype = cs3.bettype
				 WHERE cs3.sporttype = 161
				   AND cs3.bettype IN (85, 86, 87, 89, 90)
				   AND cs3.alivepositiontaking + cs3.mlivepositiontaking < mco.minlivepositiontaking
				   AND mb.custid IN (SELECT custid FROM @tmp)

				--check master max   
				--v161
				UPDATE cs3 WITH(ROWLOCK, UPDLOCK)
				   SET @maxmapos =
						 CASE
						   WHEN mcs.mpositiontaking > mco.maxpositiontaking THEN mco.maxpositiontaking
						   ELSE mcs.mpositiontaking
						 END
					 , @mpos =
						 CASE
						   WHEN @maxmapos - cs3.apositiontaking < 0 THEN 0
						   ELSE @maxmapos - cs3.apositiontaking
						 END
					 , mpositiontaking = @mpos
					 , @apos =
						 CASE
						   WHEN cs3.apositiontaking + @mpos > @maxmapos THEN @maxmapos - @mpos
						   ELSE cs3.apositiontaking
						 END
					 , apositiontaking =
						 CASE
						   WHEN @apos < aco.minpositiontaking THEN aco.minpositiontaking
						   ELSE @apos
						 END
				  FROM custsetting3rd cs3
			INNER JOIN custinfo mb WITH(NOLOCK) ON cs3.custid = mb.custid
											   --AND mb.srecommend = @_srecommend
											   --AND mb.roleid = 1
											   --AND mb.Enabled = 1
			INNER JOIN custsetting3rd mcs WITH(NOLOCK) ON mcs.custid = mb.mrecommend
													  AND mcs.sporttype = cs3.sporttype
													  AND mcs.bettype = cs3.bettype
			INNER JOIN custoverride3rd mco WITH(NOLOCK) ON mco.custid = mb.mrecommend
													   AND mco.sporttype = cs3.sporttype
													   AND mco.bettype = cs3.bettype
			INNER JOIN custoverride3rd aco WITH(NOLOCK) ON aco.custid = mb.recommend
													   AND aco.sporttype = cs3.sporttype
													   AND aco.bettype = cs3.bettype
				 WHERE cs3.sporttype = 161
				   AND cs3.bettype IN (81, 83, 86, 88)
				   AND cs3.apositiontaking + cs3.mpositiontaking > mco.maxpositiontaking
				   AND mb.custid IN (SELECT custid FROM @tmp)

				UPDATE cs3 WITH(ROWLOCK, UPDLOCK)
				   SET @maxmapos =
						 CASE
						   WHEN mcs.mlivepositiontaking > mco.maxlivepositiontaking THEN mco.maxlivepositiontaking
						   ELSE mcs.mlivepositiontaking
						 END
					 , @mpos =
						 CASE
						   WHEN @maxmapos - cs3.alivepositiontaking < 0 THEN 0
						   ELSE @maxmapos - cs3.alivepositiontaking
						 END
					 , mlivepositiontaking = @mpos
					 , @apos =
						 CASE
						   WHEN cs3.alivepositiontaking + @mpos > @maxmapos THEN @maxmapos - @mpos
						   ELSE cs3.alivepositiontaking
						 END
					 , alivepositiontaking =
						 CASE
						   WHEN @apos < aco.minlivepositiontaking THEN aco.minlivepositiontaking
						   ELSE @apos
						 END
				  FROM custsetting3rd cs3
			INNER JOIN custinfo mb WITH(NOLOCK) ON cs3.custid = mb.custid
											   --AND mb.srecommend = @_srecommend
											   --AND mb.roleid = 1
											   --AND mb.Enabled = 1
			INNER JOIN custsetting3rd mcs WITH(NOLOCK) ON mcs.custid = mb.mrecommend
													  AND mcs.sporttype = cs3.sporttype
													  AND mcs.bettype = cs3.bettype
			INNER JOIN custoverride3rd mco WITH(NOLOCK) ON mco.custid = mb.mrecommend
													   AND mco.sporttype = cs3.sporttype
													   AND mco.bettype = cs3.bettype
			INNER JOIN custoverride3rd aco WITH(NOLOCK) ON aco.custid = mb.recommend
													   AND aco.sporttype = cs3.sporttype
													   AND aco.bettype = cs3.bettype
				 WHERE cs3.sporttype = 161
				   AND cs3.bettype IN (85, 86, 87, 89, 90)
				   AND cs3.alivepositiontaking + cs3.mlivepositiontaking > mco.maxlivepositiontaking
				   AND mb.custid IN (SELECT custid FROM @tmp)

				--recal autopos   
			
				--v161
				UPDATE cs3 WITH(ROWLOCK, UPDLOCK)
				   SET spositiontaking =
						 CASE
						   WHEN scs.spositiontaking - cs3.mpositiontaking - cs3.apositiontaking >
								  CASE
									WHEN cs3.isautopositiontaking = 1 THEN cs3.autopositiontaking
									ELSE mcs.autopositiontaking
								  END
							 THEN CASE
									WHEN cs3.isautopositiontaking = 1 THEN cs3.autopositiontaking
									ELSE mcs.autopositiontaking
								  END
						   ELSE scs.spositiontaking - cs3.mpositiontaking - cs3.apositiontaking
						 END
				  FROM custsetting3rd cs3
			INNER JOIN custinfo c WITH(NOLOCK) ON cs3.custid = c.custid
			INNER JOIN custsetting3rd mcs WITH(NOLOCK) ON mcs.custid = c.mrecommend
													  AND mcs.sporttype = cs3.sporttype
													  AND mcs.bettype = cs3.bettype
			INNER JOIN custsetting3rd scs WITH(NOLOCK) ON scs.custid = @_srecommend
													  AND scs.sporttype = cs3.sporttype
													  AND scs.bettype=cs3.bettype
				 WHERE  c.custid IN (SELECT custid FROM @tmp)
					--c.srecommend = @_srecommend
				 --  AND c.roleid = 1
				 --  AND c.Enabled = 1
				   AND cs3.sporttype = 161
				   AND cs3.bettype IN (81, 83, 86, 88)
				   AND (cs3.isautopositiontaking = 1
						OR mcs.isautopositiontaking = 1
					   )


				UPDATE cs3 WITH(ROWLOCK, UPDLOCK)
				   SET slivepositiontaking =
						 CASE
						   WHEN scs.slivepositiontaking - cs3.mlivepositiontaking - cs3.alivepositiontaking >
								  CASE
									WHEN cs3.isautolivepositiontaking = 1 THEN cs3.autolivepositiontaking
									ELSE mcs.autolivepositiontaking
								  END
							 THEN CASE
									WHEN cs3.isautolivepositiontaking = 1 THEN cs3.autolivepositiontaking
									ELSE mcs.autolivepositiontaking
								  END
						   ELSE scs.slivepositiontaking - cs3.mlivepositiontaking - cs3.alivepositiontaking
						 END 
				  FROM custsetting3rd cs3
			INNER JOIN custinfo c WITH(NOLOCK) ON cs3.custid = c.custid
			INNER JOIN custsetting3rd mcs WITH(NOLOCK) ON mcs.custid = c.mrecommend
													  AND mcs.sporttype = cs3.sporttype
													  AND mcs.bettype = cs3.bettype
			INNER JOIN custsetting3rd scs WITH(NOLOCK) ON scs.custid = @_srecommend
													  AND scs.sporttype = cs3.sporttype
													  AND scs.bettype = cs3.bettype
				 WHERE c.custid IN (SELECT custid FROM @tmp)
					--c.srecommend = @_srecommend
				 --  AND c.roleid = 1
				 --  AND c.Enabled = 1
				   AND cs3.sporttype = 161
				   AND cs3.bettype IN (85, 86, 87, 89, 90)
				   AND (cs3.isautolivepositiontaking = 1
						OR mcs.isautolivepositiontaking = 1
					   )    


				--check super min
				--s1=max(n4-m1-a1,s1)    
				--v161
				UPDATE cs3 WITH(ROWLOCK, UPDLOCK)
				   SET spositiontaking = sco.minpositiontaking - cs3.mpositiontaking - cs3.apositiontaking
				  FROM custsetting3rd cs3
			INNER JOIN custinfo mb WITH(NOLOCK) ON cs3.custid = mb.custid
											   --AND mb.srecommend = @_srecommend
											   --AND mb.roleid = 1
											   --AND mb.Enabled = 1
			INNER JOIN custoverride3rd sco WITH(NOLOCK) ON sco.custid = @_srecommend
													   AND sco.sporttype = cs3.sporttype
													   AND sco.bettype = cs3.bettype
				 WHERE cs3.sporttype = 161
				   AND cs3.bettype IN (81, 83, 86, 88)
				   AND cs3.apositiontaking + cs3.mpositiontaking + cs3.spositiontaking < sco.minpositiontaking
				   AND mb.custid IN (SELECT custid FROM @tmp)

				UPDATE cs3 WITH(ROWLOCK, UPDLOCK)
				   SET slivepositiontaking = sco.minlivepositiontaking - cs3.mlivepositiontaking - cs3.alivepositiontaking
				  FROM custsetting3rd cs3
			INNER JOIN custinfo mb WITH(NOLOCK) ON cs3.custid = mb.custid
											   --AND mb.srecommend = @_srecommend
											   --AND mb.roleid = 1
											   --AND mb.Enabled = 1
			INNER JOIN custoverride3rd sco WITH(NOLOCK) ON sco.custid = @_srecommend
													   AND sco.sporttype = cs3.sporttype
													   AND sco.bettype = cs3.bettype
				 WHERE cs3.sporttype = 161
				   AND cs3.bettype IN (85, 86, 87, 89, 90)
				   AND cs3.alivepositiontaking + cs3.mlivepositiontaking + cs3.slivepositiontaking < sco.minlivepositiontaking
				   AND mb.custid IN (SELECT custid FROM @tmp)
		

				--UPDATE s1,m1,a1 IN CASE s1+m1+a1>s4
				--s1=max(0,s4-m1-a1)
				--@mapos1=iif(s1_new+m1+a1>s4,s4-s1_new,m1+a1)
				--@maxmapos=min(m3,l3)
				--@mapos2=min(@mapos1,@maxmapos)
				--@mapos=max(@mapos2,n3)
				--m1=max(0,@mapos-a1)
				--a1=iif(m1_new+a1>@mapos,@mapos-m1_new,a1)
				--v161
				UPDATE cs3 WITH(ROWLOCK, UPDLOCK)
				   SET @spos =
						 CASE
						   WHEN scs.spositiontaking - cs3.mpositiontaking - cs3.apositiontaking < 0 THEN 0
						   ELSE scs.spositiontaking - cs3.mpositiontaking - cs3.apositiontaking
						 END
					 , spositiontaking = @spos
					 , @mapos1 =
						 CASE
						   WHEN @spos + cs3.mpositiontaking + cs3.apositiontaking > scs.spositiontaking THEN scs.spositiontaking - @spos
						   ELSE cs3.mpositiontaking + cs3.apositiontaking
						 END
					 , @maxmapos =
						 CASE
						   WHEN mcs.mpositiontaking > mco.maxpositiontaking THEN mco.maxpositiontaking
						   ELSE mcs.mpositiontaking
						 END
					 , @mapos2 =
						 CASE
						   WHEN @mapos1 > @maxmapos THEN @maxmapos
						   ELSE @mapos1
						 END
					 , @mapos =
						 CASE
						   WHEN @mapos2 < mco.minpositiontaking THEN mco.minpositiontaking
						   ELSE @mapos2
						 END
					 , @mpos =
						 CASE
						   WHEN @mapos - cs3.apositiontaking < 0 THEN 0
						   ELSE @mapos - cs3.apositiontaking
						 END
					 , mpositiontaking = @mpos
					 , @apos =
						 CASE
						   WHEN cs3.apositiontaking + @mpos > @mapos THEN @mapos - @mpos
						   ELSE cs3.apositiontaking
						 END
					 , apositiontaking =
						 CASE
						   WHEN @apos < aco.minpositiontaking THEN aco.minpositiontaking
						   ELSE @apos
						 END
				  FROM custsetting3rd cs3
			INNER JOIN custinfo mb WITH(NOLOCK) ON cs3.custid = mb.custid
											   --AND mb.srecommend = @_srecommend
											   --AND mb.roleid = 1
											   --AND mb.Enabled = 1
			INNER JOIN custsetting3rd scs WITH(NOLOCK) ON scs.custid = @_srecommend
													  AND scs.sporttype = cs3.sporttype
													  AND scs.bettype = cs3.bettype
			INNER JOIN custsetting3rd mcs WITH(NOLOCK) ON mcs.custid = mb.mrecommend
													  AND mcs.sporttype = cs3.sporttype
													  AND mcs.bettype = cs3.bettype
			INNER JOIN custoverride3rd mco WITH(NOLOCK) ON mco.custid = mb.mrecommend
													   AND mco.sporttype = cs3.sporttype
													   AND mco.bettype = cs3.bettype
			INNER JOIN custoverride3rd aco WITH(NOLOCK) ON aco.custid = mb.recommend
													   AND aco.sporttype = cs3.sporttype
													   AND aco.bettype = cs3.bettype
				 WHERE cs3.sporttype = 161
				   AND cs3.bettype IN (81, 83, 86, 88)
				   AND cs3.spositiontaking + cs3.apositiontaking + cs3.mpositiontaking > scs.spositiontaking
				   AND mb.custid IN (SELECT custid FROM @tmp)

				UPDATE cs3 WITH(ROWLOCK, UPDLOCK)
				   SET @spos =
						 CASE
						   WHEN scs.slivepositiontaking - cs3.mlivepositiontaking - cs3.alivepositiontaking < 0 THEN 0
						   ELSE scs.slivepositiontaking - cs3.mlivepositiontaking - cs3.alivepositiontaking
						 END
					 , slivepositiontaking = @spos
					 , @mapos1 =
						 CASE
						   WHEN @spos + cs3.mlivepositiontaking + cs3.alivepositiontaking > scs.slivepositiontaking THEN scs.slivepositiontaking - @spos
						   ELSE cs3.mlivepositiontaking + cs3.alivepositiontaking
						 END
					 , @maxmapos =
						 CASE
						   WHEN mcs.mlivepositiontaking > mco.maxlivepositiontaking THEN mco.maxlivepositiontaking
						   ELSE mcs.mlivepositiontaking
						 END
					 , @mapos2 =
						 CASE
						   WHEN @mapos1 > @maxmapos THEN @maxmapos
						   ELSE @mapos1
						 END
					 , @mapos =
						 CASE
						   WHEN @mapos2 < mco.minlivepositiontaking THEN mco.minlivepositiontaking
						   ELSE @mapos2
						 END
					 , @mpos =
						 CASE
						   WHEN @mapos - cs3.alivepositiontaking < 0 THEN 0
						   ELSE @mapos - cs3.alivepositiontaking
						 END
					 , mlivepositiontaking = @mpos
					 , @apos =
						 CASE
						   WHEN cs3.alivepositiontaking + @mpos > @mapos THEN @mapos - @mpos
						   ELSE cs3.alivepositiontaking
						 END
					 , alivepositiontaking =
						 CASE
						   WHEN @apos < aco.minlivepositiontaking THEN aco.minlivepositiontaking
						   ELSE @apos
						 END
				   FROM custsetting3rd cs3
			INNER JOIN custinfo mb WITH(NOLOCK) ON cs3.custid = mb.custid
											   --AND mb.srecommend = @_srecommend
											   --AND mb.roleid = 1
											   --AND mb.Enabled = 1
			INNER JOIN custsetting3rd scs WITH(NOLOCK) ON scs.custid = @_srecommend
													  AND scs.sporttype = cs3.sporttype
													  AND scs.bettype = cs3.bettype
			INNER JOIN custsetting3rd mcs WITH(NOLOCK) ON mcs.custid = mb.mrecommend
													  AND mcs.sporttype = cs3.sporttype
													  AND mcs.bettype = cs3.bettype
			INNER JOIN custoverride3rd mco WITH(NOLOCK) ON mco.custid = mb.mrecommend
													   AND mco.sporttype = cs3.sporttype
													   AND mco.bettype = cs3.bettype
			INNER JOIN custoverride3rd aco WITH(NOLOCK) ON aco.custid = mb.recommend
													   AND aco.sporttype = cs3.sporttype
													   AND aco.bettype = cs3.bettype
				 WHERE cs3.sporttype = 161
				   AND cs3.bettype IN (85, 86, 87, 89, 90)
				   AND cs3.slivepositiontaking + cs3.alivepositiontaking + cs3.mlivepositiontaking > scs.slivepositiontaking
				   AND mb.custid IN (SELECT custid FROM @tmp)
		END
		
	DROP TABLE #tblCust
END
GO

-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS AND DBCUST(run finally)
--------------------------------------------------------------------------------------
DECLARE @target VARCHAR(20)
IF @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST')
	SET @target = 'DBCUST'
ELSE 
	SET @target = 'REPLICATED'

Print 'Server Name : ' + @target

CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @srecommend INT

INSERT INTO #supers(custid)
SELECT ci.custid
FROM customer ci WITH (NOLOCK) 
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
	INNER JOIN custinfo c WITH(NOLOCK) ON ci.custid = c.custid
	LEFT JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid	
WHERE ci.roleid = 4  
	AND ci.username NOT LIKE '3rdSuper%'
	AND cs.isinternal = 0
	AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	AND s.islicensee = 0
	AND ci.site = '755555'
	AND c.Enabled = 1
	AND ci.custid NOT IN (SELECT custid FROM CustAccount WITH(NOLOCK)
						WHERE GroupID IN (SELECT GroupID FROM CustGroupHeadline WITH(NOLOCK)
										WHERE custid = (SELECT custid FROM customer (NOLOCK) WHERE username = 'TT0')
										)
						)
		
-- For deployer info
DECLARE @super_cnt INT, @index INT = 0
DECLARE @msg NVARCHAR(200) = 'Currently at order %d, SuperID: %d.'
DECLARE @msg_total NVARCHAR(200) = 'Total of supers: %d.'

SET @super_cnt = (SELECT COUNT(*) FROM #supers )
RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #Supers
	SET isfinished = 1
		,@srecommend = custid			
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK
	
	SET @index = @index + 1
	RAISERROR (@msg, 0, 1, @index, @srecommend) WITH NOWAIT

	EXEC dbo.Acc_CustSetting3rd_18 @srecommend = @srecommend
			,@target = @target			
			
	waitfor delay '00:00:0.200'
END
DROP TABLE #supers
GO
	