/*<info serverAlias="DBAGE-bodb02"></info>*/
/*
	Created: 20230421@Elodie
	Task: Add Index username2 on CustSub table [RedmineId: #169643]
	DB: DBAGE/bodb02
*/

USE [bodb02]
GO

CREATE NONCLUSTERED INDEX [IX_username2] ON [dbo].[custSub]
(
	[UserName2] ASC
) ON [DATA]
GO


