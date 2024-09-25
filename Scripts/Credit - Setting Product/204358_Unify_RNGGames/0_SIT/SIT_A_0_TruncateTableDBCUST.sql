/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: @Helios
	Date: 2024/07/01
	Task: Customer Setting - Unify RNG Lottery and Virtual Sports - TRUNCATE Table SIT [redmine : #204358] 
		https://nexdev.net/issues/204358
	DB: DBCUST/CustDB
*/

SET NOCOUNT ON

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BetSetting3rd_Agent]') AND type in (N'U'))
		RETURN;

	IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BetSetting3rd_Member]') AND type in (N'U'))
		RETURN;


TRUNCATE TABLE BetSetting3rd_Agent

TRUNCATE TABLE BetSetting3rd_Member

