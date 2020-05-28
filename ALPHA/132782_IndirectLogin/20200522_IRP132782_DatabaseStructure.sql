/*
	Created: 20200522@@Johnson
	Task : prepare structure for indirect login account [redmine:#132782]
	DB: DBCUST/CustDB
*/
--create table CustInDirectLogin on DBCUST/CustDB & Replicate server under pub CustDB_DR_sync
--then add this table into pub CustDB_DR_sync
CREATE TABLE [dbo].[CustInDirectLogin](	
	CustID	 INT,
	SubAccID INT,
	CustIDIndirect	INT,
	SubAccIDIndirect INT,
	LastVerifyPwd	DATETIME
CONSTRAINT [PK_CustInDirectLogin] PRIMARY KEY CLUSTERED 
	(
		[CustID] ASC,
		SubAccID ASC,
		CustIDIndirect ASC,
		SubAccIDIndirect ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [table_customer]
) ON [table_customer]
GO

