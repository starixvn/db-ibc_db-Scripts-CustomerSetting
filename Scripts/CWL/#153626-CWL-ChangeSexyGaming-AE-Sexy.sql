
/*<info serverAlias="DBCUST-CustDB"></info>*/

/*
	Creator:	20210419@Robert
	Task:	CWL - Rename AE Casino to AE Sexy [153626]
	Database:	DBCUST.CustDB
	
	Revisions:
		- 20210419@Robert CWL - Rename AE Casino to AE Sexy [153626]
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/

/*1. CWL - Rename AE Casino to AE Sexy [153626]*/

UPDATE g
  SET 
      g.GroupName = 'AE Sexy - Normal Games'
FROM Winlimit_Group g
WHERE 
      g.GroupID = 26
      AND g.GroupName = 'AE Casino';

UPDATE g
  SET 
      g.GroupName = 'AE Sexy - Normal Games'
FROM Winlimit_ProductGlobalSetting g
WHERE 
      g.GroupID = 26
      AND g.GroupName = 'AE Casino';

/*2.  CWL - AE Casino - Support Lucky Draw [151359]*/

EXEC NAP_CWL_Initialize_Settings 
     @ProductID = 45, 
     @BetTypeID_Begin = 0, 
     @BetTypeID_End = 0, 
     @BettypeIds = '3150', 
     @GroupID = 45, 
     @GroupName = 'AE Sexy - Lucky Draw', 
     @Level101 = 0, 
     @Level102 = 0, 
     @Level1 = 1, 
     @Level2 = 0, 
     @Level3 = 0, 
     @RepresentativeBettype = 3101;

/*3.CWL - SG - Add 9 new games [152852]*/

EXEC NAP_CWL_Initialize_Settings 
     @ProductID = 36, 
     @BetTypeID_Begin = 4354, 
     @BetTypeID_End = 4362, 
     @BettypeIds = '', 
     @GroupID = 22, 
     @GroupName = 'SG', 
     @Level101 = -20000, 
     @Level102 = -50000, 
     @Level1 = 20000, 
     @Level2 = 50000, 
     @Level3 = 100000, 
     @IsBlockedTransfer_DepositSite_Level3 = 1, 
     @RepresentativeBettype = 4001;

/*4. CWL - Arcadia Gaming - Add 2 new games: Marble Mini and RPS [153061]*/

EXEC NAP_CWL_Initialize_Settings 
     @ProductID = 34, 
     @BetTypeID_Begin = 0, 
     @BetTypeID_End = 0, 
     @BettypeIDs = '1907,1908', 
     @GroupID = 21, 
     @GroupName = 'Arcadia Gaming', 
     @Level101 = -20000, 
     @Level102 = -50000, 
     @Level1 = 20000, 
     @Level2 = 50000, 
     @Level3 = 100000, 
     @IsBlockedTransfer_DepositSite_Level3 = 1, 
     @RepresentativeBettype = 4001;

/*5. CWL - Integrate Creative Gaming [146021]*/
EXEC NAP_CWL_Initialize_Settings 
     @ProductID = 62, 
     @BetTypeID_Begin = 7301, 
     @BetTypeID_End = 7386, 
     @BettypeIDs = '', 
     @GroupID = 46, 
     @GroupName = 'CG', 
     @Level101 = -20000, 
     @Level102 = -50000, 
     @Level1 = 20000, 
     @Level2 = 50000, 
     @Level3 = 100000, 
     @IsBlockedTransfer_DepositSite_Level3 = 1, 
     @RepresentativeBettype = 4001;

