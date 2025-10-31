/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created By: Johnson@20251030
	Description: Adjust Max PT 90% and Comm 0.8% for Live Casino Product [redmine: #242260]
	DB: DBCust/CustDB	
*/

SELECT MAX(custid) as maxCustID, GETDATE() as currentDate FROM custinfo WITH(NOLOCK)
GO

