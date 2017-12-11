
/*
	Created: Winnie	
	Task: Enable CashOut for new customer
	DB: DBCUST/CustDB
	Date: 20171211
*/ 
------------------------------------------------------
declare @MaxCustId int
set @MaxCustId = xxx	

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

INSERT INTO dbo.Dep_SupperProductSetting (CustID, ProductId, IsEnabled)
SELECT srecommend,25,1
FROM #supers WHERE srecommend>@maxcustid
	
INSERT INTO dbo.Dep_CustProductSetting (CustID, ProductId, IsEnabled)
SELECT c.CustID, 25, 1
FROM Customer c WITH(NOLOCK) 
INNER JOIN #supers s ON c.srecommend=s.srecommend
WHERE custid>@maxcustid AND roleid=1 


UPDATE c SET c.VirtualMultiplier=0
FROM custInfo c WITH(ROWLOCK,UPDLOCK)
INNER JOIN TradeCust tc WITH(NOLOCK) ON c.custid=tc.custid

