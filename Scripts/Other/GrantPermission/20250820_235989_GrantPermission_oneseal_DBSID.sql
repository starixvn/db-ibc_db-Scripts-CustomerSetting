/*<info serverAlias="DBSID-bodb02"></info>*/

/*
    Created: 20250820@Tacy
	Task: [3rd Integration] - Open SP permission to TW team [Redmine: #235989]
	DB: DBSID-bodb02
*/

USE bodb02
GO

GRANT EXECUTE ON [dbo].[Dot_Int_BettransInsTransactionWithoutLog_Cust] TO [oneseal_integration]
GO

GRANT EXECUTE ON [dbo].[Dot_Int_BettransInsCancelTransfer_Cust] TO [oneseal_integration]
GO

---------------------------------------------------------------------------------
-- Cross-database procedure execution
USE [bodb_customerlog];

GRANT EXECUTE ON [dbo].[WriteLog_UserLog_Transfer] TO [oneseal_integration];

---------------------------------------------------------------------------------
-- Cross-database table access (read only)
USE [CustDB];

GRANT SELECT ON [dbo].[custinfo] TO [oneseal_integration];
GRANT SELECT ON [dbo].[exchange] TO [oneseal_integration];
GRANT SELECT ON [dbo].[customer] TO [oneseal_integration];
