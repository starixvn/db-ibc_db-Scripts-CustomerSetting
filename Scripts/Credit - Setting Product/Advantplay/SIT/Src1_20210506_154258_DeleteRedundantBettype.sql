/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20210506
	Task:  Remove redundant bettype StakeLevelGroupDetail - AdvantPlay RedmineID:#154258
	DB: DBCust/CustDB
	P/s : Step 1 Remove redundant bettype StakeLevelGroupDetail Only Run SIT
*/

DELETE cg
FROM dbo.StakeLevelGroupDetail cg WITH(ROWLOCK)		
WHERE GameTypeID = 7711

DELETE cg
FROM dbo.StakeLevel cg WITH(ROWLOCK)		
WHERE GameTypeID = 7701 and  ExchangeId  in (5,6,12,69)