/*
	Created: 20200609@Elodie
	Task: Insert missing setting of IBCBet
	DB: DBCUST/CustDB
*/

USE CustDB
GO
DECLARE @SportType SMALLINT = 242, @Bettype SMALLINT = 3201
DECLARE @AgentList TABLE (CustID INT, UplineId INT)
DECLARE @MemberList TABLE (CustID INT, srecommend INT, mrecommend INT, recommend INT)

INSERT INTO @AgentList (CustID, UplineId)
SELECT custid, mrecommend
FROM custInfo WITH (NOLOCK)
WHERE custid IN (43321784
,43322414
,43322838
,43323098
,43330938
,43331303
,43331410
,43331778
,43385489
,43398319
,43398532
,43398658
,43398733
,43401853
,43427774
,43437158
,43448455
,43491411
,43522200)

INSERT INTO @MemberList (CustID, srecommend, mrecommend, recommend)
SELECT custid, srecommend, mrecommend, recommend
FROM custInfo WITH (NOLOCK)
WHERE custid IN (43235197
,43294158
,43294513
,43294551
,43295194
,43295258
,43329677
,43329840
,43329897
,43329900
,43330051
,43330113
,43330143
,43330172
,43330199
,43330224
,43330249
,43330277
,43330284
,43330307
,43331010
,43331032
,43331265
,43331349
,43331397
,43331455
,43331491
,43331535
,43331581
,43331803
,43331862
,43331917
,43331963
,43332008
,43332055
,43332324
,43336487
,43336526
,43336567
,43338637
,43338666
,43338714
,43338753
,43338959
,43338973
,43380941
,43381010
,43381022
,43381036
,43381064
,43381228
,43381239
,43381245
,43381254
,43381258
,43385796
,43386067
,43398807
,43398826
,43398889
,43402134
,43402274
,43402361
,43402371
,43402380
,43402389
,43402396
,43402514
,43402533
,43402539
,43402575
,43404530
,43408356
,43415221
,43415304
,43415383
,43415396
,43423699
,43428732
,43428814
,43430282
,43433978
,43434153
,43434240
,43434254
,43434261
,43434286
,43434302
,43434318
,43434354
,43434539
,43434547
,43434557
,43434563
,43434579
,43434601
,43434618
,43434663
,43434674
,43434684
,43434688
,43434703
,43434711
,43434718
,43434727
,43434742
,43434756
,43434765
,43435135
,43435140
,43435148
,43435156
,43435191
,43435202
,43435224
,43435232
,43435244
,43435263
,43435269
,43435273
,43438098
,43439459
,43442228
,43444168
,43448542
,43450475
,43456329
,43459808
,43461814
,43462445
,43468635
,43469294
,43469306
,43469322
,43472549
,43476273
,43477086
,43478839
,43479888
,43484478
,43484490
,43484501
,43484506
,43484514
,43485822
,43488212
,43491747
,43492749
,43493598
,43499115
,43500283
,43500290
,43500297
,43500299
,43500334
,43500339
,43500468
,43500473
,43500476
,43500483
,43500488
,43500603
,43500605
,43500617
,43500620
,43500759
,43500763
,43500769
,43500774
,43500781
,43500783
,43500791
,43500796
,43502529
,43502535
,43506167
,43510133
,43516248
,43516255
,43516265
,43516274
,43516285
,43516291
,43516295
,43516297
,43516298
,43516310
,43516726
,43516736
,43516752
,43516755
,43516769
,43516777
,43516784
,43516795
,43516810
,43516821
,43517157
,43517170
,43517176
,43517183
,43517189
,43517195
,43517198
,43517208
,43517237
,43517245
,43517272
,43517278
,43517279
,43517283
,43517335
,43517422
,43517425
,43517427
,43517433
,43517437
,43517444
,43517452
,43517457
,43517463
,43517730
,43517742
,43517773
,43517781
,43517787
,43517792
,43518060
,43518063
,43518066
,43518068
,43518070
,43518076
,43518082
,43518087
,43518119
,43518131
,43518321
,43518325
,43518331
,43518339
,43518347
,43518350
,43518354
,43518358
,43518368
,43518371
,43520685
,43520690
,43520692
,43520698
,43520705
,43520708
,43520711
,43520721
,43534541
,43534561
,43534569
,43534589
,43534992
,43534998
,43535014
,43535023
,43535041
,43535046
,43535050
,43535054
,43535239
,43535244
,43535252
,43535258
,43535584
,43535714
,43535721
,43535725
,43535741
,43535745
,43535981
,43535983
,43535986
,43535989
,43535994
,43535999
,43536002
,43536010
,43536015
,43536021
,43536285
,43536289
,43536299
,43536304
,43536308
,43536312
,43536319
,43536327
,43536333
,43536335
,43536621
,43536629
,43536637
,43536643
,43536647
,43536654
,43536662
,43536682
,43536688
,43536695
,43537725
,43537730
,43537735
,43537742
,43537744
,43537748
,43537751
,43537756
,43537759
,43537765
,43537993
,43537997
,43537999
,43538006
,43538011
,43538024
,43538028
,43538032
,43540530
,43547986
,43549299
,43553581
,43553584
,43553591
,43553601
,43553610
,43553615
,43553625
,43553631
,43553639
,43553645
,43554165
,43554226
,43554237
,43554246
,43554261
,43554276
,43554293
,43554629
,43554634
,43554648
,43554655
,43554658
,43554670
,43554674
,43554878
,43554882
,43555062
,43555068
,43555073
,43555083
,43555085
,43555094
,43555139
,43555140
,43555147
,43555151
,43555166
,43555554
,43555558
,43555560
,43555564
,43555569
,43555690
,43555693
,43555699
,43555702
,43555758
,43555765
,43556530
,43556532
,43556542
,43556565
,43556724
,43556729
,43556731
,43556736
,43556739
,43556741
,43556750)


