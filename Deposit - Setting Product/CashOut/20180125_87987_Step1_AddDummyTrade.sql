  /*
	Created: 20180125Winnie
	Task : ['Newhonbet','TGO'] Initial data for CashOut. Add dummy trade
	DB: DBCust/CustDB.	 [RedmineID: #90046]
*/

CREATE TABLE #supers (custid INT PRIMARY KEY, currency INT,isfinished bit default(0))
INSERT INTO #supers(custid,currency)
SELECT ci.custid, ci.currency
FROM Customer ci WITH(NOLOCK)
INNER JOIN custInfo c WITH(NOLOCK) ON ci.custid=c.custid
WHERE ci.roleid = 4 	
AND ci.custid IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK)) 
AND c.Enabled=1	
AND ci.site IN ('Newhonbet','TGO','Wuming','e8casino','HongChow','Swin','WM8888','AK318','Lucky88')

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

