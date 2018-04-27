SET NOCOUNT ON
GO
IF OBJECT_ID('tempdb..#tmp94325_DBA_CheckPT_Sportbook_Credit') IS NOT NULL
BEGIN
    DROP PROC #tmp94325_DBA_CheckPT_Sportbook_Credit
END
GO
CREATE PROCEDURE #tmp94325_DBA_CheckPT_Sportbook_Credit
(     @srecommend INT 
) WITH RECOMPILE
AS
 
/*
	Created: 20140313@Vicky
	Task: PT setting for credit customers - sportsbook setting
	DB: DBCUST/CustDB 
*/
BEGIN
    SET NOCOUNT ON 
    CREATE TABLE #MemberPT (CustID INT, recommend INT, mrecommend INT, srecommend INT, sporttype SMALLINT, bettype SMALLINT, spositiontaking SMALLMONEY, mpositiontaking SMALLMONEY, apositiontaking SMALLMONEY, isautompositiontaking BIT, autompositiontaking SMALLMONEY, isautopositiontaking BIT, autopositiontaking SMALLMONEY,
                            slivepositiontaking SMALLMONEY, mlivepositiontaking SMALLMONEY, alivepositiontaking SMALLMONEY, isautolivempositiontaking BIT, autolivempositiontaking SMALLMONEY, isautolivepositiontaking BIT, autolivepositiontaking SMALLMONEY)
    CREATE TABLE #AgentPT (CustID INT, mrecommend INT, srecommend INT, sporttype SMALLINT, bettype SMALLINT, spositiontaking SMALLMONEY, mpositiontaking SMALLMONEY, apositiontaking SMALLMONEY, isautompositiontaking BIT, autompositiontaking SMALLMONEY, isautopositiontaking BIT, autopositiontaking SMALLMONEY, Minpositiontaking SMALLMONEY, Maxpositiontaking SMALLMONEY, 
                            slivepositiontaking SMALLMONEY, mlivepositiontaking SMALLMONEY, alivepositiontaking SMALLMONEY, isautolivempositiontaking BIT, autolivempositiontaking SMALLMONEY, isautolivepositiontaking BIT, autolivepositiontaking SMALLMONEY, MinLivepositiontaking SMALLMONEY, MaxLivepositiontaking SMALLMONEY)
    CREATE TABLE #MasterPT (CustID INT, srecommend INT, sporttype SMALLINT, bettype SMALLINT, spositiontaking SMALLMONEY, mpositiontaking SMALLMONEY, apositiontaking SMALLMONEY, isautompositiontaking BIT, autompositiontaking SMALLMONEY, isautopositiontaking BIT, autopositiontaking SMALLMONEY, Minpositiontaking SMALLMONEY, Maxpositiontaking SMALLMONEY, 
                            slivepositiontaking SMALLMONEY, mlivepositiontaking SMALLMONEY, alivepositiontaking SMALLMONEY, isautolivempositiontaking BIT, autolivempositiontaking SMALLMONEY, isautolivepositiontaking BIT, autolivepositiontaking SMALLMONEY, MinLivepositiontaking SMALLMONEY, MaxLivepositiontaking SMALLMONEY)
    CREATE TABLE #SuperPT (CustID INT, sporttype SMALLINT, bettype SMALLINT, spositiontaking SMALLMONEY, mpositiontaking SMALLMONEY, apositiontaking SMALLMONEY, isautompositiontaking BIT, autompositiontaking SMALLMONEY, isautopositiontaking BIT, autopositiontaking SMALLMONEY, Minpositiontaking SMALLMONEY, Maxpositiontaking SMALLMONEY, 
                            slivepositiontaking SMALLMONEY, mlivepositiontaking SMALLMONEY, alivepositiontaking SMALLMONEY, isautolivempositiontaking BIT, autolivempositiontaking SMALLMONEY, isautolivepositiontaking BIT, autolivepositiontaking SMALLMONEY, MinLivepositiontaking SMALLMONEY, MaxLivepositiontaking SMALLMONEY)
    IF OBJECT_ID('tempdb..##CheckPTResult_Credit') IS NULL
    BEGIN
        CREATE TABLE ##CheckPTResult_Credit (RuleDesc VARCHAR(100), BetType INT, SportType INT, CustIdA INT, CustIdB INT, ValueA INT, ValueB INT, IsLive INT)
    END
    DECLARE @RowCount TINYINT

    SELECT cs.sporttype, cs.bettype
    INTO #DataSample
    FROM dbo.CustSetting cs WITH (NOLOCK)
    WHERE custid = 73104

    SELECT @RowCount = COUNT(1)
    FROM #DataSample
    -- Starting DATA PREPARATION
    INSERT INTO #MemberPT (CustID, recommend, mrecommend, srecommend, sporttype, bettype, spositiontaking, mpositiontaking, apositiontaking, isautompositiontaking, autompositiontaking, isautopositiontaking, autopositiontaking,
                            slivepositiontaking, mlivepositiontaking, alivepositiontaking, isautolivempositiontaking, autolivempositiontaking, isautolivepositiontaking, autolivepositiontaking)
    SELECT ci.CustID, recommend, mrecommend, srecommend, sporttype, bettype, spositiontaking, mpositiontaking, apositiontaking, isautompositiontaking, autompositiontaking, isautopositiontaking, autopositiontaking,
                            slivepositiontaking, mlivepositiontaking, alivepositiontaking, isautolivempositiontaking, autolivempositiontaking, isautolivepositiontaking, autolivepositiontaking
    FROM dbo.CustInfo ci
        INNER JOIN dbo.CustSetting cs WITH (NOLOCK) ON ci.CustID = cs.CustID
    WHERE ci.srecommend = @srecommend  
            AND ci.roleid = 1  
    
    INSERT INTO #AgentPT (CustID, mrecommend, srecommend, sporttype, bettype, spositiontaking, mpositiontaking, apositiontaking, isautompositiontaking, autompositiontaking, isautopositiontaking, autopositiontaking, Minpositiontaking, Maxpositiontaking,
                            slivepositiontaking, mlivepositiontaking, alivepositiontaking, isautolivempositiontaking, autolivempositiontaking, isautolivepositiontaking, autolivepositiontaking, MinLivepositiontaking, MaxLivepositiontaking)
    SELECT ci.CustID, mrecommend, srecommend, cs.sporttype, cs.bettype, spositiontaking, mpositiontaking, apositiontaking, isautompositiontaking, autompositiontaking, isautopositiontaking, autopositiontaking, Minpositiontaking, Maxpositiontaking,
                            slivepositiontaking, mlivepositiontaking, alivepositiontaking, isautolivempositiontaking, autolivempositiontaking, isautolivepositiontaking, autolivepositiontaking, MinLivepositiontaking, MaxLivepositiontaking
    FROM dbo.CustInfo ci
        INNER JOIN dbo.CustSetting cs WITH (NOLOCK) ON ci.CustID = cs.CustID
        INNER JOIN dbo.custoverride co WITH (NOLOCK) ON ci.CustID = co.CustID AND co.sporttype = cs.sporttype AND co.bettype = cs.bettype
    WHERE ci.srecommend = @srecommend  
            AND ci.roleid = 2  

    INSERT INTO #MasterPT (CustID, srecommend, sporttype, bettype, spositiontaking, mpositiontaking, apositiontaking, isautompositiontaking, autompositiontaking, isautopositiontaking, autopositiontaking, Minpositiontaking, Maxpositiontaking,
                            slivepositiontaking, mlivepositiontaking, alivepositiontaking, isautolivempositiontaking, autolivempositiontaking, isautolivepositiontaking, autolivepositiontaking, MinLivepositiontaking, MaxLivepositiontaking)
    SELECT ci.CustID, srecommend, cs.sporttype, cs.bettype, spositiontaking, mpositiontaking, apositiontaking, isautompositiontaking, autompositiontaking, isautopositiontaking, autopositiontaking, Minpositiontaking, Maxpositiontaking,
                            slivepositiontaking, mlivepositiontaking, alivepositiontaking, isautolivempositiontaking, autolivempositiontaking, isautolivepositiontaking, autolivepositiontaking, MinLivepositiontaking, MaxLivepositiontaking
    FROM dbo.CustInfo ci
        INNER JOIN dbo.CustSetting cs WITH (NOLOCK) ON ci.CustID = cs.CustID
        INNER JOIN dbo.custoverride co WITH (NOLOCK) ON ci.CustID = co.CustID AND co.sporttype = cs.sporttype AND co.bettype = cs.bettype
    WHERE ci.srecommend = @srecommend  
            AND ci.roleid = 3

    INSERT INTO #SuperPT (CustID, sporttype, bettype, spositiontaking, mpositiontaking, apositiontaking, isautompositiontaking, autompositiontaking, isautopositiontaking, autopositiontaking, Minpositiontaking, Maxpositiontaking,
                            slivepositiontaking, mlivepositiontaking, alivepositiontaking, isautolivempositiontaking, autolivempositiontaking, isautolivepositiontaking, autolivepositiontaking, MinLivepositiontaking, MaxLivepositiontaking)
    SELECT ci.CustID, cs.sporttype, cs.bettype, spositiontaking, mpositiontaking, apositiontaking, isautompositiontaking, autompositiontaking, isautopositiontaking, autopositiontaking, Minpositiontaking, Maxpositiontaking,
                            slivepositiontaking, mlivepositiontaking, alivepositiontaking, isautolivempositiontaking, autolivempositiontaking, isautolivepositiontaking, autolivepositiontaking, MinLivepositiontaking, MaxLivepositiontaking
    FROM dbo.CustInfo ci
        INNER JOIN dbo.CustSetting cs WITH (NOLOCK) ON ci.CustID = cs.CustID
        INNER JOIN dbo.custoverride co WITH (NOLOCK) ON ci.CustID = co.CustID AND co.sporttype = cs.sporttype AND co.bettype = cs.bettype
    WHERE ci.custid = @srecommend  
        
    SELECT CustID, COUNT(1) cnt
    INTO #MemberMissSetting
    FROM #MemberPT 
    GROUP BY CustID
    HAVING COUNT(1) < @RowCount

    SELECT CustID, COUNT(1) cnt
    INTO #AgentMissSetting
    FROM #AgentPT 
    GROUP BY CustID
    HAVING COUNT(1) < @RowCount

    SELECT CustID, COUNT(1) cnt
    INTO #MasterMissSetting
    FROM #MasterPT 
    GROUP BY CustID
    HAVING COUNT(1) < @RowCount

    SELECT CustID, COUNT(1) cnt
    INTO #SuperMissSetting
    FROM #SuperPT 
    GROUP BY CustID
    HAVING COUNT(1) < @RowCount
    
    --Miss all Sportbook setting
    INSERT INTO #MemberMissSetting (CustID) 
    SELECT CustID
    FROM dbo.custInfo ci WITH (NOLOCK)
    WHERE ci.srecommend = @srecommend
        AND ci.roleid = 1
        AND NOT EXISTS (SELECT 1 FROM #MemberPT WHERE CustID = ci.custid)

    INSERT INTO #AgentMissSetting (CustID)          
    SELECT CustID
    FROM dbo.custInfo ci WITH (NOLOCK)
    WHERE ci.srecommend = @srecommend
        AND ci.roleid = 2
        AND NOT EXISTS (SELECT 1 FROM #AgentPT WHERE CustID = ci.custid)

    INSERT INTO #MasterMissSetting (CustID)             
    SELECT CustID
    FROM dbo.custInfo ci WITH (NOLOCK)
    WHERE ci.srecommend = @srecommend
        AND ci.roleid = 3
        AND NOT EXISTS (SELECT 1 FROM #MasterPT WHERE CustID = ci.custid)

    INSERT INTO #SuperMissSetting (CustID)                      
    SELECT CustID
    FROM dbo.custInfo ci WITH (NOLOCK)
    WHERE ci.custid = @srecommend
        AND ci.roleid = 4
        AND NOT EXISTS (SELECT 1 FROM #SuperPT WHERE CustID = ci.custid)
    -- End DATA PREPARATION

    --Check a number of setting rows
    INSERT INTO ##CheckPTResult_Credit (RuleDesc, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive) 
    SELECT  'Miss setting', ds.bettype, ds.sporttype, cs.CustID, cs.CustID, 0, 0, 0
    FROM    #MemberMissSetting cs
        CROSS APPLY (SELECT sporttype, bettype FROM #DataSample) ds
    WHERE NOT EXISTS (SELECT 1 FROM #MemberPT WHERE CustID = cs.CustID AND sporttype = ds.sporttype AND bettype = ds.bettype)
        
    INSERT INTO ##CheckPTResult_Credit (RuleDesc, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive) 
    SELECT  'Miss setting', ds.bettype, ds.sporttype, cs.CustID, cs.CustID, 0, 0, 0
    FROM    #AgentMissSetting cs
        CROSS APPLY (SELECT sporttype, bettype FROM #DataSample) ds
    WHERE NOT EXISTS (SELECT 1 FROM #AgentPT WHERE CustID = cs.CustID AND sporttype = ds.sporttype AND bettype = ds.bettype)
    
    INSERT INTO ##CheckPTResult_Credit (RuleDesc, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive) 
    SELECT  'Miss setting', ds.bettype, ds.sporttype, cs.CustID, cs.CustID, 0, 0, 0
    FROM    #MasterMissSetting cs
        CROSS APPLY (SELECT sporttype, bettype FROM #DataSample) ds
    WHERE NOT EXISTS (SELECT 1 FROM #MasterPT WHERE CustID = cs.CustID AND sporttype = ds.sporttype AND bettype = ds.bettype)

    INSERT INTO ##CheckPTResult_Credit (RuleDesc, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive) 
    SELECT  'Miss setting', ds.bettype, ds.sporttype, cs.CustID, cs.CustID, 0, 0, 0
    FROM    #SuperMissSetting cs
        CROSS APPLY (SELECT sporttype, bettype FROM #DataSample) ds
    WHERE NOT EXISTS (SELECT 1 FROM #SuperPT WHERE CustID = cs.CustID AND sporttype = ds.sporttype AND bettype = ds.bettype)

---- 1. S1 < 0 OR M1 < 0 OR A1 < 0
BEGIN
    INSERT INTO ##CheckPTResult_Credit (RuleDesc, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive) 
    SELECT  '1. S1 < 0 OR M1 < 0 OR A1 < 0', cs.BetType, cs.SportType, cs.CustId, cs.CustId,
            CASE WHEN cs.spositiontaking < 0 THEN cs.spositiontaking 
                    WHEN cs.mpositiontaking < 0 THEN cs.mpositiontaking 
                    WHEN cs.apositiontaking < 0 THEN cs.apositiontaking
            ELSE 0
            END,
            0, 
            0
    FROM    #MemberPT cs
    WHERE   (cs.spositiontaking < 0 OR cs.mpositiontaking < 0 OR cs.apositiontaking < 0)
    
    INSERT INTO ##CheckPTResult_Credit (RuleDesc, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive) 
    SELECT  '1. S1 < 0 OR M1 < 0 OR A1 < 0', cs.BetType, cs.SportType, cs.CustId, cs.CustId,
            CASE WHEN cs.slivepositiontaking < 0 THEN cs.slivepositiontaking 
                    WHEN cs.mlivepositiontaking < 0 THEN cs.mlivepositiontaking 
                    WHEN cs.alivepositiontaking < 0 THEN cs.alivepositiontaking
            ELSE 0
            END,
            0,
            1
    FROM    #MemberPT cs
    WHERE   cs.Bettype IN (1,3,7,8)
        AND (cs.slivepositiontaking < 0 OR cs.mlivepositiontaking < 0 OR cs.alivepositiontaking < 0)
END

----2. S4 > 0.9 OR M4 > 0.9 OR A4 > 0.9 
BEGIN
    INSERT INTO ##CheckPTResult_Credit (RuleDesc, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
    SELECT  '2. S4 > 0.9 OR M4 > 0.9 OR A4 > 0.9 ', cs.BetType, cs.SportType, cs.CustId, cs.CustId,
            CASE WHEN cs.spositiontaking > 0.9 THEN cs.spositiontaking 
                    WHEN cs.mpositiontaking > 0.9 THEN cs.mpositiontaking 
                    WHEN cs.apositiontaking > 0.9 THEN cs.apositiontaking   
            ELSE 0.9    
            END,
            0.9,
            0
    FROM    #SuperPT cs
    WHERE   (cs.spositiontaking > 0.9 OR cs.mpositiontaking > 0.9 OR cs.apositiontaking > 0.9)
        
    INSERT INTO ##CheckPTResult_Credit (RuleDesc, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
    SELECT  '2. S4 > 0.9 OR M4 > 0.9 OR A4 > 0.9 ', cs.BetType, cs.SportType, cs.CustId, cs.CustId,
            CASE WHEN cs.slivepositiontaking > 0.9 THEN cs.slivepositiontaking 
                    WHEN cs.mlivepositiontaking > 0.9 THEN cs.mlivepositiontaking 
                    WHEN cs.alivepositiontaking > 0.9 THEN cs.alivepositiontaking   
            ELSE 0.9    
            END,
            0.9,
            1
    FROM    #SuperPT cs
    WHERE   cs.Bettype IN (1,3,7,8)
        AND (cs.slivepositiontaking > 0.9 OR cs.mlivepositiontaking > 0.9 OR cs.alivepositiontaking > 0.9)
END


----3. S4 < M4 
BEGIN 
    INSERT INTO ##CheckPTResult_Credit (RuleDesc, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
    SELECT  '3. S4 < M4', cs.BetType, cs.SportType, cs.CustId, cs.CustId, cs.spositiontaking, cs.mpositiontaking, 0
    FROM #SuperPT cs    
    WHERE cs.spositiontaking < cs.mpositiontaking 

    INSERT INTO ##CheckPTResult_Credit (RuleDesc, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
    SELECT  '3. S4 < M4', cs.BetType, cs.SportType, cs.CustId, cs.CustId, cs.slivepositiontaking, cs.mlivepositiontaking, 1
    FROM #SuperPT cs    
    WHERE cs.Bettype IN (1,3,7,8)
        AND cs.slivepositiontaking < cs.mlivepositiontaking     
END

----4. S4 < A4
BEGIN 
    INSERT INTO ##CheckPTResult_Credit (RuleDesc, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
    SELECT  '4. S4 < A4', cs.BetType, cs.SportType, cs.CustId, cs.CustId, cs.spositiontaking, cs.apositiontaking, 0
    FROM #SuperPT cs    
    WHERE cs.spositiontaking < cs.apositiontaking 

    INSERT INTO ##CheckPTResult_Credit (RuleDesc, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
    SELECT  '4. S4 < A4', cs.BetType, cs.SportType, cs.CustId, cs.CustId, cs.slivepositiontaking, cs.alivepositiontaking, 1
    FROM #SuperPT cs    
    WHERE cs.Bettype IN (1,3,7,8)
        AND cs.slivepositiontaking < cs.alivepositiontaking 
END

----5. S4 < N4  
BEGIN 
    INSERT INTO ##CheckPTResult_Credit (RuleDesc, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
    SELECT  '5. S4 < N4', cs.BetType, cs.SportType, cs.CustId, cs.CustId, cs.spositiontaking, cs.minpositiontaking, 0
    FROM #SuperPT cs
    WHERE cs.spositiontaking < cs.minpositiontaking

    INSERT INTO ##CheckPTResult_Credit (RuleDesc, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
    SELECT  '5. S4 < N4', cs.BetType, cs.SportType, cs.CustId, cs.CustId, cs.slivepositiontaking, cs.minlivepositiontaking, 1
    FROM #SuperPT cs
    WHERE cs.Bettype IN (1,3,7,8)
        AND cs.slivepositiontaking < cs.minlivepositiontaking
END
 
    ----6. S4 < US3 
BEGIN 
    INSERT INTO ##CheckPTResult_Credit (RuleDesc, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
    SELECT  '6. S4 < US3 ', cs.BetType, cs.SportType, scs.CustId, cs.CustId, scs.spositiontaking , cs.autopositiontaking, 0
    FROM    #SuperPT scs            
        INNER JOIN  #MasterPT cs ON cs.srecommend = scs.CustId AND cs.bettype = scs.bettype AND cs.sporttype = scs.sporttype            
    WHERE   scs.spositiontaking < cs.autopositiontaking

    INSERT INTO ##CheckPTResult_Credit (RuleDesc, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
    SELECT  '6. S4 < US3 ', cs.BetType, cs.SportType, scs.CustId, cs.CustId, scs.slivepositiontaking , cs.autolivepositiontaking, 1
    FROM    #SuperPT scs            
        INNER JOIN  #MasterPT cs ON cs.srecommend = scs.CustId AND cs.bettype = scs.bettype AND cs.sporttype = scs.sporttype            
    WHERE   scs.Bettype IN (1,3,7,8)
        AND scs.slivepositiontaking < cs.autolivepositiontaking
END

----7. S4 < US1 
BEGIN 
    INSERT INTO ##CheckPTResult_Credit (RuleDesc, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
    SELECT  '7. S4 < US1 ', cs.BetType, cs.SportType, scs.CustId, cs.CustId, scs.spositiontaking, cs.autopositiontaking, 0
    FROM    #SuperPT scs            
        INNER JOIN  #MemberPT cs ON cs.srecommend = scs.CustId AND cs.bettype = scs.bettype AND cs.sporttype = scs.sporttype 
    WHERE scs.spositiontaking < cs.autopositiontaking

    INSERT INTO ##CheckPTResult_Credit (RuleDesc, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
    SELECT  '7. S4 < US1 ', cs.BetType, cs.SportType, scs.CustId, cs.CustId, scs.slivepositiontaking, cs.autolivepositiontaking, 1
    FROM    #SuperPT scs            
        INNER JOIN  #MemberPT cs ON cs.srecommend = scs.CustId AND cs.bettype = scs.bettype AND cs.sporttype = scs.sporttype 
    WHERE scs.Bettype IN (1,3,7,8)
        AND scs.slivepositiontaking < cs.autolivepositiontaking
END

----8. S4 < S3 + M3 
BEGIN 
    INSERT INTO ##CheckPTResult_Credit (RuleDesc, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
    SELECT  '8. S4 < S3 + M3' , cs.BetType, cs.SportType, scs.CustId, cs.CustId, scs.spositiontaking, cs.spositiontaking + cs.mpositiontaking, 0
    FROM    #SuperPT scs            
        INNER JOIN  #MasterPT cs ON cs.srecommend = scs.CustId AND cs.bettype = scs.bettype AND cs.sporttype = scs.sporttype
    WHERE scs.spositiontaking < cs.spositiontaking + cs.mpositiontaking

    INSERT INTO ##CheckPTResult_Credit (RuleDesc, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
    SELECT  '8. S4 < S3 + M3', cs.BetType, cs.SportType, scs.CustId, cs.CustId, scs.slivepositiontaking, cs.slivepositiontaking + cs.mlivepositiontaking, 1
    FROM    #SuperPT scs            
        INNER JOIN  #MasterPT cs ON cs.srecommend = scs.CustId AND cs.bettype = scs.bettype AND cs.sporttype = scs.sporttype
    WHERE scs.Bettype IN (1,3,7,8)
        AND scs.slivepositiontaking < cs.slivepositiontaking + cs.mlivepositiontaking
END

----9. S4 < S1 + M1 + A1 
BEGIN 
    INSERT INTO ##CheckPTResult_Credit (RuleDesc, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
    SELECT  '9. S4 < S1 + M1 + A1', cs.BetType, cs.SportType, scs.CustId, cs.CustId, scs.spositiontaking, cs.spositiontaking + cs.mpositiontaking + cs.apositiontaking, 0
    FROM    #SuperPT scs            
        INNER JOIN  #MemberPT cs ON cs.srecommend = scs.CustId AND cs.bettype = scs.bettype AND cs.sporttype = scs.sporttype
    WHERE scs.spositiontaking < cs.spositiontaking + cs.mpositiontaking + cs.apositiontaking

    INSERT INTO ##CheckPTResult_Credit (RuleDesc, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
    SELECT  '9. S4 < S1 + M1 + A1', cs.BetType, cs.SportType, scs.CustId, cs.CustId, scs.slivepositiontaking, cs.slivepositiontaking + cs.mlivepositiontaking + cs.alivepositiontaking, 1
    FROM    #SuperPT scs            
        INNER JOIN  #MemberPT cs ON cs.srecommend = scs.CustId AND cs.bettype = scs.bettype AND cs.sporttype = scs.sporttype
    WHERE scs.Bettype IN (1,3,7,8)
        AND scs.slivepositiontaking < cs.slivepositiontaking + cs.mlivepositiontaking + cs.alivepositiontaking
END

----10. N4 > S1 + M1 + A1  
BEGIN 
    INSERT INTO ##CheckPTResult_Credit (RuleDesc, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
    SELECT  '10. N4 > S1 + M1 + A1', cs.BetType, cs.SportType, scs.CustId, cs.CustId, scs.minpositiontaking, cs.spositiontaking + cs.mpositiontaking + cs.apositiontaking, 0
    FROM    #SuperPT scs        
        INNER JOIN  #MemberPT cs ON cs.srecommend = scs.CustId AND cs.bettype = scs.bettype AND cs.sporttype = scs.sporttype
    WHERE scs.minpositiontaking > cs.spositiontaking + cs.mpositiontaking + cs.apositiontaking

    INSERT INTO ##CheckPTResult_Credit (RuleDesc, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
    SELECT  '10. N4 > S1 + M1 + A1', cs.BetType, cs.SportType, scs.CustId, cs.CustId, scs.minlivepositiontaking, cs.slivepositiontaking + cs.mlivepositiontaking + cs.alivepositiontaking, 1
    FROM    #SuperPT scs        
        INNER JOIN  #MemberPT cs ON cs.srecommend = scs.CustId AND cs.bettype = scs.bettype AND cs.sporttype = scs.sporttype
    WHERE scs.Bettype IN (1,3,7,8)
        AND scs.minlivepositiontaking > cs.slivepositiontaking + cs.mlivepositiontaking + cs.alivepositiontaking
END

-----------------------------------------------------------------------
----11. M4 < A4
BEGIN 
    INSERT INTO ##CheckPTResult_Credit (RuleDesc, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
    SELECT  '11. M4 < A4', cs.BetType, cs.SportType, cs.CustId, cs.CustId, cs.mpositiontaking, cs.apositiontaking, 0
    FROM #SuperPT cs
    WHERE cs.mpositiontaking < cs.apositiontaking 

    INSERT INTO ##CheckPTResult_Credit (RuleDesc, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
    SELECT  '11. M4 < A4', cs.BetType, cs.SportType, cs.CustId, cs.CustId, cs.mlivepositiontaking, cs.alivepositiontaking, 1
    FROM #SuperPT cs
    WHERE cs.Bettype IN (1,3,7,8)
        AND cs.mlivepositiontaking < cs.alivepositiontaking 
END
    
----12. M4 < M3 
BEGIN
    INSERT INTO ##CheckPTResult_Credit (RuleDesc, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
    SELECT  '12. M4 < M3', cs.BetType, cs.SportType, scs.CustId, cs.CustId, scs.mpositiontaking, cs.mpositiontaking, 0
    FROM    #SuperPT scs        
        INNER JOIN  #MasterPT cs ON cs.srecommend = scs.CustId AND cs.bettype = scs.bettype AND cs.sporttype = scs.sporttype
    WHERE scs.mpositiontaking < cs.mpositiontaking 

    INSERT INTO ##CheckPTResult_Credit (RuleDesc, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
    SELECT  '12. M4 < M3', cs.BetType, cs.SportType, scs.CustId, cs.CustId, scs.mlivepositiontaking, cs.mlivepositiontaking, 1
    FROM    #SuperPT scs        
        INNER JOIN  #MasterPT cs ON cs.srecommend = scs.CustId AND cs.bettype = scs.bettype AND cs.sporttype = scs.sporttype
    WHERE scs.Bettype IN (1,3,7,8)
        AND scs.mlivepositiontaking < cs.mlivepositiontaking 
END 

----13. M4 < N3 
BEGIN
    INSERT INTO ##CheckPTResult_Credit (RuleDesc, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
    SELECT  '13. M4 < N3 ', scs.BetType, scs.SportType, scs.CustId, cs.CustId, scs.mpositiontaking , cs.minpositiontaking, 0
    FROM    #SuperPT scs        
        INNER JOIN  #MasterPT cs ON cs.srecommend = scs.CustId AND cs.bettype = scs.bettype AND cs.sporttype = scs.sporttype
    WHERE scs.mpositiontaking < cs.minpositiontaking 

    INSERT INTO ##CheckPTResult_Credit (RuleDesc, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
    SELECT  '13. M4 < N3 ', scs.BetType, scs.SportType, scs.CustId, cs.CustId, scs.mlivepositiontaking , cs.minlivepositiontaking, 1
    FROM    #SuperPT scs        
        INNER JOIN  #MasterPT cs ON cs.srecommend = scs.CustId AND cs.bettype = scs.bettype AND cs.sporttype = scs.sporttype
    WHERE scs.Bettype IN (1,3,7,8)
        AND scs.mlivepositiontaking < cs.minlivepositiontaking 
END

----14. M4 < UM2 
BEGIN
    INSERT INTO ##CheckPTResult_Credit (RuleDesc, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
    SELECT  '14. M4 < UM2', cs.BetType, cs.SportType, scs.CustId, cs.CustId, scs.mpositiontaking, cs.autompositiontaking, 0
    FROM    #SuperPT scs        
        INNER JOIN  #AgentPT cs ON  cs.srecommend = scs.CustId AND cs.bettype = scs.bettype AND cs.sporttype = scs.sporttype
    WHERE scs.mpositiontaking < cs.autompositiontaking

    INSERT INTO ##CheckPTResult_Credit (RuleDesc, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
    SELECT  '14. M4 < UM2', cs.BetType, cs.SportType, scs.CustId, cs.CustId, scs.mlivepositiontaking, cs.autolivempositiontaking, 1
    FROM    #SuperPT scs        
        INNER JOIN  #AgentPT cs ON  cs.srecommend = scs.CustId AND cs.bettype = scs.bettype AND cs.sporttype = scs.sporttype
    WHERE scs.Bettype IN (1,3,7,8)
        AND scs.mlivepositiontaking < cs.autolivempositiontaking
END

----15. M4 < UM1 
BEGIN
    INSERT INTO ##CheckPTResult_Credit (RuleDesc, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
    SELECT  '15. M4 < UM1', cs.BetType, cs.SportType, scs.CustId, cs.CustId, scs.mpositiontaking, cs.autompositiontaking, 0
    FROM    #SuperPT scs        
        INNER JOIN  #MemberPT cs ON cs.srecommend = scs.CustId AND cs.bettype = scs.bettype AND cs.sporttype = scs.sporttype
    WHERE scs.mpositiontaking < cs.autompositiontaking

    INSERT INTO ##CheckPTResult_Credit (RuleDesc, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
    SELECT  '15. M4 < UM1', cs.BetType, cs.SportType, scs.CustId, cs.CustId, scs.mlivepositiontaking, cs.autolivempositiontaking, 1
    FROM    #SuperPT scs        
        INNER JOIN  #MemberPT cs ON cs.srecommend = scs.CustId AND cs.bettype = scs.bettype AND cs.sporttype = scs.sporttype
    WHERE scs.Bettype IN (1,3,7,8)
        AND scs.mlivepositiontaking < cs.autolivempositiontaking
END

----16. M4 < M1 + A1 
BEGIN
    INSERT INTO ##CheckPTResult_Credit (RuleDesc, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
    SELECT  '16. M4 < M1 + A1', cs.BetType, cs.SportType, scs.CustId, cs.CustId, scs.mpositiontaking , cs.mpositiontaking + cs.apositiontaking, 0
    FROM    #SuperPT scs        
        INNER JOIN  #MemberPT cs ON cs.srecommend = scs.CustId AND cs.bettype = scs.bettype AND cs.sporttype = scs.sporttype
    WHERE scs.mpositiontaking < cs.mpositiontaking + cs.apositiontaking

    INSERT INTO ##CheckPTResult_Credit (RuleDesc, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
    SELECT  '16. M4 < M1 + A1', cs.BetType, cs.SportType, scs.CustId, cs.CustId, scs.mlivepositiontaking , cs.mlivepositiontaking + cs.alivepositiontaking, 1
    FROM    #SuperPT scs        
        INNER JOIN  #MemberPT cs ON cs.srecommend = scs.CustId AND cs.bettype = scs.bettype AND cs.sporttype = scs.sporttype
    WHERE scs.Bettype IN (1,3,7,8)
        AND scs.mlivepositiontaking < cs.mlivepositiontaking + cs.alivepositiontaking
END
  
----17. M3 < N3 
BEGIN
    INSERT INTO ##CheckPTResult_Credit (RuleDesc, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
    SELECT  '17. M3 < N3', cs.BetType, cs.SportType, cs.CustId, cs.CustId, cs.mpositiontaking, cs.minpositiontaking, 0
    FROM #MasterPT cs
    WHERE cs.mpositiontaking < cs.minpositiontaking

    INSERT INTO ##CheckPTResult_Credit (RuleDesc, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
    SELECT  '17. M3 < N3', cs.BetType, cs.SportType, cs.CustId, cs.CustId, cs.mlivepositiontaking, cs.minlivepositiontaking, 1
    FROM #MasterPT cs
    WHERE cs.Bettype IN (1,3,7,8)
        AND cs.mlivepositiontaking < cs.minlivepositiontaking
END

--------------------------------------------------------------------------------------------
----18. M3 < M2 + A2 
BEGIN 
    INSERT INTO ##CheckPTResult_Credit (RuleDesc, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
    SELECT  '18. M3 < M2 + A2', cs.BetType, cs.SportType, mcs.CustId, cs.CustId, mcs.mpositiontaking, cs.mpositiontaking + cs.apositiontaking, 0
    FROM    #MasterPT mcs       
        INNER JOIN  #AgentPT cs ON  cs.mrecommend = mcs.CustId AND cs.bettype = mcs.bettype AND cs.sporttype = mcs.sporttype
    WHERE mcs.mpositiontaking < cs.mpositiontaking + cs.apositiontaking


    INSERT INTO ##CheckPTResult_Credit (RuleDesc, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
    SELECT  '18. M3 < M2 + A2', cs.BetType, cs.SportType, mcs.CustId, cs.CustId, mcs.mlivepositiontaking, cs.mlivepositiontaking + cs.alivepositiontaking, 1
    FROM    #MasterPT mcs       
        INNER JOIN  #AgentPT cs ON  cs.mrecommend = mcs.CustId AND cs.bettype = mcs.bettype AND cs.sporttype = mcs.sporttype
    WHERE cs.Bettype IN (1,3,7,8)               
        AND mcs.mlivepositiontaking < cs.mlivepositiontaking + cs.alivepositiontaking
END

----19. M3 < M1 + A1 
BEGIN 
    INSERT INTO ##CheckPTResult_Credit (RuleDesc, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
    SELECT  '19. M3 < M1 + A1', cs.BetType, cs.SportType, mcs.CustId, cs.CustId, mcs.mpositiontaking, cs.mpositiontaking + cs.apositiontaking, 0
    FROM    #MasterPT mcs       
        INNER JOIN  #MemberPT cs ON cs.mrecommend = mcs.CustId AND cs.bettype = mcs.bettype AND cs.sporttype = mcs.sporttype
    WHERE mcs.mpositiontaking < cs.mpositiontaking + cs.apositiontaking

    INSERT INTO ##CheckPTResult_Credit (RuleDesc, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
    SELECT  '19. M3 < M1 + A1', cs.BetType, cs.SportType, mcs.CustId, cs.CustId, mcs.mlivepositiontaking, cs.mlivepositiontaking + cs.alivepositiontaking, 1
    FROM    #MasterPT mcs       
        INNER JOIN  #AgentPT cs ON  cs.mrecommend = mcs.CustId AND cs.bettype = mcs.bettype AND cs.sporttype = mcs.sporttype
    WHERE cs.Bettype IN (1,3,7,8)
        AND mcs.mlivepositiontaking < cs.mlivepositiontaking + cs.alivepositiontaking
END
   
----20. N3 > M1 + A1 
BEGIN
    INSERT INTO ##CheckPTResult_Credit (RuleDesc, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
    SELECT  '20. N3 > M1 + A1', cs.BetType, cs.SportType, mcs.CustId, cs.CustId, mcs.minpositiontaking, cs.mpositiontaking + cs.apositiontaking, 0
    FROM    #MasterPT mcs       
        INNER JOIN  #MemberPT cs ON cs.mrecommend = mcs.CustId AND cs.bettype = mcs.bettype AND cs.sporttype = mcs.sporttype
    WHERE mcs.minpositiontaking > cs.mpositiontaking + cs.apositiontaking

    INSERT INTO ##CheckPTResult_Credit (RuleDesc, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
    SELECT  '20. N3 > M1 + A1', cs.BetType, cs.SportType, mcs.CustId, cs.CustId, mcs.minlivepositiontaking, cs.mlivepositiontaking + cs.alivepositiontaking, 1
    FROM    #MasterPT mcs       
        INNER JOIN  #MemberPT cs ON cs.mrecommend = mcs.CustId AND cs.bettype = mcs.bettype AND cs.sporttype = mcs.sporttype
    WHERE cs.Bettype IN (1,3,7,8)
        AND mcs.minlivepositiontaking > cs.mlivepositiontaking + cs.alivepositiontaking
END  
 
----21. A4 < A2
BEGIN 
    INSERT INTO ##CheckPTResult_Credit (RuleDesc, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLIve)
    SELECT  '21. A4 < A2', cs.BetType, cs.SportType, scs.CustId, cs.CustId, scs.apositiontaking, cs.apositiontaking, 0
    FROM    #SuperPT scs        
        INNER JOIN  #AgentPT cs ON  cs.srecommend = scs.CustId AND cs.bettype = scs.bettype AND cs.sporttype = scs.sporttype
    WHERE scs.apositiontaking < cs.apositiontaking 

    INSERT INTO ##CheckPTResult_Credit (RuleDesc, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLIve)
    SELECT  '21. A4 < A2', cs.BetType, cs.SportType, scs.CustId, cs.CustId, scs.alivepositiontaking, cs.alivepositiontaking, 1
    FROM    #SuperPT scs        
        INNER JOIN  #AgentPT cs ON  cs.srecommend = scs.CustId AND cs.bettype = scs.bettype AND cs.sporttype = scs.sporttype
    WHERE scs.Bettype IN (1,3,7,8)
        AND scs.alivepositiontaking < cs.alivepositiontaking 
END 

----22. A4 < A1
BEGIN
    INSERT INTO ##CheckPTResult_Credit (RuleDesc, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
    SELECT  '22. A4 < A1', cs.BetType, cs.SportType, scs.CustId, cs.CustId, scs.apositiontaking, cs.apositiontaking, 0
    FROM    #SuperPT scs        
        INNER JOIN  #MemberPT cs ON cs.srecommend = scs.CustId AND cs.bettype = scs.bettype AND cs.sporttype = scs.sporttype
    WHERE scs.apositiontaking < cs.apositiontaking 

    INSERT INTO ##CheckPTResult_Credit (RuleDesc, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
    SELECT  '22. A4 < A1', cs.BetType, cs.SportType, scs.CustId, cs.CustId, scs.alivepositiontaking, cs.alivepositiontaking, 1
    FROM    #SuperPT scs        
        INNER JOIN  #MemberPT cs ON cs.srecommend = scs.CustId AND cs.bettype = scs.bettype AND cs.sporttype = scs.sporttype
    WHERE scs.Bettype IN (1,3,7,8)
        AND scs.alivepositiontaking < cs.alivepositiontaking 
END 

----23. A2 < N2
BEGIN 
    INSERT INTO ##CheckPTResult_Credit (RuleDesc, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
    SELECT  '23. A2 < N2', cs.BetType, cs.SportType, cs.CustId, cs.CustId, cs.apositiontaking, cs.minpositiontaking, 0
    FROM    #AgentPT cs     
    WHERE cs.apositiontaking < cs.minpositiontaking

    INSERT INTO ##CheckPTResult_Credit (RuleDesc, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
    SELECT  '23. A2 < N2', cs.BetType, cs.SportType, cs.CustId, cs.CustId, cs.alivepositiontaking, cs.minlivepositiontaking, 1
    FROM    #AgentPT cs     
    WHERE cs.Bettype IN (1,3,7,8)
        AND cs.alivepositiontaking < cs.minlivepositiontaking
END 
 
----24. N2 > A1
BEGIN
    INSERT INTO ##CheckPTResult_Credit (RuleDesc, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
    SELECT  '24. N2 > A1', cs.BetType, cs.SportType, acs.CustId, cs.CustId, acs.minpositiontaking, cs.apositiontaking, 0 
    FROM    #AgentPT acs        
        INNER JOIN  #MemberPT cs ON cs.recommend = acs.CustId AND cs.bettype = acs.bettype AND cs.sporttype = acs.sporttype
    WHERE   acs.minpositiontaking > cs.apositiontaking 

    INSERT INTO ##CheckPTResult_Credit (RuleDesc, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
    SELECT  '24. N2 > A1', cs.BetType, cs.SportType, acs.CustId, cs.CustId, acs.minlivepositiontaking, cs.alivepositiontaking, 1 
    FROM    #AgentPT acs        
        INNER JOIN  #MemberPT cs ON cs.recommend = acs.CustId AND cs.bettype = acs.bettype AND cs.sporttype = acs.sporttype
    WHERE   cs.Bettype IN (1,3,7,8)
        AND acs.minlivepositiontaking > cs.alivepositiontaking 
END
 
    ---------------------------------------------------
---- 25. L4 < S1 + M1 + A1 
BEGIN 
    INSERT INTO ##CheckPTResult_Credit (RuleDesc, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
    SELECT  '25. L4 < S1 + M1 + A1', cs.BetType, cs.SportType, scs.CustId, cs.CustId, scs.maxpositiontaking, cs.spositiontaking + cs.mpositiontaking + cs.apositiontaking, 0
    FROM    #SuperPT scs        
        INNER JOIN  #MemberPT cs ON cs.srecommend = scs.CustId AND cs.bettype = scs.bettype AND cs.sporttype = scs.sporttype
    WHERE scs.maxpositiontaking < cs.spositiontaking + cs.mpositiontaking + cs.apositiontaking

    INSERT INTO ##CheckPTResult_Credit (RuleDesc, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
    SELECT  '25. L4 < S1 + M1 + A1', cs.BetType, cs.SportType, scs.CustId, cs.CustId, scs.maxlivepositiontaking, cs.slivepositiontaking + cs.mlivepositiontaking + cs.alivepositiontaking, 1
    FROM    #SuperPT scs        
        INNER JOIN  #MemberPT cs ON cs.srecommend = scs.CustId AND cs.bettype = scs.bettype AND cs.sporttype = scs.sporttype
    WHERE scs.Bettype IN (1,3,7,8)
        AND scs.maxlivepositiontaking < cs.slivepositiontaking + cs.mlivepositiontaking + cs.alivepositiontaking
END

---- 26. L3 < M1 +A1
BEGIN
    INSERT INTO ##CheckPTResult_Credit (RuleDesc, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
    SELECT  '26. L3 < M1 +A1', cs.BetType, cs.SportType, mcs.CustId, cs.CustId, mcs.maxpositiontaking, cs.mpositiontaking + cs.apositiontaking, 0
    FROM    #MasterPT mcs       
        INNER JOIN  #MemberPT cs ON cs.mrecommend = mcs.CustId AND cs.bettype = mcs.bettype AND cs.sporttype = mcs.sporttype
    WHERE mcs.maxpositiontaking < cs.mpositiontaking + cs.apositiontaking

    INSERT INTO ##CheckPTResult_Credit (RuleDesc, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive) 
    SELECT  '26. L3 < M1 +A1', cs.BetType, cs.SportType, mcs.CustId, cs.CustId, mcs.maxlivepositiontaking, cs.mlivepositiontaking + cs.alivepositiontaking, 1
    FROM    #MasterPT mcs       
        INNER JOIN  #MemberPT cs ON cs.mrecommend = mcs.CustId AND cs.bettype = mcs.bettype AND cs.sporttype = mcs.sporttype
    WHERE cs.Bettype IN (1,3,7,8)
        AND mcs.maxlivepositiontaking < cs.mlivepositiontaking + cs.alivepositiontaking
END  

---- 27. L2 < A1 
BEGIN
    INSERT INTO ##CheckPTResult_Credit (RuleDesc, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
    SELECT  '27. L2 < A1', cs.BetType, cs.SportType, acs.CustId, cs.CustId, acs.maxpositiontaking, cs.apositiontaking, 0
    FROM    #AgentPT acs        
        INNER JOIN  #MemberPT cs ON cs.recommend = acs.CustId AND cs.bettype = acs.bettype AND cs.sporttype = acs.sporttype
    WHERE   acs.maxpositiontaking < cs.apositiontaking 

    INSERT INTO ##CheckPTResult_Credit (RuleDesc, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
    SELECT  '27. L2 < A1', cs.BetType, cs.SportType, acs.CustId, cs.CustId, acs.maxlivepositiontaking, cs.alivepositiontaking, 1
    FROM    #AgentPT acs        
        INNER JOIN  #MemberPT cs ON cs.recommend = acs.CustId AND cs.bettype = acs.bettype AND cs.sporttype = acs.sporttype
    WHERE   cs.Bettype IN (1,3,7,8)
        AND acs.maxlivepositiontaking < cs.alivepositiontaking 
END
 
---- 28. MIN(S4-M1-A1, (IS1?US1,US3)) > S1
BEGIN 
    INSERT INTO ##CheckPTResult_Credit (RuleDesc, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
    SELECT '28. MIN(S4-M1-A1, (IS1?US1,US3)) > S1', cs.BetType, cs.SportType 
        ,CASE   WHEN scs.spositiontaking - cs.mpositiontaking - cs.apositiontaking > (CASE WHEN cs.isautopositiontaking = 1 THEN cs.autopositiontaking  ELSE mcs.autopositiontaking END)            
                THEN (  CASE    WHEN cs.isautopositiontaking = 1 
                                THEN cs.CustId 
                                ELSE mcs.CustId 
                        END)
                ELSE scs.CustId
            END 
        ,cs.CustId              
        ,CASE   WHEN scs.spositiontaking - cs.mpositiontaking - cs.apositiontaking > (CASE WHEN cs.isautopositiontaking = 1 THEN cs.autopositiontaking  ELSE mcs.autopositiontaking END)            
                THEN (  CASE    WHEN cs.isautopositiontaking = 1 
                                THEN cs.autopositiontaking 
                                ELSE mcs.autopositiontaking 
                        END)
                ELSE scs.spositiontaking - cs.mpositiontaking - cs.apositiontaking
            END 
        ,cs.spositiontaking
        ,0
    FROM #MemberPT cs       
        INNER JOIN  #MasterPT mcs ON    cs.mrecommend = mcs.CustId AND cs.bettype = mcs.bettype AND cs.sporttype = mcs.sporttype            
        INNER JOIN  #SuperPT scs ON cs.srecommend = scs.CustId AND cs.bettype = scs.bettype AND cs.sporttype = scs.sporttype            
    WHERE (cs.isautopositiontaking=1 OR mcs.isautopositiontaking=1)
        AND cs.spositiontaking < CASE   WHEN scs.spositiontaking - cs.mpositiontaking - cs.apositiontaking > (CASE WHEN cs.isautopositiontaking = 1 THEN cs.autopositiontaking  ELSE mcs.autopositiontaking END)            
                                        THEN (  CASE    WHEN cs.isautopositiontaking = 1 
                                                        THEN cs.autopositiontaking 
                                                        ELSE mcs.autopositiontaking 
                                                END)
                                        ELSE scs.spositiontaking - cs.mpositiontaking - cs.apositiontaking
                                    END 
    ----

        INSERT INTO ##CheckPTResult_Credit (RuleDesc, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
        SELECT '28. MIN(S4-M1-A1, (IS1?US1,US3)) > S1', cs.BetType, cs.SportType 
            ,CASE   WHEN scs.slivepositiontaking - cs.mlivepositiontaking - cs.alivepositiontaking > (CASE WHEN cs.isautolivepositiontaking = 1 THEN cs.autolivepositiontaking  ELSE mcs.autolivepositiontaking END)            
                    THEN (  CASE    WHEN cs.isautolivepositiontaking = 1 
                                    THEN cs.CustId 
                                    ELSE mcs.CustId 
                            END)
                    ELSE scs.CustId
                END 
            ,cs.CustId              
            ,CASE   WHEN scs.slivepositiontaking - cs.mlivepositiontaking - cs.alivepositiontaking > (CASE WHEN cs.isautolivepositiontaking = 1 THEN cs.autolivepositiontaking  ELSE mcs.autolivepositiontaking END)            
                    THEN (  CASE    WHEN cs.isautolivepositiontaking = 1 
                                    THEN cs.autolivepositiontaking 
                                    ELSE mcs.autolivepositiontaking 
                            END)
                    ELSE scs.slivepositiontaking - cs.mlivepositiontaking - cs.alivepositiontaking
                END 
            ,cs.slivepositiontaking
            ,1
        FROM #MemberPT cs       
            INNER JOIN  #MasterPT mcs ON cs.mrecommend = mcs.CustId AND cs.bettype = mcs.bettype AND cs.sporttype = mcs.sporttype           
            INNER JOIN  #SuperPT scs ON cs.srecommend = scs.CustId AND cs.bettype = scs.bettype AND cs.sporttype = scs.sporttype            
        WHERE cs.Bettype IN (1,3,7,8)
            AND (cs.isautolivepositiontaking=1 OR mcs.isautolivepositiontaking=1)
            AND cs.slivepositiontaking < CASE   WHEN scs.slivepositiontaking - cs.mlivepositiontaking - cs.alivepositiontaking > (CASE WHEN cs.isautolivepositiontaking = 1 THEN cs.autolivepositiontaking  ELSE mcs.autolivepositiontaking END)            
                                            THEN (  CASE    WHEN cs.isautolivepositiontaking = 1 
                                                            THEN cs.autolivepositiontaking 
                                                            ELSE mcs.autolivepositiontaking 
                                                    END)
                                            ELSE scs.slivepositiontaking - cs.mlivepositiontaking - cs.alivepositiontaking
                                        END 

        END 
 
---- 29. MIN (M4-A1, M3-A1,(IM1?UM1,UM2)) > M1 
BEGIN 
    INSERT INTO ##CheckPTResult_Credit (RuleDesc, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
    SELECT '29. MIN (M4-A1, M3-A1,(IM1?UM1,UM2)) > M1', cs.BetType, cs.SportType 
        ,CASE WHEN scs.mpositiontaking > mcs.mpositiontaking 
                THEN    CASE WHEN mcs.mpositiontaking - cs.apositiontaking > (CASE WHEN cs.isautompositiontaking = 1 THEN cs.autompositiontaking ELSE acs.autompositiontaking END) 
                            THEN (CASE WHEN cs.isautompositiontaking = 1 
                                    THEN cs.CustId
                                    ELSE acs.CustId 
                                    END
                                )
                            ELSE mcs.CustId
                    END
            ELSE    
                    CASE WHEN scs.mpositiontaking - cs.apositiontaking > (CASE WHEN cs.isautompositiontaking = 1 THEN cs.autompositiontaking ELSE acs.autompositiontaking END) 
                            THEN (CASE WHEN cs.isautompositiontaking = 1 
                                    THEN cs.CustId
                                    ELSE acs.CustId 
                                END
                                )
                            ELSE scs.CustId
                    END
            END
        ,cs.CustId
        ,CASE WHEN scs.mpositiontaking > mcs.mpositiontaking 
                THEN    CASE WHEN mcs.mpositiontaking - cs.apositiontaking > (CASE WHEN cs.isautompositiontaking = 1 THEN cs.autompositiontaking ELSE acs.autompositiontaking END) 
                            THEN (CASE WHEN cs.isautompositiontaking = 1 
                                    THEN cs.autompositiontaking
                                    ELSE acs.autompositiontaking 
                                END
                                )
                            ELSE mcs.mpositiontaking - cs.apositiontaking
                    END
            ELSE    
                    CASE WHEN scs.mpositiontaking - cs.apositiontaking > (CASE WHEN cs.isautompositiontaking = 1 THEN cs.autompositiontaking ELSE acs.autompositiontaking END) 
                            THEN (CASE WHEN cs.isautompositiontaking = 1 
                                    THEN cs.autompositiontaking
                                    ELSE acs.autompositiontaking 
                                END
                                )
                            ELSE scs.mpositiontaking - cs.apositiontaking
                    END
            END
        ,cs.mpositiontaking
        ,0
    FROM #MemberPT cs       
        INNER JOIN  #AgentPT acs ON cs.recommend = acs.CustId AND cs.bettype = acs.bettype AND cs.sporttype = acs.sporttype         
        INNER JOIN  #MasterPT mcs ON cs.mrecommend = mcs.CustId AND cs.bettype = mcs.bettype AND cs.sporttype = mcs.sporttype           
        INNER JOIN  #SuperPT scs ON cs.srecommend = scs.CustId AND cs.bettype = scs.bettype AND cs.sporttype = scs.sporttype    
    WHERE ( acs.isautompositiontaking = 1   OR cs.isautompositiontaking = 1 )
        AND cs.mpositiontaking < CASE WHEN scs.mpositiontaking > mcs.mpositiontaking 
                                        THEN CASE  WHEN mcs.mpositiontaking - cs.apositiontaking > (CASE WHEN cs.isautompositiontaking = 1 THEN cs.autompositiontaking ELSE acs.autompositiontaking END) 
                                                    THEN (CASE WHEN cs.isautompositiontaking = 1 
                                                            THEN cs.autompositiontaking
                                                            ELSE acs.autompositiontaking 
                                                        END
                                                        )
                                                    ELSE mcs.mpositiontaking - cs.apositiontaking
                                                    END
                                        ELSE    
                                                CASE WHEN scs.mpositiontaking - cs.apositiontaking > (CASE WHEN cs.isautompositiontaking = 1 THEN cs.autompositiontaking ELSE acs.autompositiontaking END) 
                                                        THEN (CASE WHEN cs.isautompositiontaking = 1 
                                                                THEN cs.autompositiontaking
                                                                ELSE acs.autompositiontaking 
                                                            END
                                                            )
                                                        ELSE scs.mpositiontaking - cs.apositiontaking
                                                        END
                                        END

    ------
        INSERT INTO ##CheckPTResult_Credit (RuleDesc, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
        SELECT '29. MIN (M4-A1, M3-A1,(IM1?UM1,UM2)) > M1', cs.BetType, cs.SportType 
            ,CASE WHEN scs.mlivepositiontaking > mcs.mlivepositiontaking 
                    THEN    CASE WHEN mcs.mlivepositiontaking - cs.alivepositiontaking > (CASE WHEN cs.isautolivempositiontaking = 1 THEN cs.autolivempositiontaking ELSE acs.autolivempositiontaking END) 
                                THEN (CASE WHEN cs.isautolivempositiontaking = 1 
                                        THEN cs.CustId
                                        ELSE acs.CustId 
                                        END
                                    )
                                ELSE mcs.CustId
                        END
                ELSE    
                        CASE WHEN scs.mlivepositiontaking - cs.alivepositiontaking > (CASE WHEN cs.isautolivempositiontaking = 1 THEN cs.autolivempositiontaking ELSE acs.autolivempositiontaking END) 
                                THEN (CASE WHEN cs.isautolivempositiontaking = 1 
                                        THEN cs.CustId
                                        ELSE acs.CustId 
                                    END
                                    )
                                ELSE scs.CustId
                        END
                END
            ,cs.CustId
            ,CASE WHEN scs.mlivepositiontaking > mcs.mlivepositiontaking 
                    THEN    CASE WHEN mcs.mlivepositiontaking - cs.alivepositiontaking > (CASE WHEN cs.isautolivempositiontaking = 1 THEN cs.autolivempositiontaking ELSE acs.autolivempositiontaking END) 
                                THEN (CASE WHEN cs.isautolivempositiontaking = 1 
                                        THEN cs.autolivempositiontaking
                                        ELSE acs.autolivempositiontaking 
                                    END
                                    )
                                ELSE mcs.mlivepositiontaking - cs.alivepositiontaking
                        END
                ELSE    
                        CASE WHEN scs.mlivepositiontaking - cs.alivepositiontaking > (CASE WHEN cs.isautolivempositiontaking = 1 THEN cs.autolivempositiontaking ELSE acs.autolivempositiontaking END) 
                                THEN (CASE WHEN cs.isautolivempositiontaking = 1 
                                        THEN cs.autolivempositiontaking
                                        ELSE acs.autolivempositiontaking 
                                    END
                                    )
                                ELSE scs.mlivepositiontaking - cs.alivepositiontaking
                        END
                END
            ,cs.mlivepositiontaking
            ,1
        FROM #MemberPT cs       
            INNER JOIN  #AgentPT acs ON cs.recommend = acs.CustId AND cs.bettype = acs.bettype AND cs.sporttype = acs.sporttype         
            INNER JOIN  #MasterPT mcs ON cs.mrecommend = mcs.CustId AND cs.bettype = mcs.bettype AND cs.sporttype = mcs.sporttype           
            INNER JOIN  #SuperPT scs ON cs.srecommend = scs.CustId AND cs.bettype = scs.bettype AND cs.sporttype = scs.sporttype    
        WHERE cs.Bettype IN (1,3,7,8)
            AND ( acs.isautolivempositiontaking = 1 OR cs.isautolivempositiontaking = 1 )
            AND cs.mlivepositiontaking < CASE WHEN scs.mlivepositiontaking > mcs.mlivepositiontaking 
                                            THEN CASE  WHEN mcs.mlivepositiontaking - cs.alivepositiontaking > (CASE WHEN cs.isautolivempositiontaking = 1 THEN cs.autolivempositiontaking ELSE acs.autolivempositiontaking END) 
                                                        THEN (CASE WHEN cs.isautolivempositiontaking = 1 
                                                                THEN cs.autolivempositiontaking
                                                                ELSE acs.autolivempositiontaking 
                                                            END
                                                            )
                                                        ELSE mcs.mlivepositiontaking - cs.alivepositiontaking
                                                        END
                                            ELSE    
                                                    CASE WHEN scs.mlivepositiontaking - cs.alivepositiontaking > (CASE WHEN cs.isautolivempositiontaking = 1 THEN cs.autolivempositiontaking ELSE acs.autolivempositiontaking END) 
                                                            THEN (CASE WHEN cs.isautolivempositiontaking = 1 
                                                                    THEN cs.autolivempositiontaking
                                                                    ELSE acs.autolivempositiontaking 
                                                                END
                                                                )
                                                            ELSE scs.mlivepositiontaking - cs.alivepositiontaking
                                                            END
                                            END



    END 
 END
 GO
 ---------------------------END SP------------------------
IF OBJECT_ID('tempdb..##CheckPTResult_Credit') IS NULL
BEGIN
    TRUNCATE TABLE ##CheckPTResult_Credit
END
EXEC #tmp94325_DBA_CheckPT_Sportbook_Credit 25196224
EXEC #tmp94325_DBA_CheckPT_Sportbook_Credit 25196109
EXEC #tmp94325_DBA_CheckPT_Sportbook_Credit 25197906
EXEC #tmp94325_DBA_CheckPT_Sportbook_Credit 25197688
EXEC #tmp94325_DBA_CheckPT_Sportbook_Credit 25197748
EXEC #tmp94325_DBA_CheckPT_Sportbook_Credit 25197264
EXEC #tmp94325_DBA_CheckPT_Sportbook_Credit 25197518
GO
SELECT * FROM ##CheckPTResult_Credit
GO