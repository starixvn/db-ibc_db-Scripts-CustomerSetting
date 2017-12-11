/*
	Created: Winnie	
	Task: Delete existed customer RedmineID:87987
	DB: DBCUST/CustDB
	Date: 20171211
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
AND ci.site IN  ('368Cash','alog','Avia','GamingSoft','Hengcai88','HL8','Jinyazhou','Leon','LongBao','OLE777','Salon365','SSSSEA','Sun988','SunGame','Sunrise','Taipanbet','VCBA','WeBet168','webet88',
'108bet','Bobo88','DBP','DELA','HonorW','K8VN','KeenOcean','mansion88','Mayfair','MrCat','OPEBET','Senibet','Ty777','Vwin',
'365online','396Club','3star88','818Bet','88Macao','9Club','ABB688','Abcasino','Ae88','AG','BetStar','BigGaming','Boying','Brown888','BuyWin','Dawoo','DEWA','ECLBET','Emmyo','Gampag','GOAB88','Heaven','Hecbet',
'Holey','HONBET','HuangMa','iBET','IBO','IGPTech','IONclub','KhmerG','Liga','Mayayule','PanguGame','PKbet','Royal','TGame','Uwoniwin','Webet138','XTD3','Zzun88'
)

DELETE FROM dbo.Dep_SupperProductSetting
WHERE ProductId=25 AND CustID IN (SELECT srecommend FROM #supers)

DELETE cs
FROM dbo.Dep_CustProductSetting cs
INNER JOIN Customer c WITH(NOLOCK) ON cs.custid=c.Custid
WHERE cs.ProductId=25 AND c.srecommend IN (SELECT srecommend FROM #supers)
	

