SET NOCOUNT ON
GO
IF OBJECT_ID('tempdb..#tmp94234DBA_CheckPTGame_Credit') IS NOT NULL
BEGIN
    DROP PROC #tmp94234DBA_CheckPTGame_Credit
END
GO
CREATE PROCEDURE #tmp94234DBA_CheckPTGame_Credit
(
    @srecommend INT
)WITH RECOMPILE 
AS
/*
	Created: 20140313@Vicky
	Task: Check PT setting for credit customers - Game setting
	DB: DBCUST/CustDB  
*/
BEGIN 
    SET NOCOUNT ON
    CREATE TABLE #MemberPT (CustID INT, recommend INT, mrecommend INT, srecommend INT, sporttype SMALLINT, bettype SMALLINT, spositiontaking SMALLMONEY, mpositiontaking SMALLMONEY, apositiontaking SMALLMONEY, isautompositiontaking BIT, autompositiontaking SMALLMONEY, isautopositiontaking BIT, autopositiontaking SMALLMONEY, SyncLiveCasino BIT)
    CREATE TABLE #AgentPT (CustID INT, mrecommend INT, srecommend INT, sporttype SMALLINT, bettype SMALLINT, spositiontaking SMALLMONEY, mpositiontaking SMALLMONEY, apositiontaking SMALLMONEY, isautompositiontaking BIT, autompositiontaking SMALLMONEY, isautopositiontaking BIT, autopositiontaking SMALLMONEY, Minpositiontaking SMALLMONEY, SyncLiveCasino BIT)
    CREATE TABLE #MasterPT (CustID INT, srecommend INT, sporttype SMALLINT, bettype SMALLINT, spositiontaking SMALLMONEY, mpositiontaking SMALLMONEY, apositiontaking SMALLMONEY, isautompositiontaking BIT, autompositiontaking SMALLMONEY, isautopositiontaking BIT, autopositiontaking SMALLMONEY, Minpositiontaking SMALLMONEY, SyncLiveCasino BIT)
    CREATE TABLE #SuperPT (CustID INT, sporttype SMALLINT, bettype SMALLINT, spositiontaking SMALLMONEY, mpositiontaking SMALLMONEY, apositiontaking SMALLMONEY, isautompositiontaking BIT, autompositiontaking SMALLMONEY, isautopositiontaking BIT, autopositiontaking SMALLMONEY, Minpositiontaking SMALLMONEY, SyncLiveCasino BIT)

    IF OBJECT_ID('tempdb..##CheckPTResult_Credit') IS NULL
    BEGIN
        CREATE TABLE ##CheckPTResult_Credit (RuleDesc VARCHAR(100), BetType INT, SportType INT, CustIdA INT, CustIdB INT, ValueA INT, ValueB INT, IsLive INT)
    END
    
    DECLARE @RowCount TINYINT

    SELECT cs.sporttype, cs.bettype
    INTO #DataSample
    FROM dbo.custsettinggame cs WITH (NOLOCK)
    WHERE custid = 73104

    SELECT @RowCount = COUNT(1)
    FROM #DataSample
    -- Starting DATA PREPARATION
    INSERT INTO #MemberPT (CustID, recommend, mrecommend, srecommend, sporttype, bettype, spositiontaking, mpositiontaking, apositiontaking, isautompositiontaking, autompositiontaking, isautopositiontaking, autopositiontaking, SyncLiveCasino)
    SELECT ci.CustID, recommend, mrecommend, srecommend, sporttype, bettype, spositiontaking, mpositiontaking, apositiontaking, isautompositiontaking, autompositiontaking, isautopositiontaking, autopositiontaking, SyncLiveCasino
    FROM dbo.CustInfo ci
        INNER JOIN dbo.CustSettingGame cs WITH (NOLOCK) ON ci.CustID = cs.CustID
    WHERE ci.srecommend = @srecommend  
            AND ci.roleid = 1  
 
    
    INSERT INTO #AgentPT (CustID, mrecommend, srecommend, sporttype, bettype, spositiontaking, mpositiontaking, apositiontaking, isautompositiontaking, autompositiontaking, isautopositiontaking, autopositiontaking, Minpositiontaking, SyncLiveCasino)
    SELECT ci.CustID, mrecommend, srecommend, cs.sporttype, cs.bettype, spositiontaking, mpositiontaking, apositiontaking, isautompositiontaking, autompositiontaking, isautopositiontaking, autopositiontaking, Minpositiontaking, SyncLiveCasino
    FROM dbo.CustInfo ci
        INNER JOIN dbo.CustSettingGame cs WITH (NOLOCK) ON ci.CustID = cs.CustID
        INNER JOIN dbo.custoverrideGame co WITH (NOLOCK) ON ci.CustID = co.CustID AND co.sporttype = cs.sporttype AND co.bettype = cs.bettype
    WHERE ci.srecommend = @srecommend  
            AND ci.roleid = 2  

    INSERT INTO #MasterPT (CustID, srecommend, sporttype, bettype, spositiontaking, mpositiontaking, apositiontaking, isautompositiontaking, autompositiontaking, isautopositiontaking, autopositiontaking, Minpositiontaking, SyncLiveCasino)
    SELECT ci.CustID, srecommend, cs.sporttype, cs.bettype, spositiontaking, mpositiontaking, apositiontaking, isautompositiontaking, autompositiontaking, isautopositiontaking, autopositiontaking, Minpositiontaking, SyncLiveCasino
    FROM dbo.CustInfo ci
        INNER JOIN dbo.CustSettingGame cs WITH (NOLOCK) ON ci.CustID = cs.CustID
        INNER JOIN dbo.custoverrideGame co WITH (NOLOCK) ON ci.CustID = co.CustID AND co.sporttype = cs.sporttype AND co.bettype = cs.bettype
    WHERE ci.srecommend = @srecommend  
            AND ci.roleid = 3

    INSERT INTO #SuperPT (CustID, sporttype, bettype, spositiontaking, mpositiontaking, apositiontaking, isautompositiontaking, autompositiontaking, isautopositiontaking, autopositiontaking, Minpositiontaking, SyncLiveCasino)
    SELECT ci.CustID, cs.sporttype, cs.bettype, spositiontaking, mpositiontaking, apositiontaking, isautompositiontaking, autompositiontaking, isautopositiontaking, autopositiontaking, Minpositiontaking, SyncLiveCasino
    FROM dbo.CustInfo ci
        INNER JOIN dbo.CustSettingGame cs WITH (NOLOCK) ON ci.CustID = cs.CustID
        INNER JOIN dbo.custoverrideGame co WITH (NOLOCK) ON ci.CustID = co.CustID AND co.sporttype = cs.sporttype AND co.bettype = cs.bettype
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
    
    --Miss all Casino product setting
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
    SELECT  42 AS ruleid, ds.bettype, ds.sporttype, cs.CustID, cs.CustID, 0, 0, 0
    FROM    #MemberMissSetting cs
        CROSS APPLY (SELECT sporttype, bettype FROM #DataSample) ds
    WHERE NOT EXISTS (SELECT 1 FROM #MemberPT WHERE CustID = cs.CustID AND sporttype = ds.sporttype AND bettype = ds.bettype)
        
    INSERT INTO ##CheckPTResult_Credit (RuleDesc, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive) 
    SELECT  42 AS ruleid, ds.bettype, ds.sporttype, cs.CustID, cs.CustID, 0, 0, 0
    FROM    #AgentMissSetting cs
        CROSS APPLY (SELECT sporttype, bettype FROM #DataSample) ds
    WHERE NOT EXISTS (SELECT 1 FROM #AgentPT WHERE CustID = cs.CustID AND sporttype = ds.sporttype AND bettype = ds.bettype)
    
    INSERT INTO ##CheckPTResult_Credit (RuleDesc, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive) 
    SELECT  42 AS ruleid, ds.bettype, ds.sporttype, cs.CustID, cs.CustID, 0, 0, 0
    FROM    #MasterMissSetting cs
        CROSS APPLY (SELECT sporttype, bettype FROM #DataSample) ds
    WHERE NOT EXISTS (SELECT 1 FROM #MasterPT WHERE CustID = cs.CustID AND sporttype = ds.sporttype AND bettype = ds.bettype)

    INSERT INTO ##CheckPTResult_Credit (RuleDesc, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive) 
    SELECT  42 AS ruleid, ds.bettype, ds.sporttype, cs.CustID, cs.CustID, 0, 0, 0
    FROM    #SuperMissSetting cs
        CROSS APPLY (SELECT sporttype, bettype FROM #DataSample) ds
    WHERE NOT EXISTS (SELECT 1 FROM #SuperPT WHERE CustID = cs.CustID AND sporttype = ds.sporttype AND bettype = ds.bettype)


    BEGIN 
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
            WHERE   CASE WHEN cs.Sporttype = 162 THEN cs.SyncLiveCasino ELSE 1 END = 1
                AND (cs.spositiontaking < 0 OR cs.mpositiontaking < 0 OR cs.apositiontaking < 0)        
        END
        
        ----5. S4 < N4  
        BEGIN 
            INSERT INTO ##CheckPTResult_Credit (RuleDesc, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
            SELECT  '5. S4 < N4 ', cs.BetType, cs.SportType, cs.CustId, cs.CustId, cs.spositiontaking, cs.minpositiontaking, 0
            FROM    #SuperPT cs
            WHERE CASE WHEN cs.Sporttype = 162 THEN cs.SyncLiveCasino ELSE 1 END = 1
                AND cs.spositiontaking < cs.minpositiontaking
        END

        ----6. S4 < US3 
        BEGIN 
            INSERT INTO ##CheckPTResult_Credit (RuleDesc, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
            SELECT  '6. S4 < US3', cs.BetType, cs.SportType, scs.CustId, cs.CustId, scs.spositiontaking , cs.autopositiontaking, 0
            FROM    #SuperPT scs            
                INNER JOIN  #MasterPT cs ON cs.srecommend = scs.CustId AND cs.bettype = scs.bettype AND cs.sporttype = scs.sporttype
            WHERE   CASE WHEN cs.Sporttype = 162 THEN cs.SyncLiveCasino ELSE 1 END = 1
                AND scs.spositiontaking < cs.autopositiontaking
        END

        ----7. S4 < US1 
        BEGIN 
            INSERT INTO ##CheckPTResult_Credit (RuleDesc, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
            SELECT  '7. S4 < US1', cs.BetType, cs.SportType, scs.CustId, cs.CustId, scs.spositiontaking, cs.autopositiontaking, 0
            FROM    #SuperPT scs            
            INNER JOIN  #MemberPT cs ON cs.srecommend = scs.CustId AND cs.bettype = scs.bettype AND cs.sporttype = scs.sporttype
            WHERE CASE WHEN cs.Sporttype = 162 THEN cs.SyncLiveCasino ELSE 1 END = 1
                AND scs.spositiontaking < cs.autopositiontaking         
        END
    
        ----8. S4 < S3 + M3 
        BEGIN 
            INSERT INTO ##CheckPTResult_Credit (RuleDesc, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
            SELECT  '8. S4 < S3 + M3', cs.BetType, cs.SportType, scs.CustId, cs.CustId, scs.spositiontaking, cs.spositiontaking + cs.mpositiontaking, 0
            FROM    #SuperPT scs            
                INNER JOIN  #MasterPT cs ON cs.srecommend = scs.CustId AND cs.bettype = scs.bettype AND cs.sporttype = scs.sporttype
            WHERE CASE WHEN cs.Sporttype = 162 THEN cs.SyncLiveCasino ELSE 1 END = 1
                AND scs.spositiontaking < cs.spositiontaking + cs.mpositiontaking       
        END

        ----9. S4 < S1 + M1 + A1 
        BEGIN 
            INSERT INTO ##CheckPTResult_Credit (RuleDesc, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
            SELECT  '9. S4 < S1 + M1 + A1', cs.BetType, cs.SportType, scs.CustId, cs.CustId, scs.spositiontaking, cs.spositiontaking + cs.mpositiontaking + cs.apositiontaking, 0
            FROM    #SuperPT scs            
                INNER JOIN  #MemberPT cs ON cs.srecommend = scs.CustId AND cs.bettype = scs.bettype AND cs.sporttype = scs.sporttype
            WHERE CASE WHEN cs.Sporttype = 162 THEN cs.SyncLiveCasino ELSE 1 END = 1
                AND scs.spositiontaking < cs.spositiontaking + cs.mpositiontaking + cs.apositiontaking          
        END

        ----10. N4 > S1 + M1 + A1 
        BEGIN 
            INSERT INTO ##CheckPTResult_Credit (RuleDesc, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
            SELECT  '10. N4 > S1 + M1 + A1', cs.BetType, cs.SportType, scs.CustId, cs.CustId, scs.minpositiontaking, cs.spositiontaking + cs.mpositiontaking + cs.apositiontaking, 0
            FROM    #SuperPT scs            
                INNER JOIN  #MemberPT cs ON cs.srecommend = scs.CustId AND cs.bettype = scs.bettype AND cs.sporttype = scs.sporttype
            WHERE CASE WHEN cs.Sporttype = 162 THEN cs.SyncLiveCasino ELSE 1 END = 1
                AND scs.minpositiontaking > cs.spositiontaking + cs.mpositiontaking + cs.apositiontaking            
        END
        -----------------------------------------------------------------------
  
        ----17. M3 < N3 
        BEGIN
            INSERT INTO ##CheckPTResult_Credit (RuleDesc, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
            SELECT  '17. M3 < N3 ', cs.BetType, cs.SportType, cs.CustId, cs.CustId, cs.mpositiontaking, cs.minpositiontaking, 0
            FROM #MasterPT cs
            WHERE CASE WHEN cs.Sporttype = 162 THEN cs.SyncLiveCasino ELSE 1 END = 1
                AND cs.mpositiontaking < cs.minpositiontaking           
        END

        --------------------------------------------------------------------------------------------
        ----18. M3 < M2 + A2 
        BEGIN 
            INSERT INTO ##CheckPTResult_Credit (RuleDesc, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
            SELECT  '18. M3 < M2 + A2', cs.BetType, cs.SportType, mcs.CustId, cs.CustId, mcs.mpositiontaking, cs.mpositiontaking + cs.apositiontaking, 0
            FROM    #MasterPT mcs       
            INNER JOIN  #AgentPT cs ON  cs.mrecommend = mcs.CustId AND cs.bettype = mcs.bettype AND cs.sporttype = mcs.sporttype
            WHERE CASE WHEN cs.Sporttype = 162 THEN cs.SyncLiveCasino ELSE 1 END = 1
                AND mcs.mpositiontaking < cs.mpositiontaking + cs.apositiontaking       
        END
    
        ----19. M3 < M1 + A1 
        BEGIN 
            INSERT INTO ##CheckPTResult_Credit (RuleDesc, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
            SELECT  '19. M3 < M1 + A1', cs.BetType, cs.SportType, mcs.CustId, cs.CustId, mcs.mpositiontaking, cs.mpositiontaking + cs.apositiontaking, 0
            FROM    #MasterPT mcs       
                INNER JOIN  #MemberPT cs ON cs.mrecommend = mcs.CustId AND cs.bettype = mcs.bettype AND cs.sporttype = mcs.sporttype
            WHERE CASE WHEN cs.Sporttype = 162 THEN cs.SyncLiveCasino ELSE 1 END = 1
                AND mcs.mpositiontaking < cs.mpositiontaking + cs.apositiontaking
        END
   
        ----20. N3 > M1 + A1 
        BEGIN
            INSERT INTO ##CheckPTResult_Credit (RuleDesc, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
            SELECT  '20. N3 > M1 + A1', cs.BetType, cs.SportType, mcs.CustId, cs.CustId, mcs.minpositiontaking, cs.mpositiontaking + cs.apositiontaking, 0
            FROM    #MasterPT mcs       
                INNER JOIN  #MemberPT cs ON cs.mrecommend = mcs.CustId AND cs.bettype = mcs.bettype AND cs.sporttype = mcs.sporttype
            WHERE CASE WHEN cs.Sporttype = 162 THEN cs.SyncLiveCasino ELSE 1 END = 1
                AND mcs.minpositiontaking > cs.mpositiontaking + cs.apositiontaking
        END  
 
        ----23. A2 < N2
        BEGIN 
            INSERT INTO ##CheckPTResult_Credit (RuleDesc, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
            SELECT  '23. A2 < N2'd, cs.BetType, cs.SportType, cs.CustId, cs.CustId, cs.apositiontaking, cs.minpositiontaking, 0
            FROM    #AgentPT cs 
            WHERE CASE WHEN cs.Sporttype = 162 THEN cs.SyncLiveCasino ELSE 1 END = 1
                AND cs.apositiontaking < cs.minpositiontaking           
        END 
      
        ----24. N2 > A1
        BEGIN
            INSERT INTO ##CheckPTResult_Credit (RuleDesc, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
            SELECT  '24. N2 > A1', cs.BetType, cs.SportType, acs.CustId, cs.CustId, acs.minpositiontaking, cs.apositiontaking, 0 
            FROM    #AgentPT acs        
            INNER JOIN  #MemberPT cs ON cs.recommend = acs.CustId AND cs.bettype = acs.bettype AND cs.sporttype = acs.sporttype
            WHERE   CASE WHEN cs.Sporttype = 162 THEN cs.SyncLiveCasino ELSE 1 END = 1
                AND acs.minpositiontaking > cs.apositiontaking          
        END
        ---------------------------------------------------
        ----Note: Do not check rule 25, 26, 27 at CustSettingGame table
        ---------------------------------------------------
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
            WHERE CASE WHEN cs.Sporttype = 162 THEN cs.SyncLiveCasino ELSE 1 END = 1
                AND (cs.isautopositiontaking=1 OR mcs.isautopositiontaking=1)
                AND cs.spositiontaking < CASE   WHEN scs.spositiontaking - cs.mpositiontaking - cs.apositiontaking > (CASE WHEN cs.isautopositiontaking = 1 THEN cs.autopositiontaking  ELSE mcs.autopositiontaking END)            
                                                THEN (  CASE    WHEN cs.isautopositiontaking = 1 
                                                                THEN cs.autopositiontaking 
                                                                ELSE mcs.autopositiontaking 
                                                        END)
                                                ELSE scs.spositiontaking - cs.mpositiontaking - cs.apositiontaking
                                         END         
            END 

        ----30. S4 > 0.93
            -->Live Casino, GoldDeluxe: Do not check Rule 2 Check rule 30       
        BEGIN 
            BEGIN
                INSERT INTO ##CheckPTResult_Credit (RuleDesc, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
                SELECT  '30. S4 > 0.93', cs.BetType, cs.SportType, cs.CustId, cs.CustId, cs.spositiontaking, 0.93, 0
                FROM #SuperPT cs
                WHERE ((cs.SportType = 162 AND cs.SyncLiveCasino = 1) OR cs.Sporttype = 255)                    
                    AND cs.spositiontaking > 0.93           
            END
        END

        ---- 31. MIN (M3-A1,(IM1?UM1,UM2)) > M1
            ---> Check Rule 31 instead of Rule 29 because it does not have M4, A4  [29. MIN (M4-A1, M3-A1,(IM1?UM1,UM2)) > M1]       
        BEGIN 
            INSERT INTO ##CheckPTResult_Credit (RuleDesc, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
            SELECT  '31. MIN (M3-A1,(IM1?UM1,UM2)) > M1', cs.BetType, cs.SportType,
                    CASE WHEN mcs.mpositiontaking - cs.apositiontaking > (CASE WHEN cs.isautompositiontaking = 1 THEN cs.autompositiontaking ELSE acs.autompositiontaking END) 
                                 THEN (CASE WHEN cs.isautompositiontaking = 1 
                                            THEN cs.CustId
                                            ELSE acs.CustId 
                                            END
                                       )
                    ELSE mcs.CustId
                    END 
                ,cs.CustId
                ,CASE WHEN mcs.mpositiontaking - cs.apositiontaking > (CASE WHEN cs.isautompositiontaking = 1 THEN cs.autompositiontaking ELSE acs.autompositiontaking END) 
                                 THEN (CASE WHEN cs.isautompositiontaking = 1 
                                            THEN cs.autompositiontaking
                                            ELSE acs.autompositiontaking 
                                       END
                                       )
                    ELSE mcs.mpositiontaking - cs.apositiontaking
                    END                 
                ,cs.mpositiontaking
                ,0
            FROM #MemberPT cs       
                INNER JOIN  #AgentPT acs ON cs.recommend = acs.CustId AND cs.bettype = acs.bettype AND cs.sporttype = acs.sporttype
                INNER JOIN  #MasterPT mcs ON cs.mrecommend = mcs.CustId AND cs.bettype = mcs.bettype AND cs.sporttype = mcs.sporttype                           
            WHERE CASE WHEN cs.Sporttype = 162 THEN cs.SyncLiveCasino ELSE 1 END = 1
                AND ( acs.isautompositiontaking = 1 OR cs.isautompositiontaking = 1 )
                AND cs.mpositiontaking <    CASE  WHEN mcs.mpositiontaking - cs.apositiontaking > (CASE WHEN cs.isautompositiontaking = 1 THEN cs.autompositiontaking ELSE acs.autompositiontaking END) 
                                                    THEN (CASE WHEN cs.isautompositiontaking = 1 
                                                            THEN cs.autompositiontaking
                                                            ELSE acs.autompositiontaking 
                                                        END
                                                        )
                                                    ELSE mcs.mpositiontaking - cs.apositiontaking
                                                    END                                                                                         
    END 
        
        
        ----32. S4 > 0.85
            --> Keno: Do not check Rule 2 Check rule 32         
        BEGIN 
            BEGIN
            INSERT INTO ##CheckPTResult_Credit (RuleDesc, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
                SELECT  '32. S4 > 0.85', cs.BetType, cs.SportType, cs.CustId, cs.CustId, cs.spositiontaking, 0.85, 0
                FROM    #SuperPT cs
                WHERE   cs.SportType = 202                  
                    AND cs.spositiontaking > 0.85
            END
        END

END
END
GO
-----------------------------------------------------------------END SP--------------------------
TRUNCATE TABLE ##CheckPTResult_Credit
EXEC #tmp94234DBA_CheckPTGame_Credit 25196224
EXEC #tmp94234DBA_CheckPTGame_Credit 25196109
EXEC #tmp94234DBA_CheckPTGame_Credit 25197906
EXEC #tmp94234DBA_CheckPTGame_Credit 25197688
EXEC #tmp94234DBA_CheckPTGame_Credit 25197748
EXEC #tmp94234DBA_CheckPTGame_Credit 25197264
EXEC #tmp94234DBA_CheckPTGame_Credit 25197518
GO
SELECT * FROM ##CheckPTResult_Credit
GO
