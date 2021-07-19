/*
	Created: Winnie
	Date: 2019-02-27
	Task: Update Ignored=1 for 94 account RedmineID:#108504
	DB: DBCRM/bodb_crm
*/

USE [bodb_CRM]
GO

CREATE TABLE #temp(
	[CustID] [int] NULL,
	[UserName] [varchar](50) NULL
)

GO
SET ANSI_PADDING OFF
GO
INSERT #temp ([CustID], [UserName]) VALUES (1654082, N'DK')
GO
INSERT #temp ([CustID], [UserName]) VALUES (29418666, N'LSH')
GO
INSERT #temp ([CustID], [UserName]) VALUES (30284624, N'A11H')
GO
INSERT #temp ([CustID], [UserName]) VALUES (32335843, N'MPK')
GO
INSERT #temp ([CustID], [UserName]) VALUES (6446813, N'LEONHKD')
GO
INSERT #temp ([CustID], [UserName]) VALUES (23458906, N'147HKD')
GO
INSERT #temp ([CustID], [UserName]) VALUES (28937029, N'CGY')
GO
INSERT #temp ([CustID], [UserName]) VALUES (2229262, N'SATU')
GO
INSERT #temp ([CustID], [UserName]) VALUES (30143280, N'VTINUS')
GO
INSERT #temp ([CustID], [UserName]) VALUES (27789477, N'xyz100RM')
GO
INSERT #temp ([CustID], [UserName]) VALUES (29953497, N'LianRUP')
GO
INSERT #temp ([CustID], [UserName]) VALUES (28615710, N'000WSRM')
GO
INSERT #temp ([CustID], [UserName]) VALUES (32087289, N'QZRMB')
GO
INSERT #temp ([CustID], [UserName]) VALUES (30148587, N'JS614')
GO
INSERT #temp ([CustID], [UserName]) VALUES (30016073, N'WC2018RMB')
GO
INSERT #temp ([CustID], [UserName]) VALUES (30008227, N'WC2018HK')
GO
INSERT #temp ([CustID], [UserName]) VALUES (32045063, N'ES001')
GO
INSERT #temp ([CustID], [UserName]) VALUES (29871763, N'WC18')
GO
INSERT #temp ([CustID], [UserName]) VALUES (27780175, N'999HKD')
GO
INSERT #temp ([CustID], [UserName]) VALUES (30117619, N'wstb_222')
GO
INSERT #temp ([CustID], [UserName]) VALUES (28822142, N'118M')
GO
INSERT #temp ([CustID], [UserName]) VALUES (31739198, N'ED24')
GO
INSERT #temp ([CustID], [UserName]) VALUES (32064613, N'6666PEU')
GO
INSERT #temp ([CustID], [UserName]) VALUES (27899314, N'AH501')
GO
INSERT #temp ([CustID], [UserName]) VALUES (27787409, N'XYZPTRM')
GO
INSERT #temp ([CustID], [UserName]) VALUES (29765461, N'9772RM')
GO
INSERT #temp ([CustID], [UserName]) VALUES (30293403, N'QZ3WCRMB')
GO
INSERT #temp ([CustID], [UserName]) VALUES (30293541, N'QZ3WCHKD')
GO
INSERT #temp ([CustID], [UserName]) VALUES (28014110, N'MC-C1X2')
GO
INSERT #temp ([CustID], [UserName]) VALUES (29958560, N'WCBill')
GO
INSERT #temp ([CustID], [UserName]) VALUES (32679358, N'RUIC')
GO
INSERT #temp ([CustID], [UserName]) VALUES (29270764, N'MOLLYBET')
GO
INSERT #temp ([CustID], [UserName]) VALUES (29829726, N'QE1_deleted')
GO
INSERT #temp ([CustID], [UserName]) VALUES (29830026, N'QE2_deleted')
GO
INSERT #temp ([CustID], [UserName]) VALUES (29830028, N'QE3_deleted')
GO
INSERT #temp ([CustID], [UserName]) VALUES (29830030, N'QE4_deleted')
GO
INSERT #temp ([CustID], [UserName]) VALUES (29830031, N'QE5_deleted')
GO
INSERT #temp ([CustID], [UserName]) VALUES (30999077, N'797OLD')
GO
INSERT #temp ([CustID], [UserName]) VALUES (31113887, N'HPMOLD')
GO
INSERT #temp ([CustID], [UserName]) VALUES (31178944, N'KJMOLD')
GO
INSERT #temp ([CustID], [UserName]) VALUES (33279274, N'ccti')
GO
INSERT #temp ([CustID], [UserName]) VALUES (32700040, N'899RMB')
GO
INSERT #temp ([CustID], [UserName]) VALUES (29980959, N'9wicket-hkd')
GO
INSERT #temp ([CustID], [UserName]) VALUES (30065084, N'MTD-JON')
GO
INSERT #temp ([CustID], [UserName]) VALUES (27792202, N'HMTD-Kelvin')
GO
INSERT #temp ([CustID], [UserName]) VALUES (29802760, N'STESTEUR')
GO
INSERT #temp ([CustID], [UserName]) VALUES (31356067, N'mtd-yew')
GO
INSERT #temp ([CustID], [UserName]) VALUES (32736550, N'S31OLD')
GO
INSERT #temp ([CustID], [UserName]) VALUES (27792288, N'HMTD-Yakushi')
GO
INSERT #temp ([CustID], [UserName]) VALUES (27788352, N'1x2-Stock')
GO
INSERT #temp ([CustID], [UserName]) VALUES (29243926, N'9wicket-rmb')
GO
INSERT #temp ([CustID], [UserName]) VALUES (27789706, N'HMTD-Foo')
GO
INSERT #temp ([CustID], [UserName]) VALUES (27792268, N'HMTD-Wei')
GO
INSERT #temp ([CustID], [UserName]) VALUES (30457243, N'ChesterHK')
GO
INSERT #temp ([CustID], [UserName]) VALUES (27789343, N'HMTD-FLin')
GO
INSERT #temp ([CustID], [UserName]) VALUES (32644552, N'D-W39')
GO
INSERT #temp ([CustID], [UserName]) VALUES (27792283, N'HMTD-Xu')
GO
INSERT #temp ([CustID], [UserName]) VALUES (30065162, N'MTD-PARKER')
GO
INSERT #temp ([CustID], [UserName]) VALUES (31724205, N'SHRMOLD')
GO
INSERT #temp ([CustID], [UserName]) VALUES (30393342, N'WC18OUTRIGHT')
GO
INSERT #temp ([CustID], [UserName]) VALUES (29802864, N'STESTK88')
GO
INSERT #temp ([CustID], [UserName]) VALUES (27789309, N'HMTD-BRIAN')
GO
INSERT #temp ([CustID], [UserName]) VALUES (27792214, N'HMTD-Kuan')
GO
INSERT #temp ([CustID], [UserName]) VALUES (33108587, N'M96RMOLD')
GO
INSERT #temp ([CustID], [UserName]) VALUES (30246956, N'sbomax')
GO
INSERT #temp ([CustID], [UserName]) VALUES (30265445, N'752HK')
GO
INSERT #temp ([CustID], [UserName]) VALUES (33026615, N'737RMB')
GO
INSERT #temp ([CustID], [UserName]) VALUES (30258967, N'TFHKD')
GO
INSERT #temp ([CustID], [UserName]) VALUES (29232394, N'MOLLY05')
GO
INSERT #temp ([CustID], [UserName]) VALUES (33234281, N'M-Byron1')
GO
INSERT #temp ([CustID], [UserName]) VALUES (27792235, N'HMTD-RICHIE')
GO
INSERT #temp ([CustID], [UserName]) VALUES (27789224, N'HMTD-Bao')
GO
INSERT #temp ([CustID], [UserName]) VALUES (27789287, N'HMTD-Boy')
GO
INSERT #temp ([CustID], [UserName]) VALUES (27789324, N'HMTD-Feibee')
GO
INSERT #temp ([CustID], [UserName]) VALUES (27788339, N'PH-Stock')
GO
INSERT #temp ([CustID], [UserName]) VALUES (31113550, N'SJMOLD')
GO
INSERT #temp ([CustID], [UserName]) VALUES (32373956, N'VNBF')
GO
INSERT #temp ([CustID], [UserName]) VALUES (27788325, N'MTDL-Stock')
GO
INSERT #temp ([CustID], [UserName]) VALUES (27792261, N'HMTD-VINH')
GO
INSERT #temp ([CustID], [UserName]) VALUES (27787818, N'MTD-Stock')
GO
INSERT #temp ([CustID], [UserName]) VALUES (27792252, N'HMTD-TKee')
GO
INSERT #temp ([CustID], [UserName]) VALUES (30065234, N'MTD-VICO')
GO
INSERT #temp ([CustID], [UserName]) VALUES (32203930, N'679OLD')
GO
INSERT #temp ([CustID], [UserName]) VALUES (29232384, N'MOLLY04')
GO
INSERT #temp ([CustID], [UserName]) VALUES (27792227, N'HMTD-LSoon')
GO
INSERT #temp ([CustID], [UserName]) VALUES (27936830, N'MEE168')
GO
INSERT #temp ([CustID], [UserName]) VALUES (31113499, N'AHMOLD')
GO
INSERT #temp ([CustID], [UserName]) VALUES (28463452, N'9wicket-EU')
GO
INSERT #temp ([CustID], [UserName]) VALUES (29232350, N'MOLLY01')
GO
INSERT #temp ([CustID], [UserName]) VALUES (30999101, N'92OLD')
GO
INSERT #temp ([CustID], [UserName]) VALUES (33287715, N'RS21')
GO
INSERT #temp ([CustID], [UserName]) VALUES (32533951, N'TKRMOLD')
GO
INSERT #temp ([CustID], [UserName]) VALUES (29232364, N'MOLLY02')
GO
INSERT #temp ([CustID], [UserName]) VALUES (29232373, N'MOLLY03')
GO

