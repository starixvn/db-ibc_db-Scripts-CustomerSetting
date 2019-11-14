/*	
	Created: 20191007@Eden
	Task: Rename all unused SP in DBTXN/DBPRO
	Redmine: https://redmine.nexcel.vn/issues/118413
	DB: DBTXN
*/

USE bodb02
GO 


EXEC sp_rename 'Acc_CustomerPwdUpd','DEL_Acc_CustomerPwdUpd'
GO
EXEC sp_rename 'Acc_CustomerSyncUpd','DEL_Acc_CustomerSyncUpd'
GO
EXEC sp_rename 'NAP_WinLimit_CurrencySel','DEL_NAP_WinLimit_CurrencySel'
GO
EXEC sp_rename 'NAP_WinLimit_CurrencySettingIns','DEL_NAP_WinLimit_CurrencySettingIns'
GO
EXEC sp_rename 'NAP_WinLimit_CurrencySettingSel','DEL_NAP_WinLimit_CurrencySettingSel'
GO
EXEC sp_rename 'NAP_WinLimit_CurrencySettingUpd','DEL_NAP_WinLimit_CurrencySettingUpd'
GO
EXEC sp_rename 'NAP_WinLimit_Game_Unblock','DEL_NAP_WinLimit_Game_Unblock'
GO
EXEC sp_rename 'NAP_WinLimit_GameSel','DEL_NAP_WinLimit_GameSel'
GO
EXEC sp_rename 'NAP_WinLimit_ProductSel','DEL_NAP_WinLimit_ProductSel'
GO


