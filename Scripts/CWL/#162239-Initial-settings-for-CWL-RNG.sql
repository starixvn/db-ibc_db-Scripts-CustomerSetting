
/*<info serverAlias="DBCUST-CustDB"></info>*/

/*
	Creator:	20211011@Robert
	Task:	Initial settings for CWL - OneRNG - Add new bettype 2322 "Fast Blackjack" #162239
	Database:	DBCUST.CustDB
	
	Revisions:
		- 20211011@Robert:	Initial settings for CWL - OneRNG - Add new bettype 2322 "Fast Blackjack" #162239
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/

/*1. Initial settings for CWL - OneRNG - Add new bettype 2322 "Fast Blackjack" #162239*/
EXEC NAP_CWL_Initialize_Settings 
     @ProductID = 6, 
     @BetTypeID_Begin = 0, 
     @BetTypeID_End = 0, 
     @BettypeIds = '2322', 
     @GroupID = 3, 
     @GroupName = 'RNG Casino - Normal Games', 
     @Level101 = -20000, 
     @Level102 = -50000, 
     @Level1 = 20000, 
     @Level2 = 50000, 
     @Level3 = 100000, 
     @RepresentativeBettype = 2101,
     @IsBlockedTransfer_DepositSite_Level3 = 1

/*2. #162466 - CWL - Sports Lottery - Integrate new game "NBA Lottery"*/	
EXEC NAP_CWL_Initialize_Settings 
     @ProductID = 63, 
     @BetTypeID_Begin = 3614, 
     @BetTypeID_End = 3620, 
     @BettypeIds = '',
     @GroupID = 43, 
     @GroupName = 'Sports Lottery', 
     @Level101 = -100000, 
     @Level102 = -300000, 
     @Level1 = 100000, 
     @Level2 = 300000, 
     @Level3 = 500000, 
     @RepresentativeBettype = 3611,
     @IsBlockedTransfer_DepositSite_Level3 = 0 

/*3. #162719 - CWL - Joker - Joker - Add 20 new games Oct 26 2021*/	
EXEC NAP_CWL_Initialize_Settings 
     @ProductID = 56, 
     @BetTypeID_Begin = 6416, 
     @BetTypeID_End = 6455, 
     @BettypeIds = '',
     @GroupID = 36, 
     @GroupName = 'Joker', 
     @Level101 = -20000, 
     @Level102 = -50000, 
     @Level1 = 20000, 
     @Level2 = 50000, 
     @Level3 = 100000, 
     @RepresentativeBettype = 4001,
     @IsBlockedTransfer_DepositSite_Level3 = 1
	
	select * from Winlimit_Group where GroupName like '%Joker%'