/*<info serverAlias="DBCustRepl-ReplCustDB,IRS_DBTP-bodb02"></info>*/
/*
	Created: Helios
	Date: 9/9/2024 2:24:04 
	Task: Scale Out DBCUST - Apply Inhouse replication for tables of problem account - Add Rep Inhouse config Distributor [Redmine: #209747]   
	DB: DBCustRepl-ReplCustDB,IRS_DBTP-bodb02
	Table Related:
		ProblemAccount
		ProblemAccountAction
         	ProblemAccountClassification
         	ProblemAccountLimitDownline
         	ProblemAccountReason
*/

UPDATE r SET active = 0
FROM dbo.RepInfo r WITH (ROWLOCK, UPDLOCK)
WHERE name IN ('ProblemAccount' , 'ProblemAccountAction' , 'ProblemAccountClassification', 'ProblemAccountLimitDownline' , 'ProblemAccountReason')