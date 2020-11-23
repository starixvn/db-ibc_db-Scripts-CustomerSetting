/*
	Created: Winfred	
	Task: Apply color for archived accounts [Redmine:145018 ]
	DB: DBCUST/CustDB
	Date: 20202311
*/ 


UPDATE CustLoginInfo_Member WITH (ROWLOCK, UPDLOCK) 
SET ClosedReason = 4
WHERE custid IN (45181958,45126890)

UPDATE CustLoginInfo_Member WITH (ROWLOCK, UPDLOCK) 
SET ClosedReason = 3
WHERE custid IN (45127036)	

UPDATE CustLoginInfo_Member WITH (ROWLOCK, UPDLOCK) 
SET ClosedReason = 0
WHERE custid IN (45127647)		
-- closedReason 
UPDATE CustLoginInfo WITH (ROWLOCK, UPDLOCK) 
SET ClosedReason = 0
WHERE custid IN (45081662,45133308,45133553)	

UPDATE CustLoginInfo WITH (ROWLOCK, UPDLOCK) 
SET ClosedReason = 4
WHERE custid IN (45081835,45082719,45182984,45083035)	