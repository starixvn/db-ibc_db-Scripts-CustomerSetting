/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created By: Eden@20200923
	Description: Live Casino Products -Sexy Gaming - Update bet Limit for IBCIndo Site [RM#142163]
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
WHERE s.GameTypeID IN (3101)

DROP TABLE #StakeLevel

