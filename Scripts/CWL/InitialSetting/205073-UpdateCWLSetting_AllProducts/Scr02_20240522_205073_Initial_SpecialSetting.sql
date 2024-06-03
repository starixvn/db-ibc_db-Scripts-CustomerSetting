/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Creator: 20240522@Tacy
	Task: CWL - Support to change new setting for all products [Redmine: #205073]
		- Add Special Setting for some products

	Revision:
		- 20240530@Tacy: issue when use @BetTypeID_Begin/@BetTypeID_End 
				Add setting for existing products --> should use @BettypeIDs (list bettypes)

	Database:	DBCUST.CustDB
*/

USE CustDB
GO

DECLARE	@ProductId INT, 
		@GroupId   INT, 
		@GroupName VARCHAR(200),
		@Level1    MONEY, 
		@Level2    MONEY, 
		@Level3    MONEY, 
		@Level101  MONEY, 
		@Level102  MONEY, 
		@IsDeposit BIT = 0,
		@BetTypeID_Begin SMALLINT,
		@BetTypeID_End SMALLINT
	--	,@BettypeIds VARCHAR(2000)

CREATE TABLE #tmpProductSetting (
		ProductID	INT,
		GroupID		INT,
		GroupName	VARCHAR(200),
		Level1		MONEY, 
		Level2		MONEY, 
		Level3		MONEY, 
		Level101	MONEY, 
		Level102	MONEY, 
		IsDeposit	BIT,
		IsFinished	BIT DEFAULT (0)
)
----------------------------------------------------------
--Get setting
INSERT INTO #tmpProductSetting
	(ProductID, GroupID, GroupName, Level1, Level2, Level3, Level101, Level102, IsDeposit)
SELECT 8, 4, 'RNG Keno', 50000, 100000, 200000, -100000, -250000, 1
UNION ALL
SELECT 8, 4, 'RNG Keno', 50000, 100000, 200000, -100000, -250000, 0
UNION ALL
SELECT 40, 29, 'Table Game', 10000, 30000, 75000, -30000, -75000, 1
UNION ALL
SELECT 40, 29, 'Table Game', 10000, 30000, 75000, -30000, -75000, 0
UNION ALL
SELECT 5, 2, 'Virtual Sports', 20000, 50000, 150000, -50000, -150000, 1
UNION ALL
SELECT 5, 2, 'Virtual Sports', 20000, 50000, 150000, -50000, -150000, 0
UNION ALL
SELECT 27, 12, 'Virtual Sports 2', 20000, 50000, 150000, -50000, -150000, 1
UNION ALL
SELECT 27, 12, 'Virtual Sports 2', 20000, 50000, 150000, -50000, -150000, 0
UNION ALL
SELECT 77, 62, 'Virtual Sports 3', 20000, 50000, 150000, -50000, -150000, 1
UNION ALL
SELECT 77, 62, 'Virtual Sports 3', 20000, 50000, 150000, -50000, -150000, 0
UNION ALL
SELECT 83, 66, 'Virtual Sports 4', 10000, 30000, 75000, -30000, -75000, 1
UNION ALL
SELECT 83, 66, 'Virtual Sports 4', 10000, 30000, 75000, -30000, -75000, 0
UNION ALL
SELECT 3, 1, 'Number Game', 50000, 100000, 250000, -100000, -250000, 1
UNION ALL
SELECT 3, 1, 'Number Game', 50000, 100000, 250000, -100000, -250000, 0

WHILE (1=1)
BEGIN
	UPDATE TOP (1) T
	SET T.IsFinished=1
		,@ProductId	= t.ProductID
		,@GroupId	= t.GroupID
		,@GroupName=t.GroupName
		,@Level1    = t.Level1
		,@Level2    = t.Level2
		,@Level3    = t.Level3
		,@Level101  = t.Level101
		,@Level102  = t.Level102
		,@IsDeposit = t.IsDeposit
	FROM #tmpProductSetting T
	WHERE IsFinished=0

	IF @@ROWCOUNT = 0
		BREAK
	
	/*
	SELECT @BettypeIds=(STUFF((SELECT ',' + CAST(BetTypeID AS VARCHAR)
							FROM Winlimit_GameGroupSetting WITH (NOLOCK)
							WHERE ProductID=@ProductId
							FOR XML PATH('')
							),1,1,''))
	*/

	SELECT @BetTypeID_Begin = MIN (BetTypeID)
		 , @BetTypeID_End = MAX(BetTypeID)
	FROM Winlimit_GameGroupSetting WITH (NOLOCK)
	WHERE ProductID=@ProductID

	SELECT	@ProductID AS ProductID, 
			@BetTypeID_Begin AS BetTypeID_Begin, 
			@BetTypeID_End	 AS BetTypeID_End, 
			@GroupID	AS GroupID,
			@GroupName	AS GroupName,
			@IsDeposit	AS IsDeposit

	----------------------------------------------------------
	BEGIN 
		EXEC NAP_CWL_Initialize_Settings 
			@ProductID = @ProductID, 
			@BetTypeID_Begin = @BetTypeID_Begin, 
			@BetTypeID_End = @BetTypeID_End, 
	--		@BettypeIds = @BettypeIds,
			@GroupID = @GroupID, 
			@GroupName = @GroupName, 
			@Level101 = @Level101, 
			@Level102 = @Level102, 
			@Level1 = @Level1, 
			@Level2 = @Level2, 
			@Level3 = @Level3, 
			@IsDeposit = @IsDeposit, 
			@RepresentativeBettype = @BetTypeID_Begin,
			@Currency = 'INH,RMB'
	
		WAITFOR DELAY '00:00:0.200'
	END
END
GO