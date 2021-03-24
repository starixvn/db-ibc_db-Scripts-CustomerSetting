/*
	Created: 20210305@Johnson
	Task: update sportbook comm for Saba789
	DB: DBCUST/CustDB
*/

CREATE TABLE #Supers (custid INT, isFinished BIT DEFAULT 0)
CREATE TABLE #tblCust (custid INT PRIMARY KEY, roleid TINYINT)
DECLARE @tmp TABLE(custid INT PRIMARY KEY, roleid TINYINT)

--2 supers
INSERT INTO #Supers(custid)
SELECT custid
FROM Dep_CustSuper WITH(NOLOCK)
WHERE site ='Saba789'
	
DECLARE @custid INT,
	@discount DECIMAL(9, 8) = 0.0025,
	@discountcs DECIMAL(9, 8) = 0.01,
	@discount1x2 DECIMAL(9, 8) = 0.0025
	
WHILE(1=1)
BEGIN
	UPDATE TOP (1) s
	SET @custid = custid,
		isFinished = 1
	FROM #supers s
	WHERE isFinished = 0
	
	IF @@ROWCOUNT = 0
		BREAK;
		
	DELETE #tblCust
	
	INSERT INTO #tblCust(custid,roleid)
	SELECT custid,roleid
	FROM custinfo WITH(NOLOCK)
	WHERE srecommend = @custid
		AND mrecommend NOT IN (SELECT custid 
							FROM customer WITH(NOLOCK)
							WHERE srecommend = @custid
								AND roleid =3
								AND (username LIKE '%Acc%' OR username LIKE '%LocalBank%')
						)
	
	WHILE(1=1)
	BEGIN
		DELETE @tmp
		
		DELETE TOP(100) t
		OUTPUT DELETED.custid, DELETED.roleid INTO @tmp(custid,roleid)
		FROM #tblCust t
		
		IF @@rowcount = 0
			BREAK;
			
		UPDATE cs
		SET sdiscount = CASE WHEN roleid IN (1,4) THEN 
								CASE WHEN bettype IN (1,2,3,7,8) THEN @discount
									 WHEN bettype IN (5,20) THEN @discount1x2
									 WHEN bettype IN (4,6,9,10) THEN @discountcs END			
							ELSE sdiscount END,
			adiscount = CASE WHEN roleid IN (1,3) THEN 
								CASE WHEN bettype IN (1,2,3,7,8) THEN @discount
									 WHEN bettype IN (5,20) THEN @discount1x2
									 WHEN bettype IN (4,6,9,10) THEN @discountcs END			
							ELSE adiscount END,
			discount = CASE WHEN roleid IN (1,2) THEN 
								CASE WHEN bettype IN (1,2,3,7,8) THEN @discount
									 WHEN bettype IN (5,20) THEN @discount1x2--money line belongs comm2
									 WHEN bettype IN (4,6,9,10) THEN @discountcs END			
							ELSE discount END
		FROM Dep_CustSetting cs WITH(UPDLOCK,ROWLOCK)
			INNER JOIN @tmp t ON cs.custid = t.custid
	END
	
	WAITFOR DELAY '0:0:1'
END

