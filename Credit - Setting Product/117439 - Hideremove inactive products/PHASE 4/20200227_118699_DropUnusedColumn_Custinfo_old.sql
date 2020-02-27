/*	
	Created: 20200227@Eden
	Task: Drop 40 columns on CustInfo_old  table
	Redmine: https://nexdev.net/issues/118699
	DB: DB05/bodb_customer
*/
USE bodb_customer
GO
--ADD COLUMN [DangerLevel]
ALTER TABLE dbo.Custinfo_Old ADD [DangerLevel] [tinyint] NULL 

--DROP CONSTRAINT
ALTER TABLE dbo.Custinfo_Old DROP CONSTRAINT DF_custInfo_MaxPerMatch151_AUGO
ALTER TABLE dbo.Custinfo_Old DROP CONSTRAINT DF_custInfo_MaxPerMatch152_UKGO
ALTER TABLE dbo.Custinfo_Old DROP CONSTRAINT DF_custInfo_MaxPerMatch152_AUGO
ALTER TABLE dbo.Custinfo_Old DROP CONSTRAINT DF_custInfo_MaxPerMatch153_AUGO
ALTER TABLE dbo.Custinfo_Old DROP CONSTRAINT DF_custInfo_Disable151_AUGO
ALTER TABLE dbo.Custinfo_Old DROP CONSTRAINT DF_custInfo_Disable152_UKGO
ALTER TABLE dbo.Custinfo_Old DROP CONSTRAINT DF_custInfo_Disable152_AUGO
ALTER TABLE dbo.Custinfo_Old DROP CONSTRAINT DF_custInfo_Disable153_AUGO
ALTER TABLE dbo.Custinfo_Old DROP CONSTRAINT DF_CustInfo_Old_IsAutoResetP2PGO
ALTER TABLE dbo.Custinfo_Old DROP CONSTRAINT DF_CustInfo_Old_DisableP2PGO
ALTER TABLE dbo.Custinfo_Old DROP CONSTRAINT DF_CustInfo_Old_DisableFunP2PGO
ALTER TABLE dbo.Custinfo_Old DROP CONSTRAINT DF_CustInfo_Old_MaxtransferP2PGO
ALTER TABLE dbo.Custinfo_Old DROP CONSTRAINT DF_custInfo_old_DisableHRFixedOddsGO
ALTER TABLE dbo.Custinfo_Old DROP CONSTRAINT DF_custInfo_old_maxpermatch154GO
ALTER TABLE dbo.Custinfo_Old DROP CONSTRAINT DF_custInfo_old_maxpermatch183GO
ALTER TABLE dbo.Custinfo_Old DROP CONSTRAINT DF_custInfo_old_maxpermatch185GO
ALTER TABLE dbo.Custinfo_Old DROP CONSTRAINT DF_custinfo_old_MaxPerMatch44GO
ALTER TABLE dbo.Custinfo_Old DROP CONSTRAINT DF_custinfo_old_DisableMicrogameLCGO
ALTER TABLE dbo.Custinfo_Old DROP CONSTRAINT DF_custinfo_old_DisableMicrogameRNGGO
ALTER TABLE dbo.Custinfo_Old DROP CONSTRAINT DF_custInfo_Old_DisableBinaryOptionsGO
ALTER TABLE dbo.Custinfo_Old DROP CONSTRAINT DF_custInfo_DisableHorseRacingGO
ALTER TABLE dbo.Custinfo_Old DROP CONSTRAINT DF_custInfo_DisableFinancialGO
ALTER TABLE dbo.Custinfo_Old DROP CONSTRAINT DF_custInfo_DisableOpenToteGO
ALTER TABLE dbo.Custinfo_Old DROP CONSTRAINT DF_custInfo_Maxpermatch151_OTGO

