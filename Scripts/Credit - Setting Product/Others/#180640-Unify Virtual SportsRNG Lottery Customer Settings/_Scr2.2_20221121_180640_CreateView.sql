/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20221121@Eden
	Task: Add new view refer to table DBCUST.CUSTDB.dbo.ProductSettingDetail_UAT [#180640]
	DB: all replicated server of pub: CustDB_Customer_Info, CustDB_DBTrans_CustInfo
*/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProductSettingDetail_UAT]') AND type in (N'U'))
DROP TABLE [dbo].[ProductSettingDetail_UAT]
GO
CREATE VIEW ProductSettingDetail_UAT 
AS 
/*
	Created: 20221121@Eden
	Task: Add new view refer to table DBCUST.CUSTDB.dbo.ProductSettingDetail_UAT [#180640]
	DB: all replicated server of pub: CustDB_Customer_Info, CustDB_DBTrans_CustInfo
*/
SELECT * FROM DBCUST.CUSTDB.dbo.ProductSettingDetail_UAT WITH(NOLOCK)