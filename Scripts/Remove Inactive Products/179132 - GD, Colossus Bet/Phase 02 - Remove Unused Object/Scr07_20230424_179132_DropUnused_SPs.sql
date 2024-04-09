/*<info serverAlias="DBCUST-CustDB"></info>*/

/*	
	Created: 20230424@Tacy
	Task: Drop all unused SPs in DBCUST
	Redmine: https://nexdev.net/issues/179132
	DB: DBCUST
*/

USE CUSTDB
GO 


DROP PROCEDURE DEL_Acc_CustomerUpdDisableColossusBet 
GO
DROP PROCEDURE Acc_CustomerUpdDisableColossusBet_xtest 
GO
DROP PROCEDURE Acc_CustomerUpdDisableColossusBet_UAT1 
GO
DROP PROCEDURE Acc_CustomerUpdDisableColossusBet_UAT2 
GO
DROP PROCEDURE Acc_CustomerUpdDisableColossusBet_UAT4 
GO

DROP PROCEDURE DEL_Acc_Dep_CustomerUpdDisableColossusBet 
GO
DROP PROCEDURE Acc_Dep_CustomerUpdDisableColossusBet_UAT3 
GO
DROP PROCEDURE Acc_Dep_CustomerUpdDisableColossusBet_UAT4
GO

DROP PROCEDURE DEL_Age_CustomerSelGDComm_Ag 
GO

DROP PROCEDURE DEL_Age_CustomerSelGDComm_MAg 
GO

DROP PROCEDURE DEL_Age_CustomerSelGDPositionTakingByAg 
GO
DROP PROCEDURE Age_CustomerSelGDPositionTakingByAg_UAT2 
GO

DROP PROCEDURE DEL_Age_CustomerSelGDPositionTakingByMAg 
GO
DROP PROCEDURE Age_CustomerSelGDPositionTakingByMAg_UAT2 
GO

DROP PROCEDURE DEL_Age_CustomerSelGDPositionTakingBySAg 
GO
DROP PROCEDURE Age_CustomerSelGDPositionTakingBySAg_UAT2 
GO

DROP PROCEDURE DEL_Acc_AdminSelStatusByProductID 
GO
DROP PROCEDURE Acc_AdminSelStatusByProductID_UAT1 
GO
DROP PROCEDURE Acc_AdminSelStatusByProductID_UAT2 
GO
DROP PROCEDURE Acc_AdminSelStatusByProductID_UAT4 
GO