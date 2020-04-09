/*
	Created: 20200409@Elodie
	Task: Update stake level for Saba.club
	DB: DBCUST/CustDB
*/

USE CustDB
GO

UPDATE st 
SET st.MaxLabel = '500',
	st.MaxStake = 500
FROM dbo.StakeLevelGroupDetail st WITH (ROWLOCK)
WHERE GameTypeID = 1611 

SELECT * FROM dbo.StakeLevelGroupDetail WITH (NOLOCK) WHERE GameTypeID = 1611

