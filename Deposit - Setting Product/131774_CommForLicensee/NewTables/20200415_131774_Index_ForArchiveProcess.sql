/*
	Created: 20200415@Helen
	Task: https://nexdev.net/issues/131774
	DB: dbcust/bodb_Licensee & all replicated server
*/
USE [bodb_Licensee]
GO
CREATE NONCLUSTERED INDEX IX_LicenseeCustComm_History_UpdatedTime ON LicenseeCustComm_History
(
	[UpdatedTime]
) 

