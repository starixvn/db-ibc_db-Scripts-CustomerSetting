/*<info serverAlias="DBMSG-bodb_Message"></info>*/
/*
	Created: Eden@20210618
	Task: sync data from old server to new server [Redmine: #157216]   
	DB: DBMSG/bodb_Message
*/
USE bodb_Message
GO

DECLARE @syncFromDate DATETIME = '2021/06/18 05:00:00' --Date begin sync data

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
FROM db05bk1.bodb_Message.dbo.MsgCustReadStatus s WITH(NOLOCK)
	LEFT JOIN MsgCustReadStatus d WITH(NOLOCK) ON s.CustID = d.CustID AND s.SubAccID = d.SubAccID
WHERE d.CustID IS NULL
	AND s.LastSeenSystemUpdMsg >= @syncFromDate
	AND s.LastSeenNormalMsg > = @syncFromDate
	AND s.LastSeenPersonalMsg >= @syncFromDate
	AND s.LastSeenSpecialMsg > = @syncFromDate