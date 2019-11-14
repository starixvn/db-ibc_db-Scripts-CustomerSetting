/*	
	Created: 20191007@Eden
	Task: Rename all unused SP in DBPRO
	Redmine: https://redmine.nexcel.vn/issues/118413
	DB: DBPRO
*/

USE bodb02
GO 

EXEC sp_rename 'NAP_WinLimit_CurrencySel','DEL_NAP_WinLimit_CurrencySel'
GO
EXEC sp_rename 'NAP_WinLimit_CurrencySettingUpd','DEL_NAP_WinLimit_CurrencySettingUpd'
GO