/*<info serverAlias="DBACC-bodb02"></info>*/
/*
	Created: 20240313@Johnson
	Task: Add exception archive accounts for Hedging & Phone Betting sites [redmine: #201044]
	DB: DBCUST/CustDB
*/

INSERT INTO bodb_report.dbo.[Task_Cust_ArchiveAcc_Exception](CustID,Remark)
SELECT ci.custid,ci.username
FROM dbo.custinfo ci WITH(NOLOCK)
	LEFT JOIN  bodb_report.dbo.[Task_Cust_ArchiveAcc_Exception] ce WITH (NOLOCK) ON ce.custid IN (ci.recommend,ci.mrecommend,ci.srecommend)
WHERE username IN ('SH-EURO','SH-HK$','SH-RMB','SH-RM','SH-RUP','SS-RMB','SS-RM')


