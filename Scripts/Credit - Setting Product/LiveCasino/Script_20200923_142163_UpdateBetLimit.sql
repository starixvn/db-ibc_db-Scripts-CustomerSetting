/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created By: Eden@20200923
	Description: Live Casino Products - Update bet Limit for IBCIndo Site [RM#142163]
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
--Allbet
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (2401, N'DDD', 40.00, 4000.00, '40', '4,000') -- IDR
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (2401, N'DDD', 100.00, 10000.00, '100', '10,000') -- IDR
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (2401, N'DDD', 200.00, 20000.00, '200', '20,000') -- IDR
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (2401, N'DDD', 500.00, 30000.00, '500', '30,000') -- IDR
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (2401, N'DDD', 1000.00, 50000.00, '1,000', '50,000') -- IDR
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (2401, N'IND', 40.00, 4000.00, '40', '4,000') -- IDR
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (2401, N'IND', 100.00, 10000.00, '100', '10,000') -- IDR
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (2401, N'IND', 200.00, 20000.00, '200', '20,000') -- IDR
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (2401, N'IND', 500.00, 30000.00, '500', '30,000') -- IDR
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (2401, N'IND', 1000.00, 50000.00, '1,000', '50,000') -- IDR
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (2401, N'IDR', 40.00, 4000.00, '40', '4,000') -- IDR
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (2401, N'IDR', 100.00, 10000.00, '100', '10,000') -- IDR
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (2401, N'IDR', 200.00, 20000.00, '200', '20,000') -- IDR
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (2401, N'IDR', 500.00, 30000.00, '500', '30,000') -- IDR
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (2401, N'IDR', 1000.00, 50000.00, '1,000', '50,000') -- IDR
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (2401, N'IDD', 40.00, 4000.00, '40', '4,000') -- IDR
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (2401, N'IDD', 100.00, 10000.00, '100', '10,000') -- IDR
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (2401, N'IDD', 200.00, 20000.00, '200', '20,000') -- IDR
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (2401, N'IDD', 500.00, 30000.00, '500', '30,000') -- IDR
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (2401, N'IDD', 1000.00, 50000.00, '1,000', '50,000') -- IDR
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (2401, N'IN', 40.00, 4000.00, '40', '4,000') -- IDR
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (2401, N'IN', 100.00, 10000.00, '100', '10,000') -- IDR
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (2401, N'IN', 200.00, 20000.00, '200', '20,000') -- IDR
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (2401, N'IN', 500.00, 30000.00, '500', '30,000') -- IDR
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (2401, N'IN', 1000.00, 50000.00, '1,000', '50,000') -- IDR
--Sexy
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (3101, N'DDD', 6.00, 1500.00, '6', '1,500') -- IDR
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (3101, N'DDD', 60.00, 3000.00, '60', '3,000') -- IDR
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (3101, N'DDD', 150.00, 7500.00, '150', '7,500') -- IDR
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (3101, N'DDD', 300.00, 15000.00, '300', '15,000') -- IDR
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (3101, N'DDD', 1000.00, 50000.00, '1,000', '50,000') -- IDR
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (3101, N'IND', 6.00, 1500.00, '6', '1,500') -- IDR
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (3101, N'IND', 60.00, 3000.00, '60', '3,000') -- IDR
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (3101, N'IND', 150.00, 7500.00, '150', '7,500') -- IDR
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (3101, N'IND', 300.00, 15000.00, '300', '15,000') -- IDR
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (3101, N'IND', 1000.00, 50000.00, '1,000', '50,000') -- IDR
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (3101, N'IDR', 6.00, 1500.00, '6', '1,500') -- IDR
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (3101, N'IDR', 60.00, 3000.00, '60', '3,000') -- IDR
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (3101, N'IDR', 150.00, 7500.00, '150', '7,500') -- IDR
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (3101, N'IDR', 300.00, 15000.00, '300', '15,000') -- IDR
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (3101, N'IDR', 1000.00, 50000.00, '1,000', '50,000') -- IDR
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (3101, N'IDD', 6.00, 1500.00, '6', '1,500') -- IDR
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (3101, N'IDD', 60.00, 3000.00, '60', '3,000') -- IDR
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (3101, N'IDD', 150.00, 7500.00, '150', '7,500') -- IDR
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (3101, N'IDD', 300.00, 15000.00, '300', '15,000') -- IDR
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (3101, N'IDD', 1000.00, 50000.00, '1,000', '50,000') -- IDR
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (3101, N'IN', 6.00, 1500.00, '6', '1,500') -- IDR
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (3101, N'IN', 60.00, 3000.00, '60', '3,000') -- IDR
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (3101, N'IN', 150.00, 7500.00, '150', '7,500') -- IDR
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (3101, N'IN', 300.00, 15000.00, '300', '15,000') -- IDR
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (3101, N'IN', 1000.00, 50000.00, '1,000', '50,000') -- IDR
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
WHERE s.GameTypeID IN (2401,3101,3001)

DROP TABLE #StakeLevel