-- Insert Agent
--PT
INSERT INTO CustPTSetting3rd_Agent (CustID, SportType, BetType, IsLive, SuperPT, MasterPT, AgentPT, IsAutoMasterPT, AutoMasterPT, IsAutoSuperPT, AutoSuperPT, MinPT, MaxPT)
SELECT c.custid, SportType, BetType, IsLive, 0, MasterPT,0,0,0,0,0,0 , MaxPT
FROM CustPTSetting3rd_Agent cs WITH (NOLOCK)
	INNER JOIN @AgentList c ON cs.CustID = c.UplineId
WHERE cs.SportType = @SportType AND BetType = @Bettype

--Comm
INSERT INTO CustDiscount3rd_Agent (CustID, SportType, BetType, Discount)
SELECT c.CustID, SportType, BetType, 0
FROM CustDiscount3rd_Agent cs WITH (NOLOCK)
	INNER JOIN @AgentList c ON cs.CustID = c.UplineId
WHERE cs.SportType = @SportType AND BetType = @Bettype

--BetSetting	
INSERT INTO CustStakeLevel_Agent(CustID, SportType, BetType, StakeLevelList)
SELECT c.CustID, SportType, BetType, StakeLevelList
FROM CustStakeLevel_Agent cs WITH (NOLOCK)
	INNER JOIN @AgentList c ON cs.CustID = c.UplineId
WHERE cs.SportType = @SportType AND BetType = @Bettype

--WinLossLimit Setting
INSERT INTO CustWinLossLimit_Agent(CustId, SportType, BetType, MaxWinLimit, MaxLossLimit, IsAutoReset)
SELECT c.CustID, SportType, BetType, MaxWinLimit, MaxLossLimit, IsAutoReset
FROM CustWinLossLimit_Agent cs WITH (NOLOCK)
	INNER JOIN @AgentList c ON cs.CustID = c.UplineId
WHERE cs.SportType = @SportType AND BetType = @Bettype

