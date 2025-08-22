/*<info serverAlias="DBCUST-CUSTDB"></info>*/

/*
    Created: 20250820@Tacy
	Task: [3rd Integration] - Open SP permission to TW team [Redmine: #235989]
	DB: DBCUST-CustDB
*/

USE CustDB
GO

GRANT EXECUTE ON [dbo].[Dot_Member_GetChargeComm_DCS] TO [oneseal_integration]
GO

---------------------------------------------------------------------------------
-- Cross-database procedure execution (Call from Transfer SPs)
USE [CustDB];

GRANT EXECUTE ON [dbo].[Acc_Transfer_CheckUM] TO [oneseal_integration];
GRANT EXECUTE ON [dbo].[Acc_SiteDBConfigSel] TO [oneseal_integration];

-- Cross-database table access (read only)
GRANT SELECT ON [dbo].[custinfo] TO [oneseal_integration];
GRANT SELECT ON [dbo].[exchange] TO [oneseal_integration];
GRANT SELECT ON [dbo].[customer] TO [oneseal_integration];
