/*
	Created: Winnie	
	Task: ['Newhonbet','TGO'] Delete existed customer RedmineID:90046
	DB: DBCUST/CustDB
	Date: 20180125
*/ 
------------------------------------------------------

create table #supers (srecommend int, isFinished bit default(0))
INSERT INTO #supers(srecommend)
SELECT ci.custid
FROM Customer ci WITH(NOLOCK)
INNER JOIN custInfo c WITH(NOLOCK) ON ci.custid=c.custid
WHERE ci.roleid = 4 	
AND ci.custid IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK)) 
AND c.Enabled=1	
AND ci.site IN  ('Newhonbet','TGO','Wuming','e8casino','HongChow','Swin','WM8888','AK318','Lucky88')
DELETE FROM dbo.Dep_SupperProductSetting
WHERE ProductId=25 AND CustID IN (SELECT srecommend FROM #supers)

DELETE cs
FROM dbo.Dep_CustProductSetting cs
INNER JOIN Customer c WITH(NOLOCK) ON cs.custid=c.Custid
WHERE cs.ProductId=25 AND c.srecommend IN (SELECT srecommend FROM #supers)
	

