
/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Creator:	20200925@Robert
	Task:	Initial settings for CWL - CWL - Integrate Table Games Product [142180]
	Database:	DBCUST.CustDB
	
	Revisions:
		- 20200818@Robert:	Initial settings  - [Redmine: #142180]
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/

EXEC NAP_CWL_Initialize_Settings 
     @ProductID = 40, 
     @BetTypeID_Begin = 4917, 
     @BetTypeID_End = 4921, 
     @BettypeIds = '', 
     @GroupID = 29, 
     @GroupName = 'Table Games', 
     @Level101 = -100000, 
     @Level102 = -300000, 
     @Level1 = 100000, 
     @Level2 = 300000, 
     @Level3 = 500000, 
     @RepresentativeBettype = 4901;
UPDATE g
  SET 
      g.GroupName = 'Table Game'
FROM Winlimit_Group g
WHERE g.GroupID = 29
      AND g.GroupName = 'Table Games';

UPDATE g
  SET 
      g.GroupName = 'Table Game'
FROM Winlimit_ProductGlobalSetting g
WHERE g.GroupID = 29
      AND g.GroupName = 'Table Games';

