/*
Created: 20180907@Winnie
Task: Grant permission - [Redmine:#100067]
DB: DBAGE.[bodb_Age]
Revisions:

*/
USE bodb_Age
GO

GRANT SELECT ON Age_CustDateLimit TO bodbExtAccNet
GRANT UPDATE ON Age_CustDateLimit TO bodbExtAccNet
GRANT INSERT ON Age_CustDateLimit TO bodbExtAccNet