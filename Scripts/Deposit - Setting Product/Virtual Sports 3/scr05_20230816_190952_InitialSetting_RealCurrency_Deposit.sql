/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Luke
	Date: 20230816
	Task: Insert setting for Virtual Sports 3 DEPOSIT - Real Currency [Redmine: #190952]
	DB: DBCust/CustDB
*/
-- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_09]        
        @level                  TINYINT = 0                  --0: All, 1: SMA, 2: Member
        ,@type                  TINYINT                      --1: Product Status, 2: PT, 3: Bet Setting
        ,@target                VARCHAR(20)
AS
BEGIN
        SET NOCOUNT ON;
        DECLARE @SportType		SMALLINT = 178
                ,@BetType		SMALLINT = 5302
                ,@fSporttype    SMALLINT = 190
                ,@fBettype      SMALLINT = 2701
        IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN -- run at all replicated servers
        IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN -- run at DBCUST only
                     
        IF dbo.f_CheckRepTable('Dep_CustProductStatus') = 0 RETURN
		IF dbo.f_CheckRepTable('Dep_CustPTSetting_Agent') = 0 RETURN
		IF dbo.f_CheckRepTable('Dep_CustPTGroupSetting_Member') = 0 RETURN
		IF dbo.f_CheckRepTable('Dep_CustPTSetting_Member') = 0 RETURN
		IF dbo.f_CheckRepTable('Dep_CustSettingMode') = 0 RETURN
		IF dbo.f_CheckRepTable('Dep_CustBAActive') = 0 RETURN
		IF dbo.f_CheckRepTable('Dep_CustBetSetting_Agent') = 0 RETURN
		IF dbo.f_CheckRepTable('Dep_ProductBetSetting') = 0 RETURN
		IF dbo.f_CheckRepTable('Dep_CustBetSetting_Member') = 0 RETURN
 
        --Checking dependency        
        IF (@type = 1 AND OBJECT_ID('tempdb..#Dep_CustProductStatus_TempBatch') IS NULL)
            OR (@type = 2 AND OBJECT_ID('tempdb..#Cust_PTBatch') IS NULL)
            OR (@type = 3 AND OBJECT_ID('tempdb..#Cust_BSBatch') IS NULL)
        BEGIN  
            RETURN
        END
        
        --Update
		--Update product status for customers already have
        IF @type = 1
        BEGIN
            UPDATE c 
            SET  c.bitmapIsHidden = t.bitmapIsHidden
				,c.bitmapIsDisabled = t.bitmapIsDisabled
            FROM Dep_CustProductStatus c WITH(ROWLOCK)
				INNER JOIN #Dep_CustProductStatus_TempBatch t ON c.CustID = t.CustID
        END

		--Insert PT setting for SMAs
        ELSE IF @type = 2 AND @level = 1
        BEGIN
            INSERT INTO Dep_CustPTSetting_Agent(
                [CustID]
                ,[SportType]
                ,[BetType]
                ,[IsLive]
                ,[SuperPT]
                ,[MasterPT]
                ,[AgentPT]
            )
            SELECT 
				t.[CustID]
                ,@SportType
                ,@BetType
                ,cs.IsLive
                ,cs.SuperPT
                ,cs.MasterPT
                ,cs.AgentPT
            FROM #Cust_PTBatch t
				INNER JOIN Dep_CustPTSetting_Agent cs WITH (NOLOCK) ON cs.CustID = t.CustID
            WHERE cs.SportType = @fSporttype AND cs.BetType = @fBettype                
                                                
            INSERT INTO Dep_CustPTGroupSetting_Member(
				AgentID
                ,SportType
                ,BetType
                ,IsLive
                ,SuperPT
                ,MasterPT
                ,AgentPT
            )
            SELECT t.[CustID]
                ,@SportType
                ,@BetType
                ,cs.IsLive
                ,cs.SuperPT
                ,cs.MasterPT
                ,cs.AgentPT
            FROM #Cust_PTBatch t WITH (NOLOCK)
				INNER JOIN Dep_CustPTGroupSetting_Member cs WITH (NOLOCK) ON cs.AgentID = t.CustID
            WHERE t.roleid = 2
				AND cs.SportType = @fSporttype AND cs.BetType = @fBettype
        END

		--Insert PT setting for Members
        ELSE IF @type = 2 AND @level = 2
        BEGIN
			INSERT INTO Dep_CustPTSetting_Member(
				[custid]
				,[sporttype]
				,[bettype]
				,[islive]
				,[superPT]
				,[masterPT]
				,[agentPT]
			)
			SELECT 
				t.[CustID]
				,@SportType
				,@BetType
				,cs.IsLive
				,cs.SuperPT
				,cs.MasterPT
				,cs.AgentPT
			FROM #Cust_PTBatch t
				INNER JOIN Dep_CustPTSetting_Member cs WITH (NOLOCK) ON cs.CustID = t.CustID
				INNER JOIN Dep_CustSettingMode m WITH(NOLOCK) ON t.CustID = m.CustID
			WHERE m.IsGroupedPT = 0
				AND cs.SportType = @fSporttype AND cs.BetType = @fBettype

			INSERT INTO Dep_CustSettingMode(CustID, IsGroupedPT)
			SELECT t.CustID, 1
			FROM #Cust_PTBatch t WITH (NOLOCK)
			WHERE NOT EXISTS (SELECT 1 FROM Dep_CustSettingMode WITH (NOLOCK) WHERE CustID=t.CustID)
				AND NOT EXISTS (SELECT 1 FROM Dep_CustBAActive BA WITH (NOLOCK) WHERE BA.CustId=t.CustID)
        END
        
		--Insert Bet setting for SMAs
        ELSE IF @type = 3 AND @level = 1
        BEGIN
			INSERT INTO Dep_CustBetSetting_Agent(
				CustID
				,SportType
				,BetType
				,MinBet
				,MaxBet
				,MaxPerMatch
			)
			SELECT t.CustID, ps.SportType, ps.BetType, ps.MinBet, ps.MaxBet, ps.MaxPerMatch
			FROM #Cust_BSBatch t
				CROSS APPLY Dep_ProductBetSetting ps WITH (NOLOCK)
			WHERE ps.SportType = @Sporttype AND ps.BetType = @Bettype AND ps.Currency = t.currency                
        END

		--Insert Bet setting for Members
        ELSE IF @type = 3 AND @level = 2
        BEGIN
			INSERT INTO Dep_CustBetSetting_Member(
						CustID
					,SportType
					,BetType
					,MinBet
					,MaxBet
					,MaxPerMatch
			)
			SELECT t.CustID, ps.SportType, ps.BetType, ps.MinBet, ps.MaxBet, ps.MaxPerMatch
			FROM #Cust_BSBatch t
				CROSS APPLY Dep_ProductBetSetting ps WITH (NOLOCK)
			WHERE ps.SportType = @Sporttype AND ps.BetType = @Bettype AND ps.Currency = t.currency                        
        END
