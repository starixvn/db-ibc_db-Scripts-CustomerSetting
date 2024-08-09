/*<info serverAlias=DBCUST-CustDB></info>*/

/*
	Creator: 20240710@Tacy
	Task: CWL - Non Sports Report - Nextspin - Integrate New Product [Redmine: #199987]
	Database:	DBCUST.CustDB
*/
/*
	Full range: [10450 - 10750]
*/

USE CustDB
GO

----------------------------------------------------------
DECLARE	@ProductID TINYINT = 85, 
		@BetTypeID_Begin SMALLINT, 
		@BetTypeID_End SMALLINT, 
		@GroupID TINYINT, 
		@GroupName VARCHAR(200),
		@Level1    MONEY, 
		@Level2    MONEY, 
		@Level3    MONEY, 
		@Level101  MONEY, 
		@Level102  MONEY, 
		@IsDeposit BIT = 0,
		@Currency  VARCHAR(1000)

--Get value
SELECT @BetTypeID_Begin = MIN (BetType)
	 , @BetTypeID_End = MAX(BetType)
FROM DBACC.bodb02.dbo.SportBettypeMatrix sm WITH (NOLOCK)
WHERE sm.ProductID=@ProductID

SELECT @GroupID = (MAX(GroupID) + 1) 
FROM Winlimit_Group WITH (NOLOCK)

SELECT @GroupName = ProductName
FROM DBACC.bodb02.dbo.Products p WITH (NOLOCK)
WHERE p.ProductID=@ProductID

SELECT	@ProductID AS ProductID, 
		@BetTypeID_Begin AS BetTypeID_Begin, 
		@BetTypeID_End	 AS BetTypeID_End, 
		@GroupID	AS GroupID,
		@GroupName	AS GroupName
----------------------------------------------------------
----------------------------------------------------------------------------------------
DROP TABLE IF EXISTS #tmpProductSetting
CREATE TABLE #tmpProductSetting (
		Level1		MONEY, 
		Level2		MONEY, 
		Level3		MONEY, 
		Level101	MONEY, 
		Level102	MONEY, 
		Currency	VARCHAR(200),
		IsDeposit	BIT,
		IsFinished	BIT DEFAULT (0)
)

INSERT INTO #tmpProductSetting(Level102, Level101, Level1, Level2, Level3, Currency, IsDeposit)
SELECT -75000, -50000, 10000, 50000, 75000, NULL, 1
UNION ALL
SELECT -100000, -50000, 20000, 50000, 100000, NULL, 0
UNION ALL
SELECT -75000, -50000, 10000, 50000, 75000, 'RMB,INH', 0
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

	IF @IsDeposit=1
		-- Cash member: block transfer if reach Red level
		SET @IsBlockedTransfer_DepositSite_Level3 = 1
	ELSE 
		-- Apply Suspend setting
		SELECT 
			@IsSuspendedAccount_CreditSite_Level2 = 1,
			@IsSuspendedAccount_CreditSite_Level3 = 1
	
	----------------------------------------------------------
	BEGIN 
		EXEC NAP_CWL_Initialize_Settings 
			@ProductID = @ProductID, 
			@BetTypeID_Begin = @BetTypeID_Begin, 
			@BetTypeID_End = @BetTypeID_End, 
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