/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Creator:	20220520@Elodie
	Task:	Initial settings for CWL - #173031 - CWL - PP Live Casino - Add 17 new tables game (bettype 3724--> 3740)
	Database:	DBCUST.CustDB
*/

EXEC NAP_CWL_Initialize_Settings 
     @ProductID = 65, 
     @BetTypeID_Begin = 3724, 
     @BetTypeID_End = 3740, 
     @BettypeIds = '', 
     @GroupID = 44, 
     @GroupName = 'PP Live Casino', 
     @Level101 = -100000, 
     @Level102 = -300000, 
     @Level1 = 100000, 
     @Level2 = 200000, 
     @Level3 = 300000, 
	 @IsBlockedTransfer_DepositSite_Level3 = 0, 
     @RepresentativeBettype = 3701


