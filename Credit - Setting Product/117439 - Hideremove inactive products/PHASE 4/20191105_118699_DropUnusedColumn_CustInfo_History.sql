/*	
	Created: 20191105@Eden
	Task: Drop 40 columns on CustInfo_History  table
	Redmine: https://nexdev.net/issues/118699
	DB: DBTP/bodb_CustHistory
*/
USE bodb_CustHistory
GO
-- DROP CONSTRAINT 
ALTER TABLE dbo.Custinfo DROP CONSTRAINT DF__CustInfo___SyncB__014935CB
GO
ALTER TABLE dbo.Custinfo DROP CONSTRAINT DF_custInfo_MaxPerMatch151_AU
GO
ALTER TABLE dbo.Custinfo DROP CONSTRAINT DF_custInfo_MaxPerMatch152_UK
GO
ALTER TABLE dbo.Custinfo DROP CONSTRAINT DF_custInfo_MaxPerMatch152_AU
GO
ALTER TABLE dbo.Custinfo DROP CONSTRAINT DF_custInfo_MaxPerMatch153_AU
GO
ALTER TABLE dbo.Custinfo DROP CONSTRAINT DF_custInfo_Disable151_AU
GO
ALTER TABLE dbo.Custinfo DROP CONSTRAINT DF_custInfo_Disable152_UK
GO
ALTER TABLE dbo.Custinfo DROP CONSTRAINT DF_custInfo_Disable152_AU
GO
ALTER TABLE dbo.Custinfo DROP CONSTRAINT DF_custInfo_Disable153_AU
GO
ALTER TABLE dbo.Custinfo DROP CONSTRAINT DF_CustInfo_Old_MaxtransferP2P
GO
ALTER TABLE dbo.Custinfo DROP CONSTRAINT DF_CustInfo_Old_IsAutoResetP2P
GO
ALTER TABLE dbo.Custinfo DROP CONSTRAINT DF_CustInfo_Old_DisableP2P
GO
ALTER TABLE dbo.Custinfo DROP CONSTRAINT DF_CustInfo_Old_DisableFunP2P
GO
ALTER TABLE dbo.Custinfo DROP CONSTRAINT DF_custInfo_history_DisableHRFixedOdds
GO
ALTER TABLE dbo.Custinfo DROP CONSTRAINT DF_custInfo_history_maxpermatch154
GO
ALTER TABLE dbo.Custinfo DROP CONSTRAINT DF_custInfo_history_maxpermatch183
GO
ALTER TABLE dbo.Custinfo DROP CONSTRAINT DF_custInfo_history_maxpermatch185
GO
ALTER TABLE dbo.Custinfo DROP CONSTRAINT DF_custInfo_History_DisableBinaryOptions
GO
ALTER TABLE dbo.Custinfo DROP CONSTRAINT DF_custinfo_history_MaxPerMatch44
GO
ALTER TABLE dbo.Custinfo DROP CONSTRAINT DF_custinfo_history_DisableMicrogameLC
GO
ALTER TABLE dbo.Custinfo DROP CONSTRAINT DF_custinfo_history_DisableMicrogameRNG
GO
ALTER TABLE dbo.Custinfo DROP CONSTRAINT DF__CustInfo___Disab__7F60ED59
GO

--DROP COLUMN
ALTER TABLE dbo.CustInfo_History  DROP COLUMN Disable151_AU
GO
ALTER TABLE dbo.CustInfo_History  DROP COLUMN Disable152_AU
GO
ALTER TABLE dbo.CustInfo_History  DROP COLUMN Disable152_UK
GO
ALTER TABLE dbo.CustInfo_History  DROP COLUMN Disable153_AU
GO
ALTER TABLE dbo.CustInfo_History  DROP COLUMN DisableBinaryOptions
GO
ALTER TABLE dbo.CustInfo_History  DROP COLUMN DisableBingo
GO
ALTER TABLE dbo.CustInfo_History  DROP COLUMN DisableCasinoBonus
GO
ALTER TABLE dbo.CustInfo_History  DROP COLUMN DisableFinancial
GO
ALTER TABLE dbo.CustInfo_History  DROP COLUMN DisableFunP2P
GO
ALTER TABLE dbo.CustInfo_History  DROP COLUMN DisableHorseRacing
GO
ALTER TABLE dbo.CustInfo_History  DROP COLUMN DisableHRFixedOdds
GO
ALTER TABLE dbo.CustInfo_History  DROP COLUMN DisableLiveCasino
GO
ALTER TABLE dbo.CustInfo_History  DROP COLUMN DisableMicrogameLC
GO
ALTER TABLE dbo.CustInfo_History  DROP COLUMN DisableMicrogameRNG
GO
ALTER TABLE dbo.CustInfo_History  DROP COLUMN DisableOpenTote
GO
ALTER TABLE dbo.CustInfo_History  DROP COLUMN DisableP2P
GO
ALTER TABLE dbo.CustInfo_History  DROP COLUMN DisableVirtualSports
GO
ALTER TABLE dbo.CustInfo_History  DROP COLUMN HideVirtualSports
GO
ALTER TABLE dbo.CustInfo_History  DROP COLUMN isAutoResetLiveCasino
GO
ALTER TABLE dbo.CustInfo_History  DROP COLUMN IsAutoResetP2P
GO
ALTER TABLE dbo.CustInfo_History  DROP COLUMN maxpermatch151
GO
ALTER TABLE dbo.CustInfo_History  DROP COLUMN MaxPerMatch151_AU
GO
ALTER TABLE dbo.CustInfo_History  DROP COLUMN maxpermatch151_OT
GO
ALTER TABLE dbo.CustInfo_History  DROP COLUMN MaxPerMatch152_AU
GO
ALTER TABLE dbo.CustInfo_History  DROP COLUMN MaxPerMatch152_UK
GO
ALTER TABLE dbo.CustInfo_History  DROP COLUMN MaxPerMatch153_AU
GO
ALTER TABLE dbo.CustInfo_History  DROP COLUMN maxpermatch154
GO
ALTER TABLE dbo.CustInfo_History  DROP COLUMN maxpermatch180
GO
ALTER TABLE dbo.CustInfo_History  DROP COLUMN maxpermatch181
GO
ALTER TABLE dbo.CustInfo_History  DROP COLUMN maxpermatch182
GO
ALTER TABLE dbo.CustInfo_History  DROP COLUMN maxpermatch183
GO
ALTER TABLE dbo.CustInfo_History  DROP COLUMN maxpermatch184
GO
ALTER TABLE dbo.CustInfo_History  DROP COLUMN maxpermatch185
GO
ALTER TABLE dbo.CustInfo_History  DROP COLUMN maxpermatch186
GO
ALTER TABLE dbo.CustInfo_History  DROP COLUMN maxpermatch201
GO
ALTER TABLE dbo.CustInfo_History  DROP COLUMN MaxPerMatch44
GO
ALTER TABLE dbo.CustInfo_History  DROP COLUMN MaxtransferP2P
GO
ALTER TABLE dbo.CustInfo_History  DROP COLUMN MaxWinLiveCasino
GO
ALTER TABLE dbo.CustInfo_History  DROP COLUMN SyncBingo
GO
ALTER TABLE dbo.CustInfo_History  DROP COLUMN SyncLiveCasino
GO
