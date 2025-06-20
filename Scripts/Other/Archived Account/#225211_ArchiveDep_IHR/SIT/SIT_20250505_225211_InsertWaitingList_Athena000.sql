/*<info serverAlias="DBCUST-CustDB"></info>*/

/*
	Created: 20250505@Tacy  
	Task : SIT - Insert Waiting list for manually Archive [Redmine: #225211]
	DB:  DBCUST-CustDB
*/
USE CustDB
GO

INSERT INTO dbo.Dep_Customer_Archived 
	  ([CustID], [ArchivedDate], [Username], [Username2], [Recommend], [ClosingBalance], [CustIDBalanceDummy], [Status], [RepUpdateTime])
SELECT c.custid, getdate(), c.username, c.username2, c.recommend, sum (winlost- Actual_Stake + PlayerComm) as closingbalance, 24959781, 'waiting', dbo.f_getdatetime2()
FROM vw_customer c WITH (NOLOCK) 
LEFT JOIN _tmpDBSite1.bodb02.dbo.transfer t WITH (NOLOCK) ON c.custid=t.custid
WHERE c.username BETWEEN 'Athena000UUS011904026' and 'Athena000UUS011904067'
GROUP BY c.custid, c.username, c.username2, c.recommend
GO