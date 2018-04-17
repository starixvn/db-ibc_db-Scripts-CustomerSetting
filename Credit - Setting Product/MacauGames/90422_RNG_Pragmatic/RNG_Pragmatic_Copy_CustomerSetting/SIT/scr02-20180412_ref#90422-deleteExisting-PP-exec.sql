/*
    Created: Vicky
    Date: 20180412
    Task: delete existing setting
    DB: DBCUST/CustDB
*/  

-- RUN THIS SCRIPT AT DBCUST -----
DECLARE @max_custid INT = xxx
DECLARE @var_target VARCHAR(20) = 'DBCUST'

CREATE TABLE #supers (custid INT, isfinished BIT DEFAULT(0))
DECLARE @srecommend INT

DECLARE @var_msg_index INT = 0, @var_msg_super_total INT = 0

INSERT INTO #supers(custid)
SELECT c.custid
FROM customer c             WITH (NOLOCK) 
    INNER JOIN site s       WITH (NOLOCK) ON c.site = s.site
    INNER JOIN custsuper cs WITH (NOLOCK) ON c.custid = cs.custid
WHERE c.username NOT LIKE '3rdSuper%'
    AND cs.isinternal = 0
    AND s.islicensee = 0
    AND c.custid <= @max_custid
    AND (c.currency = 20 OR c.currency = 72)

SET @var_msg_super_total = (SELECT COUNT(*) FROM #supers )
RAISERROR ('Total of supers: %d.', 0, 1, @var_msg_super_total) WITH NOWAIT

WHILE (1 = 1)
BEGIN
    UPDATE TOP (1) #Supers
    SET isfinished = 1, @srecommend = custid   
    WHERE isfinished = 0
    
    IF @@ROWCOUNT = 0 BREAK
    
    SET @var_msg_index = @var_msg_index + 1
    RAISERROR ('Currently at order %d, SuperID: %d.', 0, 1, @var_msg_index, @srecommend) WITH NOWAIT
    
    EXEC dbo.Acc_DynamicCustSetting3rd_09 @srecommend = @srecommend, @maxcustid = @max_custid
    
    WAITFOR DELAY '00:00:0.100'
END
GO