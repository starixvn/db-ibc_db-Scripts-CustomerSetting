
/*<info serverAlias="DBCUST-CustDB"></info>*/

/*
	Creator:	20210111@Robert
	Task:	CWL - Update setting for Saba.Club [148292]
	Database:	DBCUST.CustDB
	
	Revisions:
		- 20210111@Robert:	CWL - Saba.Club - Integrate new game Blackjack [148292]
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/

/*#1. CWL - Saba.Club - Integrate new game Blackjack [148292]*/

--EXEC NAP_CWL_Initialize_Settings 
--     @ProductID = 42, 
--     @BetTypeID_Begin = 0, 
--     @BetTypeID_End = 0, 
--     @BettypeIDs = '1634', 
--     @RepresentativeBettype = 1611, 
--     @GroupID = 28, 
--     @GroupName = 'Saba.club', 
--     @Level101 = -20000, 
--     @Level102 = -50000, 
--     @Level1 = 20000, 
--     @Level2 = 50000, 
--     @Level3 = 100000, 
--     @IsBlockedTransfer_DepositSite_Level3 = 1;   


/*#2. CWL - Allbet - Integrate new game PokDeng [147838]*/

EXEC NAP_CWL_Initialize_Settings 
     @ProductID = 21, 
     @BetTypeID_Begin = 0, 
     @BetTypeID_End = 0, 
     @BettypeIDs = '2408', 
     @RepresentativeBettype = 2401, 
     @GroupID = 9, 
     @GroupName = 'Allbet Casino', 
     @Level101 = -100000, 
     @Level102 = -300000, 
     @Level1 = 100000, 
     @Level2 = 300000, 
     @Level3 = 500000;

/*#3. CWL - Integrate MaxGame Product [146974]*/

EXEC NAP_CWL_Initialize_Settings 
     @ProductID = 60, 
     @BetTypeID_Begin = 0, 
     @BetTypeID_End = 0, 
     @BettypeIDs = '5401,5402,5403,5406,5407,5408,5409,5410', 
     @RepresentativeBettype = 4001, 
     @GroupID = 40, 
     @GroupName = 'MaxGame', 
     @Level101 = -20000, 
     @Level102 = -50000, 
     @Level1 = 20000, 
     @Level2 = 50000, 
     @Level3 = 100000, 
     @IsBlockedTransfer_DepositSite_Level3 = 1;   
	 
UPDATE g
  SET 
      g.GroupName = 'MaxGame'
FROM Winlimit_Group g
WHERE 
      GroupID = 40;

UPDATE g
  SET 
      g.GroupName = 'MaxGame'
FROM Winlimit_ProductGlobalSetting g
WHERE 
      g.GroupID = 40;
   

/*#4. CWL - CWL - Integrate Linked Games (Number Game) [146493]*/

EXEC NAP_CWL_Initialize_Settings 
     @ProductID = 3, 
     @BetTypeID_Begin = 3601, 
     @BetTypeID_End = 3604, 
     @BettypeIDs = '', 
     @RepresentativeBettype = 81, 
     @GroupID = 1, 
     @GroupName = 'Number Game', 
     @Level101 = -100000, 
     @Level102 = -300000, 
     @Level1 = 100000, 
     @Level2 = 300000, 
     @Level3 = 500000;

/*#5. CWL - Integrate Big Gaming Product [142478]*/

EXEC NAP_CWL_Initialize_Settings 
     @ProductID = 57, 
     @BetTypeID_Begin = 3501, 
     @BetTypeID_End = 3509, 
     @BettypeIDs = '', 
     @RepresentativeBettype = 3501, 
     @GroupID = 39, 
     @GroupName = 'BG', 
     @Level101 = -100000, 
     @Level102 = -300000, 
     @Level1 = 100000, 
     @Level2 = 300000, 
     @Level3 = 500000;
	 
