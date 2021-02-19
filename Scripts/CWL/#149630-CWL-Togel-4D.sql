
/*<info serverAlias="DBCUST-CustDB"></info>*/

/*
	Creator:	20210219@Robert
	Task:	CWL - Update setting for Saba.Club [149630]
	Database:	DBCUST.CustDB
	
	Revisions:
		- 20210111@Robert:	CWL - Rename product 'Indo 4D' into 'Togel 4D' [149630]
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/

/*#1. CWL - Rename product 'Indo 4D' into 'Togel 4D'*/

UPDATE g
  SET 
      g.GroupName = 'Togel 4D'
FROM WinLimit_Group g
WHERE 
      GroupID = 27;

UPDATE g
  SET 
      g.GroupName = 'Togel 4D'
FROM WinLimit_ProductGlobalSetting g
WHERE 
      GroupID = 27;

/*#2. CWL - PG Soft - Integrate 9 New Games [6062-6070] at #150266*/
EXEC NAP_CWL_Initialize_Settings 
     @ProductID = 55, 
     @BetTypeID_Begin = 6062, 
     @BetTypeID_End = 6070, 
     @BettypeIds = '', 
     @GroupID = 34, 
     @GroupName = 'PG Soft', 
     @Level101 = -20000, 
     @Level102 = -50000, 
     @Level1 = 20000, 
     @Level2 = 50000, 
     @Level3 = 100000, 
     @IsBlockedTransfer_DepositSite_Level3 = 1, 
     @RepresentativeBettype = 4001;

