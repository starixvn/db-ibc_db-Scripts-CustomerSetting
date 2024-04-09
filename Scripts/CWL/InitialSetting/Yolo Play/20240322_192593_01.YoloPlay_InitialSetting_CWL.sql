/*<info serverAlias="DBCUST-CustDB"></info>*/

/*
	Creator: 20240322@Tacy
	Task: CWL - Non Sports Report - Yolo Play - Integrate New Product [Redmine: #199192]
	Database:	DBCUST.CustDB
*/
/*
	Full range: [3650 - 3699]
*/

USE CustDB
GO

----------------------------------------------------------
DECLARE	@ProductID TINYINT = 84, 
		@BetTypeID_Begin SMALLINT, 
		@BetTypeID_End SMALLINT, 
		@BettypeIds VARCHAR(2000)='', 
		@GroupID TINYINT, 
		@GroupName VARCHAR(200)

SELECT @BetTypeID_Begin = MIN (BetType)
	 , @BetTypeID_End = MAX(BetType)
FROM DBACC.bodb02.dbo.SportBettypeMatrix sm WITH (NOLOCK)
WHERE sm.ProductID=@ProductID

SELECT @GroupID = (MAX(GroupID) + 1)
FROM Winlimit_Group WITH (NOLOCK)

SELECT @GroupName = ProductName --+ ' - Normal Games'
FROM DBACC.bodb02.dbo.Products p WITH (NOLOCK)
WHERE p.ProductID=@ProductID

SELECT	@ProductID AS ProductID, 
		@BetTypeID_Begin AS BetTypeID_Begin, 
		@BetTypeID_End	 AS BetTypeID_End, 
		@BettypeIds AS BettypeIds, 
		@GroupID	AS GroupID,
		@GroupName	AS GroupName
----------------------------------------------------------
BEGIN --for Normal bettypes
	-- For Deposit: all currencies except special setting
	EXEC NAP_CWL_Initialize_Settings 
		@ProductID = @ProductID, 
		@BetTypeID_Begin = @BetTypeID_Begin, 
		@BetTypeID_End = @BetTypeID_End, 
		@BettypeIds = @BettypeIds, 
		@GroupID = @GroupID, 
		@GroupName = @GroupName, 
		@Level101 = -20000, 
		@Level102 = -50000, 
		@Level1 = 20000, 
		@Level2 = 50000, 
		@Level3 = 100000, 
		@IsDeposit = 1, 
		@IsBlockedTransfer_DepositSite_Level3 = 1,
		@RepresentativeBettype = @BetTypeID_Begin,
		@Currency = ''

	-- For Deposit: special setting
	EXEC NAP_CWL_Initialize_Settings 
		@ProductID = @ProductID, 
		@BetTypeID_Begin = @BetTypeID_Begin, 
		@BetTypeID_End = @BetTypeID_End, 
		@BettypeIds = @BettypeIds, 
		@GroupID = @GroupID, 
		@GroupName = @GroupName, 
		@Level101 = -20000, 
		@Level102 = -50000, 
		@Level1 = 5000, 
		@Level2 = 30000, 
		@Level3 = 75000, 
		@IsDeposit = 1, 
		@IsBlockedTransfer_DepositSite_Level3 = 1,
		@RepresentativeBettype = @BetTypeID_Begin,
		@Currency = 'INH,RMB'

	-----------------------------------------------------
	-----------------------------------------------------
	-- For Credit: all currencies except special setting
	EXEC NAP_CWL_Initialize_Settings 
		@ProductID = @ProductID, 
		@BetTypeID_Begin = @BetTypeID_Begin, 
		@BetTypeID_End = @BetTypeID_End, 
		@BettypeIds = @BettypeIds, 
		@GroupID = @GroupID, 
		@GroupName = @GroupName, 
		@Level101 = -50000, 
		@Level102 = -100000, 
		@Level1 = 50000, 
		@Level2 = 100000, 
		@Level3 = 200000, 
		@IsDeposit = 0, 
		@IsSuspendedAccount_CreditSite_Level2 = 1,	--If: belong to RNG slot; Else: Set = 0
		@IsSuspendedAccount_CreditSite_Level3 = 1,	--If: belong to RNG slot; Else: Set = 0
		@RepresentativeBettype = @BetTypeID_Begin,
		@Currency = ''

	-- For Credit: special setting
	EXEC NAP_CWL_Initialize_Settings 
		@ProductID = @ProductID, 
		@BetTypeID_Begin = @BetTypeID_Begin, 
		@BetTypeID_End = @BetTypeID_End, 
		@BettypeIds = @BettypeIds, 
		@GroupID = @GroupID, 
		@GroupName = @GroupName, 
		@Level101 = -50000, 
		@Level102 = -100000, 
		@Level1 = 5000, 
		@Level2 = 30000, 
		@Level3 = 75000, 
		@IsDeposit = 0, 
		@IsSuspendedAccount_CreditSite_Level2 = 1,	--If: belong to RNG slot; Else: Set = 0
		@IsSuspendedAccount_CreditSite_Level3 = 1,	--If: belong to RNG slot; Else: Set = 0
		@RepresentativeBettype = @BetTypeID_Begin,
		@Currency = 'INH,RMB'
END
GO