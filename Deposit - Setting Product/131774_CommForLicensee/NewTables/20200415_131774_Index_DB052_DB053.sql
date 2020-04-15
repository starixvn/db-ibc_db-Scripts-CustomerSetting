/*
	Created: 20200415@Helen
	Task: https://nexdev.net/issues/131774
	DB: DB052/bodb_Licensee; DB053/bodb_Licensee
*/
USE [bodb_Licensee]
GO
CREATE NONCLUSTERED INDEX IX_LicenseeCustComm_History_CustID_UpdatedTime ON LicenseeCustComm_History
(
	[CustID]
	,[UpdatedTime]
) INCLUDE ([ProductID],[Comm])

