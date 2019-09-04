/*
	Created: Winnie
	Date: 2019-09-04
	Task: Enable colossus settings for new deposit customers [WKPHIL]  RedmineID: #119642
	DB: DBCUST/CustDB
*/ 
------------------------------------------------------	
DECLARE @max_custid INT

SELECT @max_custid = xxx

UPDATE dbo.custInfo WITH(ROWLOCK,UPDLOCK)	
SET DisableColossusBet = 0, HideColossusBet = 0
WHERE srecommend IN (	SELECT custid 
						FROM dbo.Dep_CustSuper cs WITH(NOLOCK)							
						WHERE cs.site ='WKPHIL')
	AND Enabled=1 AND custid > @max_custid