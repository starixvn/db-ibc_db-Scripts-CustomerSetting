/*<info serverAlias="DBTP-bodb02"></info>*/
/*
	Created: 20231002@Winfred
	Task: In-House
	DB: DBTP-bodb02
	
	Revisions:
          - 20231002@Winfred: NAP CM Customer Class - Support for Non-Sports [RedmineID: #186116] 
*/
USE bodb02
GO

INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix)
SELECT 1,'CustomerClassNonSports',1,'RepUpdateTime',0,'PolicyID','Repl_GetCustomerClassNonSports','Repl_PutCustomerClassNonSports',1000,10,60000 UNION ALL
SELECT 1,'CustomerClassNonSportsDetail',1,'RepUpdateTime',0,'SiteID|CustomerClass|PolicyID','Repl_GetCustomerClassNonSportsDetail','Repl_PutCustomerClassNonSportsDetail',1000,10,60000 UNION ALL
SELECT 1,'CustomerClassNonSports_UAT',1,'RepUpdateTime',0,'PolicyID','Repl_GetCustomerClassNonSports_UAT','Repl_PutCustomerClassNonSports_UAT',1000,10,60000 UNION ALL
SELECT 1,'CustomerClassNonSportsDetail_UAT',1,'RepUpdateTime',0,'SiteID|CustomerClass|PolicyID','Repl_GetCustomerClassNonSportsDetail_UAT','Repl_PutCustomerClassNonSportsDetail_UAT',1000,10,60000



GRANT ALTER ON [dbo].[CustomerClassUtilityOffer] TO [repl_ap]
GO

GRANT ALTER ON [dbo].[CustomerClassUtilityOffer_UAT] TO [repl_ap]
GO

