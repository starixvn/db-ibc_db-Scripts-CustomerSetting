
/*<info serverAlias="DBCUST-CustDB"></info>*/

/*
	Creator:	20220323@Robert
	Task:	CWL - WM Live Casino - Integrate Golden Flower and Andar Bahar [168847]
	Database:	DBCUST.CustDB
	
	Revisions:
		- 20220323@Robert:	CWL - WM Live Casino - Integrate Golden Flower and Andar Bahar [168847]
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/



EXEC NAP_CWL_Initialize_Settings 
    @ProductID = 51, 
    @BetTypeID_Begin = 0, 
    @BetTypeID_End = 0, 
    @BettypeIds = '3412,3413', 
    @GroupID = 35, 
    @GroupName = 'WM', 
    @Level101 = -100000, 
    @Level102 = -300000, 
    @Level1 = 100000, 
    @Level2 = 200000, 
    @Level3 = 300000, 
    @IsBlockedTransfer_DepositSite_Level3 = 1, 
    @RepresentativeBettype = 3401;

