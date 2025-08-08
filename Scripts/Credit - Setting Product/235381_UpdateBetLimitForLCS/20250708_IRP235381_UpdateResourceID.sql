/*<info serverAlias="DBGLOB-GlobCustDB" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250807@Johnson	
	Task: update resourceid for new stakelevel Live Casino [redmine:#235381]
	DB: DBGLOB-GlobCustDB
*/

--run on PRO
UPDATE s
SET s.ResourceID = CASE WHEN GameTypeID = 3151 AND MinStake = 500 THEN '12,55,40'--Yeebet
                        WHEN GameTypeID = 3151 AND MinStake = 1000 THEN '55,40,88'
                        WHEN GameTypeID = 12000 AND MinStake = 500 THEN '62,83,33'--W Casino
                        WHEN GameTypeID = 12000 AND MinStake = 1000 THEN '83,33,56' 
                        WHEN GameTypeID = 3101 AND MinStake = 1000 THEN '580615'--AE Sexy
                        WHEN GameTypeID = 3101 AND MinStake = 3000 THEN '580616' 
                        ELSE ResourceID END,
    RepUpdateTime = dbo.f_GetDateTime2()
FROM StakeLevel s WITH (ROWLOCK)
WHERE ExchangeId IN (15,22,33,34,47) --IN,IND,IDD,IDR,DDD
    AND 1 = CASE WHEN GameTypeID = 3151 AND MinStake IN (500,1000) AND MaxStake IN (200000,300000) THEN 1 --Yeebet                
                WHEN GameTypeID = 12000 AND MinStake IN (500,1000) AND MaxStake IN (100000,300000) THEN 1 --W Casino
                WHEN GameTypeID = 3101 AND MinStake IN (1000 ,3000) AND MaxStake IN (100000,300000) THEN 1 --AE Sexy
                ELSE 0 END
GO

--Run on SIT
UPDATE s
SET s.ResourceID = CASE WHEN GameTypeID = 3151 AND MinStake = 500 THEN '12,55,28'--Yeebet
                        WHEN GameTypeID = 3151 AND MinStake = 1000 THEN '55,28,87'
                        WHEN GameTypeID = 12000 AND MinStake = 500 THEN '12,55,56'--W Casino
                        WHEN GameTypeID = 12000 AND MinStake = 1000 THEN '55,56,87' 
                        WHEN GameTypeID = 3101 AND MinStake = 1000 THEN '580615'--AE Sexy
                        WHEN GameTypeID = 3101 AND MinStake = 3000 THEN '580616' 
                        ELSE ResourceID END,
    RepUpdateTime = dbo.f_GetDateTime2()
FROM StakeLevel s WITH (ROWLOCK)
WHERE ExchangeId IN (15,22,33,34,47) --IN,IND,IDD,IDR,DDD
    AND 1 = CASE WHEN GameTypeID = 3151 AND MinStake IN (500,1000) AND MaxStake IN (200000,300000) THEN 1 --Yeebet                
                WHEN GameTypeID = 12000 AND MinStake IN (500,1000) AND MaxStake IN (100000,300000) THEN 1 --W Casino
                WHEN GameTypeID = 3101 AND MinStake IN (1000 ,3000) AND MaxStake IN (100000,300000) THEN 1 --AE Sexy
                ELSE 0 END
