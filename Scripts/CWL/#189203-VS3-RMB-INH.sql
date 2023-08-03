
/*<info serverAlias="DBCUST-CustDB"></info>*/

/*
	Creator:	20230803@Robert
	Task:	#189203 - CWL - LG Virtual Sports - Incorporate new product
	Database:	DBCUST.CustDB
	
	Revisions:
		- 20230803@Robert:	#189203 - CWL - LG Virtual Sports - Incorporate new product
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/

EXEC NAP_CWL_Initialize_Settings 
	@ProductID = 77, 
	@BetTypeID_Begin = 5302, 
	@BetTypeID_End = 5307, 
	@BettypeIds = '', 
	@GroupID = 62, 
	@GroupName = 'Virtual Sports 3', 
	@Level101 = -100000, 
	@Level102 = -300000, 
	@Level1 = 100000, 
	@Level2 = 200000, 
	@Level3 = 500000, 
	@IsBlockedTransfer_DepositSite_Level3 = 0, 
	@RepresentativeBettype = 1201;
    
UPDATE g
  SET 
	 g.GroupName = 'Virtual Sports 3 (Old)'
FROM Winlimit_Group g
WHERE 
	 g.GroupID = 37;
   
UPDATE g
  SET 
	 g.GroupName = 'Virtual Sports 3 (Old)'
FROM WinLimit_ProductGlobalSetting g
WHERE 
	 g.GroupID = 37;
	 
