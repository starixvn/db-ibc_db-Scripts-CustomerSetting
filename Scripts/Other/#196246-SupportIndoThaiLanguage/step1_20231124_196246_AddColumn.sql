/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20231124@Luke
	Task: LAP - Support Indonesian & Thai language [Redmine: #196246]
	DB: DBCUST/CustDB
*/


--Add new column MsgNameIN (Indo language)
ALTER TABLE MsgError ADD MsgNameIN NVARCHAR(500) NULL
GO
