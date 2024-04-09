/*<info serverAlias="DBTXN-bodb02"></info>*/

/*
	Creator: 20240322@Tacy
	Task: CWL - Non Sports Report - UU Slots - Integrate New Product [Redmine: #192593]
		 * Update RepresentativeBettype:
			UU SLOTS
			SEAL Entertainment
			MG-RNG
			Live22
	Database:	DBTXN-bodb02
*/
USE bodb02
GO

--EXEC NAP_CWL_ProductOffer_Initialize_Settings 
--	@ProductID = 78, 
--	@RepresentativeBettype = 4001;    
--GO

UPDATE p
	SET 
		p.BetType = 4001
FROM dbo.WinLimit_ProductOffer p WITH (ROWLOCK, UPDLOCK)
WHERE p.ProductID IN (78,72,73,79)
GO