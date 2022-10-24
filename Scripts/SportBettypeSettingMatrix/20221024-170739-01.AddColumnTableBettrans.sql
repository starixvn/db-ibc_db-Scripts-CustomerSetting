/*<info serverAlias="DBCUST-CustDB, DBTP-bodb02, DBACC-bodb02"></info>*/

/*
	Created: 20221024@Tacy
	Task: Add column TableBettrans on table SportBettypeSettingMatrix
		 https://nexdev.net/issues/170739 [RedmineID: #170739]
	Database: DBCUST/CustDB, DBTP-bodb02, DBACC-bodb02
*/

USE CustDB
GO

ALTER TABLE SportBettypeSettingMatrix ADD TableBettrans VARCHAR(100) NULL;