END
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------        
--------------------------------------------------------------------------------------
-- BEGIN STEP 2: Run this script at DBCUST & all replicated servers----- -----
--------------------------------------------------------------------------------------
PRINT N'Step 2: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  

DECLARE @max_custid		INT,
        @target			NVARCHAR(20),
        @level			TINYINT,			--0: All, 1: SMA, 2: Member
        @type			TINYINT,			--1: Product Status, 2: PT, 3: Bet Setting
		@srecommend		INT
		 
SELECT @max_custid = xxx

IF @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')
        SET @target = 'DBCUST'
ELSE 
        SET @target = 'REPLICATED'
Print 'Server Name : ' + @target

CREATE TABLE #supers(custid int PRIMARY KEY, isfinished BIT)

INSERT INTO #supers(custid, isfinished)
SELECT ci.custid, 0 as isfinished
FROM custInfo ci WITH (NOLOCK)         
        INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
        INNER JOIN Dep_CustProductStatus s WITH (NOLOCK) ON ci.custid = s.CustID
        INNER JOIN Dep_CustPTSetting_Agent a WITH (NOLOCK) ON ci.custid = a.CustID
        CROSS APPLY f_CustSetting_ProductStatusSel(s.bitmapIsDisabled, 33) f                --VS3(Old) Status
        CROSS APPLY Dep_ProductBetSetting ps WITH (NOLOCK)
