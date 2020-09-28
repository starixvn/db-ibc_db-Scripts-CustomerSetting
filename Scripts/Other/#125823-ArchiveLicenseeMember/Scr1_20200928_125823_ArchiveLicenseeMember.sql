/*<info serverAlias="DBCUST-CustDB"></info>*/
/*	
	Created: 20200928@Eden
	Task: Drop 40 columns on CustInfo table of DB Archive for Licensee [#125823]
	DB: DBARCCUST/Bodb_Archive_Customer_Licensee
*/
USE Bodb_Archive_Customer_Licensee
--DROP COLUMN
ALTER TABLE dbo.CustInfo  DROP COLUMN Disable151_AU
GO
ALTER TABLE dbo.CustInfo  DROP COLUMN Disable152_AU
GO
ALTER TABLE dbo.CustInfo  DROP COLUMN Disable152_UK
GO
ALTER TABLE dbo.CustInfo  DROP COLUMN Disable153_AU
GO
ALTER TABLE dbo.CustInfo  DROP COLUMN DisableBinaryOptions
GO
ALTER TABLE dbo.CustInfo  DROP COLUMN DisableBingo
GO
ALTER TABLE dbo.CustInfo  DROP COLUMN DisableCasinoBonus
GO
ALTER TABLE dbo.CustInfo  DROP COLUMN DisableFinancial
GO
ALTER TABLE dbo.CustInfo  DROP COLUMN DisableFunP2P
GO
ALTER TABLE dbo.CustInfo  DROP COLUMN DisableHorseRacing
GO
ALTER TABLE dbo.CustInfo  DROP COLUMN DisableHRFixedOdds
GO
ALTER TABLE dbo.CustInfo  DROP COLUMN DisableLiveCasino
GO
ALTER TABLE dbo.CustInfo  DROP COLUMN DisableMicrogameLC
GO
ALTER TABLE dbo.CustInfo  DROP COLUMN DisableMicrogameRNG
GO
ALTER TABLE dbo.CustInfo  DROP COLUMN DisableOpenTote
GO
ALTER TABLE dbo.CustInfo  DROP COLUMN DisableP2P
GO
ALTER TABLE dbo.CustInfo  DROP COLUMN DisableVirtualSports
GO
ALTER TABLE dbo.CustInfo  DROP COLUMN HideVirtualSports
GO
ALTER TABLE dbo.CustInfo  DROP COLUMN isAutoResetLiveCasino
GO
ALTER TABLE dbo.CustInfo  DROP COLUMN IsAutoResetP2P
GO
ALTER TABLE dbo.CustInfo  DROP COLUMN maxpermatch151
GO
ALTER TABLE dbo.CustInfo  DROP COLUMN MaxPerMatch151_AU
GO
ALTER TABLE dbo.CustInfo  DROP COLUMN maxpermatch151_OT
GO
ALTER TABLE dbo.CustInfo  DROP COLUMN MaxPerMatch152_AU
GO
ALTER TABLE dbo.CustInfo  DROP COLUMN MaxPerMatch152_UK
GO
ALTER TABLE dbo.CustInfo  DROP COLUMN MaxPerMatch153_AU
GO
ALTER TABLE dbo.CustInfo  DROP COLUMN maxpermatch154
GO
ALTER TABLE dbo.CustInfo  DROP COLUMN maxpermatch180
GO
ALTER TABLE dbo.CustInfo  DROP COLUMN maxpermatch181
GO
ALTER TABLE dbo.CustInfo  DROP COLUMN maxpermatch182
GO
ALTER TABLE dbo.CustInfo  DROP COLUMN maxpermatch183
GO
ALTER TABLE dbo.CustInfo  DROP COLUMN maxpermatch184
GO
ALTER TABLE dbo.CustInfo  DROP COLUMN maxpermatch185
GO
ALTER TABLE dbo.CustInfo  DROP COLUMN maxpermatch186
GO
ALTER TABLE dbo.CustInfo  DROP COLUMN maxpermatch201
GO
ALTER TABLE dbo.CustInfo  DROP COLUMN MaxPerMatch44
GO
ALTER TABLE dbo.CustInfo  DROP COLUMN MaxtransferP2P
GO
ALTER TABLE dbo.CustInfo  DROP COLUMN MaxWinLiveCasino
GO
ALTER TABLE dbo.CustInfo  DROP COLUMN SyncBingo
GO
ALTER TABLE dbo.CustInfo  DROP COLUMN SyncLiveCasino
GO
