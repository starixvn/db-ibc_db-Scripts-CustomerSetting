/*
	Created: 20200610@Eden
	Task: Initial Setting for Global Level - BasketBall VR [Redmine: #134978]
	DB: DBCUST/CustDB
*/
USE CustDB
----------------INSERT GLOBAL VALUES---------------------
DECLARE @GlobalValues_Tbl TABLE(
	 BettypeGroupName NVARCHAR(200)
	,Sporttype INT DEFAULT 2
	,GlobalNonlive SMALLMONEY
	,GlobalLive SMALLMONEY
	,VRBettypeGroupID INT 
	)
INSERT INTO @GlobalValues_Tbl(BettypeGroupName,GlobalNonlive,GlobalLive) VALUES ('Handicap', 0.1, 0.12)
INSERT INTO @GlobalValues_Tbl(BettypeGroupName,GlobalNonlive,GlobalLive) VALUES ('Over/Under', 0.08, 0.08)
INSERT INTO @GlobalValues_Tbl(BettypeGroupName,GlobalNonlive,GlobalLive) VALUES ('Odd/Even', 0.15, 0.15)
INSERT INTO @GlobalValues_Tbl(BettypeGroupName,GlobalNonlive,GlobalLive) VALUES ('Moneyline', 0.15, 0.15)
INSERT INTO @GlobalValues_Tbl(BettypeGroupName,GlobalNonlive,GlobalLive) VALUES ('SportLeague', 0.15, 0.15)

UPDATE tmp
SET tmp.VRBettypeGroupID = ISNULL(btg.GroupID,-1)
FROM @GlobalValues_Tbl tmp
	LEFT  JOIN VRBettypeGroup btg WITH(NOLOCK) ON btg.GroupName = tmp.BettypeGroupName AND btg.SportType = tmp.Sporttype

DELETE vr
--SELECT vr.*
FROM VRCustSetting vr WITH(ROWLOCK)
	INNER JOIN VRSettingHierarchy h WITH(NOLOCK) ON vr.LevelID = h.LevelID
WHERE vr.CustID = 0 AND h.SportType = 2

INSERT INTO VRCustSetting (CustID,LevelID,ValueIDLIVE,ValueIDNonLIVE)
SELECT 0 AS CustID
	,h.LevelID
	,ValueLive.ValueID
	,ValueNonLive.ValueID
FROM @GlobalValues_Tbl tmp
	INNER JOIN VRSettingHierarchy h WITH(NOLOCK) ON h.VRBetTypeGroupID = tmp.VRBettypeGroupID AND tmp.Sporttype = h.SportType
	INNER JOIN VRValueMapping ValueLive WITH(NOLOCK) ON ValueLive.Value = tmp.GlobalLive
	INNER JOIN VRValueMapping ValueNonLive WITH(NOLOCK) ON ValueNonLive.Value = tmp.GlobalNonlive
WHERE h.BetType = -1
