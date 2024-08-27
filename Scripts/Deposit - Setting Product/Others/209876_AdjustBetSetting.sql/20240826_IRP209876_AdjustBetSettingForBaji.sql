/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240826@Johnson
	Task: [Baji] - Adjust SB betlimit for BDT [Redmine: #209876]
	DB: DBCust/CustDB
*/
--Step 1: deploy sp on DBCUST
ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_09]
	 @CustID				INT
	,@BetLimit				VARCHAR(MAX) =''	
AS
	--Clone from sp Acc_Dep_DynamicCustSetting_02
BEGIN
	DECLARE @CustList	VARCHAR(MAX),
			@ErrMsg		NVARCHAR(MAX)

	CREATE TABLE #tempMem(ID INT IDENTITY (1,1) PRIMARY KEY,
						CustID			INT ,
						SportType		INT ,
						BetType			INT,						
						MaxBet			MONEY,
						MaxPerMatch		MONEY,						
						MaxPayoutPerMatch	MONEY
						)
	CREATE NONCLUSTERED INDEX IDX_tempMem ON #tempMem(CustID,Sporttype,bettype)
	
	DECLARE @StartRow	INT, 
			@MaxRow		INT,
			@Threshold	INT, 
			@StopRow INT			
	SET @StartRow=1
	SET @Threshold=2000

	DECLARE @NewBetLimitTbl TABLE (
		SportType			INT
		, BetType			INT		
		, MaxBet			MONEY
		, MaxPerMatch		MONEY		
		, MaxPayoutPerMatch	MONEY
		)

	DECLARE @History_BetLimitTbl TABLE (
		CustID				INT
		, SportType			INT
		, BetType			INT
		, MaxBet			MONEY
		, MaxPerMatch		MONEY
		, UpdateTime		DATETIME
		)

	--Parse XML	
	DECLARE @iDoc INT
	
	EXEC sp_xml_preparedocument @iDoc OUTPUT
			, @BetLimit

	INSERT @NewBetLimitTbl(SportType,BetType,MaxBet,MaxPerMatch,MaxPayoutPerMatch)
	SELECT SportType,BetType,MaxBet,MaxPerMatch,MaxPayoutPerMatch
	FROM OPENXML(@iDoc, '/ROOT/BetLimit', 1) WITH (
			SportType		INT
			, BetType		INT			
			, MaxBet		MONEY
			, MaxPerMatch	MONEY			
			, MaxPayoutPerMatch	MONEY
			)

	EXEC sp_xml_removedocument @iDoc

	INSERT INTO #tempMem(CustID,SportType,BetType,MaxBet,MaxPerMatch,MaxPayoutPerMatch)
	SELECT c.CustID,s.SportType,s.BetType,s.MaxBet,s.MaxPerMatch,s.MaxPayoutPerMatch
	FROM Customer c WITH(NOLOCK)				
		CROSS APPLY @NewBetLimitTbl s
		LEFT JOIN Dep_CustSettingMode m WITH(NOLOCK) ON c.custid = m.CustID
	WHERE c.recommend=@CustID 
		AND c.roleid =1	
		AND ISNULL(m.IsGroupedBetLimit,0) = 0

	IF EXISTS(SELECT 1 FROM #tempMem)
	BEGIN
		
		SET @MaxRow = (SELECT MAX(ID) FROM #tempMem)
		
		IF	@Threshold >= @MaxRow
		SET	@Threshold = @MaxRow
		
		SET @StopRow = @Threshold

		WHILE (0 = 0)
		BEGIN	
			DELETE FROM @History_BetLimitTbl
			
			UPDATE main
			SET main.maxbet		= tmp.MaxBet
				, main.maxpermatch	= tmp.MaxperMatch				
				, main.MaxPayoutPerMatch	= tmp.MaxPayoutPerMatch				
			OUTPUT deleted.CustID, deleted.SportType, deleted.BetType, deleted.MaxBet, deleted.MaxPerMatch, GETDATE()
				INTO @History_BetLimitTbl
			FROM dbo.Dep_CustBetSettingGame_Member main WITH(ROWLOCK)
				INNER JOIN #tempMem tmp	ON main.CustID=tmp.CustID AND tmp.SportType = main.sporttype AND tmp.BetType = main.bettype
			WHERE ID >= @StartRow AND ID <= @StopRow
				AND	(main.maxbet		<> tmp.MaxBet
					OR main.maxpermatch <> tmp.MaxperMatch					
					OR main.MaxPayoutPerMatch <> tmp.MaxPayoutPerMatch
					)

			--update MinBet only and be not NG
			DELETE FROM @History_BetLimitTbl WHERE SportType<>161

			DELETE old
			FROM @History_BetLimitTbl old
				INNER JOIN #tempMem new ON new.CustID=old.CustID
										AND new.SportType=old.SportType
										AND new.BetType=old.BetType
										AND new.MaxBet=old.MaxBet
										AND new.MaxPerMatch=old.MaxPerMatch

			--Insert history bet setting
			IF EXISTS (SELECT 1 FROM @History_BetLimitTbl)
			BEGIN
				SET @CustList = (SELECT CustID		AS '@CustID',
										SportType	AS '@SportType',
										BetType		AS '@BetType',
										MaxBet		AS '@MaxBet',
										MaxPerMatch	AS '@MaxPerMatch',
										'NULL'		AS '@StakeLevelList',
										UpdateTime	AS '@UpdateTime'
								 FROM @History_BetLimitTbl
								 FOR XML PATH ('r'), ROOT ('root')
								 )

				EXECUTE Acc_Dep_DynamicCustSetting_07 @CustList=@CustList, @ErrMsg=@ErrMsg OUTPUT

				IF @ErrMsg<>''
					RETURN
			END
			
			IF	@StopRow = @MaxRow 
				BREAK
					
			SET	@StartRow = @StopRow + 1
					
			SET	@StopRow = 1 + @StopRow + @Threshold
					
			IF	@StopRow >= @MaxRow
				SET	@StopRow = @MaxRow
									
		END;
	END;			
END
GO 
--End step 1: deploy sp on DBCUST
------------------------------------------------------

--Run this script on DBCUST only
DECLARE @custid INT = 47466474,--BajiBDT01
		@srecommend INT,
		@mrecommend INT

DECLARE @tmpSetting TABLE(Sporttype INT, Bettype INT, MaxBet MONEY, MaxPerMatch MONEY, MaxPayoutPerMatch MONEY)
DECLARE @BetLimit VARCHAR(MAX)

SELECT @BetLimit=
'<ROOT>
	<BetLimit SportType="1" BetType="1" MaxBet="1190000" MaxPerMatch="1190000" MaxPayoutPerMatch="9520000"/>
	<BetLimit SportType="50" BetType="1" MaxBet="4760000" MaxPerMatch="23800000" MaxPayoutPerMatch="71399000"/>
</ROOT>'

INSERT INTO @tmpSetting(Sporttype,Bettype,MaxBet,MaxPerMatch,MaxPayoutPerMatch)
SELECT 1,1,1190000,1190000,9520000
UNION SELECT 50,1,4760000,23800000,71399000
		
SELECT @srecommend = srecommend,
	@mrecommend = mrecommend
FROM custinfo WITH(NOLOCK)
WHERE custid = @custid

UPDATE cs
SET cs.MaxBet = t.MaxBet,
	cs.MaxPerMatch = t.MaxPerMatch,
	cs.MaxPayoutPerMatch = t.MaxPayoutPerMatch
FROM Dep_CustBetSettingGame_Agent cs WITH(UPDLOCK,ROWLOCK)
	INNER JOIN @tmpSetting t ON cs.Sporttype = t.Sporttype
								AND cs.Bettype = t.Bettype
WHERE cs.custid IN (@custid,@srecommend,@mrecommend)

UPDATE cs
SET cs.MaxBet = t.MaxBet,
	cs.MaxPerMatch = t.MaxPerMatch,
	cs.MaxPayoutPerMatch = t.MaxPayoutPerMatch
FROM Dep_CustBetSettingGameGroup_Member cs WITH(UPDLOCK,ROWLOCK)
	INNER JOIN @tmpSetting t ON cs.Sporttype = t.Sporttype
								AND cs.Bettype = t.Bettype
WHERE cs.AgentID = @custid

EXEC Acc_Dep_DynamicCustSetting_09				
				@CustID=@custid,
				@BetLimit=@BetLimit