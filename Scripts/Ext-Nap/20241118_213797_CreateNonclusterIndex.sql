/*<info serverAlias="DBPOL-NAP_UserControl"></info>*/
/*
	Created: 20241118@Elodie
	Task: Create nonclustered index on eaOn_User [Redmine:#213797]
	DB: DBPOL.NAP_UserControl
*/
USE NAP_UserControl
GO

CREATE NONCLUSTERED INDEX IX_eaOnUser_CustID ON eaOn_User (CustID)