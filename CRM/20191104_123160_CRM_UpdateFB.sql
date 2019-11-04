SELECT TOP 100 f.FeedbackID,f.custid 
INTO #temp
FROM crmFeedback f WITH (NOLOCK)
	LEFT JOIN crmFeedbackCustomer fc WITH (NOLOCK) ON fc.FeedbackID=f.FeedbackID and fc.custid=f.CustID
WHERE (fc.IsRelated=1 or fc.IsRelated IS NULL)

UPDATE fc
SET 
FROM crmFeedbackCustomer fc WITH(ROWLOCK,UPDLOCK)
	INNER JOIN #temp t ON fc.FeedbackID=t.FeedbackID AND fc.CustID=t.CustID
	
select * from #temp

DROP TABLE #temp