/*<info serverAlias="DBCUST-AgencyCashService"></info>*/
/*
	Created: 20250417@Helios
	Task: Alpha - Agency Cash Service - Support QC Test [223896]   
	DB: DBCUST-AgencyCashService
*/

IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.CashAgentProviderConfig') AND type = 'U')
BEGIN
	UPDATE a SET ChannelContact = N'{"Tele": "https://t.me/+XxIV3WPg3gc3NTM1"}' , RepUpdateTime = SYSDATETIME ()
	FROM CashAgentProviderConfig a WITH (ROWLOCK ,UPDLOCK)
END
