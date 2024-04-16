/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240416@Johnson
	Task: Correct Direct accounts [redmine: #201044]
	DB: DBCUST/CustDB
*/

INSERT INTO Acc_CustDirect(custid,roleid)
SELECT 116252187,3 --MH-EURO