-- Insert Member
DECLARE @n2 SMALLMONEY, @l2 SMALLMONEY
DECLARE @im2 bit, @um2 SMALLMONEY
DECLARE @a1 SMALLMONEY, @m1 SMALLMONEY, @s1 SMALLMONEY, @i1 bit, @u1 SMALLMONEY, @im1 bit, @um1 SMALLMONEY
DECLARE @temp1 SMALLMONEY, @temp2 SMALLMONEY, @temp3 SMALLMONEY
DECLARE @s_new SMALLMONEY, @m_new SMALLMONEY, @a_new SMALLMONEY
		
DECLARE @MemberPTTbl TABLE (
		CustID		INT
	, [srecommend]	INT
	, [mrecommend]	INT
	, [recommend]	INT
	, [SportType]	SMALLINT
	, [BetType]		SMALLINT
	, [Islive]		BIT	
	, [SuperPT]		TINYINT	
	, [MasterPT]	TINYINT
	, [AgentPT]		TINYINT
	, [IsAutoMPT]	BIT
	, [AutoMPT]		TINYINT
	, [IsAutoSPT]	BIT
	, [AutoSPT]		TINYINT
)
			
--Get default PT settings	
--s1: s3
--m1: m2
--a1: a2
--is1: 0
--us1: 0
--im1: 0
--um1: 0
INSERT INTO @MemberPTTbl (
	CustID
	, SportType
	, BetType
	, Islive
	, SuperPT
	, MasterPT
	, AgentPT
	, IsAutoMPT
	, AutoMPT
	, IsAutoSPT
	, AutoSPT
	)
SELECT c.CustID
	, c.srecommend
	, c.mrecommend
	, c.recommend
	, acs.SportType
	, acs.BetType
	, acs.IsLive
	, mcs.superPT
	, acs.masterPT
	, acs.agentPT
	, 0
	, 0
	, 0
	, 0
FROM @MemberList c 
	INNER JOIN CustPTSetting3rd_Agent acs WITH (NOLOCK) ON c.recommend = acs.CustID
	INNER JOIN dbo.CustPTSetting3rd_Agent mcs WITH (NOLOCK) ON acs.sporttype = mcs.sporttype AND acs.bettype = mcs.bettype AND acs.islive = mcs.islive AND mcs.custid = c.mrecommend
WHERE acs.SportType = @SportType AND acs.BetType = @Bettype AND acs.IsLive = 0
			
