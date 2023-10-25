/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: Tacy@20231004
	Task: initial sample data for testing - SIT [Redmine:#194624] 
	DB:	DBCUST-CustDB
*/
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
--Exchange
UPDATE [exchange] WITH (ROWLOCK, UPDLOCK)
SET CreditGroupID = CASE WHEN OfferSite IN (1,0) THEN
						CASE WHEN currency IN ('RM','HKK') THEN 1
							 WHEN currency IN ('YEN','CY','USTM') THEN 2
							 WHEN currency IN ('RMB') THEN 3
							 WHEN currency IN ('GBP') THEN 5
							 WHEN currency IN ('EURO') THEN 6
						END
					END,
	LicenseeGroupID = CASE WHEN OfferSite IN (2,0) THEN
						CASE WHEN currency IN ('RM','RMB','YUN') THEN 1
							 WHEN currency IN ('GBP') THEN 4
							 WHEN currency IN ('EURO') THEN 5
						END
					END,
	RepUpdateTime = SYSDATETIME()
WHERE currency in ('RM', 'HKK','YEN','CY','USTM','EURO','RMB','YUN','GBP')

----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
--ProductStakeLevelGroup
INSERT INTO [ProductStakeLevelGroup]([Sporttype], [GameGroupID], [CreditGroupID], [MinBet], [MaxBet], [Remark])
SELECT 248, 1, 1, 0.01, 400, N'Buy bonus feature x50'
UNION
SELECT 248, 2, 1, 0.01, 1000, NULL
UNION
SELECT 247, 1, 1, 0.01, 400, NULL
UNION
SELECT 247, 2, 1, 0.01, 1000, NULL
UNION
SELECT 247, 1, 2, 10, 500, NULL
UNION
SELECT 247, 2, 2, 10, 1000, NULL
UNION
SELECT 156, 1, 6, 0.01, 500, NULL
UNION
SELECT 247, 1, 3, 0.01, 300, NULL
UNION
SELECT 247, 2, 3, 0.01, 700, NULL



----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
--Dep_ProductStakeLevelGroup
INSERT INTO [Dep_ProductStakeLevelGroup]([Sporttype], [GameGroupID], [LicenseeGroupID], [MinBet], [MaxBet], [Remark])
SELECT 232, 1, 5, 0.01, 500, NULL
UNION
SELECT 248, 1, 1, 0.01, 400, N'Buy bonus feature x5'
UNION
SELECT 248, 2, 1, 0.01, 600, NULL
GO