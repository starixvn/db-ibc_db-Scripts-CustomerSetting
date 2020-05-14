														/*
	Created: 20200513@@Johnson
	Task : monitor auto feedback[redmine:#130949]
	DB: DBCRM/bodb_CRM	
*/

--drop table #tmpFeedback
--drop table #tmpFeedback

DECLARE @LastFeedbackID INT = 848525

SELECT custid, feedbackID 
INTO #tmpFeedback
FROM crmLogFeedback WITH(NOLOCK)
WHERE FeedbackID > @LastFeedbackID
	AND UserID = 10278938 
	AND ActionID = 200
	
SELECT *
INTO #tmpFeedbackcustomer
FROM crmFeedbackcustomer WITH(NOLOCK)
WHERE FeedbackID IN (SELECT FeedbackID FROM #tmpFeedback)	
	
--get hl
create table #tblCust (custid INT,
						FeedbackID INT,
						srecommend INT,
						mrecommend INT, 
						recommend INT,
						GroupName VARCHAR(50),
						HeadlineID INT,
						HeadlineName VARCHAR(50))
		
CREATE TABLE #GroupHeadline
(
	GroupID			SMALLINT PRIMARY KEY,
	CustID			INT
)

INSERT INTO #tblCust(custid,FeedbackID)
SELECT custid, feedbackID
FROM #tmpFeedbackcustomer

UPDATE t
SET t.srecommend = c.srecommend,
	t.mrecommend = c.mrecommend,
	t.recommend = c.recommend
FROM #tblCust t 
	INNER JOIN bodb02.dbo.vw_customer c WITH(NOLOCK) ON t.custid = c.custid
	
-- Update headline
INSERT INTO #GroupHeadline (GroupID, CustID)
SELECT ca.GroupID, t.CustID
FROM DBACC.bodb02.dbo.custAccount ca WITH (NOLOCK)
	INNER JOIN DBACC.bodb02.dbo.CustGroupHeadline t WITH (NOLOCK) ON t.GroupID = ca.GroupID AND ca.custid = t.CustID
WHERE ca.IsGroupHeadLine = 1

UPDATE t
SET t.HeadlineID = hed.CustID
FROM #tblCust t	
	INNER JOIN DBACC.bodb02.dbo.custAccount ca WITH (NOLOCK) ON t.srecommend = ca.custid -- super
	INNER JOIN #GroupHeadline hed WITH (NOLOCK) ON ca.groupID = hed.groupID

UPDATE t
SET t.HeadlineID = hed.CustID
FROM #tblCust t
	INNER JOIN DBACC.bodb02.dbo.custAccount ca WITH (NOLOCK) ON t.mrecommend = ca.custid -- master
	INNER JOIN #GroupHeadline hed WITH (NOLOCK) ON ca.groupID = hed.groupID
WHERE t.HeadlineID IS NULL

UPDATE t
SET t.HeadlineID = hed.CustID
FROM #tblCust t	
	INNER JOIN DBACC.bodb02.dbo.custAccount ca WITH (NOLOCK) ON t.recommend = ca.custid -- agent
	INNER JOIN #GroupHeadline hed WITH (NOLOCK) ON ca.groupID = hed.groupID
WHERE t.HeadlineID IS NULL

UPDATE t
SET t.HeadlineID = hed.CustID
FROM #tblCust t	
	INNER JOIN DBACC.bodb02.dbo.custAccount ca WITH (NOLOCK) ON t.custid = ca.custid -- member
	INNER JOIN #GroupHeadline hed WITH (NOLOCK) ON ca.groupID = hed.groupID
WHERE t.HeadlineID IS NULL
	
UPDATE t
SET HeadlineName = c.username	
FROM #tblCust t
	INNER JOIN bodb02.dbo.vw_customer c WITH(NOLOCK) ON t.HeadlineID = c.custid
		
