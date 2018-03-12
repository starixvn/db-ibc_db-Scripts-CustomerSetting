/*
    Created: 20180305@Vicky
    Task: delete customer setting of WC
    DB: DBCUST/CustDB
*/
-- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB ------
------------------------------------------------------
 
ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_09_UAT3]
        @target VARCHAR(20)
AS
BEGIN 
    SET NOCOUNT ON
    
    RAISERROR ('Run at server: %s;', 0, 1, @@SERVERNAME) WITH NOWAIT
    
    IF (@target = 'REPLICATED' AND (@@SERVERNAME = 'DB230\SQLSERVER2008R2' OR @@SERVERNAME = 'DB233' OR @@SERVERNAME = 'DBCUST' OR @@SERVERNAME = 'SITDBCUST')) RETURN -- run at all replicated servers
    IF (@target = 'DBCUST'     AND (@@SERVERNAME = 'DB230\SQLSERVER2008R2' OR @@SERVERNAME = 'DB233' OR @@SERVERNAME = 'DBCUST' OR @@SERVERNAME = 'SITDBCUST')) RETURN -- run at dbcust only
    
    IF dbo.f_CheckRepTable('CustPTSetting3rd_Agent')   = 0 RETURN
    IF dbo.f_CheckRepTable('CustPTSetting3rd_Member')  = 0 RETURN
    IF dbo.f_CheckRepTable('CustPTGroupSetting3rd_Member')  = 0 RETURN
    IF dbo.f_CheckRepTable('CustBetSetting3rd_Agent')  = 0 RETURN
    IF dbo.f_CheckRepTable('CustBetSetting3rd_Member') = 0 RETURN
                
    DECLARE @Sporttype INT, @SporttypeDelegate INT    
            
    SELECT  @Sporttype              = 192, 
            @SporttypeDelegate      = 180
            
   
    
   --SMA LEVEL
    --------------------------------------PT Setting------------------------------------------------- 
    DELETE cg
    FROM CustPTSetting3rd_Agent cg WITH (UPDLOCK,ROWLOCK)        
    WHERE cg.SportType = @Sporttype
    RAISERROR ('Total affected row of SMA PT: %d', 0, 1, @@ROWCOUNT) WITH NOWAIT
    
    DELETE cg
    FROM CustPTGroupSetting3rd_Member cg WITH (UPDLOCK,ROWLOCK)        
    WHERE cg.SportType = @Sporttype
    RAISERROR ('Total affected row of SMA Group PT: %d', 0, 1, @@ROWCOUNT) WITH NOWAIT
    
    ----------------------------------------Bet Game Setting-------------------------------------------------
    DELETE cg
    FROM dbo.CustBetSetting3rd_Agent cg WITH (UPDLOCK,ROWLOCK)       
    WHERE cg.SportType = @Sporttype
    RAISERROR ('Total affected row of SMA BetSetting: %d', 0, 1, @@ROWCOUNT) WITH NOWAIT
    
    
    
    --Member
    --------------------------------------PT Setting------------------------------------------------- 
    DELETE cg
    FROM CustPTSetting3rd_Member cg WITH (UPDLOCK,ROWLOCK)       
    WHERE cg.SportType = @Sporttype
    RAISERROR ('Total affected row of PT: %d', 0, 1, @@ROWCOUNT) WITH NOWAIT
        
    ----------------------------------------Bet Game Setting-------------------------------------------------
    DELETE cg
    FROM dbo.CustBetSetting3rd_Member cg WITH (UPDLOCK,ROWLOCK)      
    WHERE cg.SportType = @Sporttype
    RAISERROR ('Total affected row of BetSetting: %d', 0, 1, @@ROWCOUNT) WITH NOWAIT
          
END 
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------  


-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS -----
--------------------------------------------------------------------------------------
DECLARE @max_custid INT = xxx
DECLARE @var_target VARCHAR(20) = 'REPLICATED'

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
    
    EXEC dbo.Acc_DynamicCustSetting3rd_09
            @srecommend = @srecommend
            ,@maxcustid = @max_custid
            ,@target    = @var_target
            
END
GO


-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
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
    
    EXEC dbo.Acc_DynamicCustSetting3rd_09
            @srecommend = @srecommend
            ,@maxcustid = @max_custid
            ,@target    = @var_target
            
END
GO