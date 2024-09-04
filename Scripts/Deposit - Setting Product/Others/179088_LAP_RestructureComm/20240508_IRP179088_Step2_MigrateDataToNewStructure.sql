/*<info serverAlias="DBCUST-bodb_Licensee"></info>*/
/*
	Created: 20240410@Johnson
	Task: LAP -Migrate data for new structure Player Commission
	DB: DBCUST/bodb_Licensee
*/
ALTER PROCEDURE [dbo].[Lrf_ExecRep_09] 
	@LicenseeID INT,
	@MaxCustID INT,
	@MaxGroupDiscountID INT,
	@target VARCHAR(20)	
AS
BEGIN	
	SET NOCOUNT ON;

	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DBSPARE','TESTDBCUST')) RETURN -- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DBSPARE','TESTDBCUST')) RETURN -- run at dbcust only
	
	IF (dbo.f_CheckRepTable('LicenseeGroupComm') = 0	
		OR dbo.f_CheckRepTable('LicenseeCustComm') = 0		 		 
		OR dbo.f_CheckRepTable('LicenseeGroupDiscount') = 0
		OR dbo.f_CheckRepTable('LicenseeGroupDiscountDetail') = 0
		OR dbo.f_CheckRepTable('LicenseeCustDiscount') = 0	
		)
	RETURN
	
	CREATE TABLE #tblCust (CustID INT PRIMARY KEY,GroupDiscountID INT)
	DECLARE @tmpCust TABLE(CustID INT PRIMARY KEY,GroupDiscountID INT)
	DECLARE @tblSettingDCS TABLE (Col VARCHAR(20),Sporttype INT, Bettype INT)

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
		
	INSERT INTO #tblCust(CustID,GroupDiscountID)
	SELECT CustID,GroupCommID
	FROM LicenseeCustComm WITH(NOLOCK)
	WHERE LicenseeID = @LicenseeID
		AND custid <= @MaxCustID
		
	WHILE(1=1)
	BEGIN	
		DELETE TOP(5000) t
		OUTPUT DELETED.CustID, DELETED.GroupDiscountID 
		INTO @tmpCust(CustID,GroupDiscountID)
		FROM #tblCust t
		
		IF @@ROWCOUNT = 0
			BREAK;
				
		INSERT INTO LicenseeCustDiscount (LicenseeID,CustID,GroupDiscountID)	
		SELECT @LicenseeID,CustID,GroupDiscountID
		FROM @tmpCust t
		
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
	SELECT  ID
		,[LicenseeID]
	   ,[GroupName]
	   ,[IsActive]
	   ,[color]
	   ,[IsDefault]
	FROM LicenseeGroupComm WITH(NOLOCK)
	WHERE LicenseeID = @LicenseeID
		AND ID <= @MaxGroupDiscountID

	SET IDENTITY_INSERT [LicenseeGroupDiscount] OFF
			
	;WITH tmp AS (
		SELECT *
		FROM
		(
		SELECT id, LicenseeID,  MacauComm,PPComm, SexyGamingComm, SpadeGamingComm, LotteryComm, VSComm, TableGameComm, VirtualGamesComm, ArcadiaGamingComm,
			SabaclubComm, SAGamingComm, PGSoftComm, AllbetComm, RNGComm, WMCasinoComm, BigGamingComm, JokerComm
			, HabaneroComm, VGamingComm, CGComm, AdvantComm, AdvantMiniComm, MaxGameComm, FGGComm, JiliComm, YeeBetComm, MgRNGComm,
			SBComm, Parlaycomm, NGComm, KenoComm
		FROM LicenseeGroupComm WITH(NOLOCK)
		WHERE LicenseeID = @LicenseeID
			AND ID <= @MaxGroupDiscountID) t
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
	
	DROP TABLE #tblCust	
END
GO

-- END STEP 1: DEPLOY THIS SP @ DBCUST.CustDB -------
------------------------------------------------------

------------------------------------------------------	
-- BEGIN STEP 2: Run this SP at DBCUST & replicated DB -----
--------------------------------------------------------------------------------------
DECLARE @tmpLicensee TABLE (LicenseeID INT, IsFinished BIT DEFAULT 0)

DECLARE @LicenseeID INT,
	@MaxCustID INT = xxx,
	@MaxGroupDiscountID INT = yyy,
	@Target VARCHAR(30)
	
IF @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DBSPARE')
	SELECT @Target = 'DBCUST'
ELSE 
	SELECT @Target = 'REPLICATED'	
	
INSERT INTO @tmpLicensee(LicenseeID)
SELECT LicenseeID 
FROM Licensees WITH(NOLOCK)
WHERE IsDeposit = 1 
	AND IsActive = 1
			
-- For deployer info
DECLARE @cnt INT, @index INT = 0

SET @cnt = (SELECT COUNT(*) FROM @tmpLicensee )

DECLARE @msg NVARCHAR(200) = 'Currently at order %d, LicID: %d.'

DECLARE @msg_total NVARCHAR(200) = 'Total of Licensee: %d.'

RAISERROR (@msg_total, 0, 1, @cnt) WITH NOWAIT
	
WHILE(1=1)
BEGIN
	UPDATE TOP (1) t
	SET IsFinished = 1,
		@LicenseeID = LicenseeID
	FROM @tmpLicensee t
	WHERE IsFinished = 0
	
	IF @@ROWCOUNT = 0
		BREAK;
	
	SET @index = @index + 1
	
	RAISERROR (@msg, 0, 1,@index, @LicenseeID) WITH NOWAIT
	
	EXEC Lrf_ExecRep_09
		@LicenseeID = @LicenseeID,
		@MaxCustID = @MaxCustID,
		@MaxGroupDiscountID = @MaxGroupDiscountID,
		@target = @Target
		
	WAITFOR DELAY '00:00:00.1'		
END	
GO
-- END STEP 2: Run this SP at DBCUST & replicated DB -----
--------------------------------------------------------------------------------------
