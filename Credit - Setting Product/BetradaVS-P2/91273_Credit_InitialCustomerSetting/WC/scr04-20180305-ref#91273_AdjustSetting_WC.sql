/*
    Created: Vicky
    Task: Adjust Setting for VS Basketball
    DB: DBCUST/CustDB
    Date: 20180308
*/ 


ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_09_UAT2]
AS
BEGIN
    
    SET NOCOUNT ON
    
    --no need check for winloss
    IF dbo.f_CheckRepTable('CustPTSetting3rd_Agent') = 0 RETURN
    IF dbo.f_CheckRepTable('CustPTSetting3rd_Member') = 0 RETURN
    IF dbo.f_CheckRepTable('CustPTGroupSetting3rd_Member') = 0 RETURN
    IF dbo.f_CheckRepTable('CustBetSetting3rd_Member') = 0 RETURN
    IF dbo.f_CheckRepTable('CustBetSetting3rd_Agent') = 0 RETURN
    
    DECLARE @sportType SMALLINT = 192, 
            @betType SMALLINT = 2801, 
            @sportTypeRef SMALLINT = 191, 
            @betTypeRef SMALLINT = 2701


    --*********************************PT Setting*********************************   
    BEGIN       
        CREATE TABLE #SMAList_PT         (custid INT, SuperPT SMALLMONEY, MasterPT SMALLMONEY, AgentPT SMALLMONEY, IsAutoMasterPT BIT, AutoMasterPT SMALLMONEY, IsAutoSuperPT BIT, AutoSuperPT SMALLMONEY, MinPT SMALLMONEY, MaxPT SMALLMONEY)
        CREATE TABLE #MemberList_PT      (custid INT, SuperPT SMALLMONEY, MasterPT SMALLMONEY, AgentPT SMALLMONEY, IsAutoMasterPT BIT, AutoMasterPT SMALLMONEY, IsAutoSuperPT BIT, AutoSuperPT SMALLMONEY)
        CREATE TABLE #MemberGroupList_PT (custid INT, SuperPT SMALLMONEY, MasterPT SMALLMONEY, AgentPT SMALLMONEY, IsAutoMasterPT BIT, AutoMasterPT SMALLMONEY, IsAutoSuperPT BIT, AutoSuperPT SMALLMONEY)

        --------------------------------------Get Affected Cust List-------------------------------------------------   
        --Agent Level
        INSERT INTO #SMAList_PT (custid, SuperPT, MasterPT, AgentPT, IsAutoMasterPT, AutoMasterPT, IsAutoSuperPT, AutoSuperPT, MinPT, MaxPT)
        SELECT csref.custid, csref.SuperPT, csref.MasterPT, csref.AgentPT, csref.IsAutoMasterPT, csref.AutoMasterPT, csref.IsAutoSuperPT, csref.AutoSuperPT, csref.MinPT, csref.MaxPT
        FROM dbo.CustPTSetting3rd_Agent cs    WITH (NOLOCK) 
            INNER JOIN dbo.CustPTSetting3rd_Agent csref WITH (NOLOCK) ON cs.custid = csref.custid
        WHERE   cs.sporttype    = @sportType    AND cs.bettype    = @betType  
            AND csref.SportType = @sportTypeRef AND csref.BetType = @betTypeRef
            AND (
                       cs.SuperPT       <> csref.SuperPT
                    OR cs.MasterPT      <> csref.MasterPT
                    OR cs.AgentPT       <> csref.AgentPT
                    OR cs.IsAutoMasterPT<> csref.IsAutoMasterPT
                    OR cs.AutoMasterPT  <> csref.AutoMasterPT
                    OR cs.IsAutoSuperPT <> csref.IsAutoSuperPT
                    OR cs.AutoSuperPT   <> csref.AutoSuperPT
                    OR cs.MinPT         <> csref.MinPT
                    OR cs.MaxPT         <> csref.MaxPT
                 )
        RAISERROR('Done: Get the affected SMA list for PT', 0, 1)  WITH NOWAIT
    
        --Member Level
        INSERT INTO #MemberList_PT (custid, SuperPT, MasterPT, AgentPT, IsAutoMasterPT, AutoMasterPT, IsAutoSuperPT, AutoSuperPT)
        SELECT csref.custid, csref.SuperPT, csref.MasterPT, csref.AgentPT, csref.IsAutoMasterPT, csref.AutoMasterPT, csref.IsAutoSuperPT, csref.AutoSuperPT
        FROM dbo.CustPTSetting3rd_member cs       WITH (NOLOCK) 
            INNER JOIN dbo.CustPTSetting3rd_member csref    WITH (NOLOCK) ON cs.custid = csref.custid
        WHERE   cs.sporttype    = @sportType    AND cs.bettype    = @betType  
            AND csref.SportType = @sportTypeRef AND csref.BetType = @betTypeRef
            AND (   cs.SuperPT          <> csref.SuperPT
                    OR cs.MasterPT      <> csref.MasterPT
                    OR cs.AgentPT       <> csref.AgentPT
                    OR cs.IsAutoMasterPT<> csref.IsAutoMasterPT
                    OR cs.AutoMasterPT  <> csref.AutoMasterPT
                    OR cs.IsAutoSuperPT <> csref.IsAutoSuperPT
                    OR cs.AutoSuperPT   <> csref.AutoSuperPT
                    )

        --group PT
        INSERT INTO #MemberGroupList_PT (custid, SuperPT, MasterPT, AgentPT, IsAutoMasterPT, AutoMasterPT, IsAutoSuperPT, AutoSuperPT)
        SELECT csref.AgentId, csref.SuperPT, csref.MasterPT, csref.AgentPT, csref.IsAutoMasterPT, csref.AutoMasterPT, csref.IsAutoSuperPT, csref.AutoSuperPT
        FROM dbo.CustPTGroupSetting3rd_Member cs       WITH (NOLOCK) 
            INNER JOIN dbo.CustPTGroupSetting3rd_Member csref    WITH (NOLOCK) ON cs.Agentid = csref.Agentid
        WHERE   cs.sporttype    = @sportType    AND cs.bettype    = @betType  
            AND csref.SportType = @sportTypeRef AND csref.BetType = @betTypeRef
            AND (cs.SuperPT         <> csref.SuperPT
                OR cs.MasterPT      <> csref.MasterPT
                OR cs.AgentPT       <> csref.AgentPT
                OR cs.IsAutoMasterPT<> csref.IsAutoMasterPT
                OR cs.AutoMasterPT  <> csref.AutoMasterPT
                OR cs.IsAutoSuperPT <> csref.IsAutoSuperPT
                OR cs.AutoSuperPT   <> csref.AutoSuperPT
                )
        RAISERROR('Done: Get the affected member list for PT', 0, 1)  WITH NOWAIT
        -------------------------------------------------Adjust data----------------------------------------------------
        --Agent Level
        UPDATE csa
        SET csa.SuperPT         = cschange.SuperPT
            ,csa.MasterPT       = cschange.MasterPT
            ,csa.AgentPT        = cschange.AgentPT
            ,csa.IsAutoMasterPT = cschange.IsAutoMasterPT
            ,csa.AutoMasterPT   = cschange.AutoMasterPT
            ,csa.IsAutoSuperPT  = cschange.IsAutoSuperPT 
            ,csa.AutoSuperPT    = cschange.AutoSuperPT
            ,csa.MinPT          = cschange.MinPT
            ,csa.MaxPT          = cschange.MaxPT
        FROM dbo.CustPTSetting3rd_Agent csa WITH (ROWLOCK, UPDLOCK) 
            INNER JOIN #SMAList_PT cschange WITH (NOLOCK) ON csa.custid = cschange.custid
        WHERE csa.SportType = @sportType AND csa.BetType = @betType
    
        RAISERROR('Done: Update the affected SMA list for PT', 0, 1)  WITH NOWAIT

        --MEMBER LEVEL
        UPDATE csm
        SET csm.SuperPT         = cschange.SuperPT
            ,csm.MasterPT       = cschange.MasterPT
            ,csm.AgentPT        = cschange.AgentPT
            ,csm.IsAutoMasterPT = cschange.IsAutoMasterPT
            ,csm.AutoMasterPT   = cschange.AutoMasterPT
            ,csm.IsAutoSuperPT  = cschange.IsAutoSuperPT 
            ,csm.AutoSuperPT    = cschange.AutoSuperPT
        FROM dbo.CustPTSetting3rd_Member csm   WITH (ROWLOCK, UPDLOCK)
            INNER JOIN #MemberList_PT cschange WITH (NOLOCK) ON cschange.custid = csm.custid
        WHERE csm.SportType = @sportType AND csm.BetType = @betType   

        RAISERROR('Done: Update the affected member list for PT', 0, 1)  WITH NOWAIT
        
         --MEMBER LEVEL
        UPDATE csm
        SET csm.SuperPT         = cschange.SuperPT
            ,csm.MasterPT       = cschange.MasterPT
            ,csm.AgentPT        = cschange.AgentPT
            ,csm.IsAutoMasterPT = cschange.IsAutoMasterPT
            ,csm.AutoMasterPT   = cschange.AutoMasterPT
            ,csm.IsAutoSuperPT  = cschange.IsAutoSuperPT 
            ,csm.AutoSuperPT    = cschange.AutoSuperPT
        FROM dbo.CustPTGroupSetting3rd_Member csm   WITH (ROWLOCK, UPDLOCK)
            INNER JOIN #MemberGroupList_PT cschange WITH (NOLOCK) ON cschange.custid = csm.AgentId
        WHERE csm.SportType = @sportType AND csm.BetType = @betType   

        RAISERROR('Done: Update the affected member group list for PT', 0, 1)  WITH NOWAIT

        DROP TABLE #SMAList_PT
        DROP TABLE #MemberList_PT
        DROP TABLE #MemberGroupList_PT
    END
    --*********************************END PT********************************* 
    
    
    --*********************************Bet Setting*********************************      
    BEGIN       
        CREATE TABLE #SMAList_BetSetting (custid INT, minBet MONEY, MaxBet MONEY, MaxPerMatch MONEY)
        CREATE TABLE #MemberList_BetSetting (custid INT, minBet MONEY, MaxBet MONEY, MaxPerMatch MONEY)

        --Agent Level
        INSERT INTO #SMAList_BetSetting (custid, minBet, MaxBet, MaxPerMatch)
        SELECT csref.custid, csref.minBet, csref.MaxBet, csref.MaxPerMatch
        FROM dbo.CustBetSetting3rd_Agent cs
            INNER JOIN dbo.CustBetSetting3rd_Agent csref WITH(NOLOCK) ON cs.custid = csref.custid
        WHERE   cs.sporttype    = @sportType    AND cs.bettype = @betType 
            AND csref.SportType = @sportTypeRef AND csref.BetType = @betTypeRef
            AND (   cs.minBet           <> csref.minBet
                    OR cs.MaxBet        <> csref.MaxBet
                    OR cs.MaxPerMatch   <> csref.MaxPerMatch
                )

        RAISERROR('Done: Get the affected SMA list for bet setting', 0, 1)  WITH NOWAIT

        --Member Level
        INSERT INTO #MemberList_BetSetting (custid, minBet, MaxBet, MaxPerMatch)
        SELECT csref.custid, csref.minBet, csref.MaxBet, csref.MaxPerMatch
        FROM           dbo.CustBetSetting3rd_Member cs
            INNER JOIN dbo.CustBetSetting3rd_Member csref WITH(NOLOCK) ON cs.custid = csref.custid
        WHERE   cs.sporttype    = @sportType    AND cs.bettype = @betType 
            AND csref.SportType = @sportTypeRef AND csref.BetType = @betTypeRef
            AND (   cs.minBet           <> csref.minBet
                    OR cs.MaxBet        <> csref.MaxBet
                    OR cs.MaxPerMatch   <> csref.MaxPerMatch
                )
    
        RAISERROR('Done: Get the affected member list for bet setting', 0, 1)  WITH NOWAIT

        --------------------------------------Update Bet Setting-------------------------------------------------      
        --Agent Level
        UPDATE csa
        SET csa.minBet = csref.minbet,       
            csa.MaxBet = csref.MaxBet,   
            csa.maxperMatch = csref.MaxPerMatch
        FROM dbo.CustBetSetting3rd_Agent   csa    WITH (ROWLOCK, UPDLOCK)
            INNER JOIN #SMAList_BetSetting csref WITH (NOLOCK) ON csa.CustID = csref.custid
        WHERE csa.SportType = @sportType AND csa.BetType = @betType

        RAISERROR('Done: Update the affected SMA list for bet setting', 0, 1)  WITH NOWAIT

        --Member Level
        UPDATE csm
        SET csm.minBet = csref.minbet,       
            csm.MaxBet = csref.MaxBet,   
            csm.maxperMatch = csref.MaxPerMatch
        FROM dbo.CustBetSetting3rd_Member     csm    WITH (ROWLOCK, UPDLOCK)
            INNER JOIN #MemberList_BetSetting csref WITH (NOLOCK) ON csm.CustID = csref.custid
        WHERE csm.SportType = @sportType AND csm.BetType = @betType

        RAISERROR('Done: Update the affected member list for bet setting', 0, 1)  WITH NOWAIT

        DROP TABLE #SMAList_BetSetting
        DROP TABLE #MemberList_BetSetting
    END
END     
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------  

-- BEGIN STEP 2: RUN THIS SCRIPT AT DBCUST SERVERS -----
--------------------------------------------------------------------------------------
EXEC dbo.Acc_DynamicCustSetting3rd_09 

