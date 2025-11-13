/*<info serverAlias="IRS_DBWH-bodb02,IRS_DBACC-bodb02,IRS_DBAGE-bodb02,IRS_DBBAH-bodb02,IRS_DBBOF-bodb02, DBCustRepl-ReplCustDB, IRS_DBTP-bodb02"></info>*/
/*
	Created: 20251113@Dave
	Task: EXT - Allow Headline to hide IP info of their downlines [Redmine:#243331]
	DB: IRS_DBWH.bodb02, IRS_DBACC.bodb02, IRS_DBAGE.bodb02, IRS_DBBAH.bodb02,IRS_DBBOF.bodb02, DBCustRepl.ReplCustDB, IRS_DBTP.bodb02
*/

IF EXISTS (SELECT 1 FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustSuper')
BEGIN
	UPDATE RepInfo
	SET active = 0
	WHERE [name] =  'CustSuper';
	SELECT 'Deactivated RepInfo entry for CustSuper' AS Message;
END
GO
