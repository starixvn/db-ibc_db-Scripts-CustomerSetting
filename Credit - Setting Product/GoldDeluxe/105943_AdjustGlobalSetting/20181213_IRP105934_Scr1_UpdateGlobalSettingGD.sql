/*
	Created: Johnson
	Date: 20181213
	Task: adjust global settings for GD [Redmine: #105934]
	DB: DBCUST/CUSTDB
*/


--Adjust global settings for GoldDeluxe
;WITH tmpStake AS
(
	SELECT 	187	as StakeLevelID,	1701	GameTypeID,	5.00000000	MinStake,	1000.00000000	MaxStake,	'5'	MinLabel,	'1,000' MaxLabel,	1 ResourceID
UNION SELECT 	188	,	1701	,	20.00000000	,	2500.00000000	,	'20'	,	'2,500'	,	2
UNION SELECT 	189	,	1701	,	100.00000000	,	5000.00000000	,	'100'	,	'5,000'	,	3
UNION SELECT 	190	,	1701	,	250.00000000	,	10000.00000000	,	'250'	,	'10,000'	,	4
UNION SELECT 	328	,	1702	,	1.00000000	,	1000.00000000	,	'1'	,	'1,000'	,	1
UNION SELECT 	329	,	1702	,	5.00000000	,	5000.00000000	,	'5'	,	'5,000'	,	2
UNION SELECT 	330	,	1702	,	10.00000000	,	10000.00000000	,	'10'	,	'10,000'	,	3
)

UPDATE st
SET st.MinStake = t.MinStake,
	st.MaxStake = t.MaxStake,
	st.MinLabel = t.MinLabel,
	st.MaxLabel = t.MaxLabel,
	st.ResourceID = t.ResourceID
FROM StakeLevel st WITH(UPDLOCK,ROWLOCK)
	INNER JOIN tmpStake t ON st.StakeLevelID = t.StakeLevelID
GO