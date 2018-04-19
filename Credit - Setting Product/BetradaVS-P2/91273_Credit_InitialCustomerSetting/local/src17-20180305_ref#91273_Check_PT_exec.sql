/*
	Created: 20180411@Vicky
	Task : check DCS PT Setting for Credit Customer 
	DB: DBCUST/custDB
*/
IF OBJECT_ID('tempdb..#supers') IS NOT NULL DROP TABLE #supers
GO
CREATE TABLE #supers (custid INT, isfinished BIT DEFAULT(0))
DECLARE @srecommend VARCHAR(MAX)

DECLARE @var_msg_index INT = 0, @var_msg_super_total INT = 0


-------------------clear data-----------------------------------------------------------------------------
IF OBJECT_ID('tempdb..##CheckPTResult_Credit') IS NOT NULL
BEGIN
    DELETE FROM ##CheckPTResult_Credit
END
----------------------------------------------------------------------------------------------------------
    
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
	SET @srecommend = NULL
	
    UPDATE TOP (100) #Supers
    SET isfinished = 1, @srecommend = COALESCE(@srecommend + ',', '') + CONVERT(VARCHAR(12),custid)   
    WHERE isfinished = 0
    
    IF @@ROWCOUNT = 0 BREAK
    
    SET @var_msg_index = @var_msg_index + 1
    RAISERROR ('Currently at order %d, SuperID: %s.', 0, 1, @var_msg_index, @srecommend) WITH NOWAIT
    
    EXEC dbo.[DBA_CheckPTGame_for_Line_DCS] @srecommendList=@srecommend, @SportType = 193, @BetType = 2801
    EXEC dbo.[DBA_CheckPTGame_for_Line_DCS] @srecommendList=@srecommend, @SportType = 192, @BetType = 2701
END

SELECT * FROM ##CheckPTResult_Credit
