/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Creator: 20240719@Tacy
	Task: CWL - Fix wrong Global Setting & currency setting for Promotion/Jackpot groups [Redmine: #208200]
	Database:	DBCUST.CustDB

	Revisions:
		- 20240725@Tacy: Run DBTEST
*/

USE CustDB
GO

CREATE TABLE #tmpProductSetting (
		ProductID	INT,
		GroupID		INT,
		Level1		MONEY, 
		Level2		MONEY, 
		Level3		MONEY, 
		Level101	MONEY, 
		Level102	MONEY, 
		Currency  VARCHAR(200),
		IsDeposit BIT,
		IsFinished BIT DEFAULT (0)
)

--Get new setting
INSERT INTO #tmpProductSetting
	(ProductID, GroupID, Level102, Level101, Level1, Level2, Level3, Currency, IsDeposit)
SELECT 21, 53, 0, 0, 1000, 0, 0, NULL, 0
UNION ALL
SELECT 21, 53, 0, 0, 1000, 0, 0, NULL, 1
UNION ALL
SELECT 32, 20, 0, 0, 1000, 0, 0, NULL, 0
UNION ALL
SELECT 32, 20, 0, 0, 1000, 0, 0, NULL, 1
UNION ALL
SELECT 32, 23, 0, 0, 1000, 0, 0, NULL, 0
UNION ALL
SELECT 32, 23, 0, 0, 1000, 0, 0, NULL, 1
UNION ALL
SELECT 32, 33, 0, 0, 0, 3000, 0, NULL, 0
UNION ALL
SELECT 32, 33, 0, 0, 0, 3000, 0, NULL, 1
UNION ALL
SELECT 36, 52, 0, 0, 0, 3000, 0, NULL, 0
UNION ALL
SELECT 36, 52, 0, 0, 0, 3000, 0, NULL, 1
UNION ALL
SELECT 36, 59, 0, 0, 1000, 0, 0, NULL, 0
UNION ALL
SELECT 36, 59, 0, 0, 1000, 0, 0, NULL, 1
UNION ALL
SELECT 42, 41, 0, 0, 0, 3000, 0, NULL, 0
UNION ALL
SELECT 42, 41, 0, 0, 0, 3000, 0, NULL, 1
UNION ALL
SELECT 45, 45, 0, 0, 1000, 0, 0, NULL, 0
UNION ALL
SELECT 45, 45, 0, 0, 1000, 0, 0, NULL, 1
UNION ALL
SELECT 66, 48, 0, 0, 0, 3000, 0, NULL, 0
UNION ALL
SELECT 66, 48, 0, 0, 0, 3000, 0, NULL, 1
UNION ALL
SELECT 73, 57, 0, 0, 1000, 0, 0, NULL, 0
UNION ALL
SELECT 73, 57, 0, 0, 1000, 0, 0, NULL, 1


--Update new setting
DECLARE @ProductId INT, 
		@GroupId   INT, 
		@Level1    MONEY, 
		@Level2    MONEY, 
		@Level3    MONEY, 
		@Level101  MONEY, 
		@Level102  MONEY, 
		@Currency  VARCHAR(MAX),
		@IsDeposit BIT = 0

WHILE EXISTS (SELECT 1 FROM #tmpProductSetting WHERE IsFinished=0)
BEGIN
	UPDATE TOP (1) t
	SET t.IsFinished = 1
		,@ProductId	= t.ProductID
		,@GroupId	= t.GroupID
		,@Level1    = t.Level1
		,@Level2    = t.Level2
		,@Level3    = t.Level3
		,@Level101  = t.Level101
		,@Level102  = t.Level102
		,@Currency  = ISNULL(t.Currency,'')
		,@IsDeposit = t.IsDeposit
	FROM #tmpProductSetting t
	WHERE IsFinished=0

	--Update
	EXEC dbo.NAP_CWL_Update_Settings_xpre 
		@ProductId    = @ProductID
	  , @GroupId      = @GroupID
	  , @Level1       = @Level1
	  , @Level2       = @Level2
	  , @Level3       = @Level3
	  , @Level101     = @Level101
	  , @Level102     = @Level102
	  , @Currency	   = @Currency
	  , @IsDeposit	   = @IsDeposit

	WAITFOR DELAY '00:00:0.200'
END
GO
