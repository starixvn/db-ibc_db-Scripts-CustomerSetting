/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created By: Eden@20200923
	Description: Live Casino Products - SA Gaming - Update bet Limit for IBCIndo Site [RM#142163]
	DB: DBCust/CustDB	
*/
USE CustDB
GO

DECLARE @CRE_Stake TABLE (
	[GameTypeID] INT,
	[Currency] [nvarchar](max) NULL,
	[MinStake] [money] NULL,
	[MaxStake] [money] NULL,
	[MinLabel] [varchar](20) NULL,
	[MaxLabel] [varchar](20) NULL
) 
--SA
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (3001, N'DDD', 30.00, 3000.00, '30', '3,000') -- IDR
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (3001, N'DDD', 500.00, 10000.00, '500', '10,000') -- IDR
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (3001, N'DDD', 1000.00, 20000.00, '1,000', '20,000') -- IDR
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (3001, N'DDD', 1000.00, 50000.00, '1,000', '50,000') -- IDR
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (3001, N'IND', 30.00, 3000.00, '30', '3,000') -- IDR
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (3001, N'IND', 500.00, 10000.00, '500', '10,000') -- IDR
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (3001, N'IND', 1000.00, 20000.00, '1,000', '20,000') -- IDR
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (3001, N'IND', 1000.00, 50000.00, '1,000', '50,000') -- IDR
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (3001, N'IDR', 30.00, 3000.00, '30', '3,000') -- IDR
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (3001, N'IDR', 500.00, 10000.00, '500', '10,000') -- IDR
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (3001, N'IDR', 1000.00, 20000.00, '1,000', '20,000') -- IDR
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (3001, N'IDR', 1000.00, 50000.00, '1,000', '50,000') -- IDR
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (3001, N'IDD', 30.00, 3000.00, '30', '3,000') -- IDR
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (3001, N'IDD', 500.00, 10000.00, '500', '10,000') -- IDR
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (3001, N'IDD', 1000.00, 20000.00, '1,000', '20,000') -- IDR
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (3001, N'IDD', 1000.00, 50000.00, '1,000', '50,000') -- IDR
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (3001, N'IN', 30.00, 3000.00, '30', '3,000') -- IDR
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (3001, N'IN', 500.00, 10000.00, '500', '10,000') -- IDR
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (3001, N'IN', 1000.00, 20000.00, '1,000', '20,000') -- IDR
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (3001, N'IN', 1000.00, 50000.00, '1,000', '50,000') -- IDR
 
SELECT	t.GameTypeID,
		t.MinLabel,
		t.MaxLabel,
		CONVERT(DECIMAL(19,2),t.MinStake) AS MinStake,
		CONVERT(DECIMAL(19,2),t.MaxStake) AS MaxStake,
		ExchangeId = e.exchangeid
INTO #StakeLevel
FROM @CRE_Stake t
    INNER JOIN exchange e WITH(NOLOCK) ON t.Currency = e.Currency
ORDER BY GameTypeID,ExchangeId,MinStake,MaxStake

UPDATE s
SET s.MinLabel = t.MinLabel,
	s.MinStake = t.MinStake
FROM StakeLevel s WITH(ROWLOCK)
	INNER JOIN #StakeLevel t ON s.GametypeID = t.GameTypeID 
		AND s.ExchangeId = t.ExchangeId 
		AND s.MaxStake = t.MaxStake
WHERE s.GameTypeID IN (3001)

DROP TABLE #StakeLevel

