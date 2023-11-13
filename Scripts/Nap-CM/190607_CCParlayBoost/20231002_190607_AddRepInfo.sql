/*<info serverAlias="DBTP-bodb02"></info>*/
/*
	Created: 20231002@Winfred
	Task: In-House
	DB: DBTP-bodb02
	
	Revisions:
		- 20231002@Winfred: NAP CM Customer Class - Allow to offer Parlay Boost on rule setting [RedmineID: #190607]
*/
USE bodb02
GO

INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix)
SELECT 1,'CustomerClassUtilityOffer',1,'RepUpdateTime',0,'PolicyID','Repl_GetCustomerClassUtilityOffer','Repl_PutCustomerClassUtilityOffer',1000,10,60000 UNION ALL
SELECT 1,'CustomerClassUtilityOfferDetail',1,'RepUpdateTime',0,'Currency|CustomerClass|SiteID|PolicyID','Repl_GetCustomerClassUtilityOfferDetail','Repl_PutCustomerClassUtilityOfferDetail',1000,10,60000 UNION ALL
SELECT 1,'CustomerClassUtilityOffer_UAT',1,'RepUpdateTime',0,'PolicyID','Repl_GetCustomerClassUtilityOffer_UAT','Repl_PutCustomerClassUtilityOffer_UAT',1000,10,60000 UNION ALL
SELECT 1,'CustomerClassUtilityOfferDetail_UAT',1,'RepUpdateTime',0,'Currency|CustomerClass|SiteID|PolicyID','Repl_GetCustomerClassUtilityOfferDetail_UAT','Repl_PutCustomerClassUtilityOfferDetail_UAT',1000,10,60000



GRANT ALTER ON [dbo].[CustomerClassUtilityOffer] TO [repl_ap]
GO

GRANT ALTER ON [dbo].[CustomerClassUtilityOffer_UAT] TO [repl_ap]
GO

