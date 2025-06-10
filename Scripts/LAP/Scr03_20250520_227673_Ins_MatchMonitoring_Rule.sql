/*<info serverAlias="DBCUST-bodb_licensee,DBLIC-bodb_Licensee,DBBOF-bodb_Licensee,DBACC-bodb_Licensee,DBTP-bodb_Licensee"></info>*/
/*
	Created: 20250520@Tacy
	Task: Insert rule [#RedmineID:#227673]
	DB: DBCUST-bodb_licensee,DBLIC-bodb_Licensee,DBBOF-bodb_Licensee,DBACC-bodb_Licensee,DBTP-bodb_Licensee
*/
USE bodb_Licensee
GO

-- Insert default rules
INSERT INTO [dbo].[LicenseeMatchMonitoringRule]
    ([RuleID], [RuleName])
VALUES
    (1, 'NegativeProfit'),
    (2, 'BetRatio')
GO