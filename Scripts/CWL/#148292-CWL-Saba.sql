
/*<info serverAlias="DBCUST-CustDB"></info>*/

/*
	Creator:	20210121@Robert
	Task:	CWL - Update setting for Saba.Club [148292]
	Database:	DBCUST.CustDB
	
	Revisions:
		- 20210111@Robert:	CWL - Saba.Club - Integrate new game Blackjack [148292]
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/

/*#1. CWL - Saba.Club - Integrate new game Four Guardians]*/

UPDATE g
  SET 
      g.GroupName = 'Saba.club - Normal Games'
FROM WinLimit_Group g
WHERE 
      GroupID = 28;

UPDATE g
  SET 
      g.GroupName = 'Saba.club - Normal Games'
FROM WinLimit_ProductGlobalSetting g
WHERE 
      GroupID = 28;

DELETE g
FROM dbo.Winlimit_GameGroupSetting g
WHERE 
      ProductID = 42
      AND BetTypeID IN(1698, 1699)
AND GroupID = 28;


EXEC NAP_CWL_Initialize_Settings 
     @ProductID = 42, 
     @BetTypeID_Begin = 0, 
     @BetTypeID_End = 0, 
     @BettypeIDs = '1640', 
     @RepresentativeBettype = 1611, 
     @GroupID = 28, 
     @GroupName = 'Saba.club - Normal Games', 
     @Level101 = -50000, 
     @Level102 = -100000, 
     @Level1 = 50000, 
     @Level2 = 100000, 
     @Level3 = 200000, 
     @IsBlockedTransfer_DepositSite_Level3 = 1;   

EXEC NAP_CWL_Initialize_Settings 
     @ProductID = 42, 
     @BetTypeID_Begin = 0, 
     @BetTypeID_End = 0, 
     @BettypeIDs = '1699', 
     @RepresentativeBettype = 1611, 
     @GroupID = 41, 
     @GroupName = 'Saba.club - Jackpot Prize', 
     @Level101 = 0, 
     @Level102 = 0, 
     @Level1 = 0, 
     @Level2 = 1, 
     @Level3 = 0; 
     