--Correct PT
UPDATE cs
SET @a1 = cs.AgentPT
	,@m1 = cs.MasterPT
	,@s1 = cs.SuperPT
	,@n2 = acs.MinPT
	,@l2 = acs.MaxPT
	,@im2 = acs.IsAutoMasterPT
	,@um2 = acs.AutoMasterPT
	,@i1 = cs.IsAutoSPT
	,@u1 = cs.AutoSPT
	,@im1 = cs.IsAutoMPT
	,@um1 = cs.AutoMPT
				
	-- rule #1: s1 = min(s1,s4-m3) if i=0
	,@s1 = CASE WHEN @i1 = 0 AND m.IsAutoSuperPT = 0 AND s.SuperPT-m.MasterPT < @s1 THEN s.SuperPT-m.MasterPT ELSE @s1 END

	-- rule #2: a1 = max(a1,n2); m1 = (a1<n2) ? m3-n2 : m1 --agent min
	,@a_new = CASE WHEN @a1 < @n2 THEN @n2 ELSE @a1 END
	,@m_new = CASE WHEN @a1 < @n2 AND @m1+@n2 > m.MasterPT THEN m.MasterPT-@n2 ELSE @m1 END
	,@a1 = @a_new
	,@m1 = @m_new								

	-- rule #3: a1 = min(a1,l2) -- agent max         
	,@a1 = CASE WHEN @a1 > @l2 THEN @l2 ELSE @a1 END

	-- rule #4: m1 = min(m3-a1,u2) if master auto -- Recalculate AUTO MPT 
	,@temp1 = CASE WHEN @im1 = 1 THEN @um1 ELSE @um2 END			
	,@m1 = CASE 
				WHEN @im2 = 1 OR @im1 = 1 
				THEN CASE WHEN m.MasterPT-@a1 > @temp1 THEN @temp1 ELSE m.MasterPT-@a1 END 
				ELSE @m1 
			END		

	-- rule #5: m1 = max(m1,n3-a1) -- master min   
	,@m1 = CASE WHEN @m1 < m.MinPT-@a1 THEN m.MinPT-@a1 ELSE @m1 END
				         
	-- rule #6: check master max 
	/*	@x1 = min(m3,l3) -- mpt max
		@x2 = max(@x1-a1,0) --mpt
		m1 = (a1+m1>l3) ? @x2 : m1
		@x3 = (a1+@x2 > @x1) ? @x1-@x2 : a1
		a1 = (a1+m1>l1) ? max(@x3, n2) : a1
	*/ 
	,@temp1 = CASE WHEN m.MasterPT > m.MaxPT THEN m.MaxPT ELSE m.MasterPT END
	,@temp2 = CASE WHEN @temp1-@a1 < 0 THEN 0 ELSE @temp1-@a1 END
	,@m_new = CASE WHEN @a1+@m1 > m.MaxPT THEN @temp2 ELSE @m1 END
	,@temp3 = CASE WHEN @a1+@temp2 > @temp1 THEN @temp1-@temp2 ELSE @a1 END
	,@a_new = CASE 
				WHEN @a1+@m1 > m.MaxPT 
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
	,@temp1 = CASE WHEN @i1 = 1 THEN @u1 ELSE m.AutoSuperPT END			
	,@s1 = CASE 
				WHEN @i1 = 1 OR m.IsAutoSuperPT = 1 
				THEN CASE WHEN s.SuperPT-@m1-@a1 > @temp1 THEN @temp1 ELSE s.SuperPT-@m1-@a1 END
				ELSE @s1
			END		

	-- rule #8: s1 = max(n4-m1-a1,s1) --super min
	,@s1 = CASE WHEN @a1+@m1+@s1 < s.MinPT THEN s.MinPT-@m1-@a1 ELSE @s1 END	

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
	,@temp1 = CASE WHEN s.SuperPT-@m1-@a1 < 0 THEN 0 ELSE s.SuperPT-@m1-@a1 END
	,@s_new = CASE WHEN @s1+@a1+@m1 > s.SuperPT THEN @temp1 ELSE @s1 END
	,@temp1 = CASE WHEN @temp1+@m1+@a1 > s.SuperPT THEN s.SuperPT-@temp1 ELSE @m1+@a1 END
	,@temp2 = CASE WHEN m.MasterPT > m.MaxPT THEN m.MaxPT ELSE m.MasterPT END
	,@temp2 = CASE WHEN @temp1 > @temp2 THEN @temp2 ELSE @temp1 END
	,@temp2 = CASE WHEN @temp2 < m.MinPT THEN m.MinPT ELSE @temp2 END
	,@temp3 = CASE WHEN @temp2-@a1 < 0 THEN 0 ELSE @temp2-@a1 END
	,@m_new = CASE WHEN @s1+@a1+@m1 > s.SuperPT THEN @temp3 ELSE @m1 END
	,@temp3 = CASE WHEN @a1+@temp3 > @temp2 THEN @temp2-@temp3 ELSE @a1 END
	,@temp3 = CASE WHEN @temp3 < @n2 THEN @n2 ELSE @temp3 END
	,@a_new = CASE WHEN @s1+@a1+@m1 > s.SuperPT THEN @temp3 ELSE @a1 END
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
FROM @MemberPTTbl cs 
	INNER JOIN dbo.CustPTSetting3rd_Agent acs WITH(NOLOCK) 
		ON cs.recommend = acs.custid 
			AND cs.sporttype = acs.sporttype 
			AND cs.bettype = acs.bettype 
			AND cs.IsLive = acs.IsLive
	INNER JOIN dbo.CustPTSetting3rd_Agent m WITH(NOLOCK) 
		ON cs.mrecommend = m.custid 
			AND cs.sporttype = m.sporttype 
			AND cs.bettype = m.bettype 
			AND cs.IsLive = m.IsLive
	INNER JOIN dbo.CustPTSetting3rd_Agent s WITH(NOLOCK)  
		ON cs.srecommend = s.custid 
			AND cs.sporttype = s.sporttype 
			AND cs.bettype = s.bettype 
			AND cs.IsLive = s.IsLive
