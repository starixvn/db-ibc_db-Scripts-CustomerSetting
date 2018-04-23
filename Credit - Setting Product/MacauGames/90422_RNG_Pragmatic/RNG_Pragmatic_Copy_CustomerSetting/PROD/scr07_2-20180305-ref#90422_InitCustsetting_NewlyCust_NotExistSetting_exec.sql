/*
    Created: Vicky
    Date: 20180412
    Task: Copy customer setting for newly customer
    DB: DBCUST/CustDB
*/  

-- STEP 1: RUN THIS SCRIPT AT DBCUST -----
IF OBJECT_ID('tempdb..#supers') IS NOT NULL DROP TABLE #supers
GO
DECLARE @max_custid INT = xxx
DECLARE @num_line_exec INT = 200
--------------------------------------------------------------------------------------

CREATE TABLE #supers (custid INT, isfinished BIT DEFAULT(0))
DECLARE @srecommendList VARCHAR(MAX)

DECLARE @var_msg_index INT = 0, @var_msg_super_total INT = 0

INSERT INTO #supers(custid)
SELECT c.custid
FROM customer c             WITH (NOLOCK) 
    INNER JOIN site s       WITH (NOLOCK) ON c.site = s.site
    INNER JOIN custsuper cs WITH (NOLOCK) ON c.custid = cs.custid
WHERE c.username NOT LIKE '3rdSuper%'
    AND cs.isinternal = 0
    AND s.islicensee = 0
    AND c.currency <> 20

SET @var_msg_super_total = (SELECT COUNT(*) FROM #supers )
RAISERROR ('Total of supers: %d.', 0, 1, @var_msg_super_total) WITH NOWAIT

WHILE (1 = 1)
BEGIN
    SET @srecommendList = NULL
    
    UPDATE TOP (@num_line_exec) #Supers
    SET isfinished = 1, @srecommendList = COALESCE(@srecommendList + ',', '') + CONVERT(VARCHAR(12),custid)   
    WHERE isfinished = 0
    
    IF @@ROWCOUNT = 0 BREAK
    
    SET @var_msg_index = @var_msg_index + 1
    RAISERROR ('Currently at order %d, SuperID: %s.', 0, 1, @var_msg_index, @srecommendList) WITH NOWAIT
    
    EXEC dbo.Acc_DynamicCustSetting3rd_09 @srecommendList = @srecommendList, @maxcustid = @max_custid, @SportType = 248, @BetType = 4101
    
    WAITFOR DELAY '00:00:0.100'
END
GO