/*<info serverAlias="DBCUST-CustDB"></info>*/

/*
	Creator: 20231204@Tacy
	Task: CWL - Non Sports Report - Live22 - Integrate New Product [Redmine: #195092]
	Database:	DBCUST.CustDB
*/
/*
	Full range: [7601 - 7700]
	Bettype Promotion Prize: 7698
*/

USE CustDB
GO

----------------------------------------------------------
----------------------------------------------------------
DECLARE @BettypeIds VARCHAR(2000)

SELECT @BettypeIds=(STUFF((SELECT ',' + CAST(typeid AS VARCHAR)
							FROM DBACC.bodb02.dbo.bettype WITH (NOLOCK)
							WHERE typeid BETWEEN 7601 AND 7700
								AND typeid<>7698
							FOR XML PATH('')
							),1,1,''))

BEGIN --range: [7601 - 7700] \ [7698]
	-- For Deposit: all currencies except special setting
	EXEC NAP_CWL_Initialize_Settings 
		@ProductID = 79, 
		@BetTypeID_Begin = 0, 
		@BetTypeID_End = 0, 
		@BettypeIds = @BettypeIds, 
		@GroupID = 64, 
		@GroupName = 'Live22 - Normal Games', 
		@Level101 = -20000, 
		@Level102 = -50000, 
		@Level1 = 20000, 
		@Level2 = 50000, 
		@Level3 = 100000, 
		@IsDeposit = 1, 
		@IsBlockedTransfer_DepositSite_Level3 = 1,
		@RepresentativeBettype = 7601,
		@Currency = ''

	-- For Deposit: special setting
	EXEC NAP_CWL_Initialize_Settings 
		@ProductID = 79, 
		@BetTypeID_Begin = 0, 
		@BetTypeID_End = 0, 
		@BettypeIds = @BettypeIds, 
		@GroupID = 64, 
		@GroupName = 'Live22 - Normal Games', 
		@Level101 = -20000, 
		@Level102 = -50000, 
		@Level1 = 5000, 
		@Level2 = 30000, 
		@Level3 = 75000, 
		@IsDeposit = 1, 
		@IsBlockedTransfer_DepositSite_Level3 = 1,
		@RepresentativeBettype = 7601,
		@Currency = 'INH,RMB'

	-----------------------------------------------------
	-----------------------------------------------------
	-- For Credit: all currencies except special setting
	EXEC NAP_CWL_Initialize_Settings 
		@ProductID = 79, 
		@BetTypeID_Begin = 0, 
		@BetTypeID_End = 0, 
		@BettypeIds = @BettypeIds, 
		@GroupID = 64, 
		@GroupName = 'Live22 - Normal Games', 
		@Level101 = -50000, 
		@Level102 = -100000, 
		@Level1 = 50000, 
		@Level2 = 100000, 
		@Level3 = 200000, 
		@IsDeposit = 0, 
		@IsSuspendedAccount_CreditSite_Level2 = 1,	--If: belong to RNG slot; Else: Set = 0
		@IsSuspendedAccount_CreditSite_Level3 = 1,	--If: belong to RNG slot; Else: Set = 0
		@RepresentativeBettype = 7601,
		@Currency = ''

	-- For Credit: special setting
	EXEC NAP_CWL_Initialize_Settings 
		@ProductID = 79, 
		@BetTypeID_Begin = 0, 
		@BetTypeID_End = 0, 
		@BettypeIds = @BettypeIds, 
		@GroupID = 64, 
		@GroupName = 'Live22 - Normal Games', 
		@Level101 = -50000, 
		@Level102 = -100000, 
		@Level1 = 5000, 
		@Level2 = 30000, 
		@Level3 = 75000, 
		@IsDeposit = 0, 
		@IsSuspendedAccount_CreditSite_Level2 = 1,	--If: belong to RNG slot; Else: Set = 0
		@IsSuspendedAccount_CreditSite_Level3 = 1,	--If: belong to RNG slot; Else: Set = 0
		@RepresentativeBettype = 7601,
		@Currency = 'INH,RMB'
END
GO

---------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------
--integrate bettype 7698 -  Promotion Prize (not support to enable the suspend settings)
BEGIN
	-- For Deposit:
	EXEC NAP_CWL_Initialize_Settings 
		@ProductID = 79, 
		@BetTypeID_Begin = 0, 
		@BetTypeID_End = 0, 
		@BettypeIds = '7698', 
		@GroupID = 65, 
		@GroupName = 'Live22 - Promotion Prize', 
		@Level101 = 0, 
		@Level102 = 0, 
		@Level1 = 1000, 
		@Level2 = 0, 
		@Level3 = 0, 
		@IsDeposit = 1, 
		@IsBlockedTransfer_DepositSite_Level3 = 1,
		@RepresentativeBettype = 7601,
		@Currency = ''

	-- For Credit: 
	EXEC NAP_CWL_Initialize_Settings 
		@ProductID = 79, 
		@BetTypeID_Begin = 0, 
		@BetTypeID_End = 0, 
		@BettypeIds = '7698', 
		@GroupID = 65, 
		@GroupName = 'Live22 - Promotion Prize',
		@Level101 = 0, 
		@Level102 = 0, 
		@Level1 = 1000, 
		@Level2 = 0, 
		@Level3 = 0, 
		@IsDeposit = 0, 
		@RepresentativeBettype = 7601,
		@Currency = ''
END
GO