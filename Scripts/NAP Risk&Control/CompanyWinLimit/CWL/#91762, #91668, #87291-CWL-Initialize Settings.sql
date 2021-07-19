USE CustDB;

UPDATE Winlimit_Group
  SET 
	 GroupName = 'RNG Casino - Normal Games'
WHERE GroupID = 3;

EXEC NAP_CWL_Initialize_Settings 
	@ProductID = 6, 
	@BetTypeID_Begin = 0, 
	@BetTypeID_End = 0, 
	@BettypeIDs = '2319,2919,2178', 
	@GroupID = 3, 
	@GroupName = 'RNG Casino - Normal Games', 
	@Level101 = -10000, 
	@Level102 = -30000, 
	@Level1 = 10000, 
	@Level2 = 30000, 
	@Level3 = 100000; 


EXEC NAP_CWL_Initialize_Settings 
	@ProductID = 6, 
	@BetTypeID_Begin = 0, 
	@BetTypeID_End = 0, 
	@BettypeIDs = '2320,2920,2179', 
	@GroupID = 17, 
	@GroupName = 'RNG Casino - Minor Jackpot', 
	@Level101 = 0, 
	@Level102 = 0, 
	@Level1 = 10000, 
	@Level2 = 0, 
	@Level3 = 0, 
	@IsBlockedTransfer_DepositSite_Level3 = 1; 


EXEC NAP_CWL_Initialize_Settings 
	@ProductID = 6, 
	@BetTypeID_Begin = 0, 
	@BetTypeID_End = 0, 
	@BettypeIDs = '2399,2999,2199', 
	@GroupID = 18, 
	@GroupName = 'RNG Casino - Mega Jackpot', 
	@Level101 = 0, 
	@Level102 = 0, 
	@Level1 = 0, 
	@Level2 = 0, 
	@Level3 = 1, 
	@IsBlockedTransfer_DepositSite_Level3 = 1;


EXEC NAP_CWL_Initialize_Settings 
	@ProductID = 32, 
	@BetTypeID_Begin = 4101, 
	@BetTypeID_End = 4120, 
	@GroupID = 16, 
	@GroupName = 'PP', 
	@Level101 = -10000, 
	@Level102 = -30000, 
	@Level1 = 10000, 
	@Level2 = 30000, 
	@Level3 = 100000, 
	@IsBlockedTransfer_DepositSite_Level3 = 1;


EXEC NAP_CWL_Initialize_Settings 
	@ProductID = 27, 
	@BetTypeID_Begin = 0, 
	@BetTypeID_End = 0, 
	@BettypeIDs = '2801,2802,2803,2804,2805,2806,2807,2808,2809,2811,2812', 
	@GroupID = 12, 
	@GroupName = 'Virtual Sports 2', 
	@Level1 = 100000, 
	@Level2 = 300000, 
	@Level3 = 500000, 
	@Level101 = -100000, 
	@Level102 = -300000;


DELETE FROM Winlimit_GameGroupSetting
WHERE GroupID = 12
	 AND BetTypeID = 2810
	 AND ProductID = 27;

DELETE FROM Winlimit_ProductGlobalSetting
WHERE ProductID = 6
	 AND BetTypeID = 2178
	 AND GroupID = 3
	 AND GroupName = 'RNG Casino - Normal Games';


UPDATE Winlimit_ProductGlobalSetting
  SET 
	 GroupName = 'RNG Casino - Normal Games'
WHERE ProductID = 6
	 AND BetTypeID = 2101
	 AND GroupID = 3
	 AND GroupName = 'RNG Casino';