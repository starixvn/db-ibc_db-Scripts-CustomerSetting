/*<info serverAlias="DBCUST-CustDB,DBACC-bodb02,DBAGE-bodb02,DBSIC-CustDB"></info>*/
/*
	Created: 20250417@Helios
	Task: Alpha - Agency Cash Service -  ALTER View  [CustInfoExtra] [223896]  
	DB: DBCUST-CustDB,DBACC-bodb02,DBAGE-bodb02,DBSIC-CustDB
*/
/****** Object:  View [dbo].[vw_CustInfoExtra]    Script Date: 6/4/2025 3:36:45 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


ALTER VIEW [dbo].[vw_CustInfoExtra]
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
    cpp.ServiceType
FROM dbo.CustProductStatus cpp
GO


