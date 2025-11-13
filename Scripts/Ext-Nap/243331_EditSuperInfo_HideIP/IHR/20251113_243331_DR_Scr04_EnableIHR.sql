/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20251113@Dave
	Task: EXT - Allow Headline to hide IP info of their downlines [Redmine:#243331]
	DB: DBCUST.CustDB
*/

IF EXISTS (SELECT 1 FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustSuper')
BEGIN
	UPDATE RepInfo
	SET active = 1
	WHERE [name] =  'CustSuper';
	SELECT 'Activated RepInfo entry for CustSuper' AS Message;
END
GO
