
/*<info serverAlias="DBCUST-CustDB"></info>*/

/*
	Creator:	20210315@Robert
	Task:	CWL - Integrate Habanero [145461]
	Database:	DBCUST.CustDB
	
	Revisions:
		- 20210315@Robert:	CWL - Integrate Habanero [145461]
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/

/*#1. CWL - Integrate Habanero #145461*/

DELETE FROM dbtxn.bodb02.dbo.WinLimit_ProductOffer
WHERE 
      ProductID = 61;
EXEC NAP_CWL_Initialize_Settings 
     @ProductID = 61, 
     @BetTypeID_Begin = 7001, 
     @BetTypeID_End = 7099, 
     @BettypeIds = '', 
     @GroupID = 42, 
     @GroupName = 'Habanero', 
     @Level101 = -20000, 
     @Level102 = -50000, 
     @Level1 = 20000, 
     @Level2 = 50000, 
     @Level3 = 100000, 
     @IsBlockedTransfer_DepositSite_Level3 = 1, 
     @RepresentativeBettype = 4001;

EXEC NAP_CWL_Initialize_Settings 
     @ProductID = 61, 
     @BetTypeID_Begin = 7101, 
     @BetTypeID_End = 7116, 
     @BettypeIds = '', 
     @GroupID = 42, 
     @GroupName = 'Habanero', 
     @Level101 = -20000, 
     @Level102 = -50000, 
     @Level1 = 20000, 
     @Level2 = 50000, 
     @Level3 = 100000, 
     @IsBlockedTransfer_DepositSite_Level3 = 1, 
     @RepresentativeBettype = 4001;

/*#2. CWL - Integrate Sports Lottery #147367*/

DELETE FROM dbtxn.bodb02.dbo.WinLimit_ProductOffer
WHERE 
      ProductID = 63;
EXEC NAP_CWL_Initialize_Settings 
     @ProductID = 63, 
     @BetTypeID_Begin = 3611, 
     @BetTypeID_End = 3612, 
     @BettypeIds = '', 
     @GroupID = 43, 
     @GroupName = 'Sports Lottery', 
     @Level101 = -100000, 
     @Level102 = -300000, 
     @Level1 = 100000, 
     @Level2 = 300000, 
     @Level3 = 500000, 
     @RepresentativeBettype = 3611;

/*#3. CWL - Integrate PP Live Casino #133733*/

DELETE FROM dbtxn.bodb02.dbo.WinLimit_ProductOffer
WHERE 
      ProductID = 65;
EXEC NAP_CWL_Initialize_Settings 
     @ProductID = 65, 
     @BetTypeID_Begin = 3701, 
     @BetTypeID_End = 3709, 
     @BettypeIds = '', 
     @GroupID = 44, 
     @GroupName = 'PP Live Casino', 
     @Level101 = -100000, 
     @Level102 = -300000, 
     @Level1 = 100000, 
     @Level2 = 300000, 
     @Level3 = 500000, 
     @RepresentativeBettype = 3701;

--select * from Winlimit_Group where GroupName='Sports Lottery'
-- select * from  dbtxn.bodb02.dbo.WinLimit_ProductOffer where ProductID=65
-- delete from  dbtxn.bodb02.dbo.WinLimit_ProductOffer where ProductID=65