
/*<info serverAlias="DBCUST-CustDB"></info>*/

/*
	Creator:	20211020@Robert
	Task:	Initial settings for CWL - OneRNG - Add new bettype 2322 "Fast Blackjack" #162239
	Database:	DBCUST.CustDB
	
	Revisions:
		- 20211011@Robert:	Initial settings for CWL - OneRNG - Add new bettype 2322 "Fast Blackjack" #162239
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/

/*1. Initial settings for CWL - OneRNG - Add new bettype 2322 "Fast Blackjack" #162239*/

DELETE g
FROM Winlimit_GameGroupSetting g
WHERE 
	 BetTypeID = 2322;

EXEC NAP_CWL_Initialize_Settings 
	@ProductID = 6, 
	@BetTypeID_Begin = 0, 
	@BetTypeID_End = 0, 
	@BettypeIds = '2181', 
	@GroupID = 3, 
	@GroupName = 'RNG Casino - Normal Games', 
	@Level101 = -20000, 
	@Level102 = -50000, 
	@Level1 = 20000, 
	@Level2 = 50000, 
	@Level3 = 100000, 
	@RepresentativeBettype = 2101, 
	@IsBlockedTransfer_DepositSite_Level3 = 1;

/*2. #163232 - CWL - AdvantPlay - Incorporate 4 new games*/

EXEC NAP_CWL_Initialize_Settings 
	@ProductID = 67, 
	@BetTypeID_Begin = 7713, 
	@BetTypeID_End = 7716, 
	@BettypeIds = '', 
	@GroupID = 49, 
	@GroupName = 'AdvantPlay', 
	@Level101 = -20000, 
	@Level102 = -50000, 
	@Level1 = 20000, 
	@Level2 = 50000, 
	@Level3 = 100000, 
	@RepresentativeBettype = 4001, 
	@IsBlockedTransfer_DepositSite_Level3 = 1;

/*3. #163203 - CWL - Macau Games - Incorporate 5 new games*/
EXEC NAP_CWL_Initialize_Settings 
	@ProductID = 22, 
	@BetTypeID_Begin = 4091, 
	@BetTypeID_End = 4095, 
	@BettypeIds = '', 
	@GroupID = 10, 
	@GroupName = 'Macau Games', 
	@Level101 = -20000, 
	@Level102 = -50000, 
	@Level1 = 20000, 
	@Level2 = 50000, 
	@Level3 = 100000, 
	@RepresentativeBettype = 4001, 
	@IsBlockedTransfer_DepositSite_Level3 = 1;

/*4. #163158 - CWL - Table Game - Integrate new games*/
EXEC NAP_CWL_Initialize_Settings 
	@ProductID = 40, 
	@BetTypeID_Begin = 4928, 
	@BetTypeID_End = 4930, 
	@BettypeIds = '', 
	@GroupID = 29, 
	@GroupName = 'Table Game', 
	@Level101 = -100000, 
	@Level102 = -300000, 
	@Level1 = 100000, 
	@Level2 = 300000, 
	@Level3 = 500000, 
	@RepresentativeBettype = 4901, 
	@IsBlockedTransfer_DepositSite_Level3 = 0;

/*5. #163156 - CWL - Lottery - Integrate new games*/
EXEC NAP_CWL_Initialize_Settings 
	@ProductID = 28, 
	@BetTypeID_Begin = 1071, 
	@BetTypeID_End = 1076, 
	@BettypeIds = '', 
	@GroupID = 13, 
	@GroupName = 'Lottery', 
	@Level101 = -100000, 
	@Level102 = -300000, 
	@Level1 = 100000, 
	@Level2 = 300000, 
	@Level3 = 500000, 
	@RepresentativeBettype = 1021, 
	@IsBlockedTransfer_DepositSite_Level3 = 0;

/*6.#163153 - CWL - Keno - Integrate new Keno games (Max Keno 3, Max Keno 4)*/
EXEC NAP_CWL_Initialize_Settings 
	@ProductID = 8, 
	@BetTypeID_Begin = 1530, 
	@BetTypeID_End = 1531, 
	@BettypeIds = '', 
	@GroupID = 4, 
	@GroupName = 'RNG Keno', 
	@Level101 = -100000, 
	@Level102 = -300000, 
	@Level1 = 100000, 
	@Level2 = 300000, 
	@Level3 = 500000, 
	@RepresentativeBettype = 1501, 
	@IsBlockedTransfer_DepositSite_Level3 = 0;