WHERE ci.username NOT LIKE '3rdSuper%'        
        AND ci.CustID <= @max_custid
        AND ci.Enabled = 1
        AND cs.site IN ('12Bet','18Luck','24AVIA','365online','383sport','3ge888','3star88','633esports','7kplatform','88Macao','9bet','9Club','9w','A1game','ab6688','Abcasino','ACsports','Ae88','AEUG','AKYL99','Aladdin99','allwincity','alog','Alphalota','AnvoFH','Aoncash','B24VN','Baji','Barcelo9','BBIN2','BBIN3','bdtt','BE7','beplay','BigGaming','Bigwiner','bmwbet','Bobo88','Bolanation','Bonanza88','BPLE','C7YOUXI','C88bet','Callmeboss','CCLive','CGame','Dade','dafd','Dawoo','Dawooxin','DBP','DCSDemo','DDwin','DEWA','DFGame','Diamond','DingTai','DMsports','DTGJZ','e8casino','ECBet88','ECLBET','erhaozhan','FB88','FHLMSABA','G4ALL','GAMEBee','GamingSoft','Gampag','Gaobet','GESAB','haifa','HBPT','HC6YAYOU','Heaven','Hecbet','HFYX','HIDZ','hjccasino','HL8','HOT99','HuangMa','HY6','iBET','IBO','ig128','infini88','INSERTGAME','IONclub','ITCbet','JDJDAPI','JIBET','Jiuyou','JJBGAME','JUYOU','kbosports','KingBet','KUTECH','LegendWin','Leng4D','LIGAWLHKB','LLgaming','loc','Lode88','LUCKYBET','M8bola','M8Credit','Macaubet','ManCity','Mancity2','Mayayule','Mayibet','mbxusdt','MICL','Monaco','Mopgaming','MTech','MYGAME','N88','N8B','N8BK','N8G','NewFuture','OBGM','OBsystem','OCMS','OESports','OPEBET','Ot88','OYO','PLAYES','pmwint','Q8bola','Raisetech','Rio66','Saba789','SampleSite','ScaleDemo1','ScaleDemo2','SDY','sea168','SGM88','SKY1688','skykey','Soon88','starsoccer','STEBBCBI','Sunriseb2b','Sunwin','SWSite','TangChao','TaoCai','TCbet','Tesla','TGAA0813','Titanbet','TopGame','Towin','Tripleone','TSLA','TT128','TXJT','txwl002','TYgaming','TYM2','US8YAYOU','Uwoniwin','VCBA','VEGA77','VKGAME','vnggame','VWIN66','WABET','Wanbo','Wanfang','WBG88','Wcasino','Wcasino88','webet88','win365','Winbox','WINCLUB88','WINHX1','WKCUR','WKPHIL','WLSTAR','wmcasino','WRServices','Xiaojin','Xinbo','XTSB','Yibo','Yintai','YongBao','YSYBO688','Yunji','YYHbet','ZF026','ZF055PMW','ZF133FIN2','ZF138THB','ZF138USD','ZF138VND','ZF215aTR','ZFRT090','ZFRT126','ZFRT132','ZFRT144','ZFRT155new','ZFRT156','ZFRT159','ZFRT161','ZFRT165','ZFRT166','ZFRT179','ZFRT195','ZFRT213','ZFRT218','ZFRT219','ZFRT263','ZFRT264','ZFRT276','ZFRT282','ZFRT80GPGT','ZhiFeng009','ZhiFeng012','ZhiFeng013','ZhiFeng021','ZhiFeng030','ZhiFeng032','ZhiFeng035','ZhiFeng036','ZhiFeng040','ZhiFeng041','ZhiFeng051','ZhiFeng138','ZhiFeng147','ZhiFeng183','ZhiFeng221','ZhiFeng222','ZhiFeng228','ZhiFeng253','ZhiFeng267','ZhiFeng271','ZhiFeng303','Zowin','zt828','ZTech')
        AND a.Sporttype = 190 AND a.Bettype = 2701                                           --VS2 PT                
        AND ps.Sporttype = 178 AND ps.Bettype = 5302 AND ps.Currency = ci.currency
        AND f.value = 0

CREATE TABLE #Dummy(CustID INT PRIMARY KEY)

INSERT INTO #Dummy(CustID)
SELECT c.CustID FROM Customer c WITH (NOLOCK)        
        INNER JOIN #supers s WITH (NOLOCK) ON c.srecommend = s.custid
WHERE c.roleid = 3 
        AND (c.username LIKE '%Acc%' OR c.username LIKE '%LocalBank%' OR c.username LIKE '%AFF%' OR c.username LIKE 'AB88'+'CAS%')
        AND c.custid <= @max_custid 

