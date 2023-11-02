/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20231031@Johnson
	Task: update global bet limit setting for SG, Joker [redmine: #196182]
	DB: DBCUST/CustDB
*/

;WITH T AS(
SELECT 	1	CreditGroupID,	0.01	MinBet,	25000 MaxBet
UNION ALL SELECT 	2	,	0.01	,	250000
UNION ALL SELECT 	3	,	0.01	,	25000
UNION ALL SELECT 	4	,	0.01	,	25000
UNION ALL SELECT 	5	,	0.01	,	250000
UNION ALL SELECT 	6	,	0.01	,	25000
UNION ALL SELECT 	7	,	0.01	,	500000
UNION ALL SELECT 	8	,	0.01	,	50000000
UNION ALL SELECT 	10	,	0.01	,	25000
UNION ALL SELECT 	11	,	0.01	,	1250000
)
UPDATE p
SET p.MinBet = t.MinBet,
	p.MaxBet = t.MaxBet,
	p.RepUpdateTime = SYSDATETIME()
FROM ProductStakeLevelGroup p WITH(ROWLOCK)
	INNER JOIN T on p.CreditGroupID = t.CreditGroupID
WHERE  Sporttype = 247 --SG
	AND GameGroupID = 2--Others
	
UPDATE p
SET p.MinBet = 0.01,	
	p.RepUpdateTime = SYSDATETIME()
FROM ProductStakeLevelGroup p WITH(ROWLOCK)	
WHERE Sporttype = 234 --Joker
	AND GameGroupID = 1--Slot Game
	AND CreditGroupID IN (1,2,3,6,7,8,11)
	
;WITH T AS(
	SELECT 		1	LicenseeGroupID,	0.01	MinBet,	25000 MaxBet
UNION ALL SELECT 	2	,	0.01	,	25000
UNION ALL SELECT 	3	,	0.01	,	500000
UNION ALL SELECT 	4	,	0.01	,	25000
UNION ALL SELECT 	5	,	0.01	,	250000
UNION ALL SELECT 	6	,	0.01	,	25000
UNION ALL SELECT 	7	,	0.01	,	250000
UNION ALL SELECT 	8	,	0.01	,	500000
UNION ALL SELECT 	10	,	0.01	,	50000000
UNION ALL SELECT 	13	,	0.01	,	1250000
UNION ALL SELECT 	14	,	0.01	,	500000
UNION ALL SELECT 	15	,	0.01	,	500000
UNION ALL SELECT 	16	,	0.01	,	25000
UNION ALL SELECT 	17	,	0.01	,	1250000
)	
UPDATE p
SET p.MinBet = t.MinBet,
	p.MaxBet = t.MaxBet,
	p.RepUpdateTime = SYSDATETIME()
FROM Dep_ProductStakeLevelGroup p WITH(ROWLOCK)
	INNER JOIN T on p.LicenseeGroupID = t.LicenseeGroupID
WHERE  Sporttype = 247 --SG
	AND GameGroupID = 2--Others
	
UPDATE p
SET p.MinBet = 0.01,	
	p.RepUpdateTime = SYSDATETIME()
FROM Dep_ProductStakeLevelGroup p WITH(ROWLOCK)	
WHERE Sporttype = 234 --Joker
	AND GameGroupID = 1--Slot Game
	AND LicenseeGroupID IN (1,2,3,4,5,6,7,10,15,16)

--update for currency ARS
declare @new_LicenseeGroupID tinyint

select @new_LicenseeGroupID=Max(LicenseeGroupID) + 1
from exchange with (nolock)

--select @new_LicenseeGroupID

update exchange with (updlock, rowlock)
set LicenseeGroupID=@new_LicenseeGroupID
, RepUpdateTime=SYSDATETIME()
where currency= 'ARS'	

INSERT INTO [dbo].[Dep_ProductStakeLevelGroup]
           ([Sporttype]
           ,[GameGroupID]
           ,[MinBet]
           ,[MaxBet]
           ,[LicenseeGroupID]
           ,[Remark]
           ,[RepUpdateTime]
           ,[isDeleted]
           ,[SiteID])
SELECT 172,1,0.01,350000, @new_LicenseeGroupID,NULL,SYSDATETIME(),0,0--AdvantPlay
UNION SELECT 174,2,0.01,350000, @new_LicenseeGroupID,NULL,SYSDATETIME(),0,0--AdvantPlay Mini
UNION SELECT 165,2,0.01,350000, @new_LicenseeGroupID,NULL,SYSDATETIME(),0,0--AdvantPlay Mini