UPDATE c
	SET c.Ignored=1
FROM #temp t
INNER JOIN crmCustomer c WITH(ROWLOCK,UPDLOCK) ON t.CustID=c.CustID

DELETE t
FROM #temp t
INNER JOIN crmCustomer c WITH(NOLOCK) ON t.CustID=c.CustID

DECLARE @custID INT, @username NVARCHAR(50), @roleid TINYINT
DECLARE @Site					INT  = NULL,
		@FirstName				NVARCHAR(100) = NULL,
		@LastName				NVARCHAR(100) = NULL,
		@Language				VARCHAR(500) = NULL,
		@CountryID				INT = NULL,
		@Phone					NVARCHAR(100) = NULL,
		@PhoneCountryCode		NVARCHAR(20) = NULL,
		@PhoneAreaCode			NVARCHAR(20) = NULL,
		@Phone2					NVARCHAR(100) = NULL,
		@Phone2CountryCode		NVARCHAR(20) = NULL,
		@Phone2AreaCode			NVARCHAR(20) = NULL,
		@Phone3					NVARCHAR(100) = NULL,
		@Phone3CountryCode		NVARCHAR(20) = NULL,
		@Phone3AreaCode			NVARCHAR(20) = NULL,
		@MobilePhone			NVARCHAR(100) = NULL,
		@MobilePhoneCountryCode	NVARCHAR(20) = NULL,
		@MobilePhoneAreaCode	NVARCHAR(20) = NULL,
		@Email					NVARCHAR(100) = NULL,
		@MSN					NVARCHAR(100) = NULL,
		@Skype					NVARCHAR(100) = NULL,
		@Pic1					NVARCHAR(200) = NULL,
		@Pic2					NVARCHAR(200) = NULL,
		@Pic3					NVARCHAR(200) = NULL,
		@Pic4					NVARCHAR(200) = NULL,
		@Pic1Name				NVARCHAR(200)='',
		@Pic2Name				NVARCHAR(200)='',
		@Pic3Name				NVARCHAR(200)='',
		@Pic4Name				NVARCHAR(200)='',
		@UserID					INT = 24103343,
		@IP						VARCHAR(15) = '125.227.140.97'

