/*	
	Created: 20191105@Eden
	Task: Drop 40 columns on Custinfo table
	Redmine: https://nexdev.net/issues/118699
	DB: DBCUST
*/
USE CustDB
GO

ALTER TABLE dbo.Custinfo DROP COLUMN DEL_Disable151_AU
GO
ALTER TABLE dbo.Custinfo DROP COLUMN DEL_Disable152_AU
GO
ALTER TABLE dbo.Custinfo DROP COLUMN DEL_Disable152_UK
GO
ALTER TABLE dbo.Custinfo DROP COLUMN DEL_Disable153_AU
GO
ALTER TABLE dbo.Custinfo DROP COLUMN DEL_DisableBinaryOptions
GO
ALTER TABLE dbo.Custinfo DROP COLUMN DEL_DisableBingo
GO
ALTER TABLE dbo.Custinfo DROP COLUMN DEL_DisableCasinoBonus
GO
ALTER TABLE dbo.Custinfo DROP COLUMN DEL_DisableFinancial
GO
ALTER TABLE dbo.Custinfo DROP COLUMN DEL_DisableFunP2P
GO
ALTER TABLE dbo.Custinfo DROP COLUMN DEL_DisableHorseRacing
GO
ALTER TABLE dbo.Custinfo DROP COLUMN DEL_DisableHRFixedOdds
GO
ALTER TABLE dbo.Custinfo DROP COLUMN DEL_DisableLiveCasino
GO
ALTER TABLE dbo.Custinfo DROP COLUMN DEL_DisableMicrogameLC
GO
ALTER TABLE dbo.Custinfo DROP COLUMN DEL_DisableMicrogameRNG
GO
ALTER TABLE dbo.Custinfo DROP COLUMN DEL_DisableOpenTote
GO
ALTER TABLE dbo.Custinfo DROP COLUMN DEL_DisableP2P
GO
ALTER TABLE dbo.Custinfo DROP COLUMN DEL_DisableVirtualSports
GO
ALTER TABLE dbo.Custinfo DROP COLUMN DEL_HideVirtualSports
GO
ALTER TABLE dbo.Custinfo DROP COLUMN DEL_isAutoResetLiveCasino
GO
ALTER TABLE dbo.Custinfo DROP COLUMN DEL_IsAutoResetP2P
GO
ALTER TABLE dbo.Custinfo DROP COLUMN DEL_maxpermatch151
GO
ALTER TABLE dbo.Custinfo DROP COLUMN DEL_MaxPerMatch151_AU
GO
ALTER TABLE dbo.Custinfo DROP COLUMN DEL_maxpermatch151_OT
GO
ALTER TABLE dbo.Custinfo DROP COLUMN DEL_MaxPerMatch152_AU
GO
ALTER TABLE dbo.Custinfo DROP COLUMN DEL_MaxPerMatch152_UK
GO
ALTER TABLE dbo.Custinfo DROP COLUMN DEL_MaxPerMatch153_AU
GO
ALTER TABLE dbo.Custinfo DROP COLUMN DEL_maxpermatch154
GO
ALTER TABLE dbo.Custinfo DROP COLUMN DEL_maxpermatch180
GO
ALTER TABLE dbo.Custinfo DROP COLUMN DEL_maxpermatch181
GO
ALTER TABLE dbo.Custinfo DROP COLUMN DEL_maxpermatch182
GO
ALTER TABLE dbo.Custinfo DROP COLUMN DEL_maxpermatch183
GO
ALTER TABLE dbo.Custinfo DROP COLUMN DEL_maxpermatch184
GO
ALTER TABLE dbo.Custinfo DROP COLUMN DEL_maxpermatch185
GO
ALTER TABLE dbo.Custinfo DROP COLUMN DEL_maxpermatch186
GO
ALTER TABLE dbo.Custinfo DROP COLUMN DEL_maxpermatch201
GO
ALTER TABLE dbo.Custinfo DROP COLUMN DEL_MaxPerMatch44
GO
ALTER TABLE dbo.Custinfo DROP COLUMN DEL_MaxtransferP2P
GO
ALTER TABLE dbo.Custinfo DROP COLUMN DEL_MaxWinLiveCasino
GO
ALTER TABLE dbo.Custinfo DROP COLUMN DEL_SyncBingo
GO
ALTER TABLE dbo.Custinfo DROP COLUMN DEL_SyncLiveCasino
GO
