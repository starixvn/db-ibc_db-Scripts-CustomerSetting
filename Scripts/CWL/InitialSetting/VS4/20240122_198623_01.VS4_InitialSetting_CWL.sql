/*<info serverAlias="DBCUST-CustDB"></info>*/

/*
	Creator: 20240122@Tacy
	Task: CWL - Non Sports Report - VS4 - Integrate New Product [Redmine: #198623]
	Database:	DBCUST.CustDB
*/
/*
	Full range: [10400 - 10449]
	Bettype Mix Parlay: 10449
*/

USE CustDB
GO

----------------------------------------------------------
----------------------------------------------------------
BEGIN 
	-- For Deposit: all currencies
	EXEC NAP_CWL_Initialize_Settings 
		@ProductID = 83, 
		@BetTypeID_Begin = 10400, 
		@BetTypeID_End = 10449, 
		@BettypeIds = '', 
		@GroupID = 66, 
		@GroupName = 'Virtual Sports 4', 
		@Level101 = -100000, 
		@Level102 = -300000, 
		@Level1 = 100000, 
		@Level2 = 300000, 
		@Level3 = 500000, 
		@IsDeposit = 1, 
		@RepresentativeBettype = 1201,
		@Currency = ''

	-----------------------------------------------------
	-----------------------------------------------------
	-- For Credit: all currencies
	EXEC NAP_CWL_Initialize_Settings 
		@ProductID = 83, 
		@BetTypeID_Begin = 10400, 
		@BetTypeID_End = 10449,  
		@BettypeIds = '', 
		@GroupID = 66, 
		@GroupName = 'Virtual Sports 4',
		@Level101 = -100000, 
		@Level102 = -200000, 
		@Level1 = 100000, 
		@Level2 = 200000, 
		@Level3 = 300000, 
		@IsDeposit = 0, 
		@RepresentativeBettype = 1201,
		@Currency = ''
END
GO