DECLARE		@SportType      SMALLINT = 178, 
            @BetType		SMALLINT = 5302,
            @fSporttype		SMALLINT = 190,
            @fBettype       SMALLINT = 2701,
            @BitMapOrder	TINYINT
SELECT @BitMapOrder = bitmapOrder
FROM Dep_ProductStatusProfile WITH (NOLOCK)
WHERE Sporttype = @SportType AND Bettype = @BetType

CREATE TABLE #SMATemp(
        CustID			INT PRIMARY KEY
        ,currency		INT
		,roleid			TINYINT
        ,isfinishedpt	BIT
        ,isfinishedbs	BIT
) 

CREATE TABLE #MemberTemp(
        CustID			INT PRIMARY KEY
        ,currency		INT
        ,isfinishedpt	BIT
        ,isfinishedbs	BIT
) 


CREATE TABLE #Dep_CustProductStatus_Temp(CustID INT PRIMARY KEY, bitmapIsHidden BINARY(32), bitmapIsDisabled BINARY(32))
CREATE TABLE #Dep_CustProductStatus_TempBatch(CustID INT PRIMARY KEY, bitmapIsHidden BINARY(32), bitmapIsDisabled BINARY(32))

CREATE TABLE #Cust_PTBatch(custid INT PRIMARY KEY, roleid TINYINT)
CREATE TABLE #Cust_BSBatch(custid INT PRIMARY KEY, currency INT)

DECLARE @super_cnt INT, @index INT = 0
DECLARE @msg NVARCHAR(200) = 'Currently at order %d, SuperID: %d.'
DECLARE @msg_total NVARCHAR(200) = 'Total of supers: %d.'

