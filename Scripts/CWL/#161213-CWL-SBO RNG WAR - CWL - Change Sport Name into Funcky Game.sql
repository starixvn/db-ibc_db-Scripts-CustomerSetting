
/*<info serverAlias="DBCUST-CustDB"></info>*/

/*
	Creator:	20211011@Robert
	Task:	SBO RNG WAR - CWL - Change Sport Name into Funcky Game and add some new games [#161213]
	Database:	DBCUST.CustDB
	
	Revisions:
		- SBO RNG WAR - CWL - Change Sport Name into Funcky Game and add some new games [#161213]
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/

/*1. SBO RNG WAR - CWL - Change Sport Name into Funcky Game and add some new games [#161213]*/

UPDATE g
  SET 
	 g.GroupName = 'Funky Games'
FROM Winlimit_Group g
WHERE 
	 g.GroupID = 32;  

UPDATE g
  SET 
	 g.GroupName = 'Funky Games'
FROM Winlimit_ProductGlobalSetting g
WHERE 
	 g.GroupID = 32;

EXEC NAP_CWL_Initialize_Settings 
	@ProductID = 50, 
	@BetTypeID_Begin = 5500, 
	@BetTypeID_End = 5550, 
	@BettypeIDs = '', 
	@GroupID = 32, 
	@GroupName = 'Funky Games', 
	@Level101 = -100000, 
	@Level102 = -300000, 
	@Level1 = 100000, 
	@Level2 = 300000, 
	@Level3 = 500000, 
	@RepresentativeBettype = 5500; 

/*2. #163505 - CWL - Pragmatic Slot Games - Integrate 10 new games*/	  

EXEC NAP_CWL_Initialize_Settings 
	@ProductID = 32, 
	@BetTypeID_Begin = 4266 , 
	@BetTypeID_End = 4296, 
	@BettypeIDs = '', 
	@GroupID = 16, 
	@GroupName = 'PP - Normal Games', 
	@Level101 = -20000, 
	@Level102 = -50000, 
	@Level1 = 20000, 
	@Level2 = 50000, 
	@Level3 = 100000, 
	@IsBlockedTransfer_DepositSite_Level3 = 1,
	@RepresentativeBettype = 4001; 

/*3. #163596 - CWL - PG Soft - Implement 9 new games*/
EXEC NAP_CWL_Initialize_Settings 
	@ProductID = 55, 
	@BetTypeID_Begin = 6078  , 
	@BetTypeID_End = 6100, 
	@BettypeIDs = '', 
	@GroupID = 34, 
	@GroupName = 'PG Soft', 
	@Level101 = -20000, 
	@Level102 = -50000, 
	@Level1 = 20000, 
	@Level2 = 50000, 
	@Level3 = 100000, 
	@IsBlockedTransfer_DepositSite_Level3 = 1,
	@RepresentativeBettype = 4001; 

/*4. #163788 - CWL - AdvantPlay Mini - Incorporate Card Racing Game*/
EXEC NAP_CWL_Initialize_Settings 
	@ProductID = 68, 
	@BetTypeID_Begin = 0  , 
	@BetTypeID_End = 0, 
	@BettypeIDs = '7802', 
	@GroupID = 50, 
	@GroupName = 'AdvantPlay Mini', 
	@Level101 = -20000, 
	@Level102 = -50000, 
	@Level1 = 20000, 
	@Level2 = 50000, 
	@Level3 = 100000, 
	@IsBlockedTransfer_DepositSite_Level3 = 1,
	@RepresentativeBettype = 4001; 

/*5. #164092 - CWL - Spade Gaming- Incorporate 10 new games*/
EXEC NAP_CWL_Initialize_Settings 
	@ProductID = 36, 
	@BetTypeID_Begin = 4363   , 
	@BetTypeID_End = 4382, 
	@BettypeIDs = '', 
	@GroupID = 22, 
	@GroupName = 'SG', 
	@Level101 = -20000, 
	@Level102 = -50000, 
	@Level1 = 20000, 
	@Level2 = 50000, 
	@Level3 = 100000, 
	@IsBlockedTransfer_DepositSite_Level3 = 1,
	@RepresentativeBettype = 4001; 

	 select * from Winlimit_Group  w where w.GroupName like'%SG%'