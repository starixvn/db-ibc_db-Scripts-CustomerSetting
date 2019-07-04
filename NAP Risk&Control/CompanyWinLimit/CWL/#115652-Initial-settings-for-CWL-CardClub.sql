/*
	Creator:	20190704@Robert
	Task:	Initial settings for CWL - Integrate Card Club Video Poker Games
	Database:	DBCUST.CustDB
	
	Revisions:
		- 20190704@Robert:	Initial settings  - [Redmine: #115652]
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/

EXEC NAP_CWL_Initialize_Settings
	@ProductID = 34
   , @BetTypeID_Begin = 0
   , @BetTypeID_End = 0
   , @BettypeIds = '1901'
   , @GroupID = 21
   , @GroupName = 'Card Club'
   , @Level101 = -20000
   , @Level102 = -50000
   , @Level1 = 20000
   , @Level2 = 50000
   , @Level3 = 100000
   , @IsBlockedTransfer_DepositSite_Level3 = 1;


DELETE ggs
FROM Winlimit_GameGroupSetting AS ggs
WHERE ProductID = 33
	 AND BetTypeID = 1901;


DELETE w
FROM WinLimit_CustGameMonitoring w
WHERE ProductID = 33
	 AND BettypeIDList = '1901';

DELETE w
FROM WinLimit_CustGameMonitoring_History w
WHERE ProductID = 33
	 AND BettypeIDList = '1901';

DELETE w
FROM WinLimit_CustGameStatus w
WHERE ProductID = 33
	 AND BettypeID = '1901';