/*
	Created: 20200616@Helen
	Task: CRM - Resolve Duplicated and missing feedback while creating automatically - https://nexdev.net/issues/135337
	DB: DB061/bodb02
*/
USE bodb02
GO
CREATE NONCLUSTERED INDEX IX_VodingHistory_CreatedDate
ON [dbo].[TicketVoiding_VoidingHistory] ([CreatedDate])
INCLUDE ([MessageId],[StatusId])
GO