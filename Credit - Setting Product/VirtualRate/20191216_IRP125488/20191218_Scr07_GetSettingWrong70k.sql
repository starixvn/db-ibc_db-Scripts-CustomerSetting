/*
	Created: Johnson
	Date: 2019-12-18
	Task: get list settings gonna update dbcust
	DB: DBSPARE/CUSTDB_Temp2
*/

SELECT cs.*
into Tmp_CustVirtual70k
FROM custinfo ci WITH(NOLOCK) 
	INNER JOIN dbo.CustVirtualSetting cs WITH(NOLOCK) ON ci.custid = cs.custid
WHERE ci.custid in (SELECT custid FROM Tmp_CustVirtual)	
AND ((cs.seqNo = 1
				AND (					
					--OU/1H OU
					SUBSTRING(cs.bitmapVirtual,5,1) = CAST(12 AS BINARY(1))
					OR SUBSTRING(cs.bitmapVirtual,6,1) = CAST(12 AS BINARY(1))
					OR SUBSTRING(cs.bitmapVirtual,9,1) = CAST(12 AS BINARY(1))
					OR SUBSTRING(cs.bitmapVirtual,10,1) = CAST(12 AS BINARY(1))
					OR SUBSTRING(cs.bitmapVirtual,17,1) = CAST(12 AS BINARY(1))
					OR SUBSTRING(cs.bitmapVirtual,18,1) = CAST(12 AS BINARY(1))
					OR SUBSTRING(cs.bitmapVirtual,21,1) = CAST(12 AS BINARY(1))
					OR SUBSTRING(cs.bitmapVirtual,22,1) = CAST(12 AS BINARY(1))
					OR SUBSTRING(cs.bitmapVirtual,29,1) = CAST(12 AS BINARY(1))
					OR SUBSTRING(cs.bitmapVirtual,30,1) = CAST(12 AS BINARY(1))
					OR SUBSTRING(cs.bitmapVirtual,33,1) = CAST(12 AS BINARY(1))
					OR SUBSTRING(cs.bitmapVirtual,34,1) = CAST(12 AS BINARY(1))
					OR SUBSTRING(cs.bitmapVirtual,41,1) = CAST(12 AS BINARY(1))
					OR SUBSTRING(cs.bitmapVirtual,42,1) = CAST(12 AS BINARY(1))
					OR SUBSTRING(cs.bitmapVirtual,49,1) = CAST(12 AS BINARY(1))
					OR SUBSTRING(cs.bitmapVirtual,50,1) = CAST(12 AS BINARY(1))
					OR SUBSTRING(cs.bitmapVirtual,59,1) = CAST(12 AS BINARY(1))
					OR SUBSTRING(cs.bitmapVirtual,60,1) = CAST(12 AS BINARY(1))				
					)		
				)
				OR
				( cs.seqNo = 2
				AND 
					(SUBSTRING(cs.bitmapVirtual,3,1) = CAST(12 AS BINARY(1))
					OR SUBSTRING(cs.bitmapVirtual,4,1) = CAST(12 AS BINARY(1))
					OR SUBSTRING(cs.bitmapVirtual,9,1) = CAST(12 AS BINARY(1))
					OR SUBSTRING(cs.bitmapVirtual,10,1) = CAST(12 AS BINARY(1))
					OR SUBSTRING(cs.bitmapVirtual,13,1) = CAST(12 AS BINARY(1))
					OR SUBSTRING(cs.bitmapVirtual,14,1) = CAST(12 AS BINARY(1))
					OR SUBSTRING(cs.bitmapVirtual,23,1) = CAST(12 AS BINARY(1))
					OR SUBSTRING(cs.bitmapVirtual,24,1) = CAST(12 AS BINARY(1))
					OR SUBSTRING(cs.bitmapVirtual,31,1) = CAST(12 AS BINARY(1))
					OR SUBSTRING(cs.bitmapVirtual,32,1) = CAST(12 AS BINARY(1))
					OR SUBSTRING(cs.bitmapVirtual,39,1) = CAST(12 AS BINARY(1))					
					OR SUBSTRING(cs.bitmapVirtual,40,1) = CAST(12 AS BINARY(1))
					OR SUBSTRING(cs.bitmapVirtual,47,1) = CAST(12 AS BINARY(1))
					OR SUBSTRING(cs.bitmapVirtual,48,1) = CAST(12 AS BINARY(1))
					OR SUBSTRING(cs.bitmapVirtual,51,1) = CAST(12 AS BINARY(1))
					OR SUBSTRING(cs.bitmapVirtual,52,1) = CAST(12 AS BINARY(1))										
					)
				)
			)	
	AND ci.srecommend NOT IN (31739187,31739187,31739191,31739194,31739195,33015605,33015607,
	33015614,33015617,33015618,33015624,33015625,33015625,33015627,33015628,33015631,33015632,
	33015635,33015644,33015646,33015843,33015844)		
			
			