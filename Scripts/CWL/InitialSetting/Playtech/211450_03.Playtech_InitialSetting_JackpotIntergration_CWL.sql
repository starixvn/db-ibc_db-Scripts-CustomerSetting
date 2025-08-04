/*<info serverAlias="DBCUST-CustDB"></info>*/

/*
	Creator: 20250729@July
	Task: CWL - Playtech - Integrate New Product [Redmine: #233896]
	Database:	DBCUST/CustDB
*/
/*
	Full range: [12500 - 12999]
	Jackpot Prize: 12999
*/

USE CustDB
GO

----------------------------------------------------------
DECLARE	@ProductId INT=100, 
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
		@JackpotBT VARCHAR(2000)

--Get value
SELECT @MaxGroupId=MAX(GroupID)
FROM Winlimit_Group WITH (NOLOCK)

SELECT @GroupName = ProductName
FROM DBACC.bodb02.dbo.Products p WITH (NOLOCK)
WHERE p.ProductID=@ProductID

SELECT @JackpotBT = '12999'
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
SELECT @ProductId, @MaxGroupId + 1, @GroupName + ' - Jackpot Prize', 0, 0, 0, 3000, 0, NULL, 1
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------

UPDATE w
SET w.GroupID = @MaxGroupId + 1, w.RepUpdateTime = dbo.f_GetDateTime2()
FROM Winlimit_GameGroupSetting AS w WITH (UPDLOCK, ROWLOCK)
WHERE w.BetTypeID = 12999 AND w.ProductID = @ProductId

UPDATE w
SET w.GroupName = 'Playtech - Normal Games'
FROM Winlimit_Group AS w WITH (UPDLOCK, ROWLOCK)
WHERE w.GroupName = 'Playtech'

UPDATE w
SET w.GroupName = 'Playtech - Normal Games'
FROM Winlimit_ProductGlobalSetting AS w WITH (UPDLOCK, ROWLOCK)
WHERE w.ProductID = 100 AND w.BetTypeID = 12500

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

	IF @GroupName LIKE '%Prize%'
		SET @BettypeIds = @JackpotBT		--Jackpot Prize bettype
	
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
			@BetTypeID_End = 0, 
			@BettypeIds = @BettypeIds,
			@GroupID = @GroupID, 
			@GroupName = @GroupName, 
			@Level101 = @Level101, 
			@Level102 = @Level102, 
			@Level1 = @Level1, 
			@Level2 = @Level2, 
			@Level3 = @Level3, 
			@IsDeposit = @IsDeposit, 
			@RepresentativeBettype = 4001,
			@Currency = @Currency
	
		WAITFOR DELAY '00:00:0.200'
	END
END
GO