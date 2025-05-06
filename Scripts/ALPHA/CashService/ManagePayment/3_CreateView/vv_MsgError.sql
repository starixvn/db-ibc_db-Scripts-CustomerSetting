/*<info serverAlias="DBCUST-CustDB,DBACC-bodb02,DBAGE-bodb02,DBBAH-bodb02,DBBOF-bodb02,IRS_DBSIG-bodb02,IRS_DBCTG-CustDB,IRS_DBTP-bodb02"></info>*/
/*
	Created: 20250417@Helios
	Task: Alpha - Agency Cash Service -  Create new View  [CustInfoExtra] [223896]  
	DB: DBCUST/CustDB
*/

--DROP VIEW IF EXISTS [CustInfoExtra];

USE AgencyCashService
GO
CREATE VIEW [dbo].[MsgError]
AS
SELECT [MsgID], [MsgGroupID], [MsgNameEN], [MsgNameCT], [MsgNameCS], [MsgNameJP], [MsgNameTH], [MsgNameKO], [MsgNameES], [MsgNameVI], [IsActive], [MsgNameCN], [MsgNameIN]
FROM CUSTDB.dbo.MsgError
GO

--GRANT PERMISSION
GRANT SELECT ON [dbo].[MsgError] TO wsv_CashService;
