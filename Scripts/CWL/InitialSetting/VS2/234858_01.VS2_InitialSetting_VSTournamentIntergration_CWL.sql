/*<info serverAlias="DBCUST-CustDB"></info>*/

/*
	Creator: 20250806@July
	Task: CWL - Virtual Sports 2 - VS Tournament Integration [Redmine: #234858]
	Database:	DBCUST/CustDB
*/
/*
	Full range: [2701 - 2813]
	VS Tournament : 2798
*/

USE CustDB
GO

----------------------------------------------------------
DECLARE	@ProductId INT=27, 
		@MaxGroupId INT,
		@GroupId   INT, 
		@GroupName VARCHAR(200),
		@Level1    MONEY, 
		@Level2    MONEY, 
		@Level3    MONEY, 
		@Level101  MONEY, 
		@Level102  MONEY, 
		@IsDeposit BIT = 0,
		@Currency  VARCHAR(1000),
		@BettypeIds VARCHAR(2000),
		@VSTournamentBT VARCHAR(2000)

--Get value
SELECT @MaxGroupId=MAX(GroupID)
FROM Winlimit_Group WITH (NOLOCK)

SELECT @GroupName = ProductName
FROM DBACC.bodb02.dbo.Products p WITH (NOLOCK)
WHERE p.ProductID=@ProductID

SELECT @VSTournamentBT = '2798'
----------------------------------------------------------------------------------------
DROP TABLE IF EXISTS #tmpProductSetting
CREATE TABLE #tmpProductSetting (
		ProductID	INT,
		GroupID		INT,
		GroupName	VARCHAR(200),
		Level1		MONEY, 
		Level2		MONEY, 
		Level3		MONEY, 
		Level101	MONEY, 
		Level102	MONEY, 
		Currency	VARCHAR(200),
		IsDeposit	BIT,
		IsFinished	BIT DEFAULT (0)
)

INSERT INTO #tmpProductSetting(ProductID, GroupID, GroupName, Level102, Level101, Level1, Level2, Level3, Currency, IsDeposit)
SELECT @ProductId, @MaxGroupId + 1, @GroupName + ' - VS Tournament', 0, 0, 1000, 0, 0, NULL, 1
UNION ALL 
SELECT @ProductId, @MaxGroupId + 1, @GroupName + ' - VS Tournament', 0, 0, 1000, 0, 0, NULL, 0
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------

INSERT INTO Winlimit_GameGroupSetting (ProductID,BetTypeID, GroupID, RepUpdateTime)
SELECT @ProductId, 2798, @MaxGroupId + 1, dbo.f_GetDateTime2()

--Miss bettype 
IF NOT EXISTS ( SELECT TOP 1 1 FROM Winlimit_GameGroupSetting WITH (NOLOCK) WHERE ProductID = @ProductId AND BetTypeID IN (2813)) 
BEGIN
	INSERT INTO Winlimit_GameGroupSetting (ProductID,BetTypeID, GroupID, RepUpdateTime)
	SELECT @ProductId, 2813, 12, dbo.f_GetDateTime2()
END

IF NOT EXISTS ( SELECT TOP 1 1 FROM Winlimit_GameGroupSetting WITH (NOLOCK) WHERE ProductID = @ProductId AND BetTypeID IN (2770)) 
BEGIN
	INSERT INTO Winlimit_GameGroupSetting (ProductID,BetTypeID, GroupID, RepUpdateTime)
	SELECT @ProductId, 2770, 12, dbo.f_GetDateTime2()
END
IF NOT EXISTS ( SELECT TOP 1 1 FROM Winlimit_GameGroupSetting WITH (NOLOCK) WHERE ProductID = @ProductId AND BetTypeID IN (2771)) 
BEGIN
	INSERT INTO Winlimit_GameGroupSetting (ProductID,BetTypeID, GroupID, RepUpdateTime)
	SELECT @ProductId, 2771, 12, dbo.f_GetDateTime2()
END


UPDATE w
SET w.GroupName = 'Virtual Sports 2 - Normal Games'
FROM Winlimit_Group AS w WITH (UPDLOCK, ROWLOCK)
WHERE w.GroupName = 'Virtual Sports 2'

UPDATE w
SET w.GroupName = 'Virtual Sports 2 - Normal Games'
FROM Winlimit_ProductGlobalSetting AS w WITH (UPDLOCK, ROWLOCK)
WHERE w.ProductID = 27 AND w.BetTypeID = 2701

WHILE (1=1)
BEGIN

	UPDATE TOP (1) t
	SET t.IsFinished = 1
		,@GroupId	= t.GroupID
		,@GroupName	= t.GroupName
		,@Level1    = t.Level1
		,@Level2    = t.Level2
		,@Level3    = t.Level3
		,@Level101  = t.Level101
		,@Level102  = t.Level102
		,@Currency  = ISNULL(t.Currency,'')
		,@IsDeposit = t.IsDeposit
	FROM #tmpProductSetting t
	WHERE IsFinished=0

	IF @@ROWCOUNT = 0
		BREAK

	SET @BettypeIds = @VSTournamentBT		
	
	SELECT	@ProductID AS ProductID, 
			@BettypeIds AS BettypeIds, 
			@GroupID	AS GroupID,
			@GroupName	AS GroupName,
			@IsDeposit	AS IsDeposit

	----------------------------------------------------------
	BEGIN 
		EXEC NAP_CWL_Initialize_Settings 
			@ProductID = @ProductID, 
			@BetTypeID_Begin = 0,
			@BetTypeID_END = 0, 
			@BettypeIds = @BettypeIds,
			@GroupID = @GroupID, 
			@GroupName = @GroupName, 
			@Level101 = @Level101, 
			@Level102 = @Level102, 
			@Level1 = @Level1, 
			@Level2 = @Level2, 
			@Level3 = @Level3, 
			@IsDeposit = @IsDeposit, 
			@RepresentativeBettype = 1201,
			@Currency = @Currency
	
		WAITFOR DELAY '00:00:0.200'
	END
END
GO