--PT
INSERT INTO [dbo].[CustPTSetting3rd_Member]
		([CustID]
		,[SportType]
		,[BetType]
		,[IsLive]
		,[SuperPT]
		,[MasterPT]
		,[AgentPT]
		,[IsAutoMasterPT]
		,[AutoMasterPT]
		,[IsAutoSuperPT]
		,[AutoSuperPT])
SELECT CustID,SportType,BetType,Islive,
	SuperPT,MasterPT,AgentPT,IsAutoMPT,AutoMPT,IsAutoSPT,AutoSPT
FROM @memberPTTbl

--Comm
INSERT INTO CustDiscount3rd_Member (CustID, SportType, BetType, PlayerDiscount, AgentDiscount, MasterDiscount, SuperDiscount)
SELECT 
	c.CustID
	,acs.SportType
	,acs.BetType
	,0
	,acs.Discount
	,mcs.Discount
	,scs.Discount
FROM @MemberList c 
	INNER JOIN dbo.CustDiscount3rd_Agent acs WITH (NOLOCK) ON c.recommend = acs.CustID
	INNER JOIN dbo.CustDiscount3rd_Agent mcs WITH (NOLOCK) ON acs.sporttype = mcs.sporttype AND acs.bettype = mcs.bettype AND mcs.custid = c.mrecommend
	INNER JOIN dbo.CustDiscount3rd_Agent scs WITH (NOLOCK) ON acs.sporttype = scs.sporttype AND acs.bettype = scs.bettype AND scs.custid = c.srecommend
WHERE acs.SportType = @SportType AND acs.BetType = @Bettype

--BetSetting	
INSERT INTO CustStakeLevel_Member(CustID, SportType, BetType, StakeLevelList, LastUpdated)
SELECT	c.CustID, csla.SportType, csla.BetType, ISNULL(sr.LowestStakeLevel, ''), GETDATE()
FROM	@MemberList c
	INNER JOIN dbo.CustStakeLevel_Agent AS csla WITH(NOLOCK) ON c.recommend = csla.CustID
	OUTER APPLY (
		SELECT TOP(1) ISNULL(CONVERT(VARCHAR(20), sl.StakeLevelID), '') AS LowestStakeLevel
		FROM (
			SELECT	CAST(val AS INT) AS val
			FROM	dbo.strSplit(csla.StakeLevelList, ',')
		) AS ss
		INNER JOIN	dbo.StakeLevel AS sl WITH(NOLOCK)
				ON	ss.val = sl.StakeLevelID
		ORDER BY	sl.MaxStake, sl.MinStake, sl.GameGroupID
	) sr
WHERE	csla.SportType = @SportType AND csla.BetType = @Bettype

--WinLossLimit Setting
INSERT INTO CustWinLossLimit_Member(CustId, SportType, BetType, MaxWinLimit, MaxLossLimit, IsAutoReset)
SELECT c.CustID, SportType, BetType, MaxWinLimit, MaxLossLimit, IsAutoReset
FROM CustWinLossLimit_Agent cs WITH (NOLOCK)
	INNER JOIN @MemberList c ON cs.CustID = c.recommend
WHERE cs.SportType = @SportType AND BetType = @Bettype

