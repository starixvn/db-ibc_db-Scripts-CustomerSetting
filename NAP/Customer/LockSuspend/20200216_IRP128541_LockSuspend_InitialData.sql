/*
	Created by: Elodie
	Date: 20200216
	Task: Insert test data
	DB: DBCUST/CustDB
*/
USE CustDB
GO


--25 affected rows
INSERT INTO CustSuspendLockUpd (CustID)
SELECT custid
FROM dbo.custInfo ci WITH (NOLOCK)
WHERE ci.username IN ('2RM1ABY','S88MKHK','WRD33','KJM00JF','SMORMZAUU','SAE24','LHK11','D771201','S88AB1C1',
						'S88AB1F3','SG51H01','SG6H31','2RM1A','2CURS','2CUTI','ALO05','LHKAB','MOXZA','SMORMZA',
						'CKS23','KJM00','KJH00ZX','KJH003F','SWM83','2RBAK')
