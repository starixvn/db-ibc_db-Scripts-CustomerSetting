/*
	Created: Winnie
	Task: Update PT settings of NG for licensees RedmineID: #108062
	DB: DBCUST/CustDB
	Date: 20190117
*/ 

ALTER PROCEDURE [dbo].Acc_CustSetting_19
	@srecommend INT	
	,@maxcustid INT
	,@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbtrans only
	
	IF dbo.f_CheckRepTable('CustInfo') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustSetting3rd') = 0 RETURN		
	
	DECLARE @PT SMALLMONEY	
	SELECT @PT=0.88
	DECLARE @StartRow	INT, 
		@MaxRow		INT,		
		@Threshold	INT, 
		@StopRow	INT		
	SET @StartRow=1
	SET @Threshold=3000	
	--------------------------------------PT Setting-------------------------------------------------	
	
	CREATE TABLE #tempSporttype (Sporttype SMALLINT,BetType SMALLINT,IsLive BIT,PRIMARY KEY(Sporttype,BetType,IsLive))
	INSERT INTO #tempSporttype(Sporttype ,BetType ,IsLive )
	SELECT 	161,	81,	0
	UNION ALL
	SELECT 161,	83,	0
	UNION ALL
	SELECT 161,	85,	1
	UNION ALL
	SELECT 161,	86,	0
	UNION ALL
	SELECT 161,	86,	1
	UNION ALL
	SELECT 161,	87,	1
	UNION ALL
	SELECT 161,	88,	0
	UNION ALL
	SELECT 161,	89,	1
	UNION ALL
	SELECT 161,	90,	1
	
	CREATE TABLE #tmpCust	(CustID INT,Sporttype SMALLINT,BetType SMALLINT,IsLive BIT)	
	CREATE TABLE #tmpSMA	(ID INT IDENTITY (1,1) PRIMARY KEY,CustID INT ,RoleID INT,Sporttype SMALLINT,BetType SMALLINT,IsLive SMALLINT)	
	CREATE TABLE #tmpCust161_81_0	(CustID INT,BetType SMALLINT,Sporttype SMALLINT,IsLive BIT, PRIMARY KEY(CustID,BetType ,Sporttype  ,IsLive))	

	INSERT INTO #tmpCust(CustID,Sporttype,BetType,IsLive)
	SELECT ci.CustID,Sporttype,BetType,IsLive
	FROM custInfo ci WITH(NOLOCK)	
		CROSS JOIN #tempSporttype
	WHERE ci.srecommend = @srecommend AND ci.custid<=@maxcustid 
		AND roleid = 1 	

	INSERT INTO #tmpSMA(CustID,RoleID,Sporttype,BetType,IsLive)
	SELECT CustID,RoleID,Sporttype,BetType,IsLive
	FROM custInfo ci WITH(NOLOCK)		
			CROSS JOIN #tempSporttype
	WHERE ci.srecommend = @srecommend AND ci.custid<=@maxcustid 
		AND roleid IN(2,3,4) 
	
	--AGENT LEVEL	

	IF EXISTS(SELECT 1 FROM #tmpSMA)
	BEGIN
			
		SET @MaxRow = (SELECT MAX(ID) FROM #tmpSMA)
			
		IF	@Threshold >= @MaxRow
		SET	@Threshold = @MaxRow
			
		SET @StopRow = @Threshold

		WHILE (0 = 0)
		BEGIN			
			UPDATE a
				SET a.spositiontaking=@PT,a.mpositiontaking=@PT,a.apositiontaking=@PT
			FROM Dep_CustSetting3rd a WITH(ROWLOCK,UPDLOCK)
				INNER JOIN #tmpSMA t ON a.CustID=t.CustID		
			WHERE ID >= @StartRow AND ID <= @StopRow AND RoleID=4 AND a.SportType =t.Sporttype AND a.bettype=t.BetType AND a.islive=t.IsLive
	
			UPDATE a
				SET a.mpositiontaking=@PT
			FROM Dep_CustSetting3rd a WITH(ROWLOCK,UPDLOCK)
				INNER JOIN #tmpSMA t ON a.CustID=t.CustID
			WHERE ID >= @StartRow AND ID <= @StopRow AND RoleID=3 AND a.SportType =t.Sporttype AND a.bettype=t.BetType AND a.islive=t.IsLive
		
			UPDATE a
				SET a.apositiontaking=@PT
			FROM Dep_CustSetting3rd a WITH(ROWLOCK,UPDLOCK)
				INNER JOIN #tmpSMA t ON a.CustID=t.CustID
			WHERE ID >= @StartRow AND ID <= @StopRow AND RoleID=2 AND a.SportType =t.Sporttype AND a.bettype=t.BetType AND a.islive=t.IsLive
		
			IF	@StopRow = @MaxRow 
				BREAK
						
			SET	@StartRow = @StopRow + 1
						
			SET	@StopRow = 1 + @StopRow + @Threshold
						
			IF	@StopRow >= @MaxRow
				SET	@StopRow = @MaxRow
										
		END;
	END;	
	----------------------------------------
	WHILE EXISTS(SELECT 1 FROM #tmpCust)
	BEGIN
		DELETE TOP (3000) #tmpCust OUTPUT DELETED.* INTO #tmpCust161_81_0

		UPDATE a
			SET a.apositiontaking=@PT
		FROM Dep_CustSetting3rd a WITH(ROWLOCK)
			INNER JOIN #tmpCust161_81_0 t ON a.CustID=t.CustID AND a.bettype=t.BetType AND a.SportType =t.Sporttype AND a.islive=t.IsLive
							
		TRUNCATE TABLE #tmpCust161_81_0

	END


	
END
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS -----
--------------------------------------------------------------------------------------
CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @max_custid INT, @srecommend INT

SELECT @max_custid = xxx

INSERT INTO #supers(custid)
SELECT ci.custid
FROM custInfo ci WITH (NOLOCK) 	
	INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.username NOT LIKE '3rdSuper%'	
	AND ci.CustID <= @max_custid
	AND ci.Enabled=1
	AND cs.site IN('12Bet','asiabet88','mansion88','alog','spondemo','TLC','SunGame','MayFair','Zzun88','Bodog','Vwin','Macaubet','Aoncash','ITCBet','Athena000','Avia','W88','9bet','3star88','OLE777',
	'88Macao','Boma365','Salon365','Ae88','Hengcai88','368Cash','Senibet','Happy1668','AG','M8bola','9Club','XTD3','HONBET','Q8bola','BE7','iBET','ISC888','Liga','NBCbet','HonorW','Royal',
	'DEWA','IBO','Unobet','GamingSoft','Newhonbet','Hecbet','DBP','HL8','Abcasino','TGO','Starnet','365online','Bolanation','KhmerG','Gampag','IONclub','Sun988','Mayayule','HuangMa','Webet138','webet88',
	'BigGaming','Boying','Brown888','MrCat','CGame','PKbet','VCBA','Taipanbet','FLC','IGPTech','BetStar','TGame','Dawoo','Ty777','Uwoniwin','Sunrise','Swin','UN168','PanguGame','K8VN','ECLBET','GPIGAME','818Bet','SSSSEA',
	'Heaven','GOAB88','Bobo88','OPEBET','Jinyazhou','Sunriseb2b','Okada','396Club','Mybet88','e8casino','HongChow','TangChao','MAX88','YongBao','Fugui','GMASTER','ALPHA88','Citybk','Tripleone','GWORLD',
	'ENTAPLAY','MICL','zt828','Aplus','Arlocash','WBS','YBTech','Yibo','24TECH','Xinbo','BETSUN','HOT88','Monaco','Opadmin','Bonanza88','SSSGaming','JIBET','WINCLUB88','EU88','MARS','Dade','Nbbet',
	'Gameroom','ANGbet','Hongtu','Callmeboss','Hong88','BetDeal','SampleSite','VWIN66','A1game','HJTK','TitanOne','gbkj','skykey','Dachen','Bobbet','laba360','AEUG','XinYo','18Luck','Mbet','Kudatogel','WinWin',
	'HCVIP','ig128','AMG','MRCATSB','VN88')

-- For deployer info
DECLARE @super_cnt INT, @index INT = 0
DECLARE @msg NVARCHAR(200) = 'Currently at order %d, SuperID: %d.'
DECLARE @msg_total NVARCHAR(200) = 'Total of supers: %d.'

SET @super_cnt = (SELECT COUNT(*) FROM #supers )
RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #Supers
	SET isfinished = 1
		,@srecommend = custid	
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK
	
	SET @index = @index + 1
	RAISERROR (@msg, 0, 1, @index, @srecommend) WITH NOWAIT

	EXEC dbo.Acc_CustSetting_19 @srecommend = @srecommend
			,@maxcustid = @max_custid
			,@target = 'REPLICATED'
			
			
	waitfor delay '00:00:0.100'
END
GO

-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
PRINT N'Step 4: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  

CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @max_custid INT, @srecommend INT

SELECT @max_custid = xxx

INSERT INTO #supers(custid)
SELECT ci.custid
FROM custInfo ci WITH (NOLOCK) 	
	INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.username NOT LIKE '3rdSuper%'	
	AND ci.CustID <= @max_custid
	AND ci.Enabled=1
	AND cs.site IN('12Bet','asiabet88','mansion88','alog','spondemo','TLC','SunGame','MayFair','Zzun88','Bodog','Vwin','Macaubet','Aoncash','ITCBet','Athena000','Avia','W88','9bet','3star88','OLE777',
	'88Macao','Boma365','Salon365','Ae88','Hengcai88','368Cash','Senibet','Happy1668','AG','M8bola','9Club','XTD3','HONBET','Q8bola','BE7','iBET','ISC888','Liga','NBCbet','HonorW','Royal',
	'DEWA','IBO','Unobet','GamingSoft','Newhonbet','Hecbet','DBP','HL8','Abcasino','TGO','Starnet','365online','Bolanation','KhmerG','Gampag','IONclub','Sun988','Mayayule','HuangMa','Webet138','webet88',
	'BigGaming','Boying','Brown888','MrCat','CGame','PKbet','VCBA','Taipanbet','FLC','IGPTech','BetStar','TGame','Dawoo','Ty777','Uwoniwin','Sunrise','Swin','UN168','PanguGame','K8VN','ECLBET','GPIGAME','818Bet','SSSSEA',
	'Heaven','GOAB88','Bobo88','OPEBET','Jinyazhou','Sunriseb2b','Okada','396Club','Mybet88','e8casino','HongChow','TangChao','MAX88','YongBao','Fugui','GMASTER','ALPHA88','Citybk','Tripleone','GWORLD',
	'ENTAPLAY','MICL','zt828','Aplus','Arlocash','WBS','YBTech','Yibo','24TECH','Xinbo','BETSUN','HOT88','Monaco','Opadmin','Bonanza88','SSSGaming','JIBET','WINCLUB88','EU88','MARS','Dade','Nbbet',
	'Gameroom','ANGbet','Hongtu','Callmeboss','Hong88','BetDeal','SampleSite','VWIN66','A1game','HJTK','TitanOne','gbkj','skykey','Dachen','Bobbet','laba360','AEUG','XinYo','18Luck','Mbet','Kudatogel','WinWin',
	'HCVIP','ig128','AMG','MRCATSB','VN88')

-- For deployer info
DECLARE @super_cnt INT, @index INT = 0
DECLARE @msg NVARCHAR(200) = 'Currently at order %d, SuperID: %d.'
DECLARE @msg_total NVARCHAR(200) = 'Total of supers: %d.'

SET @super_cnt = (SELECT COUNT(*) FROM #supers )
RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #Supers
	SET isfinished = 1
		,@srecommend = custid	
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK

	SET @index = @index + 1
	RAISERROR (@msg, 0, 1, @index, @srecommend) WITH NOWAIT

	EXEC dbo.Acc_CustSetting_19 @srecommend = @srecommend
			,@maxcustid = @max_custid
			,@target = 'DBCUST'
						
	waitfor delay '00:00:0.100'
END

PRINT N'Step 4: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
