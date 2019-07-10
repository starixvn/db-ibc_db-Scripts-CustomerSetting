/*
	Created: 20190621@Winnie
	Task: Update Stake Level for Card Club
	DB: DBCUST/CustDB
*/
UPDATE t
SET MinLabel=CAST(CAST(t.MinStake AS float) AS NVARCHAR(50)),
MaxLabel=CAST(CAST(t.MaxStake AS float) AS NVARCHAR(50))
FROM StakeLevelGroupDetail t WITH(ROWLOCK,UPDLOCK)
WHERE GameTypeID=1901