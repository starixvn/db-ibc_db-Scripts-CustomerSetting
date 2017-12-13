  /*
	Created: 20171211Winnie
	Task : Initial data for CashOut. Add dummy trade
	DB: DBCust/CustDB.	 [RedmineID: #87987]
*/

CREATE TABLE #supers (custid INT PRIMARY KEY, currency INT,isfinished bit default(0))
INSERT INTO #supers(custid,currency)
SELECT ci.custid, ci.currency
FROM Customer ci WITH(NOLOCK)
INNER JOIN custInfo c WITH(NOLOCK) ON ci.custid=c.custid
WHERE ci.roleid = 4 	
AND ci.custid IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK)) 
AND c.Enabled=1	
AND ci.site IN ('368Cash','alog','Avia','GamingSoft','Hengcai88','HL8','Jinyazhou','Leon','LongBao','OLE777','Salon365','SSSSEA','Sun988','SunGame','Sunrise','Taipanbet','VCBA','WeBet168','webet88',
'108bet','Bobo88','DBP','DELA','HonorW','K8VN','KeenOcean','Mayfair','MrCat','OPEBET','Senibet','Ty777','Vwin',
'365online','396Club','3star88','818Bet','88Macao','9Club','ABB688','Abcasino','Ae88','AG','BetStar','BigGaming','Boying','Brown888','BuyWin','Dawoo','DEWA','ECLBET','Emmyo','Gampag','GOAB88','Heaven','Hecbet',
'Holey','HONBET','HuangMa','iBET','IBO','IGPTech','IONclub','KhmerG','Liga','Mayayule','PanguGame','PKbet','Royal','TGame','Uwoniwin','Webet138','XTD3','Zzun88'
)
INSERT INTO #supers(custid,currency)
SELECT ci.custid, ci.currency
FROM Customer ci WITH(NOLOCK)
INNER JOIN custInfo c WITH(NOLOCK) ON ci.custid=c.custid
WHERE ci.roleid = 4 	
AND ci.custid IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
AND c.Enabled=1	
AND ci.site ='mansion88'
AND ci.currency<>20

DECLARE @srecommend INT
WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #Supers
	SET isfinished = 1
		,@srecommend = custid	
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK

	EXEC Acc_CustomerInsDummyTradeCashOut	@ProductID	=25	
										,@CustID	=@srecommend
										,@UserID	=10278938

	UPDATE t
	  SET HouseDeductionRate=0.03,HousePT =1
	FROM [TradeComm] t WITH(ROWLOCK,UPDLOCK)
		INNER JOIN custInfo c WITH(NOLOCK) ON t.AgentID=c.custid
	WHERE c.srecommend=@srecommend
END

