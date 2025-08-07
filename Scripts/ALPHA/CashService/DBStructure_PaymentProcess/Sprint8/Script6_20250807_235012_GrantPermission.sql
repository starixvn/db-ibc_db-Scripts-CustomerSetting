/*<info serverAlias="DBSIC-CustDB"></info>*/
/*
  Created: 20250807@Eden
  Task: Grant permission CustSub table
  DB: DBSIC-CustDB
*/
USE [CustDB]
GO
GRANT SELECT ON [dbo].CustSub TO asv_CashService;
GRANT SELECT ON [dbo].CustSub TO wsv_CashService;