/*
	Created: Johnson
	Date: 2017-10-25
	Task: update default value for allbet
	DB: DBLIC/bodb_Licensee
*/

update dbo.LicenseeGroupComm with(UPDLOCK,ROWLOCK)
set AllbetComm=0
GO

update dbo.LicenseeCustComm with(UPDLOCK,ROWLOCK)
set AllbetComm=0
GO