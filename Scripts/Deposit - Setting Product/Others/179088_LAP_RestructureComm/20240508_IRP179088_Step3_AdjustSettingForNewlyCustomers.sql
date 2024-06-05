/*<info serverAlias="DBCUST-bodb_Licensee"></info>*/
/*
	Created: 20240508@Johnson
	Task: LAP -Migrate data for new structure Player Commission
	DB: DBCUST/bodb_Licensee
*/
	CREATE TABLE #tblCust (LicenseeID INT, CustID INT PRIMARY KEY,GroupDiscountID INT)
	DECLARE @tmpCust TABLE(CustID INT PRIMARY KEY,GroupDiscountID INT)
	DECLARE @tmpLic TABLE(LicenseeID INT,GroupDiscountID INT)
	DECLARE @tblSettingDCS TABLE (Col VARCHAR(20),Sporttype INT, Bettype INT)
	
	DECLARE @MaxCustID INT = xxx,
			@MaxGroupDiscountID INT = yyy
	
	INSERT INTO @tblSettingDCS (Col,sporttype,Bettype)
	VALUES ('MacauComm', 212,4001)
		, ('PPComm',248,4101)
		-- phase 2
		,('SexyGamingComm',243,3101)
		,('SpadeGamingComm' ,247,4301)
		,('LotteryComm' ,220,1021)
		,('VSComm' ,9908,1201)
		,('TableGameComm' ,222,4901)
		-- Phase 3
		,('VirtualGamesComm',245,4601)
		,('ArcadiaGamingComm',165,1901)
		,('SabaclubComm',200,1611)
		,('SAGamingComm',244,3001)
		,('PGSoftComm',232,6001)
		,('AllbetComm',211,2401)
		--Saba Casino
		,('RNGComm',208,2101)
		--> phase 4
		,('WMCasinoComm',233,3401)
		,('BigGamingComm',239,3501)
		,('JokerComm',234,6401)
		,('HabaneroComm',238,7001)
		,('VGamingComm',171,3801)				
		-- Phase 4.2
		,('CGComm',167,7301)
		,('AdvantComm',172,7701)
		,('AdvantMiniComm',174,7801)
		
		,('MaxGameComm',237,5401)
		,('FGGComm',176,8201)
		,('JiliComm',158,5100)

		,('YeeBetComm',159,3151)
		,('MgRNGComm',155,8400)

		--
		,('SBComm',1,1)
		,('SBComm',1,4)
		,('SBComm',1,5)
		,('SBComm',2,2)
		,('ParlayComm',1,9)
		,('NGComm',161,81)
		,('KenoComm',202,1501)
		
	INSERT INTO #tblCust(LicenseeID,CustID,GroupDiscountID)
	SELECT LicenseeID,CustID,GroupCommID
	FROM LicenseeCustComm WITH(NOLOCK)
	WHERE custid > @MaxCustID
		
	WHILE(1=1)
	BEGIN	
		DELETE TOP(5000) t
		OUTPUT DELETED.LicenseeID, DELETED.CustID, DELETED.GroupDiscountID 
		INTO @tmpCust(LicenseeID,CustID,GroupDiscountID)
		FROM #tblCust t
		
		IF @@ROWCOUNT = 0
			BREAK;
				
		INSERT INTO LicenseeCustDiscount (LicenseeID,CustID,GroupDiscountID)	
		SELECT LicenseeID,CustID,GroupDiscountID
		FROM @tmpCust t
			LEFT JOIN LicenseeCustDiscount c WITH(NOLOCK) ON t.custid = c.custid
		WHERE c.custid IS NULL
		
		DELETE @tmpCust
	END
	
	
	SET IDENTITY_INSERT [LicenseeGroupDiscount] ON

	INSERT INTO [dbo].[LicenseeGroupDiscount]
			   ([GroupDiscountID],
			   [LicenseeID]
			   ,[GroupName]
			   ,[IsActive]
			   ,[color]
			   ,[IsDefault])
	OUTPUT INSERTED.GroupDiscountID, INSERTED.LicenseeID INTO @tmpLic(GroupDiscountID,LicenseeID)			
	SELECT  ID
		,[LicenseeID]
	   ,[GroupName]
	   ,[IsActive]
	   ,[color]
	   ,[IsDefault]
	FROM LicenseeGroupComm gc WITH(NOLOCK)
		LEFT JOIN LicenseeGroupDiscount gd WITH(NOLOCK) ON gc.ID = gd.GroupDiscountID
	WHERE gd.GroupDiscountID IS NULL	
		AND gc.ID > @MaxGroupDiscountID

	SET IDENTITY_INSERT [LicenseeGroupDiscount] OFF
	
	IF @@ROWCOUNT = 0
		RETURN;
	
	;WITH tmp AS (
		SELECT *
		FROM
		(
		SELECT id, LicenseeID,  MacauComm,PPComm, SexyGamingComm, SpadeGamingComm, LotteryComm, VSComm, TableGameComm, VirtualGamesComm, ArcadiaGamingComm,
			SabaclubComm, SAGamingComm, PGSoftComm, AllbetComm, RNGComm, WMCasinoComm, BigGamingComm, JokerComm
			, HabaneroComm, VGamingComm, CGComm, AdvantComm, AdvantMiniComm, MaxGameComm, FGGComm, JiliComm, YeeBetComm, MgRNGComm,
			SBComm, Parlaycomm, NGComm, KenoComm
		FROM LicenseeGroupComm WITH(NOLOCK)
		WHERE ID IN (SELECT GroupDiscountID FROM @tmpLic)) t
		UNPIVOT (
			Discount for col IN ( MacauComm,PPComm, SexyGamingComm, SpadeGamingComm, LotteryComm, VSComm, TableGameComm, VirtualGamesComm, ArcadiaGamingComm,
				SabaclubComm, SAGamingComm, PGSoftComm, AllbetComm, RNGComm, WMCasinoComm, BigGamingComm, JokerComm
				,HabaneroComm, VGamingComm, CGComm, AdvantComm, AdvantMiniComm, MaxGameComm, FGGComm, JiliComm, YeeBetComm, MgRNGComm,
				SBComm, Parlaycomm, NGComm, KenoComm)
		) as unpvt
	)
	INSERT INTO LicenseeGroupDiscountDetail (GroupDiscountID,Licenseeid,SportType,BetType,Discount) 
	SELECT id,Licenseeid,SportType,BetType,Discount
	FROM tmp
	INNER JOIN @tblSettingDCS t on tmp.col = t.Col
	