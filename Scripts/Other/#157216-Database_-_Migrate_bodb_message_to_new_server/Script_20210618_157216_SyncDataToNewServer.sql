/*<info serverAlias="DBMSG-bodb_Message"></info>*/
/*
	Created: Eden@20210618
	Task: sync data from old server to new server [Redmine: #157216]   
	DB: DBMSG/bodb_Message
*/
USE bodb_Message
GO

CREATE TABLE #temp(
	 CustID               INT, 
	 SubAccID             INT, 
	 LastSeenNormalMsg    DATETIME, 
	 LastSeenPersonalMsg  DATETIME, 
	 LastSeenSpecialMsg   DATETIME, 
	 LastSeenSystemUpdMsg DATETIME
)

INSERT INTO #temp (
	CustId
	,SubAccId
	,LastSeenNormalMsg
	,LastSeenPersonalMsg
	,LastSeenSpecialMsg
	,LastSeenSystemUpdMsg
)
SELECT CustId
	,SubAccId
	,LastSeenNormalMsg
	,LastSeenPersonalMsg
	,LastSeenSpecialMsg
	,LastSeenSystemUpdMsg
FROM OPENQUERY (DB05BK1, '
	SELECT s.CustId
		,s.SubAccId
		,s.LastSeenNormalMsg
		,s.LastSeenPersonalMsg
		,s.LastSeenSpecialMsg
		,s.LastSeenSystemUpdMsg 
	FROM bodb_Message.dbo.MsgCustReadStatus s WITH(NOLOCK)
	WHERE s.LastSeenSystemUpdMsg >= ''2021/06/18 05:00:00''
			AND s.LastSeenNormalMsg > = ''2021/06/18 05:00:00''
			AND s.LastSeenPersonalMsg >= ''2021/06/18 05:00:00''
			AND s.LastSeenSpecialMsg > = ''2021/06/18 05:00:00''
	')

--> MsgCustReadStatus
INSERT INTO dbo.MsgCustReadStatus (
				CustId
				,SubAccId
				,LastSeenNormalMsg
				,LastSeenPersonalMsg
				,LastSeenSpecialMsg
				,LastSeenSystemUpdMsg
				)
SELECT s.CustId
	,s.SubAccId
	,s.LastSeenNormalMsg
	,s.LastSeenPersonalMsg
	,s.LastSeenSpecialMsg
	,s.LastSeenSystemUpdMsg 
FROM #temp s
	LEFT JOIN MsgCustReadStatus d WITH(NOLOCK) ON s.CustID = d.CustID AND s.SubAccID = d.SubAccID
WHERE d.CustID IS NULL