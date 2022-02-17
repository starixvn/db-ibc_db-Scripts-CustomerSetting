
/*<info serverAlias="DBCUST-CustDB"></info>*/

/*
	Creator:	20220215@Robert
	Task:	Change settings for #168493 - CWL - Change limit setting for some products
	Database:	DBCUST.CustDB
	
	Revisions:
		- 20220215@Robert:	Change settings for #168493 - CWL - Change limit setting for some products
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/

/*17. [165590] - CWL - Spadegaming - Incorporate Jackpot Games*/

UPDATE g
  SET 
	 g.GroupName = 'SG - Normal Games'
FROM Winlimit_Group g
WHERE 
	 g.GroupID = 22
	 AND g.GroupName = 'SG';

UPDATE g
  SET 
	 g.GroupName = 'SG - Normal Games'
FROM Winlimit_ProductGlobalSetting g
WHERE 
	 g.GroupID = 22
	 AND g.GroupName = 'SG';


EXEC NAP_CWL_Initialize_Settings 
	@ProductID = 36, 
	@BetTypeID_Begin = 0, 
	@BetTypeID_End = 0, 
	@BettypeIds = '4373,4374', 
	@GroupID = 22, 
	@GroupName = 'SG - Normal Games', 
	@Level101 = -20000, 
	@Level102 = -50000, 
	@Level1 = 20000, 
	@Level2 = 50000, 
	@Level3 = 100000, 
	@IsBlockedTransfer_DepositSite_Level3 = 1, 
	@RepresentativeBettype = 4001;

EXEC NAP_CWL_Update_Settings 
	@ProductId = 36, 
	@GroupId = 22, 
	@Level101 = -20000, 
	@Level102 = -50000, 
	@Level1 = 5000, 
	@Level2 = 30000, 
	@Level3 = 75000, 
	@Currency = 'INH,RMB';

EXEC NAP_CWL_Initialize_Settings 
	@ProductID = 36, 
	@BetTypeID_Begin = 0, 
	@BetTypeID_End = 0, 
	@BettypeIds = '4600', 
	@GroupID = 52, 
	@GroupName = 'SG - Jackpot Prize', 
	@Level101 = 0, 
	@Level102 = 0, 
	@Level1 = 0, 
	@Level2 = 1, 
	@Level3 = 0, 
	@IsBlockedTransfer_DepositSite_Level3 = 0, 
	@RepresentativeBettype = 4001;	



/*18. [167236] - CWL - Allbet - Incorporate Red Envelope event*/

EXEC NAP_CWL_Initialize_Settings 
	@ProductID = 21, 
	@BetTypeID_Begin = 0, 
	@BetTypeID_End = 0, 
	@BettypeIds = '2499', 
	@GroupID = 53, 
	@GroupName = 'Allbet - Promotion', 
	@Level101 = 0, 
	@Level102 = 0, 
	@Level1 = 1, 
	@Level2 = 0, 
	@Level3 = 0, 
	@IsBlockedTransfer_DepositSite_Level3 = 0, 
	@RepresentativeBettype = 2401;


/*#167862 - CWL - Sports Lottery - Incorporate new game Tennis Lottery*/

EXEC NAP_CWL_Initialize_Settings 
	@ProductID = 63, 
	@BetTypeID_Begin = 0, 
	@BetTypeID_End = 0, 
	@BettypeIds = '3615', 
	@GroupID = 43, 
	@GroupName = 'Sports Lottery', 
	@Level101 = -100000, 
	@Level102 = -300000, 
	@Level1 = 100000, 
	@Level2 = 300000, 
	@Level3 = 500000, 
	@IsBlockedTransfer_DepositSite_Level3 = 0, 
	@RepresentativeBettype = 3611;
	
/*19. [167398] - CWL - Joker Gaming - Add 20 new games*/

EXEC NAP_CWL_Initialize_Settings 
	@ProductID = 56, 
	@BetTypeID_Begin = 6436, 
	@BetTypeID_End = 6475, 
	@BettypeIds = '', 
	@GroupID = 36, 
	@GroupName = 'Joker', 
	@Level101 = -20000, 
	@Level102 = -50000, 
	@Level1 = 20000, 
	@Level2 = 50000, 
	@Level3 = 100000, 
	@IsBlockedTransfer_DepositSite_Level3 = 1, 
	@RepresentativeBettype = 4001;

	
EXEC NAP_CWL_Update_Settings 
	@ProductId = 56, 
	@GroupId = 36, 
	@Level101 = -20000, 
	@Level102 = -50000, 
	@Level1 = 5000, 
	@Level2 = 30000, 
	@Level3 = 75000, 
	@Currency = 'INH,RMB';

/*20 [165686] - CWL - Guaranteed Gaming (FGG) - Incorporate new product*/

EXEC NAP_CWL_Initialize_Settings 
	@ProductID = 70, 
	@BetTypeID_Begin = 8201, 
	@BetTypeID_End = 8210, 
	@BettypeIds = '', 
	@GroupID = 54, 
	@GroupName = 'FGG', 
	@Level101 = -100000, 
	@Level102 = -300000, 
	@Level1 = 100000, 
	@Level2 = 200000, 
	@Level3 = 300000, 
	@IsBlockedTransfer_DepositSite_Level3 = 0, 
	@RepresentativeBettype = 8201;

/*21. #168760 - NAP Risk & Control - Rename Saba Club to Saba.games*/

UPDATE g
  SET 
	 g.GroupName = 'Saba.games - Normal Games'
FROM Winlimit_Group g
WHERE 
	 g.GroupID = 28
	 AND g.GroupName = 'Saba.club - Normal Games';

UPDATE g
  SET 
	 g.GroupName = 'Saba.games - Normal Games'
FROM Winlimit_ProductGlobalSetting g
WHERE 
	 g.GroupID = 28
	 AND g.GroupName = 'Saba.club - Normal Games';

UPDATE g
  SET 
	 g.GroupName = 'Saba.games - Jackpot Prize'
FROM Winlimit_Group g
WHERE 
	 g.GroupID = 41
	 AND g.GroupName = 'Saba.club - Jackpot Prize';

UPDATE g
  SET 
	 g.GroupName = 'Saba.games - Jackpot Prize'
FROM Winlimit_ProductGlobalSetting g
WHERE 
	 g.GroupID = 41
	 AND g.GroupName = 'Saba.club - Jackpot Prize';

--SELECT 
--	  *
--FROM Winlimit_Group
--WHERE GroupName LIKE '%Saba%';

