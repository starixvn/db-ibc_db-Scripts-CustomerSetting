
/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Creator:	20201022@Robert
	Task:	CWL - Card Club - Change Product Name into Arcadia Gaming [144021]
	Database:	DBCUST.CustDB
	
	Revisions:
		- 20201022@RobertCWL - CWL - Card Club - Change Product Name into Arcadia Gaming [144021]
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/

UPDATE g
  SET 
      g.GroupName = 'Arcadia Gaming'
FROM Winlimit_Group g
WHERE g.GroupID = 21
      AND g.GroupName = 'Card Club';

UPDATE g
  SET 
      g.GroupName = 'Arcadia Gaming'
FROM Winlimit_ProductGlobalSetting g
WHERE g.GroupID = 21
      AND g.GroupName = 'Card Club';


	  