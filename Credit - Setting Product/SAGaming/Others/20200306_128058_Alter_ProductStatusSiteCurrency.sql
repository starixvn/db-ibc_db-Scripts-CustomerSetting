/*
	Created: 20200306@Tiara
	Date: 20200306
	Task: Add constraint for ProductStatusSiteCurrency - SIT [Redmine: #128058]
	DB: DBCUST/CustDB
*/

ALTER TABLE [dbo].[ProductStatusSiteCurrency] ADD  DEFAULT ((1)) FOR [HasSynced]
GO
