/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20201111@Eden
	Task: Create Non Cluster Index UMConfig [RM#142142]
	DB: DBCUST/CustDB
*/

USE CustDB
GO
CREATE NONCLUSTERED INDEX IX_UMConfig_ConfigID ON UMConfig(ConfigID)
GO
