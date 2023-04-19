/*<info serverAlias="DBCRM-bodb_CRM"></info>*/
/*
	Created: 20230419@Tacy
	Task: Update new sites (yUT, y789, y889, yOther) for the rest of the UUS customers on PRO
		 https://nexdev.net/issues/182438 [RedmineID: #182438]
	Database: DBCRM-bodb_CRM
*/
IF	OBJECT_ID('tempdb..#tmp_Customer') IS NOT NULL
	DROP TABLE	#tmp_Customer;

CREATE TABLE #tmp_Customer (
		custid		INT, 
		newSiteID	INT,
		isfinished	BIT DEFAULT(0))

CREATE TABLE #tmp_Customer_Batch (
		custid		INT, 
		newSiteID	INT)

DECLARE @CustList NVARCHAR(MAX), @site VARCHAR(50), @siteID INT

SELECT @siteID=s.SettingID
FROM crmSetting s WITH (NOLOCK) 
WHERE SettingName='SITE' and SettingValue='789y (old)'

INSERT INTO #tmp_Customer (custid, newSiteID)
SELECT  cc.CustID, s.SettingID
FROM crmCustomer cc WITH (NOLOCK)
INNER JOIN bodb02.dbo.customer c WITH(NOLOCK) ON c.custid=cc.CustID
INNER JOIN crmSetting s WITH(NOLOCK) ON s.SettingValue=c.site
WHERE SettingName = 'SITE' 
AND cc.SiteID=@siteID
AND c.site IN ('yUT','y789','y889','yOther')
AND c.currency=20

WHILE (1 = 1)
BEGIN
	TRUNCATE TABLE #tmp_Customer_Batch

	UPDATE TOP (2000) #tmp_Customer
	SET isfinished = 1
	OUTPUT inserted.custid, inserted.newSiteID
		INTO #tmp_Customer_Batch(custid,newSiteID)
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK

	UPDATE cc
	SET cc.SiteID=t.newSiteID
	FROM crmCustomer cc WITH (ROWLOCK, UPDLOCK)
	INNER JOIN #tmp_Customer_Batch t ON t.custid=cc.CustID
			
	WAITFOR DELAY '00:00:0.100'
END

DROP TABLE #tmp_Customer, #tmp_Customer_Batch
GO
