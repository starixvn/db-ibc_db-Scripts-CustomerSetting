 /*
 	Created: Winnie
	Date: 20191028
	Task: Update PP
	DB: DBCust/CustDB
*/
 UPDATE a
 SET a.MaxStake=750,MaxLabel='750',MinStake=0.15,MinLabel='0.15'
 FROM StakeLevelGroupDetail a WITH(ROWLOCK,UPDLOCK)
 WHERE StakeLevelID=857 AND GameTypeID=4121
  
 
 UPDATE a
 SET a.MaxStake=540,MaxLabel='540',MinStake=0.9,MinLabel='0.9'
 FROM StakeLevelGroupDetail a WITH(ROWLOCK,UPDLOCK)
 WHERE StakeLevelID=857 AND GameTypeID=4154