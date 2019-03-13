/*
	Created: 20190313@Johnson
	Task: insert profile setting for PP
	DB: DBCUST/CustDB
*/
use CustDB
go

INSERT INTO [dbo].[Dep_StakeLevel]
           ([StakeLevelID]
           ,[GameTypeID]
           ,[GameGroupID]
           ,[ExchangeID]
           )
 SELECT 	497	,	4101	,	8	,	3
UNION SELECT 	504	,	4101	,	8	,	15