--check for ETUS
IF EXISTS(SELECT 1 FROM #tblCust WHERE HeadlineName = 'ETUS')
BEGIN
	--update groupname follow by super
	UPDATE t
	SET t.groupname = cg.GroupName
	FROM #tblCust t
		INNER JOIN DBACC.bodb02.dbo.Acc_CustGroup cg WITH(NOLOCK) ON t.srecommend = cg.custid
	WHERE cg.GroupName IN ('ACCYEN668','ACCYEN789','ACCYEN889')
	
	--Change hl to ET789, ET889
	;WITH tmpGroup AS (
		SELECT c.custid, c.username, g.GroupName				
		FROM bodb02.dbo.vw_customer c WITH(NOLOCK)
		INNER JOIN (SELECT 'ET789' username, 'ACCYEN668' GroupName
				UNION ALL SELECT 'ET789', 'ACCYEN789'
				UNION ALL SELECT 'ET889', 'ACCYEN889'					
			)g ON c.username = g.username			
	)
	UPDATE t
	SET t.HeadlineId = gr.custid,
		t.HeadlineName = gr.username
	FROM #tblCust t
		INNER JOIN tmpGroup gr ON gr.GroupName = t.GroupName
	
	--change hl for other vw_customers under ETUS to XT
	UPDATE t
	SET t.HeadlineID = c.custid,
		t.HeadlineName = c.username
	FROM #tblCust t
		CROSS APPLY (SELECT custid, username FROM bodb02.dbo.vw_customer WITH(NOLOCK) WHERE username = 'XT') c
	WHERE HeadlineName = 'ETUS'
END

--check for vw_customer without group, assign to direct vw_customer
IF EXISTS(SELECT TOP (1) 1 FROM #tblCust WHERE headlineID IS NULL)
BEGIN
	--hl is super
	UPDATE t
	SET t.headlineID = c.custid,
		t.HeadlineName = c.username
	FROM #tblCust t
		CROSS APPLY (SELECT custid,username FROM bodb02.dbo.vw_customer c WITH(NOLOCK) WHERE c.custid = t.srecommend)c
	WHERE headlineID IS NULL
		AND NOT EXISTS(SELECT 1 
					FROM DBACC.bodb02.dbo.Acc_CustDirect c WITH(NOLOCK)
					WHERE t.srecommend = c.custid
					)
		AND NOT EXISTS(SELECT 1 
					FROM DBACC.bodb02.dbo.Acc_CustDirect c WITH(NOLOCK)
					WHERE t.mrecommend = c.custid
					)
		AND NOT EXISTS(SELECT 1 
					FROM DBACC.bodb02.dbo.Acc_CustDirect c WITH(NOLOCK)
					WHERE t.recommend = c.custid
					)
					
	--hl is direct master
	UPDATE t
	SET t.headlineID = c.custid,
		t.HeadlineName = c.username
	FROM #tblCust t
		CROSS APPLY (SELECT custid,username FROM bodb02.dbo.vw_customer c WITH(NOLOCK) WHERE c.custid = t.mrecommend)c
	WHERE headlineID IS NULL
		AND NOT EXISTS(SELECT 1 
					FROM DBACC.bodb02.dbo.Acc_CustDirect c WITH(NOLOCK)
					WHERE t.mrecommend = c.custid
					)	
		AND NOT EXISTS(SELECT 1 
					FROM DBACC.bodb02.dbo.Acc_CustDirect c WITH(NOLOCK)
					WHERE t.recommend = c.custid
					)
					
	--hl is direct agent
	UPDATE t
	SET t.headlineID = c.custid,
		t.HeadlineName = c.username
	FROM #tblCust t
		CROSS APPLY (SELECT custid,username FROM bodb02.dbo.vw_customer c WITH(NOLOCK) WHERE c.custid = t.recommend)c
	WHERE headlineID IS NULL
		AND NOT EXISTS(SELECT 1 
					FROM DBACC.bodb02.dbo.Acc_CustDirect c WITH(NOLOCK)
					WHERE t.recommend = c.custid
					)
						
	--hl is direct member
	UPDATE t
	SET t.headlineID = c.custid,
		t.HeadlineName = c.username
	FROM #tblCust t
		CROSS APPLY (SELECT custid,username FROM bodb02.dbo.vw_customer c WITH(NOLOCK) WHERE c.custid = t.custid)c
	WHERE headlineID IS NULL
		AND NOT EXISTS(SELECT 1 
					FROM DBACC.bodb02.dbo.Acc_CustDirect c WITH(NOLOCK)
					WHERE t.custid = c.custid
					)					
END

SELECT t.custid relatedCustid,
	c1.username as relatedUsername,		
	t.HeadlineID,
	t.HeadlineName,
	t.FeedbackID,
	hl.custid hlIDFeedback,
	c2.username hlUsernameFeedback
FROM #tblCust t
	INNER JOIN 	bodb02.dbo.vw_customer c1 (nolock) on t.custid = c1.custid 
	INNER JOIN #tmpFeedback hl ON t.FeedbackID = hl.FeedbackID
	INNER JOIN 	bodb02.dbo.vw_customer c2 (nolock) on hl.custid = c2.custid 
WHERE t.HeadlineID <> hl.custid


SELECT t.custid relatedCustid,
	c1.username as relatedUsername,		
	t.HeadlineID,
	t.HeadlineName,
	t.FeedbackID,
	hl.custid hlIDFeedback,
	c.username hlUsernameFeedback 
FROM #tblCust t
	INNER JOIN 	bodb02.dbo.vw_customer c1 (nolock) on t.custid = c1.custid 
	LEFT JOIN #tmpFeedback hl ON t.FeedbackID = hl.FeedbackID
	INNER JOIN bodb02.dbo.vw_customer c (nolock) on hl.custid = c.custid 
--select top 10 * from crmLogFeedback where UserID = 10278938  order by FeedbackID DESC

--select top 10 * from crmFeedbackvw_customer order by FeedbackID DESC