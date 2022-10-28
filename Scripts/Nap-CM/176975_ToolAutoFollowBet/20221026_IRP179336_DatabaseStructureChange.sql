/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20221026@Johnson
	Task: Database structure change to manage follow bet account [Redmine: #179336]
	DB: DBCUST/CustDB
*/

ALTER TABLE Acc_CustFollowBet ADD IsFollow BIT 

UPDATE Acc_CustFollowBet WITH(ROWLOCK)
SET isFollow = 1