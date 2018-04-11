/*
	Created: 20180411@Winnie
	Task: Exchange - Change Charge commission to 3% for Dafabet licensee
	Redmine: https://nexdev.net/issues/93422
	DB: DBCUST/CUSTDB
*/  
------------------------------------------------------

CREATE TABLE #tblCust (custid INT PRIMARY KEY) 
INSERT INTO #tblCust (custid)			
SELECT ci.custid
FROM custInfo CI WITH(NOLOCK)
	INNER JOIN Dep_CustSuper CS WITH(NOLOCK) ON ci.srecommend = cs.custid
WHERE ci.mrecommend NOT IN (SELECT custid FROM custinfo cs1 WITH(NOLOCK)
						   WHERE cs1.srecommend=ci.srecommend AND cs1.username LIKE '%Acc%' AND cs1.roleid=3 )
	AND ci.Currency IN(3,61)
	AND site IN ('alog')		
	AND roleid IN(2,3,4)
	
UPDATE d
	SET d.[Discount]=0.03
FROM [Dep_CustDiscountSetting_Agent] d WITH(NOLOCK)
	INNER JOIN #tblCust t ON d.CustID=t.custid
WHERE [SportType]=221 AND [BetType]=8001


DROP TABLE #tblCust

