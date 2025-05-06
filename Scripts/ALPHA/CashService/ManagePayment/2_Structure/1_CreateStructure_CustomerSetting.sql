/*<info serverAlias="DBCUST-GlobCustDB"></info>*/
/*
	Created: 20250417@Helios
	Task: Alpha - Agency Cash Service - [223896]  
	DB: DBCUST/CustDB
*/

--*************************Customer Setting*************************






---- Check and update CustProductStatus table
--IF COL_LENGTH('CustProductStatus', 'ServiceType') IS NULL
--BEGIN
--    ALTER TABLE CustProductStatus ADD ServiceType TINYINT NOT NULL DEFAULT 0;
--END;

---- Check and update ProductSettingProfile table
--IF COL_LENGTH('ProductSettingProfile', 'OfferType') IS NULL
--BEGIN
--    ALTER TABLE ProductSettingProfile ADD OfferType TINYINT NOT NULL DEFAULT 0;
--END;


---- Dữ liệu cho SiteId = 22
--INSERT INTO CashBankConfig (SiteId, BankID)
--VALUES
--(22, 1), (22, 2), (22, 3), (22, 4), (22, 5),
--(22, 6), (22, 7), (22, 8), (22, 9), (22, 10),
--(22, 11), (22, 12), (22, 13), (22, 14), (22, 15),
--(22, 16), (22, 17), (22, 18), (22, 19), (22, 20),
--(22, 21), (22, 22), (22, 23), (22, 24), (22, 25),
--(22, 26), (22, 27);

---- Dữ liệu cho SiteId = 1233
--INSERT INTO CashBankConfig (SiteId, BankID)
--VALUES
--(1233, 1), (1233, 2), (1233, 3), (1233, 4), (1233, 5),
--(1233, 6), (1233, 7), (1233, 8), (1233, 9), (1233, 10),
--(1233, 11), (1233, 12), (1233, 13), (1233, 14), (1233, 15),
--(1233, 16), (1233, 17), (1233, 18), (1233, 19), (1233, 20),
--(1233, 21), (1233, 22), (1233, 23), (1233, 24), (1233, 25),
--(1233, 26), (1233, 27);
