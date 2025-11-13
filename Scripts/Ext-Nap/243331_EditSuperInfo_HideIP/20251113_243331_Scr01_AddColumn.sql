/*<info serverAlias="DBCUST-CustDB,DBAGE-bodb02,DBWH-bodb02,DBACC-bodb02,DBBAH-bodb02,DBBOF-bodb02,DBTP-bodb02,DBCustRepl-ReplCustDB"></info>*/
/*
	Created: 20251113@Dave
	Task: EXT - Allow Headline to hide IP info of their downlines [Redmine:#243331]
	DB: DBCUST.CustDB,DBAGE.bodb02,DBWH.bodb02,DBACC.bodb02,DBBAH.bodb02,DBBOF.bodb02,DBTP.bodb02,DBCustRepl.ReplCustDB
*/

ALTER TABLE dbo.CustSuper ADD isHideIP BIT;

ALTER TABLE dbo.CustSuper ADD CONSTRAINT DF_CustSuper_isHideIP DEFAULT (0) FOR isHideIP;


