/*
	Creator:	20200302@Robert
	Task:	Change settings for #129524 - CWL - PP
	Database:	DBCUST.CustDB
	
	Revisions:
		- 20200302@Robert:	Change settings for #129524 - CWL - PP
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/

EXEC NAP_CWL_Update_Settings 
	@ProductId = 32
   , @GroupId = 20
   , @Level101 = 0
   , @Level102 = 0
   , @Level1 = 1
   , @Level2 = 0
   , @Level3 = 0;

UPDATE g
	  SET 
		 g.blockedTransferLvl3 = 0
FROM Winlimit_ProductGlobalSetting g
WHERE ProductID = 32
	 AND BetTypeID = 4300
	 AND GroupID = 20;

UPDATE w
	  SET 
		 w.IsBlockedTransfer = 0
FROM WinLimit_ProductSettingDetail w
WHERE ProductID = 32
	 AND GroupID = 20
	 AND IsBlockedTransfer = 1;