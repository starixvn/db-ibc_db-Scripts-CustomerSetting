/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20221214@Tacy
	Task: Add column RealProductId on table SportBettypeSettingMatrix
		 https://nexdev.net/issues/170739 [RedmineID: #170739]
	Database: DBCUST/CustDB
*/

USE CustDB
GO

ALTER TABLE SportBettypeSettingMatrix ADD RealProductId tinyint