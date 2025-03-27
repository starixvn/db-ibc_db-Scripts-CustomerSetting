/*<info serverAlias="DBCUST-CustDB"></info>*/

/*
	Creator: 20250326@Lani
	Task: NAP Risk & Control and CWL - Integrate New Product - HOTDOG [Redmine: #220074]
	Database:	DBCUST.CustDB
*/
/*
	Full range: [11900 - 11999]
	Promotion Prize: 11999
*/

USE CustDB
GO
----------------------------------------------------------------------------------------
DECLARE	@ProductId INT=95, 
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
		@NormalBT	VARCHAR(2000),
		@PromotionBT VARCHAR(2000)

--Get value
SELECT @MaxGroupId=MAX(GroupID)
FROM Winlimit_Group WITH (NOLOCK)

SELECT @GroupName = ProductName
FROM DBACC.bodb02.dbo.Products p WITH (NOLOCK)
WHERE p.ProductID=@ProductID

;WITH cte_Bettype AS (
	SELECT DISTINCT sm.BetType, SubProduct
	FROM DBACC.bodb02.dbo.SportBettypeMatrix sm WITH (NOLOCK)
	INNER JOIN DBACC.bodb02.dbo.bettype b WITH (NOLOCK) ON b.typeid=sm.BetType
	WHERE sm.ProductID=@ProductId
)
SELECT @NormalBT = STUFF((SELECT ',' + CAST(t.BetType AS VARCHAR)
						FROM cte_Bettype t
						WHERE t.SubProduct NOT LIKE '%Prize'
						FOR XML PATH('')
						),1,1,'')
	,@PromotionBT = STUFF((SELECT ',' + CAST(t.BetType AS VARCHAR)
						FROM cte_Bettype t
						WHERE t.SubProduct LIKE '%Prize'
						FOR XML PATH('')
						),1,1,'')
FROM cte_Bettype b
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
SELECT @ProductId, @MaxGroupId + 1, @GroupName + ' - Normal Games', -100000, -50000, 20000, 50000, 100000, NULL, 0
UNION ALL
SELECT @ProductId, @MaxGroupId + 1, @GroupName + ' - Normal Games', -75000, -50000, 10000, 50000, 75000, NULL, 1
UNION ALL
SELECT @ProductId, @MaxGroupId + 1, @GroupName + ' - Normal Games', -75000, -50000, 10000, 50000, 75000, 'RMB,INH', 0
UNION ALL
SELECT @ProductId, @MaxGroupId + 1, @GroupName + ' - Normal Games', -75000, -50000, 10000, 50000, 75000, 'RMB,INH', 1
UNION ALL
SELECT @ProductId, @MaxGroupId + 2, @GroupName + ' - Promotion Prize', 0, 0, 1000, 0, 0, NULL, 0
UNION ALL
SELECT @ProductId, @MaxGroupId + 2, @GroupName + ' - Promotion Prize', 0, 0, 1000, 0, 0, NULL, 1
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------
WHILE (1=1)
BEGIN
	DECLARE 
		@IsBlockedTransfer_DepositSite_Level3 BIT = 0,
		@IsSuspendedAccount_CreditSite_Level2 BIT = 0,	--If: belong to RNG slot; Else: Set = 0
		@IsSuspendedAccount_CreditSite_Level3 BIT = 0	--If: belong to RNG slot; Else: Set = 0

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
		SET @BettypeIds=@PromotionBT		--Promotion Prize bettype
	ELSE 
		SET @BettypeIds=@NormalBT

	IF @IsDeposit=1 
		-- Cash member: block transfer if reach Red level
		SET @IsBlockedTransfer_DepositSite_Level3 = 1
	ELSE IF @IsDeposit=0 AND @GroupName NOT LIKE '%Prize%'
		-- Apply Suspend setting
		SELECT 
			@IsSuspendedAccount_CreditSite_Level2 = 1,
			@IsSuspendedAccount_CreditSite_Level3 = 1
	
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
			@Currency = @Currency,
			@IsBlockedTransfer_DepositSite_Level3 = @IsBlockedTransfer_DepositSite_Level3,
			@IsSuspendedAccount_CreditSite_Level2 = @IsSuspendedAccount_CreditSite_Level2,
			@IsSuspendedAccount_CreditSite_Level3 = @IsSuspendedAccount_CreditSite_Level3
	
		WAITFOR DELAY '00:00:0.200'
	END
END
GO