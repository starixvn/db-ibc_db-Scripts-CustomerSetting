/*<info serverAlias="DBACC-bodb02,DBAGE-bodb02,DBSIC-CustDB"></info>*/
/*
	Created: 20250417@Helios
	Task: Alpha - Agency Cash Service -  Create new View  [CustInfoExtra] [223896]  
	DB: DBACC-bodb02,DBAGE-bodb02,DBSIC-CustDB
*/

--DROP VIEW IF EXISTS [vw_CustInfoExtra];

CREATE VIEW [dbo].[vw_CustInfoExtra]
AS

SELECT 
    cpp.[CustID], 
    cpp.[bitmapHasSynced], 
    cpp.[bitmapIsHidden], 
    cpp.[bitmapIsDisabled], 
    cpp.[SuspendInfo], 
    cpp.[Locked], 
    cpp.[CloseInfo], 
    cpp.[RepUpdateTime],
    CASE 
	WHEN tb_uat.CustID IS NOT NULL THEN tb_uat.ServiceType 
	WHEN tb_uat.CustID IS NULL THEN 0
   END AS ServiceType
FROM dbo.CustProductStatus cpp
LEFT JOIN DBCUST.CustDB.dbo.CustProductStatus_UAT tb_uat ON cpp.CustID = tb_uat.CustID
GO

GRANT SELECT ON [dbo].[vw_CustInfoExtra] TO asv_CashService;
GRANT SELECT ON [dbo].[vw_CustInfoExtra] TO wsv_CashService;
