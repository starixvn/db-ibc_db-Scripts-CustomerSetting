
/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Creator:	20200917@Robert
	Task:	CWL - Email/Letstalk - Change Sexy Gaming to AE Casino [141448]
	Database:	DBCUST.CustDB
	
	Revisions:
		- 20200917@RobertCWL - Email/Letstalk - Change Sexy Gaming to AE Casino [141448]		
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/

UPDATE g
  SET 
      g.GroupName = 'AE Casino'
FROM Winlimit_Group g
WHERE g.GroupID = 26
      AND g.GroupName = 'Sexy Gaming';

UPDATE g
  SET 
      g.GroupName = 'AE Casino'
FROM Winlimit_ProductGlobalSetting g
WHERE g.GroupID = 26
      AND g.GroupName = 'Sexy Gaming';