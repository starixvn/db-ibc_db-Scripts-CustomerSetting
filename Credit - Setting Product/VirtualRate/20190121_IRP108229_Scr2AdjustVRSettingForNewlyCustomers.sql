/*
	Created: Johnson
	Date: 2019-01-21
	Task: adjust virtual rate 
	DB: DBCUST/CUSTDB
*/


CREATE TABLE #supers (custid INT,  isfinished BIT DEFAULT(0))

DECLARE @max_custid INT, @srecommend INT
SELECT  @max_custid= xxx ---input maxcustid

INSERT INTO #supers(custid)
--get list supers for credit
SELECT ci.custid
FROM customer ci WITH (NOLOCK) 
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
	LEFT JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.roleid = 4  
	AND ci.username NOT LIKE '3rdSuper%'
	AND cs.isinternal = 0
	AND s.islicensee = 0
	AND ci.currency = 64 --UT currency	
	AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
UNION 
--get list supers for licensees
SELECT ci.custid
FROM Dep_CustSuper ci WITH(NOLOCK)	

CREATE TABLE #tblCust (CustID INT, seqNo TINYINT, newBitmap BINARY(64), ID INT PRIMARY KEY IDENTITY(1,1))	
DECLARE @tmpCust TABLE(CustID INT, seqNo TINYINT, newBitmap binary(64))
	
INSERT INTO #tblCust(custid, seqNo, newBitmap)		
SELECT ci.custid, cs.seqNo, (SELECT bitmap FROM dbo.f_GenerateVirtualSetting_inline(cs.bitmapVirtual, P.virtualXML)) newBitmap
FROM custinfo ci WITH(NOLOCK)
	INNER JOIN CustVirtualSetting cs WITH (NOLOCK) ON cs.custid = ci.custid 							
	CROSS APPLY (
			SELECT		
				(SELECT pvs1.profileID as '@p', 0.15 as '@v'--new value -85%
					FROM ProfileVirtualSetting pvs1 WITH(NOLOCK) 
					WHERE cs.seqNo = pvs1.seqNo													
						AND (CASE WHEN CAST(substring(cs.bitmapVirtual, 1+((profileID-1)%64), 1) as int) > 200 THEN ((CAST(substring(cs.bitmapVirtual, 1+((profileID-1)%64), 1) as int) - 200)*5 + 200)
								 ELSE CAST(substring(cs.bitmapVirtual, 1+((profileID-1)%64), 1) as int) 
								 END) / 100.0 = 0.2-- VR = -80%						
						FOR XML PATH ('r')
						,ROOT('root')	
				) AS virtualXML
	) p	

WHERE ci.srecommend IN (SELECT custid FROM #supers)
	AND ci.custid > @max_custid
	AND virtualXML IS NOT NULL
	
	DECLARE @Threshold INT = 5000,@fromID INT , @toID INT, @maxID INT
	
	SELECT @maxID = max(ID) FROM #tblCust
	SELECT @fromID = 0, @toID = @Threshold, @maxID = ISNULL(@maxID,0)	
		
	WHILE(1=1)
	BEGIN		
		DELETE @tmpCust

		DELETE #tblCust
		OUTPUT DELETED.custID, DELETED.seqNo, DELETED.newBitmap
		INTO @tmpCust
		WHERE ID BETWEEN @fromID AND @toID

		IF @@rowcount = 0 
			BREAK;
		
		UPDATE cs
		SET cs.bitmapVirtual = t.newbitmap
		FROM	@tmpCust t
			INNER JOIN CustVirtualSetting cs WITH(UPDLOCK,ROWLOCK) ON t.custID = cs.custID
																	AND t.seqNo = cs.seqNo			
		
		SELECT @fromID = @toID + 1,
			@toID = @toID + @Threshold + 1

		IF @fromID > @maxID
			BREAK;	
			
		WAITFOR DELAY '00:00:00.1'
	END
	
	DROP TABLE #tblCust