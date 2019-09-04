/*
	Created: 20190904@Johnson
	Task: data patch for headline message
	DB: DBCUST/CustDB
*/

CREATE TABLE #Headline (HeadlineID INT)

INSERT INTO #Headline(HeadlineID)
SELECT custid
FROM dbo.customer ci WITH(NOLOCK)
WHERE roleid = 0
	AND site = 'CN88'
	
INSERT INTO DBMSG.bodb_Message.dbo.MsgCustReadStatus (
				CustId
				,SubAccId
				,LastSeenNormalMsg
				,LastSeenPersonalMsg
				,LastSeenSpecialMsg
				,LastSeenSystemUpdMsg
				)	
SELECT h.HeadlineID
	,0
	,GETDATE()
	,GETDATE()
	,GETDATE()
	,GETDATE()
FROM #Headline h 
	LEFT JOIN DBMSG.bodb_Message.dbo.MsgCustReadStatus s WITH(NOLOCK) ON h.HeadlineID = s.custid
WHERE s.custid IS NULL				
	