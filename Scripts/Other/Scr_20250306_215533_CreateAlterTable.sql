/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20250306@Eden
	Task: Create new table Tmp_ActiveDirectMembers - store masterid, superid of active direct member follow by Archive condition
		  Alter table CustArc_NewActive add new column CreatedDTS  [#RedmineID:#215533]
	DB: DBCUST-CustDB
*/
USE custdb
GO
CREATE TABLE Tmp_ActiveDirectMembers(mrecommend INT, srecommend INT)
CREATE NONCLUSTERED INDEX IX_mrecommend ON Tmp_ActiveDirectMembers(mrecommend ASC)
CREATE NONCLUSTERED INDEX IX_srecommend ON Tmp_ActiveDirectMembers(srecommend ASC)

ALTER TABLE CustArc_NewActive ADD CreatedDTS DATETIME NULL CONSTRAINT [DF_CustArc_NewActive_CreatedDTS] DEFAULT GETDATE()