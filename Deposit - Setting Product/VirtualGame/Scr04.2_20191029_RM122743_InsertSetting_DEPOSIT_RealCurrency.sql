/*
	Created: Eden
	Date: 20191029
	Task: Insert setting for Virtual game - Real Currency -  Athena Site
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
	INSERT INTO @SportBetType(SportType, BetType) VALUES (245, 4601)

	DECLARE @DEP_Stake TABLE (
		[GameTypeID] [int] NOT NULL,
		[Currency] [nvarchar](max) NULL,
		[MinStake] [money] NULL,
		[MaxStake] [money] NULL,
		[MinLabel] [varchar](20) NULL,
		[MaxLabel] [varchar](20) NULL
	) 
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'UUS', 5.00, 500.00, '5', '500') -- 
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'UUS', 5.00, 1000.00, '5', '1,000') -- 
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'UUS', 5.00, 2000.00, '5', '2,000') -- 
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'RM', 20.00, 2090.00, '20', '2,090') -- MYR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'RM', 20.00, 4150.00, '20', '4,150') -- MYR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'RM', 20.00, 8300.00, '20', '8,300') -- MYR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'HKK', 20.00, 2090.00, '20', '2,090') -- HKD
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'HKK', 20.00, 4150.00, '20', '4,150') -- HKD
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'HKK', 20.00, 8300.00, '20', '8,300') -- HKD
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'KHR', 20.00, 2090.00, '20', '2,090') -- KHR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'KHR', 20.00, 4150.00, '20', '4,150') -- KHR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'KHR', 20.00, 8300.00, '20', '8,300') -- KHR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'PLN', 20.00, 2090.00, '20', '2,090') -- PLN
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'PLN', 20.00, 4150.00, '20', '4,150') -- PLN
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'PLN', 20.00, 8300.00, '20', '8,300') -- PLN
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'$US', 5.00, 500.00, '5', '500') -- USD
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'$US', 5.00, 1000.00, '5', '1,000') -- USD
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'$US', 5.00, 2000.00, '5', '2,000') -- USD
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'US$', 5.00, 500.00, '5', '500') -- USD
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'US$', 5.00, 1000.00, '5', '1,000') -- USD
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'US$', 5.00, 2000.00, '5', '2,000') -- USD
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'UT', 5.00, 500.00, '5', '500') -- USD
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'UT', 5.00, 1000.00, '5', '1,000') -- USD
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'UT', 5.00, 2000.00, '5', '2,000') -- USD
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'Yen', 5.00, 500.00, '5', '500') -- USD
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'Yen', 5.00, 1000.00, '5', '1,000') -- USD
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'Yen', 5.00, 2000.00, '5', '2,000') -- USD
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'PTU', 5.00, 500.00, '5', '500') -- INR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'PTU', 5.00, 1000.00, '5', '1,000') -- INR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'PTU', 5.00, 2000.00, '5', '2,000') -- INR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'CHF', 5.00, 500.00, '5', '500') -- CHF
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'CHF', 5.00, 1000.00, '5', '1,000') -- CHF
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'CHF', 5.00, 2000.00, '5', '2,000') -- CHF
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'MKK', 5.00, 500.00, '5', '500') -- MMK
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'MKK', 5.00, 1000.00, '5', '1,000') -- MMK
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'MKK', 5.00, 2000.00, '5', '2,000') -- MMK
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'MMK', 5.00, 500.00, '5', '500') -- MMK
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'MMK', 5.00, 1000.00, '5', '1,000') -- MMK
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'MMK', 5.00, 2000.00, '5', '2,000') -- MMK
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'TH', 5.00, 500.00, '5', '500') -- USD
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'TH', 5.00, 1000.00, '5', '1,000') -- USD
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'TH', 5.00, 2000.00, '5', '2,000') -- USD
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'PS', 5.00, 500.00, '5', '500') -- INR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'PS', 5.00, 1000.00, '5', '1,000') -- INR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'PS', 5.00, 2000.00, '5', '2,000') -- INR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'SD$', 5.00, 500.00, '5', '500') -- SGD
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'SD$', 5.00, 1000.00, '5', '1,000') -- SGD
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'SD$', 5.00, 2000.00, '5', '2,000') -- SGD
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'YNG', 5.00, 500.00, '5', '500') -- YNG
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'YNG', 5.00, 1000.00, '5', '1,000') -- YNG
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'YNG', 5.00, 2000.00, '5', '2,000') -- YNG
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'AUD', 5.00, 500.00, '5', '500') -- AUD
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'AUD', 5.00, 1000.00, '5', '1,000') -- AUD
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'AUD', 5.00, 2000.00, '5', '2,000') -- AUD
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'RMB', 30.00, 3500.00, '30', '3,500') -- CNY
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'RMB', 30.00, 7000.00, '30', '7,000') -- CNY
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'RMB', 30.00, 14000.00, '30', '14,000') -- CNY
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'CY', 30.00, 3500.00, '30', '3,500') -- CNY
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'CY', 30.00, 7000.00, '30', '7,000') -- CNY
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'CY', 30.00, 14000.00, '30', '14,000') -- CNY
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'YUN', 30.00, 3500.00, '30', '3,500') -- CNY
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'YUN', 30.00, 7000.00, '30', '7,000') -- CNY
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'YUN', 30.00, 14000.00, '30', '14,000') -- CNY
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'PTH', 30.00, 3500.00, '30', '3,500') -- INR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'PTH', 30.00, 7000.00, '30', '7,000') -- INR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'PTH', 30.00, 14000.00, '30', '14,000') -- INR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'HK$', 30.00, 3500.00, '30', '3,500') -- HKD
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'HK$', 30.00, 7000.00, '30', '7,000') -- HKD
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'HK$', 30.00, 14000.00, '30', '14,000') -- HKD
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'DKK', 30.00, 3500.00, '30', '3,500') -- DKK
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'DKK', 30.00, 7000.00, '30', '7,000') -- DKK
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'DKK', 30.00, 14000.00, '30', '14,000') -- DKK
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'SEK', 30.00, 3500.00, '30', '3,500') -- SEK
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'SEK', 30.00, 7000.00, '30', '7,000') -- SEK
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'SEK', 30.00, 14000.00, '30', '14,000') -- SEK
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'NOK', 30.00, 3500.00, '30', '3,500') -- NOK
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'NOK', 30.00, 7000.00, '30', '7,000') -- NOK
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'NOK', 30.00, 14000.00, '30', '14,000') -- NOK
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'IND', 50.00, 7000.00, '50', '7,000') -- IDR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'IND', 50.00, 14000.00, '50', '14,000') -- IDR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'IND', 50.00, 28000.00, '50', '28,000') -- IDR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'IDR', 50.00, 7000.00, '50', '7,000') -- IDR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'IDR', 50.00, 14000.00, '50', '14,000') -- IDR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'IDR', 50.00, 28000.00, '50', '28,000') -- IDR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'IN', 50.00, 7000.00, '50', '7,000') -- IDR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'IN', 50.00, 14000.00, '50', '14,000') -- IDR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'IN', 50.00, 28000.00, '50', '28,000') -- IDR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'IDD', 50.00, 7000.00, '50', '7,000') -- IDR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'IDD', 50.00, 14000.00, '50', '14,000') -- IDR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'IDD', 50.00, 28000.00, '50', '28,000') -- IDR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'DDD', 50.00, 7000.00, '50', '7,000') -- IDR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'DDD', 50.00, 14000.00, '50', '14,000') -- IDR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'DDD', 50.00, 28000.00, '50', '28,000') -- IDR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'THB', 150.00, 15000.00, '150', '15,000') -- THB
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'THB', 150.00, 30200.00, '150', '30,200') -- THB
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'THB', 150.00, 60000.00, '150', '60,000') -- THB
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'TB', 150.00, 15000.00, '150', '15,000') -- THB
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'TB', 150.00, 30200.00, '150', '30,200') -- THB
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'TB', 150.00, 60000.00, '150', '60,000') -- THB
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'Won', 5000.00, 587000.00, '5,000', '587,000') -- KRW
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'Won', 5000.00, 1150000.00, '5,000', '1,150,000') -- KRW
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'Won', 5000.00, 2350000.00, '5,000', '2,350,000') -- KRW
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'KW', 5000.00, 587000.00, '5,000', '587,000') -- KRW
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'KW', 5000.00, 1150000.00, '5,000', '1,150,000') -- KRW
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'KW', 5000.00, 2350000.00, '5,000', '2,350,000') -- KRW
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'INH', 100.00, 11500.00, '100', '11,500') -- VND
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'INH', 100.00, 23000.00, '100', '23,000') -- VND
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'INH', 100.00, 46500.00, '100', '46,500') -- VND
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'INR', 300.00, 35000.00, '300', '35,000') -- INR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'INR', 300.00, 70000.00, '300', '70,000') -- INR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'INR', 300.00, 140000.00, '300', '140,000') -- INR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'RUB', 300.00, 35000.00, '300', '35,000') -- RUB
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'RUB', 300.00, 70000.00, '300', '70,000') -- RUB
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'RUB', 300.00, 140000.00, '300', '140,000') -- RUB
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'GBP', 3.00, 385.00, '3', '385') -- GBP
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'GBP', 3.00, 750.00, '3', '750') -- GBP
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'GBP', 3.00, 1500.00, '3', '1,500') -- GBP
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'EURO', 3.00, 385.00, '3', '385') -- EUR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'EURO', 3.00, 750.00, '3', '750') -- EUR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'EURO', 3.00, 1500.00, '3', '1,500') -- EUR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'EUR', 3.00, 385.00, '3', '385') -- EUR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'EUR', 3.00, 750.00, '3', '750') -- EUR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'EUR', 3.00, 1500.00, '3', '1,500') -- EUR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'JPY', 500.00, 54000.00, '500', '54,000') -- JPY
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'JPY', 500.00, 105000.00, '500', '105,000') -- JPY
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'JPY', 500.00, 215000.00, '500', '215,000') -- JPY

	DECLARE @MaxStakeLevelID INT
	SELECT @MaxStakeLevelID = MAX(StakeLevelID) FROM DEP_StakeLevel WITH(NOLOCK)

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
DECLARE @PT smallmoney = 90.00 --10% of Athena Licensee fee (Licensees take 90%, House takes 10%)

SELECT @max_custid = xxx

INSERT INTO #supers(custid, SiteId)
SELECT c.custid, s.siteid
FROM customer c WITH (NOLOCK) 
	INNER JOIN site s WITH (NOLOCK) ON c.site = s.site
	INNER JOIN custinfo ci  WITH (NOLOCK) ON c.custid = ci.custid
WHERE c.roleid = 4  
 AND s.islicensee = 1
 AND ci.Enabled = 1
 AND c.custid <= @max_custid
 AND c.currency NOT IN (72,27,28,17,21,31,36,37,40,44,46,50,62,63,65,68,73)
 AND NOT (c.currency = 20 AND s.site = 'Athena000')
 AND s.site IN (
				'spondemo'
				,'Macaubet'
				,'Aoncash'
				,'ITCBet'
				,'Athena000'
				,'9bet'
				,'M8bola'
				,'Q8bola'
				,'BE7'
				,'NBCbet'
				,'Unobet'
				,'Bolanation'
				,'Luckywin88'
				,'Winn69'
				,'Axiawin'
				,'Jumbo88'
				,'Lagadewa'
				,'Ratugg'
				,'Monstergol'
				)

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
DECLARE @PT smallmoney = 90.00 --10% of Athena Licensee fee (Licensees take 90%, House takes 10%)

SELECT @max_custid = xxx

INSERT INTO #supers(custid, SiteId)
SELECT c.custid, s.siteid
FROM customer c WITH (NOLOCK) 
	INNER JOIN site s WITH (NOLOCK) ON c.site = s.site
	INNER JOIN custinfo ci  WITH (NOLOCK) ON c.custid = ci.custid
WHERE c.roleid = 4  
 AND s.islicensee = 1
 AND ci.Enabled = 1
 AND c.custid <= @max_custid
 AND c.currency NOT IN (72,27,28,17,21,31,36,37,40,44,46,50,62,63,65,68,73)
 AND NOT (c.currency = 20 AND s.site = 'Athena000')
 AND s.site IN (
				'spondemo'
				,'Macaubet'
				,'Aoncash'
				,'ITCBet'
				,'Athena000'
				,'9bet'
				,'M8bola'
				,'Q8bola'
				,'BE7'
				,'NBCbet'
				,'Unobet'
				,'Bolanation'
				,'Luckywin88'
				,'Winn69'
				,'Axiawin'
				,'Jumbo88'
				,'Lagadewa'
				,'Ratugg'
				,'Monstergol'
				)

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
		,@siteId =SiteId
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