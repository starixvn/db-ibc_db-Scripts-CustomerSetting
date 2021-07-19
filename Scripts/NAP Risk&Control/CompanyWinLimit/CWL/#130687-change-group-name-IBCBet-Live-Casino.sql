
/*
	Creator:	20200427@Robert
	Task:	CWL & Game Round - Integrate IBCBet Live Casino - [Redmine: #130687]
	Database:	DBCUST.CustDB
	
	Revisions:
		- 20200427@Robert:	Initial settings  - [Redmine: #130687]
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/

DELETE g
FROM [dbo].[GameRoundBetLimitSettings] g
WHERE g.ProductID = 46
      AND g.SportType = 242
      AND g.BetType = 3206;
UPDATE w
  SET 
      w.GroupName = 'IBCBet Live Casino'
FROM Winlimit_Group w
WHERE w.GroupID = 30;
