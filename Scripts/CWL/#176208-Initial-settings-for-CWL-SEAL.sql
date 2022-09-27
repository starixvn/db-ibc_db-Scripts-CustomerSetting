
/*<info serverAlias="DBCUST-CustDB"></info>*/

/*
	Creator:	20220919@Robert
	Task:	CWL - SEAL Entertainment - Incorporate new product [176208]
	Database:	DBCUST.CustDB
	
	Revisions:
		- 20220919@Robert:	CWL - SEAL Entertainment - Incorporate new product [176208]
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/

/*1. CWL - SEAL Entertainment - Incorporate new product [176208]*/

EXEC NAP_CWL_Initialize_Settings 
    @ProductID = 72, 
    @BetTypeID_Begin = 0, 
    @BetTypeID_End = 0, 
    @BettypeIds = '8900', 
    @GroupID = 55, 
    @GroupName = 'SEAL Entertainment', 
    @Level101 = -20000, 
    @Level102 = -50000, 
    @Level1 = 20000, 
    @Level2 = 50000, 
    @Level3 = 100000, 
    @IsBlockedTransfer_DepositSite_Level3 = 1, 
    @RepresentativeBettype = 8900,
    @Currency = ''

EXEC NAP_CWL_Initialize_Settings 
    @ProductID = 72, 
    @BetTypeID_Begin = 0, 
    @BetTypeID_End = 0, 
    @BettypeIds = '8900', 
    @GroupID = 55, 
    @GroupName = 'SEAL Entertainment', 
    @Level101 = -20000, 
    @Level102 = -50000, 
    @Level1 = 5000, 
    @Level2 = 30000, 
    @Level3 = 75000, 
    @IsBlockedTransfer_DepositSite_Level3 = 1, 
    @RepresentativeBettype = 8900,
    @Currency = 'INH,RMB'



/*2. CWL - SEAL Entertainment - Incorporate new product [175849]*/
EXEC NAP_CWL_Initialize_Settings 
    @ProductID = 73, 
    @BetTypeID_Begin = 8400, 
    @BetTypeID_End = 8450, 
    @BettypeIds = '', 
    @GroupID = 56, 
    @GroupName = 'MG-RNG', 
    @Level101 = -20000, 
    @Level102 = -50000, 
    @Level1 = 20000, 
    @Level2 = 50000, 
    @Level3 = 100000, 
    @IsBlockedTransfer_DepositSite_Level3 = 1, 
    @RepresentativeBettype = 8400,
    @Currency = ''

EXEC NAP_CWL_Initialize_Settings 
    @ProductID = 73, 
    @BetTypeID_Begin = 8400, 
    @BetTypeID_End = 8450, 
    @BettypeIds = '', 
    @GroupID = 56, 
    @GroupName = 'MG-RNG', 
    @Level101 = -20000, 
    @Level102 = -50000, 
    @Level1 = 5000, 
    @Level2 = 30000, 
    @Level3 = 75000, 
    @IsBlockedTransfer_DepositSite_Level3 = 1, 
    @RepresentativeBettype = 8400,
    @Currency = 'INH,RMB'


	