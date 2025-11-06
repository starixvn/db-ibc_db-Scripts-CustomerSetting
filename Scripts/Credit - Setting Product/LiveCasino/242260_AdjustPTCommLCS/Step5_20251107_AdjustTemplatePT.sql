/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created By: Johnson@20251107
	Description: Add new template PT for Live Casino Product [redmine: #242260]
	DB: DBCust/CustDB	
*/

CREATE TABLE #tblSMA(CustID INT, TemplateID INT)

INSERT INTO #tblSMA(CustID, TemplateID)
SELECT DISTINCT ci.custid, pt.TemplateID
FROM customer ci WITH (NOLOCK) 
	INNER JOIN custinfo cu with (nolock) on cu.custid=ci.custid		
    INNER JOIN CustPTTemplate pt WITH(NOLOCK) ON ci.custid = pt.custid	
WHERE ci.site IN ('BEST-ODDS','611111','733333','755555','222223','7aa666','KORIBC','722222','XYZBet')	
	AND cu.Enabled = 1
    AND cu.roleid IN (2,3,4)

INSERT INTO [dbo].[CustPTTemplateDetail]
           ([TemplateID]
           ,[GroupID]
           ,[SubGroupID]
           ,[PT]
           ,[RepUpdateTime])
SELECT 
       pt.TemplateID
       ,pt.GroupID
       ,s.NewSubGroupID
       ,pt.PT
       ,dbo.f_GetDateTime2()
FROM CustPTTemplateDetail pt WITH(NOLOCK) 
    INNER JOIN #tblSMA t ON pt.TemplateID = t.TemplateID
    CROSS APPLY (SELECT 11 as NewSubGroupID UNION SELECT 12 UNION SELECT 13) s
WHERE pt.GroupID = 3 AND pt.SubGroupID = 6 -- Existing Live Casino TemplateID
