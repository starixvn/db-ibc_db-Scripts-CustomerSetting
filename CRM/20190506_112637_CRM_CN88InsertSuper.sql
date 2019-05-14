/*
	Created: Winnie
	Date: 20190509
	Task: Insert CN88 RedmineID:#112637
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
INSERT #temp ([CustID])
SELECT CustID FROM bodb02.dbo.Customer WITH(NOLOCK) WHERE 
--srecommend IN(SELECT custid from bodb02.dbo.CS_CustSuper) OR 
RoleID=0

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
FROM  bodb02.dbo.custInfo ci WITH (NOLOCK)
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
			AND (SettingName = 'Site' OR SettingName='SiteCategory')

	END
	ELSE
	BEGIN
		SELECT @SiteID = SettingID 
		FROM crmSetting WITH(NOLOCK) 
		WHERE SettingValue = 
							(SELECT site 
								FROM bodb02.dbo.customer c WITH(NOLOCK)
								WHERE c.custid = @CustID)
			AND (SettingName = 'Site' OR SettingName='SiteCategory')
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

	exec Acc_CRM_CustomerUpdateBasicInfo_xpre @IP=@IP,@MobilePhone=@MobilePhone,@LastName=@LastName,@Phone3=@Phone3,@Language=@Language,@Phone2AreaCode=@Phone2AreaCode,
										@Email=@Email,@FirstName=@FirstName,@Phone2=@Phone2,@MobilePhoneCountryCode=@MobilePhoneCountryCode,@PhoneAreaCode=@PhoneAreaCode,
										@Site=@SiteID,@MSN=@MSN,@UserID=@UserID,@Phone3AreaCode=@Phone3AreaCode,@CustID=@custID,@MobilePhoneAreaCode=@MobilePhoneAreaCode,
										@Skype=@Skype,@CountryID=@CountryID,@Phone2CountryCode=@Phone2CountryCode,@Phone3CountryCode=@Phone3CountryCode,
										@PhoneCountryCode=@PhoneCountryCode,@Phone=@Phone,@UserRole=1
	waitfor delay '00:00:0.100'
END

UPDATE c
	SET c.Ignored=0
FROM #temp t
INNER JOIN crmCustomer c WITH(ROWLOCK,UPDLOCK) ON t.CustID=c.CustID

DROP TABLE #temp
DROP TABLE #CustListImport

--select * from crmCustomer where custid=35555230