SET @super_cnt = (SELECT COUNT(1) FROM #supers )

RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1=1)
BEGIN
	UPDATE TOP (1) s
	SET s.isfinished = 1,
		@srecommend = s.custid
	FROM #supers s 
	WHERE s.isfinished = 0

	IF @@ROWCOUNT = 0
		BREAK
	
	TRUNCATE TABLE #SMATemp

	INSERT INTO #SMATemp(custid, roleid, currency, isfinishedpt, isfinishedbs)
	SELECT ci.custid, ci.roleid, ci.currency, 0 as isfinishedpt, 0 as isfinishedbs
	FROM custinfo ci WITH (NOLOCK)
	WHERE ci.Enabled = 1 
		AND ci.srecommend = @srecommend
		AND ci.roleid IN (2,3,4)
		AND ci.custid <= @max_custid
		AND ci.mrecommend NOT IN (SELECT custid FROM #Dummy WITH (NOLOCK))

	TRUNCATE TABLE #MemberTemp

	INSERT INTO #MemberTemp(custid, currency, isfinishedpt, isfinishedbs)
	SELECT ci.custid, ci.currency, 0 as isfinishedpt, 0 as isfinishedbs
	FROM custinfo ci WITH (NOLOCK)
	WHERE ci.Enabled = 1 
		AND ci.srecommend = @srecommend
		AND ci.roleid = 1
		AND ci.custid <= @max_custid
		AND ci.mrecommend NOT IN (SELECT custid FROM #Dummy WITH (NOLOCK))

	--Product status
	INSERT INTO #Dep_CustProductStatus_Temp(CustID, bitmapIsHidden, bitmapIsDisabled)
	SELECT c.CustID, 
					dbo.f_GenerateProductStatus(c.bitmapIsHidden, @BitMapOrder, 0),
					dbo.f_GenerateProductStatus(c.bitmapIsDisabled, @BitMapOrder, 0)
	FROM Dep_CustProductStatus c WITH (NOLOCK)
			INNER JOIN #SMATemp t ON c.CustID = t.CustID
	UNION ALL
	SELECT c.CustID, 
					dbo.f_GenerateProductStatus(c.bitmapIsHidden, @BitMapOrder, 0),
					dbo.f_GenerateProductStatus(c.bitmapIsDisabled, @BitMapOrder, 0)
	FROM Dep_CustProductStatus c WITH (NOLOCK)
			INNER JOIN #MemberTemp t ON c.CustID = t.CustID

	WHILE (1 = 1)
	BEGIN
			DELETE FROM #Dep_CustProductStatus_TempBatch

			DELETE TOP (5000) t
			OUTPUT DELETED.custid, DELETED.bitmapIsHidden, DELETED.bitmapIsDisabled INTO #Dep_CustProductStatus_TempBatch(CustID, bitmapIsHidden, bitmapIsDisabled)
			FROM #Dep_CustProductStatus_Temp t 

			IF @@ROWCOUNT = 0
					BREAK
                
			EXEC  dbo.[Acc_DynamicCustSetting3rd_09] 
							@type = 1
							,@target = @target
	END

	IF NOT EXISTS(SELECT TOP 1 1 FROM Dep_LicenseeProductSetting WITH(NOLOCK) WHERE Custid=@srecommend AND ProductSettingID = 168)
	BEGIN
		INSERT INTO Dep_LicenseeProductSetting(CustID, ProductSettingID)
		SELECT @srecommend, 168
	END
	
	--Position taking
	WHILE (1=1)
	BEGIN
			DELETE FROM #Cust_PTBatch

			UPDATE TOP (5000) t 
			SET t.isfinishedpt = 1
			OUTPUT DELETED.CustID, DELETED.roleid INTO #Cust_PTBatch(custid, roleid)
			FROM #SMATemp t 
			WHERE t.isfinishedpt = 0

			IF @@ROWCOUNT = 0
					BREAK

			EXEC dbo.[Acc_DynamicCustSetting3rd_09] 
				@type = 2
				,@level = 1
				,@target = @target
	END

	WHILE (1=1)
	BEGIN
			DELETE FROM #Cust_PTBatch

			UPDATE TOP (5000) t 
			SET t.isfinishedpt = 1
			OUTPUT DELETED.CustID INTO #Cust_PTBatch(custid)
			FROM #MemberTemp t 
			WHERE t.isfinishedpt = 0

			IF @@ROWCOUNT = 0
					BREAK

			EXEC dbo.[Acc_DynamicCustSetting3rd_09] 
				@type = 2
				,@level = 2
				,@target = @target
	END

	IF NOT EXISTS(SELECT TOP 1 1 FROM Dep_LicenseeProductSetting WITH(NOLOCK) WHERE Custid=@srecommend AND ProductSettingID = 169)
	BEGIN
		INSERT INTO Dep_LicenseeProductSetting(CustID, ProductSettingID)
		SELECT @srecommend, 169
	END

	--Bet setting
	WHILE (1=1)
	BEGIN
			DELETE FROM #Cust_BSBatch

			UPDATE TOP (5000) t
			SET t.isfinishedbs = 1
			OUTPUT DELETED.CustID, DELETED.currency INTO #Cust_BSBatch(custid, currency)
			FROM #SMATemp t 
			WHERE t.isfinishedbs = 0

			IF @@ROWCOUNT = 0
					BREAK

			EXEC dbo.[Acc_DynamicCustSetting3rd_09] 
				@type = 3
				,@level = 1
				,@target = @target
	END

	WHILE (1=1)
	BEGIN
			DELETE FROM #Cust_BSBatch

			UPDATE TOP (5000) t
			SET t.isfinishedbs = 1
			OUTPUT DELETED.CustID, DELETED.currency INTO #Cust_BSBatch(custid, currency)
			FROM #MemberTemp t 
			WHERE t.isfinishedbs = 0

			IF @@ROWCOUNT = 0
					BREAK

			EXEC dbo.[Acc_DynamicCustSetting3rd_09] 
				@type = 3
				,@level = 2
				,@target = @target  
	END

	IF NOT EXISTS(SELECT TOP 1 1 FROM Dep_LicenseeProductSetting WITH(NOLOCK) WHERE Custid=@srecommend AND ProductSettingID = 170)
	BEGIN
		INSERT INTO Dep_LicenseeProductSetting(CustID, ProductSettingID)
		SELECT @srecommend, 170
	END

	WAITFOR DELAY '00:00:0.050'  
	SET @index +=1
	RAISERROR(@msg, 0, 1, @index, @srecommend) WITH NOWAIT
END

DROP TABLE #supers,
			#Cust_BSBatch,
			#Cust_PTBatch,
			#Dep_CustProductStatus_Temp,
			#Dep_CustProductStatus_TempBatch,
			#Dummy,
			#MemberTemp,
			#SMATemp
GO	

PRINT N'Step 2: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
GO
-- END STEP 2: Run this script at DBCUST & all replicated servers-----
----------------------------------------------------------------------