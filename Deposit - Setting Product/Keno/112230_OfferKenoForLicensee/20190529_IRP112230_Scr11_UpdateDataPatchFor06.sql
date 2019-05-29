/*
	Created: 20190529@Johnson
	DB: DB06/tp
	Task: update data patch for db06/tp for keno
*/

--delete existing setting custgametype
delete custgametype WITH(UPDLOCK,ROWLOCK)
WHERE custid = 15301853 
	AND gametypeid = 1
GO

EXEC Acc_CustSetting3rd_19
	@srecommend = 14428593	
	,@minbet = 5 --	MYR
	,@maxbet = 10000
	,@maxPerDraw = 50000
	,@max_custid = 36662725	
	,@target = 'REPLICATED' 	