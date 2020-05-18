/*
	Created: Eden
	Date: 20200507
	Task: Insert stake level for Virtual game - Real Currency -XocDia
	DB: DBCust/CustDB
*/

ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_09]
	 @srecommend INT		
	,@target VARCHAR(20)
	,@max_custid INT
	,@SiteId INT
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only

	IF dbo.f_CheckRepTable('CustInfo') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustStakeLevel_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustStakeLevel_Member') = 0 RETURN

	DECLARE @currency INT

	SELECT @currency = ci.currency FROM dbo.custInfo ci WITH (NOLOCK) WHERE ci.custid = @srecommend

	CREATE TABLE #MemberTemp
	(
		CustID INT PRIMARY KEY CLUSTERED
	)

	CREATE TABLE #SMATemp
	(
		CustID INT PRIMARY KEY CLUSTERED
		,roleid	TINYINT
	)
	
	CREATE TABLE #Dummy	(CustID INT PRIMARY KEY)
	INSERT INTO #Dummy(CustID)
	SELECT CustID FROM Customer WITH(NOLOCK) 
	WHERE srecommend=@srecommend AND roleid=3 AND username LIKE '%Acc%'
		AND custid<=@max_custid 

	INSERT INTO #MemberTemp (CustID)
	SELECT custid
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend = @srecommend AND roleid = 1  AND Enabled = 1 AND custid <= @max_custid
	AND mrecommend NOT IN (SELECT custid FROM #Dummy)

	INSERT INTO #SMATemp (CustID,roleid)
	SELECT custid,roleid
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend = @srecommend AND roleid IN (2,3,4) AND Enabled = 1 AND custid <= @max_custid
	AND mrecommend NOT IN (SELECT custid FROM #Dummy)

	DECLARE @SportBetType TABLE
	(
		SportType SMALLINT, 
		BetType   SMALLINT
	)
	INSERT INTO @SportBetType(SportType, BetType) VALUES (245, 4602)

	DECLARE @DEP_Stake TABLE (
		[GameTypeID] [int] NOT NULL,
		[Currency] [nvarchar](max) NULL,
		[MinStake] [money] NULL,
		[MaxStake] [money] NULL,
		[MinLabel] [varchar](20) NULL,
		[MaxLabel] [varchar](20) NULL
	) 
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'RM', 20.00, 10450.00, '20', '10,450') -- MYR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'RM', 20.00, 20750.00, '20', '20,750') -- MYR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'RM', 20.00, 41500.00, '20', '41,500') -- MYR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'KHR', 20.00, 10450.00, '20', '10,450') -- KHR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'KHR', 20.00, 20750.00, '20', '20,750') -- KHR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'KHR', 20.00, 41500.00, '20', '41,500') -- KHR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'PLN', 20.00, 10450.00, '20', '10,450') -- PLN
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'PLN', 20.00, 20750.00, '20', '20,750') -- PLN
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'PLN', 20.00, 41500.00, '20', '41,500') -- PLN
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'HKK', 20.00, 10450.00, '20', '10,450') -- HKD
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'HKK', 20.00, 20750.00, '20', '20,750') -- HKD
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'HKK', 20.00, 41500.00, '20', '41,500') -- HKD
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'Yen', 5.00, 2500.00, '5', '2,500') -- USD
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'Yen', 5.00, 5000.00, '5', '5,000') -- USD
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'Yen', 5.00, 10000.00, '5', '10,000') -- USD
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'UT', 5.00, 2500.00, '5', '2,500') -- USD
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'UT', 5.00, 5000.00, '5', '5,000') -- USD
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'UT', 5.00, 10000.00, '5', '10,000') -- USD
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'$US', 5.00, 2500.00, '5', '2,500') -- USD
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'$US', 5.00, 5000.00, '5', '5,000') -- USD
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'$US', 5.00, 10000.00, '5', '10,000') -- USD
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'US$', 5.00, 2500.00, '5', '2,500') -- USD
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'US$', 5.00, 5000.00, '5', '5,000') -- USD
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'US$', 5.00, 10000.00, '5', '10,000') -- USD
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'MMK', 5.00, 2500.00, '5', '2,500') -- MMK
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'MMK', 5.00, 5000.00, '5', '5,000') -- MMK
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'MMK', 5.00, 10000.00, '5', '10,000') -- MMK
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'MKK', 5.00, 2500.00, '5', '2,500') -- MMK
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'MKK', 5.00, 5000.00, '5', '5,000') -- MMK
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'MKK', 5.00, 10000.00, '5', '10,000') -- MMK
	--INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'YNG', 5.00, 2500.00, '5', '2,500') -- YNG
	--INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'YNG', 5.00, 5000.00, '5', '5,000') -- YNG
	--INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'YNG', 5.00, 10000.00, '5', '10,000') -- YNG
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'RMB', 30.00, 17500.00, '30', '17,500') -- CNY
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'RMB', 30.00, 35000.00, '30', '35,000') -- CNY
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'RMB', 30.00, 70000.00, '30', '70,000') -- CNY
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'CY', 30.00, 17500.00, '30', '17,500') -- CNY
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'CY', 30.00, 35000.00, '30', '35,000') -- CNY
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'CY', 30.00, 70000.00, '30', '70,000') -- CNY
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'YUN', 30.00, 17500.00, '30', '17,500') -- CNY
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'YUN', 30.00, 35000.00, '30', '35,000') -- CNY
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'YUN', 30.00, 70000.00, '30', '70,000') -- CNY
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'HK$', 30.00, 17500.00, '30', '17,500') -- HKD
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'HK$', 30.00, 35000.00, '30', '35,000') -- HKD
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'HK$', 30.00, 70000.00, '30', '70,000') -- HKD
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'DDD', 50.00, 35000.00, '50', '35,000') -- IDR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'DDD', 50.00, 70000.00, '50', '70,000') -- IDR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'DDD', 50.00, 140000.00, '50', '140,000') -- IDR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'IND', 50.00, 35000.00, '50', '35,000') -- IDR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'IND', 50.00, 70000.00, '50', '70,000') -- IDR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'IND', 50.00, 140000.00, '50', '140,000') -- IDR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'IDR', 50.00, 35000.00, '50', '35,000') -- IDR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'IDR', 50.00, 70000.00, '50', '70,000') -- IDR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'IDR', 50.00, 140000.00, '50', '140,000') -- IDR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'IDD', 50.00, 35000.00, '50', '35,000') -- IDR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'IDD', 50.00, 70000.00, '50', '70,000') -- IDR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'IDD', 50.00, 140000.00, '50', '140,000') -- IDR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'IN', 50.00, 35000.00, '50', '35,000') -- IDR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'IN', 50.00, 70000.00, '50', '70,000') -- IDR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'IN', 50.00, 140000.00, '50', '140,000') -- IDR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'THB', 150.00, 75000.00, '150', '75,000') -- THB
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'THB', 150.00, 151000.00, '150', '151,000') -- THB
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'THB', 150.00, 300000.00, '150', '300,000') -- THB
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'TB', 150.00, 75000.00, '150', '75,000') -- THB
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'TB', 150.00, 151000.00, '150', '151,000') -- THB
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'TB', 150.00, 300000.00, '150', '300,000') -- THB
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'Won', 5000.00, 2935000.00, '5,000', '2,935,000') -- KRW
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'Won', 5000.00, 5750000.00, '5,000', '5,750,000') -- KRW
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'Won', 5000.00, 11750000.00, '5,000', '11,750,000') -- KRW
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'INH', 100.00, 57500.00, '100', '57,500') -- VND
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'INH', 100.00, 115000.00, '100', '115,000') -- VND
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'INH', 100.00, 232500.00, '100', '232,500') -- VND
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'INR', 300.00, 175000.00, '300', '175,000') -- INR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'INR', 300.00, 350000.00, '300', '350,000') -- INR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'INR', 300.00, 700000.00, '300', '700,000') -- INR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'RUB', 300.00, 175000.00, '300', '175,000') -- RUB
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'RUB', 300.00, 350000.00, '300', '350,000') -- RUB
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'RUB', 300.00, 700000.00, '300', '700,000') -- RUB
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'EURO', 3.00, 1925.00, '3', '1,925') -- EUR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'EURO', 3.00, 3750.00, '3', '3,750') -- EUR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'EURO', 3.00, 7500.00, '3', '7,500') -- EUR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'GBP', 3.00, 1925.00, '3', '1,925') -- GBP
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'GBP', 3.00, 3750.00, '3', '3,750') -- GBP
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'GBP', 3.00, 7500.00, '3', '7,500') -- GBP
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'JPY', 500.00, 270000.00, '500', '270,000') -- JPY
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'JPY', 500.00, 525000.00, '500', '525,000') -- JPY
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'JPY', 500.00, 1075000.00, '500', '1,075,000') -- JPY
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'UUS', 5.00, 2500.00, '5', '2,500') -- UUS
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'UUS', 5.00, 5000.00, '5', '5,000') -- UUS
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'UUS', 5.00, 10000.00, '5', '10,000') -- UUS

	DECLARE @MaxStakeLevelID INT
	SELECT @MaxStakeLevelID = MAX(StakeLevelID) FROM DEP_StakeLevel WITH(NOLOCK)

	IF NOT EXISTS (	SELECT 1 
					FROM DEP_StakeLevel WITH (NOLOCK)
					WHERE SiteID = @SiteId AND ExchangeID = @currency AND GameTypeID = 4602)
	BEGIN
		INSERT INTO DEP_StakeLevel(
			GameTypeID
			,MinLabel
			,MaxLabel
			,MinStake
			,MaxStake
			,ExchangeId
			,GameGroupID
			,SiteID
			,StakeLevelID
		)
		SELECT	t.GameTypeID,
				t.MinLabel,
				t.MaxLabel,
				CONVERT(DECIMAL(19,2),t.MinStake) AS MinStake,
				CONVERT(DECIMAL(19,2),t.MaxStake) AS MaxStake,
				ExchangeId = e.exchangeid,
				GameGroupID = 0,
				@SiteId,
				StakeLevelID = @MaxStakeLevelID + ROW_NUMBER() OVER(ORDER BY e.exchangeid)
		FROM @DEP_Stake t
			INNER JOIN exchange e WITH(NOLOCK) ON t.Currency = e.Currency
		WHERE e.exchangeid = @currency
	END

	-------------------------------------------------STAKE LEVEL----------------------------------------------------------------
	DECLARE @StakeLevAgent VARCHAR(200)
	DECLARE @StakeLevMember VARCHAR(200)
	SELECT @StakeLevAgent = SUBSTRING(( SELECT ',' + CONVERT(VARCHAR(5),s.StakeLevelID) 
										FROM DEP_StakeLevel s WITH(NOLOCK) 
											CROSS APPLY @SportBetType t	
										WHERE s.ExchangeId = @currency AND s.GameTypeID = t.BetType AND s.SiteID = @SiteId 
										FOR XML PATH(''))
							,2,200)

	SELECT @StakeLevMember = (	SELECT TOP 1 CONVERT(VARCHAR(5),s.StakeLevelID) 
								FROM DEP_StakeLevel s WITH(NOLOCK) 
									CROSS APPLY @SportBetType t	
								WHERE s.ExchangeId = @currency AND s.GameTypeID = t.BetType AND s.SiteID = @SiteId 
								ORDER BY s.MaxStake)

	--> Bet Limit: Apply bet limit group level for all S/M/A/Member levels
	INSERT INTO DEP_CustStakeLevel_Agent(CustID, SportType, BetType, StakeLevelList)
	SELECT tmp.CustID
		,SportType = t.SportType
		,BetType = t.BetType
		,StakeLevelList = @StakeLevAgent
	FROM #SMATemp tmp
		CROSS APPLY @SportBetType t

	INSERT INTO DEP_CustStakeLevel_Member(CustID, SportType, BetType, StakeLevelList,LastUpdated)
	SELECT tmp.CustID
		,SportType = t.SportType
		,BetType = t.BetType
		,StakeLevelList = @StakeLevMember
		,GETDATE()
	FROM #MemberTemp tmp
		CROSS APPLY @SportBetType t

	DROP TABLE #SMATemp
	DROP TABLE #MemberTemp
