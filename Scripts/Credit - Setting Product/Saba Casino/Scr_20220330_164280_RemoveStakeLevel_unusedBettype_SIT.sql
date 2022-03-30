/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20220330@Eden
	Task: Remove stake level for remove 5 games bellow: ALL CURRENCY- SIT
			2155 Chinese Zodiac
			2162 Football Fans
			2111 Roulette Pro (Fast)
			2178 Baccarat(Progressive JP)
			2151 Fox Force 5[#164280]
	DB: DBCUST/CustDB
*/

USE CustDB
GO

DELETE sl
FROM StakeLevelGroupDetail SL WITH (NOLOCK)
	INNER JOIN StakeLevel s WITH(NOLOCK)ON sl.StakeLevelID = s.StakeLevelID
WHERE S.GameTypeID = 2101
AND sl.GameTypeID IN(2155,2162,2111,2178,2151)