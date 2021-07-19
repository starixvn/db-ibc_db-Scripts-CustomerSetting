/*
	Created: 20200831@Johnson
	Task: migrate data for crmAutoFeedbackInfo
	DB: DBCRM/bodb_CRM
*/
--Migrate data from crmMessageImport_tmp to new table crmMessageImport

INSERT INTO crmMessageImport(MessageId,RequestID,CreatedDate,IsProcessed)
SELECT DISTINCT vh.MessageId, vh.RequestId,GETDATE(),0
FROM dbacc.bodb02.dbo.TicketVoiding_VoidingHistory vh WITH(NOLOCK)
	INNER JOIN dbacc.bodb02.dbo.TicketVoiding_Request r WITH (NOLOCK) ON vh.RequestId = r.RequestId 
														AND r.IssueTypeId = 11 --abnormal bets
WHERE vh.CreatedDate >= GETDATE() - 2
	AND vh.StatusId = 2 --tickets void successfully
ORDER BY MessageId ASC 

--update isProcessed for msg already created fb
UPDATE c
SET c.CreatedDate = t.CreatedDate,
	c.IsProcessed = t.IsProcessed
FROM crmMessageImport c WITH(UPDLOCK,ROWLOCK)
	INNER JOIN crmMessageImport_tmp t WITH(NOLOCK) ON c.MessageID = t.MessageID
GO


-------------------------------------------------------------------
--Migrate data from crmAutoFeedbackInfo_tmp to crmAutoFeedbackInfo 

CREATE TABLE #VoidingHistory (VoidingHistoryId INT, RequestId INT, MessageId INT, TransId BIGINT, CustID INT)

INSERT INTO #VoidingHistory (VoidingHistoryId, RequestId, MessageId, TransId)
SELECT vh.VoidingHistoryId, vh.RequestId, vh.MessageId, t.TransId
FROM dbacc.bodb02.dbo.TicketVoiding_VoidingHistory vh WITH (NOLOCK)
	CROSS APPLY (
		SELECT val AS TransId FROM dbo.f_CRM_strSplit(vh.TransIds, ',')
	) t
WHERE EXISTS (SELECT 1 FROM crmMessageImport m WHERE vh.MessageId = m.MessageId AND vh.RequestID = m.RequestID)
	AND vh.StatusId = 2 --tickets void successfully
		
UPDATE vh
SET vh.custid = b.custid
FROM #VoidingHistory vh 
	INNER JOIN bodb02.dbo.bettrans b WITH(NOLOCK) ON vh.Transid = b.Transid 
	
INSERT INTO [dbo].[crmAutoFeedbackInfo]
           ([MessageID]
		   ,[RequestID]
           ,[CustID]
           ,[HeadlineID]
           ,[RelatedCustID]
           ,[EventInfo]
           ,[Status]
           ,[CreatedDate]
           ,[UpdatedTime]
           ,[Description]
           ,[RetryCount]
           )
SELECT DISTINCT c.MessageID
	   ,vh.RequestID
	   ,c.CustID
	   ,c.HeadlineID
	   ,c.RelatedCustID
	   ,c.EventInfo
	   ,c.Status
	   ,c.CreatedDate
	   ,c.UpdatedTime
	   ,c.Description
	   ,c.RetryCount
FROM crmAutoFeedbackInfo_tmp c WITH(NOLOCK)    	
	INNER JOIN #VoidingHistory vh ON c.MessageID = vh.MessageID
									AND c.CustID = vh.custid
									
									