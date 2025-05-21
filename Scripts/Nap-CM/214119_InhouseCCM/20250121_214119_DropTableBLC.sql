/*<info serverAlias="DBCust-CustDB,DBACC-bodb02,IRS_DBTP-bodb02 "></info>*/
/*
	Created: 20241008@Winfred
	DB: DBCust-CustDB,DBACC-bodb02,IRS_DBTP-bodb02
	Task: Apply Inhouse replication for Customer Class
	Revisions:
		- 20250121@Winfred: [NAP CM] Scale Out DBCUST - Apply Inhouse replication for Customer Class[Redmine: #214119]
*/
/***************************************************************************/

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BetLimitControlTypeDetail]') AND type in (N'U'))
BEGIN
	DROP TABLE [dbo].[BetLimitControlTypeDetail]
END
ELSE 
BEGIN
	SELECT 'Table BetLimitControlTypeDetail NOT exists!!!'
END
GO
/***************************************************************************/