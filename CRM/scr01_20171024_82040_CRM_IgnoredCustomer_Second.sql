/*
	Created: 20171024@Elodie
	Task: Import customer from mainDB to CRM system 
	DB: DBCRM/bodb_CRM
*/
USE bodb_CRM
GO

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
		@UserID					INT = 15954668,
		@IP						VARCHAR(15) = '125.227.140.97'

SELECT ci.custid, ci.username, ci.roleid, 0 AS IsFinished
INTO #CustListImport
FROM bodb02.dbo.Customer ci WITH (NOLOCK)
WHERE username IN ('IS','JTM','JTR','MasDirUus06','MasDirUus07','S52ARM','S86BTB','SA-$US','SA-$US789y','SA-AUD','SA-C','SA-CAD','SA-CHF','SA-EURO','SA-GBP','SA-H','SA-IDD',
						'SA-IDR','SA-IN','SA-IND','SA-IRR','SA-JPY','SA-NT','SA-NTD','SA-P','SA-PE','SA-pts','SA-RMB','SA-SD$','SA-TB','SA-THB','SA-UUS','SA-Y$US','SA-Yen','SB5R',
						'supertest14','supertest16','supertestgrk01','supertestlive8','supertestlive9','supertestuat','supertestuatX','M32ARM','M3BRMB','M3ZRMB','3S100','359IRM',
						'6599RMB','MALRM','S195.COM','7899R','789R','801BM','MGARM','MGBRM','MGCRM','MGDRM','MGHK','9999SD','AA999','NL999','KIN','AEK','BV91','BV92','BV93','BV94',
						'BV95','BV96','BV97','BV98','BV99','DTD56','DTD57','DTD58','DTD59','DTD60','DTD61','DTD62','DTD63','DTD65','DTD66','DTD67','DTD68','DTD69','DTD70','DTD71',
						'DTD72','DTD73','DTD75','DTD76','DTD77','EAL','EE','EH5','EH6','EQH','ET','ET1RMB','ETEX','ETprovision','ETR','KP100','KP101','KP102','KP200','KP300','KP90',
						'KP91','KP92','KP93','KP94','KP95','KP96','KP97','KY48','MEK','OP21','OP22','OP23','OP24','OP25','OP26','OP27','OP28','OP29','OP9','PV100','S05','SM','SQ',
						'SQH','SQQR','TWW','VT1US','XE','XF','XL','XXC','XXF','ZW1','ZW10','ZW11','ZW12','ZW13','ZW14','ZW15','ZW16','ZW17','ZW18','ZW19','ZW2','ZW20','ZW21','ZW22',
						'ZW23','ZW24','ZW25','ZW26','ZW27','ZW28','ZW29','ZW3','ZW30','ZW4','ZW5','ZW6','ZW7','ZW8','ZW9','ZX21','ZX22','ZX23','ZX24','ZX25','ZX26','ZX27','ZX28',
						'ZX29','ZX30','ZX31','ZX32','ZX33','ZX34','ZX35','ZX36','ZX37','ZX38','ZX39','ZX40','WHD-PT','WHT-PT','VVA','LHHR','S12RM','166AHK','166HK','3188HK','A50RM',
						'B50RM','M50ARM','5503RM','c9009','A7US','M7US','A818H','9600RM','SBKR','MMYUS','shhkk','POQ','RG16','1188RM','M188HK','2VH','S22R','AL8','LGH1','36IRM',
						'M47ARMB','M47BRMB','M56R','S56RMB','330SD','M63ARMB','M63BRMB','M63CRMB','M63DRMB','M63RMB','69HK','6666AEU','6666AUD','6666ieu','6666SD','6666US','666ius',
						'M85R','M88ARM','M88ARMB','M88BRM','M88BRMB','M88CRM','M88CRMB','M88DRM','M88DRMB','M88ERM','855BP','SBIR00','sbir03','MD1H','mharmb','MHBRMB','MHCRMB','MHDRMB',
						'MHERMB','MHFRMB','MHGRMB','MHHRMB','MHIRMB','MHJRMB','MHKRMB','MHLRMB','MHRMB','SHRM','113SD','MKARM','PARMB','PPRMB','SSSDRM','STIRM','QZ80','QZ81','QZ82',
						'QZ83','QZ84','QZ85','QZ86','QZ87','QZ88','QZ89','QZ8A','QZ8B','QZ8C','QZ8D','QZ8E','QZ8F','QZ8G','QZ8H','QZ8i','QZ8J','QZ8K','QZ8L','QZ8M','QZ8N','QZ8O',
						'QZ8P','QZ8Q','QZ8R','QZ8S','QZ8T','QZ8U','QZ8V','QZ8W','QZ8X','QZ8Y','QZ8Z','JTRIGBP','DTA53')
	AND NOT EXISTS (SELECT 1 FROM dbo.crmCustomer crm WITH (NOLOCK) WHERE ci.username = crm.username)

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
GO