END
GO

-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS  -----
--------------------------------------------------------------------------------------
PRINT N'Step 2: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  

CREATE TABLE #supers (custid int, SiteId INT,isfinished bit default(0))

DECLARE @srecommend INT , @max_custid INT

SELECT @max_custid = xxx

INSERT INTO #supers(custid, SiteId)
SELECT c.custid, s.siteid
FROM customer c WITH (NOLOCK) 
	INNER JOIN site s WITH (NOLOCK) ON c.site = s.site
	INNER JOIN custinfo ci  WITH (NOLOCK) ON c.custid = ci.custid
	INNER JOIN Dep_LicenseeProductSetting cs WITH (NOLOCK) ON c.custid = cs.custid
WHERE c.roleid = 4  
 AND s.islicensee = 1
 AND ci.Enabled = 1
 AND cs.ProductSettingID = 34
 AND c.custid <= @max_custid
 AND c.currency IN ( 	2	--RM
					, 	71	--KHR
					, 	56	--PLN
					, 	67	--HKK
					, 	16	--Yen
					, 	64	--UT
					, 	35	--$US
					, 	3	--US$
					, 	69	--MMK
					, 	70	--MKK
					--, 	72	--YNG
					, 	13	--RMB
					, 	81	--CY
					, 	66	--YUN
					, 	5	--HK$
					, 	47	--DDD
					, 	22	--IND
					, 	34	--IDR
					, 	33	--IDD
					, 	15	--IN
					, 	43	--THB
					, 	4	--TB
					, 	45	--Won
					, 	51	--INH
					, 	61	--INR
					, 	55	--RUB
					, 	6	--EURO
					, 	12	--GBP
					, 	32	--JPY
					,   20 --UUS
					) --Offered Currencies
 AND s.site IN (
				 N'e8casino'
				,N'CGame'
				,N'Axiawin'
				,N'88Goals'
				,N'BoAPI05'
				,N'9Club'
				,N'Aplus'
				,N'HonorW'
				,N'ID88'
				,N'sbt88'
				,N'11bet'
				,N'VWIN66'
				,N'24AVIA'
				,N'Spark'
				,N'FLC'
				,N'TitanCraft'
				,N'Sunwin'
				,N'Mayayule'
				,N'Yunji'
				,N'NBCbet'
				,N'XTDGT'
				,N'Zowin'
				,N'Sin88'
				,N'Lucky88'
				,N'JIBET'
				,N'Liga'
				,N'633esports'
				,N'SV88'
				,N'erhaozhan'
				,N'Jumbo88'
				,N'TCbet'
				,N'MICL'
				,N'Raisetech'
				,N'Uwoniwin'
				,N'Siamgame'
				,N'Athena000'
				,N'Leng4D'
				,N'Taipanbet'
				,N'18Luck'
				,N'AnvoFH'
				,N'ALPHA88'
				,N'Senibet'
				,N'skykey'
				,N'ISC888'
				,N'MARS'
				,N'Xinbo'
				,N'ECLBET'
				,N'9bet'
				,N'Kraton'
				,N'UwinY'
				,N'CGame4'
				,N'IONclub'
				,N'BE7'
				,N'JZFortune'
				,N'Champion'
				,N'IBG'
				,N'Kudatogel'
				,N'Red88'
				,N'VN88'
				,N'Fabet'
				,N'INSERTGAME'
				,N'Sunrise'
				,N'396Club'
				,N'Hong88'
				,N'IvoryBet'
				,N'Royal'
				,N'TitanOne'
				,N'Newhonbet'
				,N'Bobo88'
				,N'BPLE'
				,N'ITCbet'
				,N'BWGaming'
				,N'MTech'
				,N'TLC'
				,N'3star88'
				,N'BigGaming'
				,N'Okada'
				,N'haifa'
				,N'Datang001'
				,N'BETSUN'
				,N'Bonanza88'
				,N'Pinbo'
				,N'BBIN3'
				,N'UN168'
				,N'Starnet'
				,N'BoAPI06'
				,N'WBS'
				,N'Callmeboss'
				,N'Heji888'
				,N'afb99'
				,N'ig128'
				,N'12Bet'
				,N'Luckywin88'
				,N'BBIN2'
				,N'Hecbet'
				,N'OneSports'
				,N'Unobet'
				,N'KUTECH'
				,N'Monstergol'
				,N'Wanfang'
				,N'HuangMa'
				,N'Boma365'
				,N'AG'
				,N'DTGW'
				,N'N8G'
				,N'Bolanation'
				,N'starsoccer'
				,N'Sunriseb2b'
				,N'Yibo'
				,N'Zbet'
				,N'OLE777'
				,N'JIDU'
				,N'IBO'
				,N'HONBET'
				,N'zt828'
				,N'AMG'
				,N'Five88'
				,N'Opal88'
				,N'TYCgame'
				,N'368Cash'
				,N'Soon88'
				,N'BOSSB'
				,N'TangChao'
				,N'A1game'
				,N'GamingSoft'
				,N'Lagadewa'
				,N'YongBao'
				,N'alog'
				,N'WKPHIL'
				,N'shengboyun'
				,N'webet88'
				,N'N8B'
				,N'FB88'
				,N'DingTai'
				,N'K8VN'
				,N'Aoncash'
				,N'Gampag'
				,N'N88'
				,N'YAYOU'
				,N'Heaven'
				,N'365online'
				,N'OCMS'
				,N'Xtu168'
				,N'Happy8'
				,N'XTD3'
				,N'ZhiFeng032'
				,N'B24VN'
				,N'Gameroom'
				,N'Ratugg'
				,N'AEUG'
				,N'Happy1668'
				,N'Ｗin88   '
				,N'Apollo'
				,N'IGPTech'
				,N'Dawoo'
				,N'GMASTER'
				,N'KingBet'
				,N'OPEBET'
				,N'Wanbo'
				,N'Abcasino'
				,N'Boying'
				,N'Macaubet'
				,N'Mopgaming'
				,N'WINCLUB88'
				,N'Winn69'
				,N'iBET'
				,N'GPIGAME'
				,N'Gaobet'
				,N'ANGbet'
				,N'Bodog'
				,N'ENT22'
				,N'W88'
				,N'YTX'
				,N'PanguGame'
				,N'HBO999'
				,N'DEWA'
				,N'WKIBPH'
				,N'HCVIP'
				,N'Lode88'
				,N'ENTAPLAY'
				,N'asiabet88'
				,N'GESAB'
				,N'XinYo'
				,N'VCBA'
				,N'WUYICP'
				,N'weicai'
				,N'MAX88'
				,N'Ae88'
				,N'Monaco'
				,N'BOG22'
				,N'DBP'
				,N'M8bola'
				,N'mansion88'
				,N'SunGame'
				,N'TGO'
				,N'88Macao'
				,N'Debet'
				,N'Onegaming'
				,N'YBTech'
				,N'TopGame'
				,N'MFgame'
				,N'GGBOOK'
				,N'818Bet'
				,N'PKbet'
				,N'Q8bola'
				,N'TaoCai'
				,N'hjccasino'
				,N'Swin'
				,N'Nbbet'
				,N'One88'
				,N'txwl002'
				,N'Mybet88'
				,N'Yabo3'
				,N'Tianbo'
				,N'Datang'
				,N'allwincity'
				,N'Tripleone'
				,N'Bobbet'
				,N'WKCUR'
				,N'gbkj'
				,N'HL8'
				,N'Weiwei'
				,N'spondemo'
				,N'KeenOcean'
				,N'G2Win'
				,N'SSSGaming'
				,N'KhmerG'
				,N'Sun988'
				,N'Jarvis'
				,N'Bsdbet'
				 )
	AND NOT (s.site IN('Athena000') AND c.currency = 20)
