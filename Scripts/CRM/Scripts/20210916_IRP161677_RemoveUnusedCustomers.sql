/*<info serverAlias="DBCRM-bodb_CRM"></info>*/
/*
	Created: 20210916@Johnson
	Task: delete un-used guest customers in crm
	DB: DBCRM/bodb_CRM
*/

DECLARE @tmpCust TABLE (custid INT)

INSERT INTO @tmpCust(custid) 
SELECT val 
FROM dbo.f_CRM_strSplit('-1083,-1089,-1084,-1086,-1085,-1088',',')

DELETE FROM crmCustomerRemark WITH(ROWLOCK)
WHERE custid IN (SELECT custid FROM @tmpCust)

DELETE FROM crmCustomerSearch WITH(ROWLOCK)
WHERE custid IN (SELECT custid FROM @tmpCust)

DELETE FROM crmCustSearch WITH(ROWLOCK)
WHERE custid IN (SELECT custid FROM @tmpCust)

DELETE FROM crmDefaultCommTool WITH(ROWLOCK)
WHERE custid IN (SELECT custid FROM @tmpCust)

--delete feedback & related tables
SELECT FeedbackID 
INTO #tmpFB
FROM crmFeedback WITH(NOLOCK)
WHERE custid IN (SELECT custid FROM @tmpCust)

DELETE FROM crmFeedbackSetting WITH(ROWLOCK)
WHERE FeedbackID IN (SELECT FeedbackID FROM #tmpFB) 

DELETE FROM crmFeedbackCustomer WITH(ROWLOCK)
WHERE custid IN (SELECT custid FROM @tmpCust)

DELETE FROM crmFeedback WITH(ROWLOCK)
WHERE custid IN (SELECT custid FROM @tmpCust)

DELETE FROM crmLogCustomerRemark WITH(ROWLOCK)
WHERE custid IN (SELECT custid FROM @tmpCust)

DELETE FROM crmLogFeedback WITH(ROWLOCK)
WHERE custid IN (SELECT custid FROM @tmpCust)

DELETE FROM crmLogCustomer WITH(ROWLOCK)
WHERE custid IN (SELECT custid FROM @tmpCust)

DELETE FROM crmCustomerLanguage WITH(ROWLOCK)
WHERE custid IN (SELECT custid FROM @tmpCust)

DELETE FROM crmCustomer WITH(ROWLOCK)
WHERE custid IN (SELECT custid FROM @tmpCust)
