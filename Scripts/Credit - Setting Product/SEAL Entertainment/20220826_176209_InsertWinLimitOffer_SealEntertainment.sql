/*<info serverAlias="dbtxn-bodb02"></info>*/
/*
	Created: 20220826@Tacy
	Task: Insert new Product profile for SEAL Entertainment [redmine:#176078]
	DB: dbtxn/bodb02
*/

-- [Products]
INSERT INTO [Products] ([ProductID], [ProductName], [Description], [ProductPrefix], [Enabled], [BalanceType], [SubProductBalanceType], [GroupType], [CasinoType], [IsOfferPlayForFun], [EndOfSupportDate], [VendorID])
VALUES (72,'SEAL Entertainment','SEAL Entertainment','SEA',1,3,NULL,0,1,0,NULL,72)


-- [WinLimit_ProductOffer]
INSERT INTO [WinLimit_ProductOffer] ([ProductID], [BetType], [IsActive_SMA], [IsActive_Company])
VALUES (72,8900,1,0)