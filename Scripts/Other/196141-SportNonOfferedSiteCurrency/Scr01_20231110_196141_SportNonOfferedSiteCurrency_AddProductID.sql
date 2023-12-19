/*<info serverAlias="DBCUST-CustDB"></info>*/

/*
	Created: 20231110@Tacy
	Task: Add column ProductID on table SportNonOfferedSiteCurrency (RealProductID)
		 https://nexdev.net/issues/196141
	Database: DBCUST/CustDB
*/

USE CustDB
GO

ALTER TABLE SportNonOfferedSiteCurrency ADD RealProductID TINYINT NULL;
