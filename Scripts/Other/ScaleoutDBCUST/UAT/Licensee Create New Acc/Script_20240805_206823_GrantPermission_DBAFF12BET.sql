/*<info serverAlias="DBAFF12BET-Affiliate_12Bet"></info>*/
/*
	Created: Eden@20240805
	Task: Grant permission [Redmine: #206823]   
	DB: DBCUST-master
*/
USE Affiliate_12Bet
GO
GRANT EXECUTE ON [dbo].[Aff_CustomerInsMember] TO [asv_cust]
GO 