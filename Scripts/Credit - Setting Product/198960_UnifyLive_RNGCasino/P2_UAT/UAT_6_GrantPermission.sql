/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*	
	Created: 20240405@Eden
	Task: Grant permission for wsv_xnap (use cross DB) [#198960]
	
	DB: DBCUST/CUSTDB
*/
USE CUSTDB
GO
GRANT SELECT ON dbo.f_CustSetting_ProductProfileSel TO wsv_xnap