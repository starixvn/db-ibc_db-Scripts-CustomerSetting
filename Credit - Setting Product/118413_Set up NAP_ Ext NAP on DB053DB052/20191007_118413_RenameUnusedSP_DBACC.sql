/*	
	Created: 20191007@Eden
	Task: Rename all unused SP in DBACC
	Redmine: https://redmine.nexcel.vn/issues/118413
	DB: DBACC
*/

USE bodb02
GO 


EXEC sp_rename 'Acc_AllStatement_FULL2','DEL_Acc_AllStatement_FULL2'
GO
EXEC sp_rename 'ACC_CustomerValidation','DEL_ACC_CustomerValidation'
GO

