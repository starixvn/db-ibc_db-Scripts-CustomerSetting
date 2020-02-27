/*
	Created: Eden
	Date: 20200226
	Task: migarte data for table VRSetting_AutoUpdate_VirtualRate [Redmine:#129279]	
	DB: DBCust/CustDB
*/
TRUNCATE TABLE VRSettingAutoUpdate

INSERT INTO VRSettingAutoUpdate(
	 CustId
	,IsLive
	,SportType
	,VRLeagueGroupId
	,VRBettypeGroupId
	,Bettype
	,VirtualMultiplier
	,CreatedDate
)
SELECT cv.CustId
	,IsLive
	,SportId
	,VRLeagueGroupId
	,VRBettypeGroupId
	,BettypeId
	,cv.VirtualMultiplier
	,CreatedDate
FROM DBDW2.bodb_VR2Model.[dbo].[VR2Model_VirtualRate] cv WITH (NOLOCK)
	INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = cv.CustId
UNION ALL
SELECT cv.CustId
	,IsLive
	,SportId
	,VRLeagueGroupId
	,VRBettypeGroupId
	,BettypeId
	,cv.VirtualMultiplier
	,CreatedDate
FROM DBDW2.bodb_VR2Model.[dbo].[VR2Model_VirtualRate] cv WITH (NOLOCK)
WHERE cv.CustId = 0
UNION ALL
SELECT CustId
	,IsLive
	,SportId
	,VRLeagueGroupId = -1
	,VRBettypeGroupId
	,BettypeId
	,VirtualMultiplier
	,CreatedDate
FROM DBDW2.bodb_VR2Model.[dbo].[VR2Model_VirtualRate] WITH (NOLOCK)
WHERE VRLeagueGroupId = 11 AND VRBettypeGroupId = -1 AND BettypeId = -1 AND CustID = 0



