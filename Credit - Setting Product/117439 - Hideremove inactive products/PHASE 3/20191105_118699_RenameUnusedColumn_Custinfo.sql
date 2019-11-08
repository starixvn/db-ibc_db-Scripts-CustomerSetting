/*	
	Created: 20191105@Eden
	Task: Rename 40 columns on Custinfo table
	Redmine: https://nexdev.net/issues/118699
	DB: DBCUST/CUSTDB and ALL REPLICATIONS
*/
GO 
EXEC sp_rename 'custinfo.Disable151_AU','DEL_Disable151_AU', 'COLUMN'
EXEC sp_rename 'custinfo.Disable152_AU','DEL_Disable152_AU', 'COLUMN'
EXEC sp_rename 'custinfo.Disable152_UK','DEL_Disable152_UK', 'COLUMN'
EXEC sp_rename 'custinfo.Disable153_AU','DEL_Disable153_AU', 'COLUMN'
EXEC sp_rename 'custinfo.DisableBinaryOptions','DEL_DisableBinaryOptions', 'COLUMN'
EXEC sp_rename 'custinfo.DisableBingo','DEL_DisableBingo', 'COLUMN'
EXEC sp_rename 'custinfo.DisableCasinoBonus','DEL_DisableCasinoBonus', 'COLUMN'
EXEC sp_rename 'custinfo.DisableFinancial','DEL_DisableFinancial', 'COLUMN'
EXEC sp_rename 'custinfo.DisableFunP2P','DEL_DisableFunP2P', 'COLUMN'
EXEC sp_rename 'custinfo.DisableHorseRacing','DEL_DisableHorseRacing', 'COLUMN'
EXEC sp_rename 'custinfo.DisableHRFixedOdds','DEL_DisableHRFixedOdds', 'COLUMN'
EXEC sp_rename 'custinfo.DisableLiveCasino','DEL_DisableLiveCasino', 'COLUMN'
EXEC sp_rename 'custinfo.DisableMicrogameLC','DEL_DisableMicrogameLC', 'COLUMN'
EXEC sp_rename 'custinfo.DisableMicrogameRNG','DEL_DisableMicrogameRNG', 'COLUMN'
EXEC sp_rename 'custinfo.DisableOpenTote','DEL_DisableOpenTote', 'COLUMN'
EXEC sp_rename 'custinfo.DisableP2P','DEL_DisableP2P', 'COLUMN'
EXEC sp_rename 'custinfo.DisableVirtualSports','DEL_DisableVirtualSports', 'COLUMN'
EXEC sp_rename 'custinfo.HideVirtualSports','DEL_HideVirtualSports', 'COLUMN'
EXEC sp_rename 'custinfo.isAutoResetLiveCasino','DEL_isAutoResetLiveCasino', 'COLUMN'
EXEC sp_rename 'custinfo.IsAutoResetP2P','DEL_IsAutoResetP2P', 'COLUMN'
EXEC sp_rename 'custinfo.maxpermatch151','DEL_maxpermatch151', 'COLUMN'
EXEC sp_rename 'custinfo.MaxPerMatch151_AU','DEL_MaxPerMatch151_AU', 'COLUMN'
EXEC sp_rename 'custinfo.maxpermatch151_OT','DEL_maxpermatch151_OT', 'COLUMN'
EXEC sp_rename 'custinfo.MaxPerMatch152_AU','DEL_MaxPerMatch152_AU', 'COLUMN'
EXEC sp_rename 'custinfo.MaxPerMatch152_UK','DEL_MaxPerMatch152_UK', 'COLUMN'
EXEC sp_rename 'custinfo.MaxPerMatch153_AU','DEL_MaxPerMatch153_AU', 'COLUMN'
EXEC sp_rename 'custinfo.maxpermatch154','DEL_maxpermatch154', 'COLUMN'
EXEC sp_rename 'custinfo.maxpermatch180','DEL_maxpermatch180', 'COLUMN'
EXEC sp_rename 'custinfo.maxpermatch181','DEL_maxpermatch181', 'COLUMN'
EXEC sp_rename 'custinfo.maxpermatch182','DEL_maxpermatch182', 'COLUMN'
EXEC sp_rename 'custinfo.maxpermatch183','DEL_maxpermatch183', 'COLUMN'
EXEC sp_rename 'custinfo.maxpermatch184','DEL_maxpermatch184', 'COLUMN'
EXEC sp_rename 'custinfo.maxpermatch185','DEL_maxpermatch185', 'COLUMN'
EXEC sp_rename 'custinfo.maxpermatch186','DEL_maxpermatch186', 'COLUMN'
EXEC sp_rename 'custinfo.maxpermatch201','DEL_maxpermatch201', 'COLUMN'
EXEC sp_rename 'custinfo.MaxPerMatch44','DEL_MaxPerMatch44', 'COLUMN'
EXEC sp_rename 'custinfo.MaxtransferP2P','DEL_MaxtransferP2P', 'COLUMN'
EXEC sp_rename 'custinfo.MaxWinLiveCasino','DEL_MaxWinLiveCasino', 'COLUMN'
EXEC sp_rename 'custinfo.SyncBingo','DEL_SyncBingo', 'COLUMN'
EXEC sp_rename 'custinfo.SyncLiveCasino','DEL_SyncLiveCasino', 'COLUMN'


