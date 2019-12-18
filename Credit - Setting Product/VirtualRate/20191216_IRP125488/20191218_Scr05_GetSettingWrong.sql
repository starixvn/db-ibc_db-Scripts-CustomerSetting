/*
	Created: Johnson
	Date: 2019-12-19
	Task: get setting wrong
	DB: DBSPARE/CUSTDB_Temp2
*/
	
SELECT cs.*
into Tmp_CustVirtual2
FROM dbo.CustVirtualSetting cs WITH(NOLOCK)
WHERE custid IN (SELECT custid FROM Tmp_CustVirtual)	
AND ((cs.seqNo = 1
				AND (					
					--OU/1H OU
					SUBSTRING(cs.bitmapVirtual,5,1) = CAST(15 AS BINARY(1))
					OR SUBSTRING(cs.bitmapVirtual,6,1) = CAST(15 AS BINARY(1))
					OR SUBSTRING(cs.bitmapVirtual,9,1) = CAST(15 AS BINARY(1))
					OR SUBSTRING(cs.bitmapVirtual,10,1) = CAST(15 AS BINARY(1))
					OR SUBSTRING(cs.bitmapVirtual,17,1) = CAST(15 AS BINARY(1))
					OR SUBSTRING(cs.bitmapVirtual,18,1) = CAST(15 AS BINARY(1))
					OR SUBSTRING(cs.bitmapVirtual,21,1) = CAST(15 AS BINARY(1))
					OR SUBSTRING(cs.bitmapVirtual,22,1) = CAST(15 AS BINARY(1))
					OR SUBSTRING(cs.bitmapVirtual,29,1) = CAST(15 AS BINARY(1))
					OR SUBSTRING(cs.bitmapVirtual,30,1) = CAST(15 AS BINARY(1))
					OR SUBSTRING(cs.bitmapVirtual,33,1) = CAST(15 AS BINARY(1))
					OR SUBSTRING(cs.bitmapVirtual,34,1) = CAST(15 AS BINARY(1))
					OR SUBSTRING(cs.bitmapVirtual,41,1) = CAST(15 AS BINARY(1))
					OR SUBSTRING(cs.bitmapVirtual,42,1) = CAST(15 AS BINARY(1))
					OR SUBSTRING(cs.bitmapVirtual,49,1) = CAST(15 AS BINARY(1))
					OR SUBSTRING(cs.bitmapVirtual,50,1) = CAST(15 AS BINARY(1))
					OR SUBSTRING(cs.bitmapVirtual,59,1) = CAST(15 AS BINARY(1))
					OR SUBSTRING(cs.bitmapVirtual,60,1) = CAST(15 AS BINARY(1))				
					)		
				)
				OR
				( cs.seqNo = 2
				AND 
					(SUBSTRING(cs.bitmapVirtual,3,1) = CAST(15 AS BINARY(1))
					OR SUBSTRING(cs.bitmapVirtual,4,1) = CAST(15 AS BINARY(1))
					OR SUBSTRING(cs.bitmapVirtual,9,1) = CAST(15 AS BINARY(1))
					OR SUBSTRING(cs.bitmapVirtual,10,1) = CAST(15 AS BINARY(1))
					OR SUBSTRING(cs.bitmapVirtual,13,1) = CAST(15 AS BINARY(1))
					OR SUBSTRING(cs.bitmapVirtual,14,1) = CAST(15 AS BINARY(1))
					OR SUBSTRING(cs.bitmapVirtual,23,1) = CAST(15 AS BINARY(1))
					OR SUBSTRING(cs.bitmapVirtual,24,1) = CAST(15 AS BINARY(1))
					OR SUBSTRING(cs.bitmapVirtual,31,1) = CAST(15 AS BINARY(1))
					OR SUBSTRING(cs.bitmapVirtual,32,1) = CAST(15 AS BINARY(1))
					OR SUBSTRING(cs.bitmapVirtual,39,1) = CAST(15 AS BINARY(1))					
					OR SUBSTRING(cs.bitmapVirtual,40,1) = CAST(15 AS BINARY(1))
					OR SUBSTRING(cs.bitmapVirtual,47,1) = CAST(15 AS BINARY(1))
					OR SUBSTRING(cs.bitmapVirtual,48,1) = CAST(15 AS BINARY(1))
					OR SUBSTRING(cs.bitmapVirtual,51,1) = CAST(15 AS BINARY(1))
					OR SUBSTRING(cs.bitmapVirtual,52,1) = CAST(15 AS BINARY(1))										
					)
				)
			)	