ORDER BY custid
-- For deployer info
DECLARE @super_cnt INT, @index INT = 0, @siteId INT
DECLARE @msg NVARCHAR(200) = 'Currently at order %d, SuperID: %d.'
DECLARE @msg_total NVARCHAR(200) = 'Total of supers: %d.'

SET @super_cnt = (SELECT COUNT(*) FROM #supers )
RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #Supers
	SET isfinished = 1
		,@srecommend = custid
		,@siteId = SiteId	
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK

	SET @index = @index + 1
	RAISERROR (@msg, 0, 1, @index, @srecommend) WITH NOWAIT

	EXEC dbo.Acc_Dep_DynamicCustSetting_09 @srecommend = @srecommend
			,@target = 'REPLICATED'
			,@max_custid = @max_custid
			,@siteId = @siteId
						
	waitfor delay '00:00:0.100'
END

PRINT N'Step 2: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 

DROP TABLE #supers
GO
-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
PRINT N'Step 2: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  

CREATE TABLE #supers (custid int, SiteId INT,isfinished bit default(0))

DECLARE @srecommend INT , @max_custid INT

SELECT @max_custid = xxx

INSERT INTO #supers(custid, SiteId)
SELECT c.custid, s.siteid
FROM customer c WITH (NOLOCK) 
	INNER JOIN site s WITH (NOLOCK) ON c.site = s.site
	INNER JOIN custinfo ci  WITH (NOLOCK) ON c.custid = ci.custid
	INNER JOIN Dep_LicenseeProductSetting cs WITH (NOLOCK) ON c.custid = cs.custid
WHERE c.roleid = 4  
 AND s.islicensee = 1
 AND ci.Enabled = 1
 AND cs.ProductSettingID = 34
 AND c.custid <= @max_custid
 AND c.currency IN ( 	2	--RM
					, 	71	--KHR
					, 	56	--PLN
					, 	67	--HKK
					, 	16	--Yen
					, 	64	--UT
					, 	35	--$US
					, 	3	--US$
					, 	69	--MMK
					, 	70	--MKK
					--, 	72	--YNG
					, 	13	--RMB
					, 	81	--CY
					, 	66	--YUN
					, 	5	--HK$
					, 	47	--DDD
					, 	22	--IND
					, 	34	--IDR
					, 	33	--IDD
					, 	15	--IN
					, 	43	--THB
					, 	4	--TB
					, 	45	--Won
					, 	51	--INH
					, 	61	--INR
					, 	55	--RUB
					, 	6	--EURO
					, 	12	--GBP
					, 	32	--JPY
					,   20 --UUS
					) --Offered Currencies
 AND s.site IN (
				 N'e8casino'
				,N'CGame'
				,N'Axiawin'
				,N'88Goals'
				,N'BoAPI05'
				,N'9Club'
				,N'Aplus'
				,N'HonorW'
				,N'ID88'
				,N'sbt88'
				,N'11bet'
				,N'VWIN66'
				,N'24AVIA'
				,N'Spark'
				,N'FLC'
				,N'TitanCraft'
				,N'Sunwin'
				,N'Mayayule'
				,N'Yunji'
				,N'NBCbet'
				,N'XTDGT'
				,N'Zowin'
				,N'Sin88'
				,N'Lucky88'
				,N'JIBET'
				,N'Liga'
				,N'633esports'
				,N'SV88'
				,N'erhaozhan'
				,N'Jumbo88'
				,N'TCbet'
				,N'MICL'
				,N'Raisetech'
				,N'Uwoniwin'
				,N'Siamgame'
				,N'Athena000'
				,N'Leng4D'
				,N'Taipanbet'
				,N'18Luck'
				,N'AnvoFH'
				,N'ALPHA88'
				,N'Senibet'
				,N'skykey'
				,N'ISC888'
				,N'MARS'
				,N'Xinbo'
				,N'ECLBET'
				,N'9bet'
				,N'Kraton'
				,N'UwinY'
				,N'CGame4'
				,N'IONclub'
				,N'BE7'
				,N'JZFortune'
				,N'Champion'
				,N'IBG'
				,N'Kudatogel'
				,N'Red88'
				,N'VN88'
				,N'Fabet'
				,N'INSERTGAME'
				,N'Sunrise'
				,N'396Club'
				,N'Hong88'
				,N'IvoryBet'
				,N'Royal'
				,N'TitanOne'
				,N'Newhonbet'
				,N'Bobo88'
				,N'BPLE'
				,N'ITCbet'
				,N'BWGaming'
				,N'MTech'
				,N'TLC'
				,N'3star88'
				,N'BigGaming'
				,N'Okada'
				,N'haifa'
				,N'Datang001'
				,N'BETSUN'
				,N'Bonanza88'
				,N'Pinbo'
				,N'BBIN3'
				,N'UN168'
				,N'Starnet'
				,N'BoAPI06'
				,N'WBS'
				,N'Callmeboss'
				,N'Heji888'
				,N'afb99'
				,N'ig128'
				,N'12Bet'
				,N'Luckywin88'
				,N'BBIN2'
				,N'Hecbet'
				,N'OneSports'
				,N'Unobet'
				,N'KUTECH'
				,N'Monstergol'
				,N'Wanfang'
				,N'HuangMa'
				,N'Boma365'
				,N'AG'
				,N'DTGW'
				,N'N8G'
				,N'Bolanation'
				,N'starsoccer'
				,N'Sunriseb2b'
				,N'Yibo'
				,N'Zbet'
				,N'OLE777'
				,N'JIDU'
				,N'IBO'
				,N'HONBET'
				,N'zt828'
				,N'AMG'
				,N'Five88'
				,N'Opal88'
				,N'TYCgame'
				,N'368Cash'
				,N'Soon88'
				,N'BOSSB'
				,N'TangChao'
				,N'A1game'
				,N'GamingSoft'
				,N'Lagadewa'
				,N'YongBao'
				,N'alog'
				,N'WKPHIL'
				,N'shengboyun'
				,N'webet88'
				,N'N8B'
				,N'FB88'
				,N'DingTai'
				,N'K8VN'
				,N'Aoncash'
				,N'Gampag'
				,N'N88'
				,N'YAYOU'
				,N'Heaven'
				,N'365online'
				,N'OCMS'
				,N'Xtu168'
				,N'Happy8'
				,N'XTD3'
				,N'ZhiFeng032'
				,N'B24VN'
				,N'Gameroom'
				,N'Ratugg'
				,N'AEUG'
				,N'Happy1668'
				,N'Ｗin88   '
				,N'Apollo'
				,N'IGPTech'
				,N'Dawoo'
				,N'GMASTER'
				,N'KingBet'
				,N'OPEBET'
				,N'Wanbo'
				,N'Abcasino'
				,N'Boying'
				,N'Macaubet'
				,N'Mopgaming'
				,N'WINCLUB88'
				,N'Winn69'
				,N'iBET'
				,N'GPIGAME'
				,N'Gaobet'
				,N'ANGbet'
				,N'Bodog'
				,N'ENT22'
				,N'W88'
				,N'YTX'
				,N'PanguGame'
				,N'HBO999'
				,N'DEWA'
				,N'WKIBPH'
				,N'HCVIP'
				,N'Lode88'
				,N'ENTAPLAY'
				,N'asiabet88'
				,N'GESAB'
				,N'XinYo'
				,N'VCBA'
				,N'WUYICP'
				,N'weicai'
				,N'MAX88'
				,N'Ae88'
				,N'Monaco'
				,N'BOG22'
				,N'DBP'
				,N'M8bola'
				,N'mansion88'
				,N'SunGame'
				,N'TGO'
				,N'88Macao'
				,N'Debet'
				,N'Onegaming'
				,N'YBTech'
				,N'TopGame'
				,N'MFgame'
				,N'GGBOOK'
				,N'818Bet'
				,N'PKbet'
				,N'Q8bola'
				,N'TaoCai'
				,N'hjccasino'
				,N'Swin'
				,N'Nbbet'
				,N'One88'
				,N'txwl002'
				,N'Mybet88'
				,N'Yabo3'
				,N'Tianbo'
				,N'Datang'
				,N'allwincity'
				,N'Tripleone'
				,N'Bobbet'
				,N'WKCUR'
				,N'gbkj'
				,N'HL8'
				,N'Weiwei'
				,N'spondemo'
				,N'KeenOcean'
				,N'G2Win'
				,N'SSSGaming'
				,N'KhmerG'
				,N'Sun988'
				,N'Jarvis'
				,N'Bsdbet'
				 )
	AND NOT (s.site IN('Athena000') AND c.currency = 20)
ORDER BY custid
-- For deployer info
DECLARE @super_cnt INT, @index INT = 0, @siteId INT
DECLARE @msg NVARCHAR(200) = 'Currently at order %d, SuperID: %d.'
DECLARE @msg_total NVARCHAR(200) = 'Total of supers: %d.'

SET @super_cnt = (SELECT COUNT(*) FROM #supers )
RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #Supers
	SET isfinished = 1
		,@srecommend = custid
		,@siteId = SiteId	
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK

	SET @index = @index + 1
	RAISERROR (@msg, 0, 1, @index, @srecommend) WITH NOWAIT

	EXEC dbo.Acc_Dep_DynamicCustSetting_09 @srecommend = @srecommend
			,@target = 'DBCUST'
			,@max_custid = @max_custid
			,@siteId = @siteId
						
	waitfor delay '00:00:0.100'
END

PRINT N'Step 2: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 

DROP TABLE #supers
GO