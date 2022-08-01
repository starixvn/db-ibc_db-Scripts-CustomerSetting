/*<info serverAlias="DBPOL-Nap_UserControl"></info>*/
/*
	Created: 20220517@Winfred
	Task : Remove duplicate acc QC Test [redmine:#170994]
	DB: DBPOL/NAP_UserControl
*/

USE Nap_UserControl
GO

DELETE FROM AdminOTP WHERE CustID = 65286237 AND  System = 'NAP' AND Creator = 10278938 