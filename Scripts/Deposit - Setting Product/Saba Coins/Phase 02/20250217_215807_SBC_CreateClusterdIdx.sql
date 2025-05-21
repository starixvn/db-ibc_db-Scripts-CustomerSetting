/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: Tacy@20241220
	Task: Create CLUSTERED INDEX - Dep_CustSabaInfo_Del_InHouse [Redmine:#215807] 
	DB:	DBCUST-CustDB
*/
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
--
--CREATE INDEX
USE CustDB
GO 

DROP INDEX IF EXISTS [IX_Dep_CustSabaInfo_Del_InHouse_RepUpdateTime] ON [dbo].[Dep_CustSabaInfo_Del_InHouse]
GO

CREATE CLUSTERED INDEX [CIX_Dep_CustSabaInfo_Del_InHouse_RepUpdateTime] ON [dbo].[Dep_CustSabaInfo_Del_InHouse]
(
	[RepUpdateTime] ASC
)
GO