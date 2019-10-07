/*	
	Created: 20191007@Eden
	Task: Drop all unused SP in DBACC
	Redmine: https://redmine.nexcel.vn/issues/118413
	DB: DBACC
*/

USE bodb02
GO 


DROP PROCEDURE DEL_Acc_AllStatement_FULL2
GO
DROP PROCEDURE Acc_AllStatement_FULL2_xpre
GO
DROP PROCEDURE Acc_AllStatement_FULL2_xtest
GO
DROP PROCEDURE Acc_AllStatement_FULL2_UAT1
GO
DROP PROCEDURE Acc_AllStatement_FULL2_UAT2
GO
DROP PROCEDURE Acc_AllStatement_FULL2_UAT3
GO
DROP PROCEDURE Acc_AllStatement_FULL2_UAT4
GO
DROP PROCEDURE DEL_ACC_CustomerValidation
GO
DROP PROCEDURE ACC_CustomerValidation_xpre
GO
DROP PROCEDURE ACC_CustomerValidation_xtest
GO
DROP PROCEDURE ACC_CustomerValidation_UAT1
GO
DROP PROCEDURE ACC_CustomerValidation_UAT2
GO
DROP PROCEDURE ACC_CustomerValidation_UAT3
GO
DROP PROCEDURE ACC_CustomerValidation_UAT4
GO