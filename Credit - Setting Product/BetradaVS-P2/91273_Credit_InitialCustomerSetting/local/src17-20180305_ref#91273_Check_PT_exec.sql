/*
	Created: 20180411@Vicky
	Task : check DCS PT Setting for Credit Customer 
	DB: DBCUST/custDB
	
	
	Param's Explanation:
	Exameple: 
*/

CREATE TABLE #supers (custid INT, isfinished BIT DEFAULT(0))
DECLARE @srecommend VARCHAR(225)

DECLARE @var_msg_index INT = 0, @var_msg_super_total INT = 0

INSERT INTO #supers(custid)
SELECT c.custid
FROM customer c             WITH (NOLOCK) 
    INNER JOIN site s       WITH (NOLOCK) ON c.site = s.site
    INNER JOIN custsuper cs WITH (NOLOCK) ON c.custid = cs.custid
WHERE c.username NOT LIKE '3rdSuper%'
    AND cs.isinternal = 0
    AND s.islicensee = 0

SET @var_msg_super_total = (SELECT COUNT(*) FROM #supers )
RAISERROR ('Total of supers: %d.', 0, 1, @var_msg_super_total) WITH NOWAIT

WHILE (1 = 1)
BEGIN
    UPDATE TOP (1) #Supers
    SET isfinished = 1, @srecommend = STR(custid)   
    WHERE isfinished = 0
    
    IF @@ROWCOUNT = 0 BREAK
    
    SET @var_msg_index = @var_msg_index + 1
    RAISERROR ('Currently at order %d, SuperID: %s.', 0, 1, @var_msg_index, @srecommend) WITH NOWAIT
    
    exec dbo.[DBA_CheckPTGame_DCS] @srecommendList=@srecommend, @SportType = 193, @BetType = 2801
    exec dbo.[DBA_CheckPTGame_DCS] @srecommendList=@srecommend, @SportType = 192, @BetType = 2701
END

SELECT * FROM ##CheckPTResult_Credit
