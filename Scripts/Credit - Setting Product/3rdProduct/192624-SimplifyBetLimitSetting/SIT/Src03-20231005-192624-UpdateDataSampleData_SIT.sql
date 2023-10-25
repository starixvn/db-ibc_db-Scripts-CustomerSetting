/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: Tacy@20231005
	Task: INITIAL sample data for testing - SIT [Redmine:#194624] 
	DB:	DBCUST-CustDB
*/
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
--Exchange
UPDATE [exchange] WITH (ROWLOCK, UPDLOCK)
SET CreditGroupID = NULL,
	LicenseeGroupID = NULL,
	RepUpdateTime = SYSDATETIME()
WHERE CreditGroupID IS NOT NULL OR LicenseeGroupID IS NOT NULL

--init currency group
UPDATE [exchange] WITH (ROWLOCK, UPDLOCK)
SET CreditGroupID = CASE WHEN OfferSite IN (1,0) THEN
						CASE WHEN currency IN ('RM', 'HKK') THEN 1
							 WHEN currency IN ('YEN', 'US$', '$US', 'UT', 'USD') THEN 2
							 WHEN currency IN ('RMB') THEN 3
							 WHEN currency IN ('GBP') THEN 5
							 WHEN currency IN ('UUS') THEN 6
						END
					END,
	LicenseeGroupID = CASE WHEN OfferSite IN (2,0) THEN
						CASE WHEN currency IN ('RMB') THEN 1
							 WHEN currency IN ('RM') THEN 2
							 WHEN currency IN ('GBP') THEN  4
							 WHEN currency IN ('EURO') THEN  5
							 WHEN currency IN ('TB') THEN 6
						END
					END,
	RepUpdateTime = SYSDATETIME()
WHERE currency in ('RM','Yen','HKK','RMB','GBP','UUS','EURO','US$','$US','UT','USD','TB')

----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
--ProductStakeLevelGroup
INSERT INTO [ProductStakeLevelGroup]([Sporttype], [GameGroupID], [CreditGroupID], [MinBet], [MaxBet], [Remark])
SELECT 248, 1, 1, 0.1, 10000, NULL
UNION
SELECT 248, 2, 1, 0.1, 2500, NULL
UNION
SELECT 247, 1, 1, 0.1, 10000, NULL
UNION
SELECT 247, 2, 1, 0.1, 2500, NULL
UNION
SELECT 247, 1, 2, 0.1, 2500, NULL
UNION
SELECT 247, 2, 2, 0.1, 500, NULL
UNION
SELECT 156, 1, 6, 0.1, 1000, NULL
UNION
SELECT 247, 1, 3, 0.1, 7500, NULL
UNION
SELECT 247, 2, 3, 0.1, 2000, NULL

----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
--Dep_ProductStakeLevelGroup
INSERT INTO [Dep_ProductStakeLevelGroup]([Sporttype], [GameGroupID], [LicenseeGroupID], [MinBet], [MaxBet], [Remark])
SELECT 232, 1, 5, 0.01, 1000, NULL
UNION
SELECT 248, 1, 1, 0.01, 8000, NULL
UNION
SELECT 248, 2, 1, 0.01, 4000, NULL
UNION
SELECT 248, 1, 2, 0.01, 5000, NULL
UNION
SELECT 248, 2, 2, 0.01, 2500, NULL