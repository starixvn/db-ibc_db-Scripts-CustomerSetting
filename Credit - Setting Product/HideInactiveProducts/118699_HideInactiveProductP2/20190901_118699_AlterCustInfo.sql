/*	
	Created: 20190901@Elodie
	Task: Alter CustInfo_History
	Redmine: https://redmine.nexcel.vn/issues/118699
	DB: DBTP/bodb_CustHistory
*/
USE bodb_CustHistory
GO 

ALTER TABLE dbo.CustInfo_History ALTER COLUMN DisableHorseRacing BIT NULL
ALTER TABLE dbo.CustInfo_History ALTER COLUMN DisableFinancial BIT NULL
ALTER TABLE dbo.CustInfo_History ALTER COLUMN DisableOpenTote BIT NULL
ALTER TABLE dbo.CustInfo_History ALTER COLUMN maxpermatch151_OT MONEY NULL
ALTER TABLE dbo.CustInfo_History ALTER COLUMN DisableBingo BIT NULL
ALTER TABLE dbo.CustInfo_History ALTER COLUMN SyncBingo BIT NULL
ALTER TABLE dbo.CustInfo_History ALTER COLUMN MaxPerMatch151_AU MONEY NULL
ALTER TABLE dbo.CustInfo_History ALTER COLUMN MaxPerMatch152_UK MONEY NULL
ALTER TABLE dbo.CustInfo_History ALTER COLUMN MaxPerMatch152_AU MONEY NULL
ALTER TABLE dbo.CustInfo_History ALTER COLUMN MaxPerMatch153_AU MONEY NULL
ALTER TABLE dbo.CustInfo_History ALTER COLUMN Disable151_AU BIT NULL
ALTER TABLE dbo.CustInfo_History ALTER COLUMN Disable152_UK BIT NULL
ALTER TABLE dbo.CustInfo_History ALTER COLUMN Disable152_AU BIT NULL
ALTER TABLE dbo.CustInfo_History ALTER COLUMN Disable153_AU BIT NULL
ALTER TABLE dbo.CustInfo_History ALTER COLUMN MaxtransferP2P MONEY NULL
ALTER TABLE dbo.CustInfo_History ALTER COLUMN IsAutoResetP2P BIT NULL
ALTER TABLE dbo.CustInfo_History ALTER COLUMN DisableP2P BIT NULL
ALTER TABLE dbo.CustInfo_History ALTER COLUMN DisableFunP2P BIT NULL
ALTER TABLE dbo.CustInfo_History ALTER COLUMN DisableLiveCasino BIT NULL
ALTER TABLE dbo.CustInfo_History ALTER COLUMN SyncLiveCasino BIT NULL
ALTER TABLE dbo.CustInfo_History ALTER COLUMN DisableVirtualSports BIT NULL
ALTER TABLE dbo.CustInfo_History ALTER COLUMN HideVirtualSports BIT NULL
ALTER TABLE dbo.CustInfo_History ALTER COLUMN isAutoResetLiveCasino BIT NULL
ALTER TABLE dbo.CustInfo_History ALTER COLUMN MaxWinLiveCasino SMALLMONEY NULL
ALTER TABLE dbo.CustInfo_History ALTER COLUMN DisableCasinoBonus BIT NULL