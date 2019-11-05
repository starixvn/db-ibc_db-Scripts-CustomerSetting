/*	
	Created: 20191105@Eden
	Task: Rename 40 columns on Custinfo table - Script ROLLBACK
	Redmine: https://nexdev.net/issues/118699
	DB: DBCUST
*/

USE CUSTDB
GO 


EXEC sp_rename 'custinfo.DEL_Disable151_AU','Disable151_AU', 'COLUMN'
EXEC sp_rename 'custinfo.DEL_Disable152_AU','Disable152_AU', 'COLUMN'
EXEC sp_rename 'custinfo.DEL_Disable152_UK','Disable152_UK', 'COLUMN'
EXEC sp_rename 'custinfo.DEL_Disable153_AU','Disable153_AU', 'COLUMN'
EXEC sp_rename 'custinfo.DEL_DisableBinaryOptions','DisableBinaryOptions', 'COLUMN'
EXEC sp_rename 'custinfo.DEL_DisableBingo','DisableBingo', 'COLUMN'
EXEC sp_rename 'custinfo.DEL_DisableCasinoBonus','DisableCasinoBonus', 'COLUMN'
EXEC sp_rename 'custinfo.DEL_DisableFinancial','DisableFinancial', 'COLUMN'
EXEC sp_rename 'custinfo.DEL_DisableFunP2P','DisableFunP2P', 'COLUMN'
EXEC sp_rename 'custinfo.DEL_DisableHorseRacing','DisableHorseRacing', 'COLUMN'
EXEC sp_rename 'custinfo.DEL_DisableHRFixedOdds','DisableHRFixedOdds', 'COLUMN'
EXEC sp_rename 'custinfo.DEL_DisableLiveCasino','DisableLiveCasino', 'COLUMN'
EXEC sp_rename 'custinfo.DEL_DisableMicrogameLC','DisableMicrogameLC', 'COLUMN'
EXEC sp_rename 'custinfo.DEL_DisableMicrogameRNG','DisableMicrogameRNG', 'COLUMN'
EXEC sp_rename 'custinfo.DEL_DisableOpenTote','DisableOpenTote', 'COLUMN'
EXEC sp_rename 'custinfo.DEL_DisableP2P','DisableP2P', 'COLUMN'
EXEC sp_rename 'custinfo.DEL_DisableVirtualSports','DisableVirtualSports', 'COLUMN'
EXEC sp_rename 'custinfo.DEL_HideVirtualSports','HideVirtualSports', 'COLUMN'
EXEC sp_rename 'custinfo.DEL_isAutoResetLiveCasino','isAutoResetLiveCasino', 'COLUMN'
EXEC sp_rename 'custinfo.DEL_IsAutoResetP2P','IsAutoResetP2P', 'COLUMN'
EXEC sp_rename 'custinfo.DEL_maxpermatch151','maxpermatch151', 'COLUMN'
EXEC sp_rename 'custinfo.DEL_MaxPerMatch151_AU','MaxPerMatch151_AU', 'COLUMN'
EXEC sp_rename 'custinfo.DEL_maxpermatch151_OT','maxpermatch151_OT', 'COLUMN'
EXEC sp_rename 'custinfo.DEL_MaxPerMatch152_AU','MaxPerMatch152_AU', 'COLUMN'
EXEC sp_rename 'custinfo.DEL_MaxPerMatch152_UK','MaxPerMatch152_UK', 'COLUMN'
EXEC sp_rename 'custinfo.DEL_MaxPerMatch153_AU','MaxPerMatch153_AU', 'COLUMN'
EXEC sp_rename 'custinfo.DEL_maxpermatch154','maxpermatch154', 'COLUMN'
EXEC sp_rename 'custinfo.DEL_maxpermatch180','maxpermatch180', 'COLUMN'
EXEC sp_rename 'custinfo.DEL_maxpermatch181','maxpermatch181', 'COLUMN'
EXEC sp_rename 'custinfo.DEL_maxpermatch182','maxpermatch182', 'COLUMN'
EXEC sp_rename 'custinfo.DEL_maxpermatch183','maxpermatch183', 'COLUMN'
EXEC sp_rename 'custinfo.DEL_maxpermatch184','maxpermatch184', 'COLUMN'
EXEC sp_rename 'custinfo.DEL_maxpermatch185','maxpermatch185', 'COLUMN'
EXEC sp_rename 'custinfo.DEL_maxpermatch186','maxpermatch186', 'COLUMN'
EXEC sp_rename 'custinfo.DEL_maxpermatch201','maxpermatch201', 'COLUMN'
EXEC sp_rename 'custinfo.DEL_MaxPerMatch44','MaxPerMatch44', 'COLUMN'
EXEC sp_rename 'custinfo.DEL_MaxtransferP2P','MaxtransferP2P', 'COLUMN'
EXEC sp_rename 'custinfo.DEL_MaxWinLiveCasino','MaxWinLiveCasino', 'COLUMN'
EXEC sp_rename 'custinfo.DEL_SyncBingo','SyncBingo', 'COLUMN'
EXEC sp_rename 'custinfo.DEL_SyncLiveCasino','SyncLiveCasino', 'COLUMN'


