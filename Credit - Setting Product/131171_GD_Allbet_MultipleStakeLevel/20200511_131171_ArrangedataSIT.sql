/*
	Created: 20200511@Tiara
	Date: 20200511
	Task: Arrange data for testing on SIT [Redmine: #131171]
	DB: DBCUST/CustDB
*/
USE CustDB
GO

CREATE TABLE #temp(
	GameTypeID		INT,
	[MinLabel]		VARCHAR(30),
	[MaxLabel]		VARCHAR(30),
	[MinStake]			[decimal](19, 8) NULL,
	[MaxStake]			[decimal](19, 8) NULL,
	[ExchangeId]	[int] 
) ON [PRIMARY]

GO
INSERT #temp (GameTypeID, MinLabel, MaxLabel, MinStake, MaxStake,ExchangeId)
SELECT 2401,'5','2,500',5,2500,	20 UNION ALL
SELECT 2401,'25','2,500',25,2500,20 UNION ALL
SELECT 2401,'50','5,000',50,5000,20 UNION ALL
SELECT 2401,'250','10,000',250,10000,20 UNION ALL
SELECT 2401,'500','25,000',500,25000,20 


INSERT INTO StakeLevel (GameTypeID, MinLabel, MaxLabel, MinStake, MaxStake,ExchangeId)
SELECT T.GameTypeID, T.MinLabel,T.MaxLabel,	T.MinStake , T.MaxStake, T.ExchangeId
FROM #temp T WITH(NOLOCK)
WHERE T.GameTypeID = 2401

DROP TABLE #temp

--Delete data CAN SEE
DELETE S
FROM ProductLaunchedSiteCurrency S WITH (ROWLOCK)
inner join Site si on si.siteid=s.SiteID
WHERE S.BetType IN (3101,2401,3001) AND S.SiteID = 1

---Update Max Choice
UPDATE P
SET P.MaxChoice=2
FROM ProductSettingDetail P WITH (ROWLOCK,UPDLOCK)
WHERE P.SettingType=17