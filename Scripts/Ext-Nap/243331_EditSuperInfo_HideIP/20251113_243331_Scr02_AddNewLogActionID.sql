/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: 20251113@Dave
	Task: EXT - Allow Headline to hide IP info of their downlines [Redmine:#243331]
	DB: DBLOG.bodb_CustomerLog
*/
USE bodb_CustomerLog
GO


INSERT INTO dbo.LogAction(ActionID, ActionTypeID, SPName, ActionNameEN)
VALUES(848,4,'EAS_CustomerUpdIsHideIP','Allow hiding a downline''s IP information'),
(849,4,'EAS_CustomerUpdIsHideIP_Multiple','Allow hiding IP information for multiple downlines');


SELECT ActionID, ActionTypeID, SPName, ActionNameEN
FROM dbo.LogAction WITH (NOLOCK)
WHERE ActionID IN (848,849);