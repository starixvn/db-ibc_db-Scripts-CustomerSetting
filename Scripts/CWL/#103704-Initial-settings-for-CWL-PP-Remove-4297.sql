/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Creator:	20200720@Robert
	Task:	Initial settings for CWL - Add new PP games into CWL system [137283]
	Database:	DBCUST.CustDB
	
	Revisions:
		- 20200715@Robert:	Initial settings  - [Redmine: #137283]
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/

DELETE FROM Winlimit_GameGroupSetting
WHERE ProductID = 32
      AND BetTypeID = 4297;