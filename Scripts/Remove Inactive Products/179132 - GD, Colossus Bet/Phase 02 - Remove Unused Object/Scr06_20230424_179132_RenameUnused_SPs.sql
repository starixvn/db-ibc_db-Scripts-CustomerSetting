/*<info serverAlias="DBCUST-CustDB"></info>*/
/*	
	Created: 20230424@Tacy
	Task: Rename unused SPs
	Redmine: https://nexdev.net/issues/179132
	DB: DBCUST-CustDB
*/
USE CustDB
GO 

EXEC sp_rename 'Acc_CustomerUpdDisableColossusBet',		'DEL_Acc_CustomerUpdDisableColossusBet',	'Object'
GO 
EXEC sp_rename 'Acc_Dep_CustomerUpdDisableColossusBet', 'DEL_Acc_Dep_CustomerUpdDisableColossusBet','Object'
GO
EXEC sp_rename 'Age_CustomerSelGDComm_Ag',				'DEL_Age_CustomerSelGDComm_Ag',				'Object'
GO
EXEC sp_rename 'Age_CustomerSelGDComm_MAg',				'DEL_Age_CustomerSelGDComm_MAg',			'Object'
GO
EXEC sp_rename 'Age_CustomerSelGDPositionTakingByAg',	'DEL_Age_CustomerSelGDPositionTakingByAg',	'Object'
GO
EXEC sp_rename 'Age_CustomerSelGDPositionTakingByMAg',	'DEL_Age_CustomerSelGDPositionTakingByMAg', 'Object'
GO
EXEC sp_rename 'Age_CustomerSelGDPositionTakingBySAg',	'DEL_Age_CustomerSelGDPositionTakingBySAg', 'Object'
GO
EXEC sp_rename 'Acc_AdminSelStatusByProductID',			'DEL_Acc_AdminSelStatusByProductID', 'Object'
GO