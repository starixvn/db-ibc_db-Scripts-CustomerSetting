/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: 20250702@Dave
	Task: Agency Cash Service - Customer Setting - Reset Banlace Cash Member [Redmine: #232054]
	DB: DBCUST-CUSTDB
*/ 
USE [CustDB]
GO

ALTER TRIGGER [dbo].[CustWinLossLimit_Member_update] ON [dbo].[CustWinLossLimit_Member]
AFTER UPDATE
AS
/*
	Created by: 2024114@Johnson
	Task: Trigger for updating [CustWinLossLimit_Member] table
	DB: DBCUST/CUSTDB
	
	Revisions: 
        - 2024114@Johnson: Apply In-house Replication for Credit Customer Setting [redmine:#212684]
		- 20250702@Dave: Agency Cash Service - Customer Setting - Reset Banlace Cash Member [Redmine: #232054]
*/
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

	INSERT INTO CustDB_History.dbo.CustWinLossLimit_Member_history
		(	CustId, SportType, BetType, MaxWinLimit, MaxLossLimit, IsAutoReset, RestedDate)
	SELECT	CustId, SportType, BetType, MaxWinLimit, MaxLossLimit, IsAutoReset, RestedDate
	FROM	Deleted
END 