--DROP COLUMN
ALTER TABLE dbo.CustInfo_Old  DROP COLUMN Disable151_AU
GO
ALTER TABLE dbo.CustInfo_Old  DROP COLUMN Disable152_AU
GO
ALTER TABLE dbo.CustInfo_Old  DROP COLUMN Disable152_UK
GO
ALTER TABLE dbo.CustInfo_Old  DROP COLUMN Disable153_AU
GO
ALTER TABLE dbo.CustInfo_Old  DROP COLUMN DisableBinaryOptions
GO
ALTER TABLE dbo.CustInfo_Old  DROP COLUMN DisableBingo
GO
ALTER TABLE dbo.CustInfo_Old  DROP COLUMN DisableCasinoBonus
GO
ALTER TABLE dbo.CustInfo_Old  DROP COLUMN DisableFinancial
GO
ALTER TABLE dbo.CustInfo_Old  DROP COLUMN DisableFunP2P
GO
ALTER TABLE dbo.CustInfo_Old  DROP COLUMN DisableHorseRacing
GO
ALTER TABLE dbo.CustInfo_Old  DROP COLUMN DisableHRFixedOdds
GO
ALTER TABLE dbo.CustInfo_Old  DROP COLUMN DisableLiveCasino
GO
ALTER TABLE dbo.CustInfo_Old  DROP COLUMN DisableMicrogameLC
GO
ALTER TABLE dbo.CustInfo_Old  DROP COLUMN DisableMicrogameRNG
GO
ALTER TABLE dbo.CustInfo_Old  DROP COLUMN DisableOpenTote
GO
ALTER TABLE dbo.CustInfo_Old  DROP COLUMN DisableP2P
GO
ALTER TABLE dbo.CustInfo_Old  DROP COLUMN DisableVirtualSports
GO
ALTER TABLE dbo.CustInfo_Old  DROP COLUMN HideVirtualSports
GO
ALTER TABLE dbo.CustInfo_Old  DROP COLUMN isAutoResetLiveCasino
GO
ALTER TABLE dbo.CustInfo_Old  DROP COLUMN IsAutoResetP2P
GO
ALTER TABLE dbo.CustInfo_Old  DROP COLUMN maxpermatch151
GO
ALTER TABLE dbo.CustInfo_Old  DROP COLUMN MaxPerMatch151_AU
GO
ALTER TABLE dbo.CustInfo_Old  DROP COLUMN maxpermatch151_OT
GO
ALTER TABLE dbo.CustInfo_Old  DROP COLUMN MaxPerMatch152_AU
GO
ALTER TABLE dbo.CustInfo_Old  DROP COLUMN MaxPerMatch152_UK
GO
ALTER TABLE dbo.CustInfo_Old  DROP COLUMN MaxPerMatch153_AU
GO
ALTER TABLE dbo.CustInfo_Old  DROP COLUMN maxpermatch154
GO
ALTER TABLE dbo.CustInfo_Old  DROP COLUMN maxpermatch180
GO
ALTER TABLE dbo.CustInfo_Old  DROP COLUMN maxpermatch181
GO
ALTER TABLE dbo.CustInfo_Old  DROP COLUMN maxpermatch182
GO
ALTER TABLE dbo.CustInfo_Old  DROP COLUMN maxpermatch183
GO
ALTER TABLE dbo.CustInfo_Old  DROP COLUMN maxpermatch184
GO
ALTER TABLE dbo.CustInfo_Old  DROP COLUMN maxpermatch185
GO
ALTER TABLE dbo.CustInfo_Old  DROP COLUMN maxpermatch186
GO
ALTER TABLE dbo.CustInfo_Old  DROP COLUMN maxpermatch201
GO
ALTER TABLE dbo.CustInfo_Old  DROP COLUMN MaxPerMatch44
GO
ALTER TABLE dbo.CustInfo_Old  DROP COLUMN MaxtransferP2P
GO
ALTER TABLE dbo.CustInfo_Old  DROP COLUMN MaxWinLiveCasino
GO
ALTER TABLE dbo.CustInfo_Old  DROP COLUMN SyncBingo
GO
ALTER TABLE dbo.CustInfo_Old  DROP COLUMN SyncLiveCasino
GO
