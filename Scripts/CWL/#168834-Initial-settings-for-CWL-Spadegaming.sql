
/*<info serverAlias="DBCUST-CustDB"></info>*/

/*
	Creator:	20220324@Robert
	Task:	CWL - Spadegaming - Launch 10 new games [168834]
	Database:	DBCUST.CustDB
	
	Revisions:
		- 20220324@Robert:	CWL - Spadegaming - Launch 10 new games [168834]
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/

/*1. CWL - Spadegaming - Launch 10 new games [168834]*/

EXEC NAP_CWL_Initialize_Settings 
    @ProductID = 36, 
    @BetTypeID_Begin = 4375, 
    @BetTypeID_End = 4394, 
    @BettypeIds = '', 
    @GroupID = 22, 
    @GroupName = 'SG - Normal Games', 
    @Level101 = -20000, 
    @Level102 = -50000, 
    @Level1 = 20000, 
    @Level2 = 50000, 
    @Level3 = 100000, 
    @IsBlockedTransfer_DepositSite_Level3 = 1, 
    @RepresentativeBettype = 4001,
    @Currency = ''

EXEC NAP_CWL_Initialize_Settings 
    @ProductID = 36, 
    @BetTypeID_Begin = 4375, 
    @BetTypeID_End = 4394, 
    @BettypeIds = '', 
    @GroupID = 22, 
    @GroupName = 'SG - Normal Games', 
    @Level101 = -20000, 
    @Level102 = -50000, 
    @Level1 = 5000, 
    @Level2 = 30000, 
    @Level3 = 75000, 
    @IsBlockedTransfer_DepositSite_Level3 = 1, 
    @RepresentativeBettype = 4001,
    @Currency = 'INH,RMB'

  --  select * from Winlimit_ProductGlobalSetting where ProductID = 36

/*2. CWL - Pragmatic - Incorporate 21 New Games [169513]*/
EXEC NAP_CWL_Initialize_Settings 
    @ProductID = 32, 
    @BetTypeID_Begin = 6716, 
    @BetTypeID_End = 6736, 
    @BettypeIds = '', 
    @GroupID = 16, 
    @GroupName = 'PP - Normal Games', 
    @Level101 = -20000, 
    @Level102 = -50000, 
    @Level1 = 20000, 
    @Level2 = 50000, 
    @Level3 = 100000, 
    @IsBlockedTransfer_DepositSite_Level3 = 1, 
    @RepresentativeBettype = 4001,
    @Currency = ''

EXEC NAP_CWL_Initialize_Settings 
    @ProductID = 32, 
    @BetTypeID_Begin = 6716, 
    @BetTypeID_End = 6736, 
    @BettypeIds = '', 
    @GroupID = 16, 
    @GroupName = 'PP - Normal Games', 
    @Level101 = -20000, 
    @Level102 = -50000, 
    @Level1 = 5000, 
    @Level2 = 30000, 
    @Level3 = 75000, 
    @IsBlockedTransfer_DepositSite_Level3 = 1, 
    @RepresentativeBettype = 4001,
    @Currency = 'INH,RMB'

-- select * from Winlimit_ProductGlobalSetting where ProductID = 32
/*3. CWL - PG Soft - Add 9 new games [169833]*/

EXEC NAP_CWL_Initialize_Settings 
    @ProductID = 55, 
    @BetTypeID_Begin = 6087, 
    @BetTypeID_End = 6095, 
    @BettypeIds = '', 
    @GroupID = 34, 
    @GroupName = 'PG Soft', 
    @Level101 = -20000, 
    @Level102 = -50000, 
    @Level1 = 20000, 
    @Level2 = 50000, 
    @Level3 = 100000, 
    @IsBlockedTransfer_DepositSite_Level3 = 1, 
    @RepresentativeBettype = 4001,
    @Currency = ''

EXEC NAP_CWL_Initialize_Settings 
    @ProductID = 55, 
    @BetTypeID_Begin = 6087, 
    @BetTypeID_End = 6095, 
    @BettypeIds = '', 
    @GroupID = 34, 
    @GroupName = 'PG Soft', 
    @Level101 = -20000, 
    @Level102 = -50000, 
    @Level1 = 5000, 
    @Level2 = 30000, 
    @Level3 = 750000, 
    @IsBlockedTransfer_DepositSite_Level3 = 1, 
    @RepresentativeBettype = 4001,
    @Currency = 'INH,RMB'

/*4. CWL - Guaranteed Gaming (FGG) - Incorporate new product [165686]*/    

EXEC NAP_CWL_Initialize_Settings 
     @ProductID = 70, 
     @BetTypeID_Begin = 8201 , 
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
    
    -- select * from Winlimit_Group where GroupName like '%FGG%'
    --select * from Winlimit_ProductGlobalSetting where ProductID = 55
    