SELECT ci.custid, ci.username, ci.roleid, 0 AS IsFinished
INTO #CustListImport
FROM bodb02.dbo.CustDirectAccount cd WITH (NOLOCK)
	INNER JOIN bodb02.dbo.custInfo ci WITH (NOLOCK) ON ci.custid = cd.CustID
	INNER JOIN #temp t ON ci.custid=t.CustID
WHERE NOT EXISTS (SELECT 1 FROM dbo.crmCustomer crm WITH (NOLOCK) WHERE ci.username = crm.username)

-- For deployer info
DECLARE @List_cnt INT, @index INT = 0
DECLARE @msg NVARCHAR(200) = 'Currently at order %d, custID: %d.'
DECLARE @msg_total NVARCHAR(200) = 'Total of customers: %d.'

SET @List_cnt = (SELECT COUNT(*) FROM #CustListImport )
RAISERROR (@msg_total, 0, 1, @List_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #CustListImport
	SET isfinished = 1
		,@custID = custid	
		,@username = username
		,@roleid = roleid
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK
	
	SET @index = @index + 1
	RAISERROR (@msg, 0, 1, @index, @custID) WITH NOWAIT

	DECLARE @SiteID INT,
			@CountryName varchar(100),
			@IsGroupHeadLine BIT
		
	IF @RoleID = 1
	BEGIN
		SELECT @SiteID = SettingID 
		FROM crmSetting WITH(NOLOCK) 
		WHERE SettingValue = 
							(SELECT ag.site 
								FROM bodb02.dbo.customer c WITH(NOLOCK) 
									INNER JOIN bodb02.dbo.customer ag WITH(NOLOCK) ON c.recommend = ag.custid
								WHERE c.custid = @CustID)
			AND SettingName = 'Site'

	END
	ELSE
	BEGIN
		SELECT @SiteID = SettingID 
		FROM crmSetting WITH(NOLOCK) 
		WHERE SettingValue = 
							(SELECT site 
								FROM bodb02.dbo.customer c WITH(NOLOCK)
								WHERE c.custid = @CustID)
			AND SettingName = 'Site'
	END

	-----return customer
	SELECT @CountryName = Country,
			@CountryID = c.CountryID
	FROM bodb02.dbo.Customer cm WITH(NOLOCK)
	INNER JOIN crmCountry c ON cm.country = c.CountryName
	WHERE cm.custid = @custID
			
	SELECT @IsGroupHeadLine=ISNULL(IsGroupHeadLine,0) FROM bodb02.dbo.custAccount WITH(NOLOCK) WHERE custid=@CustID AND IsGroupHeadLine=1

	SELECT	
		@FirstName = cm.FirstName,
		@LastName = cm.LastName, 
		@Phone = cm.phone, 
		@MobilePhone = cm.MobilePhone,
		@Email = cm.Email, 
		@CountryName = ct.CountryName
	FROM 
		bodb02.dbo.custinfo c WITH(NOLOCK) 
				LEFT JOIN crmCustomer crm WITH(NOLOCK) ON c.custID = crm.custID
				LEFT JOIN crmCountry ct WITH(NOLOCK) ON ct.CountryID = crm.CountryID
				LEFT JOIN bodb02.dbo.Customer cm WITH(NOLOCK) on c.custID = cm.CustID
	WHERE  c.custID = @custID

	--2nd Record Set
	SELECT @Language = cl.LanguageID
	FROM crmCustomerLanguage cl WITH (NOLOCK) 
	WHERE CustID = @custID

	exec Acc_CRM_CustomerUpdateBasicInfo @IP=@IP,@MobilePhone=@MobilePhone,@LastName=@LastName,@Phone3=@Phone3,@Language=@Language,@Phone2AreaCode=@Phone2AreaCode,
										@Email=@Email,@FirstName=@FirstName,@Phone2=@Phone2,@MobilePhoneCountryCode=@MobilePhoneCountryCode,@PhoneAreaCode=@PhoneAreaCode,
										@Site=@Site,@MSN=@MSN,@UserID=@UserID,@Phone3AreaCode=@Phone3AreaCode,@CustID=@custID,@MobilePhoneAreaCode=@MobilePhoneAreaCode,
										@Skype=@Skype,@CountryID=@CountryID,@Phone2CountryCode=@Phone2CountryCode,@Phone3CountryCode=@Phone3CountryCode,
										@PhoneCountryCode=@PhoneCountryCode,@Phone=@Phone
	
	waitfor delay '00:00:0.100'
END

UPDATE c
	SET c.Ignored=1
FROM #temp t
INNER JOIN crmCustomer c WITH(ROWLOCK,UPDLOCK) ON t.CustID=c.CustID

DROP TABLE #temp
DROP TABLE #CustListImport