/*<info serverAlias="dbtxn-bodb02"></info>*/
/*
	Created: 20220829@Tacy
	Task: Insert new Product profile for Microgaming [redmine:#175853]
	DB: dbtxn/bodb02
*/

-- [Products]
INSERT INTO [Products] ([ProductID], [ProductName], [Description], [ProductPrefix], [Enabled], [BalanceType], [SubProductBalanceType], [GroupType], [CasinoType], [IsOfferPlayForFun], [EndOfSupportDate], [VendorID])
VALUES (73,'MG','Microgaming ','MGRNG',1,3,NULL,0,1,0,NULL,73)


-- [WinLimit_ProductOffer]
INSERT INTO [WinLimit_ProductOffer] ([ProductID], [BetType], [IsActive_SMA], [IsActive_Company])
VALUES (73,8400,1,0)