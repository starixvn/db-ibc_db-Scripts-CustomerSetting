/*<info serverAlias="IRS_DBG-bodb02"></info>*/
/*
	Created: Helios
	Date: 9/9/2024
	Task: Scale Out DBCUST - Apply Inhouse replication for tables of problem account - Add Rep Inhouse config Subscriber [Redmine: #209747]   
	DB: IRS_DBG-bodb02
	Table: ProblemAccount
*/


/***************************************************************************/
UPDATE r SET active = 0 FROM dbo.RepInfo r WITH (ROWLOCK , UPDLOCK) WHERE name = 'ProblemAccount'