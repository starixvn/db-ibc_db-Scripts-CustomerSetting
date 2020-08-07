/*
	Created By: Eden
	Created Date: 20200807
	Description: Update Stakelevel for Virtual Games CREDIT - UUS
	DB: DBCust/CustDB	
*/
USE CustDB
GO

DECLARE @CRE_Stake TABLE (
	[Currency] [nvarchar](max) NULL,
	[MinStake] [money] NULL,
	[MaxStake] [money] NULL,
	[MinLabel] [varchar](20) NULL,
	[MaxLabel] [varchar](20) NULL
) 
INSERT INTO @CRE_Stake ( [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES ( N'UUS', 1.00, 2500.00, '1', '2,500') -- 
INSERT INTO @CRE_Stake ( [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES ( N'UUS', 5.00, 5000.00, '5', '5,000') -- 
INSERT INTO @CRE_Stake ( [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES ( N'UUS', 10.00, 10000.00, '10', '10,000') -- 
 
SELECT	t.MinLabel,
		t.MaxLabel,
		CONVERT(DECIMAL(19,2),t.MinStake) AS MinStake,
		CONVERT(DECIMAL(19,2),t.MaxStake) AS MaxStake,
		ExchangeId = e.exchangeid
INTO #StakeLevel
FROM @CRE_Stake t
    INNER JOIN exchange e WITH(NOLOCK) ON t.Currency = e.Currency

UPDATE s
SET s.MinLabel = t.MinLabel,
	s.MinStake = t.MinStake
FROM StakeLevel s WITH(ROWLOCK)
	INNER JOIN #StakeLevel t ON s.ExchangeId = t.ExchangeId AND s.MaxStake = t.MaxStake
WHERE s.GameTypeID IN (4601,4602)

DROP TABLE #StakeLevel

