/*<info serverAlias="DBCUST-CustDB,DBSIC-CustDB"></info>*/
/*
	Created: 20250417@Max
	Task: Alpha - Agency Cash Service - [Redmine: #223896]  
	DB: DBCUST-CustDB,DBSIC-CustDB
*/

USE [CustDB]
GO

CREATE VIEW [dbo].[vw_CashService_Customer] 
AS
SELECT c.custid, firstname AS firstname, lastname AS lastname,'' AS address, '' AS postal,'' AS  city, '' AS state, '' AS country, c.phone AS phone, c.mobilephone AS mobilephone
		,'' AS  fax,'' AS  email, birthday, refcode1, refcode2, remark, creatdate, c.creator, c.username, c.currency, lastlogged, c.roleid, c.mrecommend, c.recommend, ugroup, logincount, on_sessionid, site
		,'' AS  iplogin, important, c.srecommend, username2
FROM dbo.Customer c WITH (NOLOCK) 
GO

/*Grant permission*/
GRANT SELECT ON [dbo].[vw_CashService_Customer] TO asv_CashService;
GRANT SELECT ON [dbo].[vw_CashService_Customer] TO wsv_CashService;

--Other tables: custinfo, exchange
GRANT SELECT ON [dbo].[custinfo] TO asv_CashService;
GRANT SELECT ON [dbo].[custinfo] TO wsv_CashService;

GRANT SELECT ON [dbo].[exchange] TO asv_CashService;
GRANT SELECT ON [dbo].[exchange] TO wsv_CashService;


