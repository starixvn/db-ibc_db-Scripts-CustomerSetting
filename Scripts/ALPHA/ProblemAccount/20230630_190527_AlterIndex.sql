/*<info serverAlias="DBCUST-CustDB"></info>*/

/*
	Created: 20230630@Elodie
	Task: Include column IsReviewed on IX_ProblemAccountClassification_ModifiedDate index
		https://nexdev.net/issues/190527 RedmineID: #190527
	Database: DBCUST-CustDB
*/

USE [CustDB]
GO

/****** Object:  Index [IX_ProblemAccountClassification_ModifiedDate]    Script Date: 6/30/2023 1:50:00 PM ******/
CREATE NONCLUSTERED INDEX [IX_ProblemAccountClassification_ModifiedDate] ON [dbo].[ProblemAccountClassification]
(
	[ModifiedDate] ASC
)INCLUDE(IsReviewed) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = ON, ONLINE = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [table_customer]
GO


