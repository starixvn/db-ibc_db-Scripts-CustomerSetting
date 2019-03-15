/*
	Created: Elodie
	Task: Update PT settings of SB for licensees [RedmineID: #110111]
	DB: DBCUST/CustDB
	Date: 20190313
*/ 

ALTER PROCEDURE [dbo].Acc_CustSetting_19
	@srecommend INT	
	,@PT SMALLMONEY	
	,@maxcustid INT
	,@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at DBCUST only
	
	IF dbo.f_CheckRepTable('CustInfo') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustSetting') = 0 RETURN		
	
	DECLARE @StartRow INT, @StopRow	INT, @MaxRow INT, @ThresholdSMA INT, @ThresholdMem INT
				
	SET @StartRow = 1
	SET @ThresholdSMA = 3000	
	--------------------------------------PT Setting-------------------------------------------------		
	
	CREATE TABLE #tmpMem	(CustID INT)	
	CREATE TABLE #tmpSMA	(ID INT IDENTITY (1,1) PRIMARY KEY,CustID INT ,RoleID INT)	
	CREATE TABLE #tmpCust	(CustID INT PRIMARY KEY)	

	
	CREATE TABLE #DummySMA (CustID INT PRIMARY KEY)
	CREATE TABLE #DummyMember (CustID INT PRIMARY KEY)
	
	DECLARE @tmpDumMaster TABLE (custid INT PRIMARY KEY, username VARCHAR(30))

	INSERT INTO @tmpDumMaster(custid, username)
	SELECT c.CustID, fc.username
	FROM Customer c WITH(NOLOCK) 
		CROSS APPLY (
					SELECT TOP 1 custid, username
					FROM dbo.Customer cc WITH(NOLOCK)
					WHERE c.custid = cc.custid 
					) fc
	WHERE c.srecommend = @srecommend AND c.roleid =3

	INSERT INTO #DummyMember(CustID)
	SELECT c.custid
	FROM @tmpDumMaster d
		INNER JOIN dbo.Customer c ON d.custid = c.mrecommend AND c.roleid = 1
	WHERE d.username LIKE '%Acc%' OR d.username LIKE '%LocalBank%'

	INSERT INTO #DummySMA(CustID)
	SELECT c.custid
	FROM @tmpDumMaster d
	 INNER JOIN dbo.Customer c 
	  ON d.custid = c.mrecommend AND c.roleid IN(2,3)
	WHERE d.username LIKE '%Acc%' OR d.username LIKE '%LocalBank%'

	INSERT INTO #tmpMem(CustID)
	SELECT ci.CustID
	FROM custInfo ci WITH(NOLOCK)			
	WHERE ci.srecommend = @srecommend AND ci.custid<=@maxcustid 
		AND roleid = 1 	
		AND ci.custid NOT IN(SELECT Custid FROM #DummyMember)

	INSERT INTO #tmpSMA(CustID,RoleID)
	SELECT CustID,RoleID
	FROM custInfo ci WITH(NOLOCK)				
	WHERE ci.srecommend = @srecommend AND ci.custid<=@maxcustid 
		AND roleid IN(2,3,4) 
		AND ci.custid NOT IN(SELECT Custid FROM #DummySMA)
	
	--AGENT LEVEL	
	IF EXISTS(SELECT 1 FROM #tmpSMA)
	BEGIN
			
		SET @MaxRow = (SELECT MAX(ID) FROM #tmpSMA)
			
		IF	@ThresholdSMA >= @MaxRow
		SET	@ThresholdSMA = @MaxRow
			
		SET @StopRow = @ThresholdSMA

		WHILE (0 = 0)
		BEGIN			
			UPDATE a
			SET a.spositiontaking=@PT,a.mpositiontaking=@PT,a.apositiontaking=@PT
			FROM Dep_CustSetting a WITH(ROWLOCK)
				INNER JOIN #tmpSMA t ON a.CustID=t.CustID		
			WHERE ID >= @StartRow AND ID <= @StopRow AND RoleID=4
	
			UPDATE a
			SET a.mpositiontaking=@PT
			FROM Dep_CustSetting3rd a WITH(ROWLOCK,UPDLOCK)
				INNER JOIN #tmpSMA t ON a.CustID=t.CustID
			WHERE ID >= @StartRow AND ID <= @StopRow AND RoleID=3
		
			UPDATE a
			SET a.apositiontaking=@PT
			FROM Dep_CustSetting3rd a WITH(ROWLOCK,UPDLOCK)
				INNER JOIN #tmpSMA t ON a.CustID=t.CustID
			WHERE ID >= @StartRow AND ID <= @StopRow AND RoleID=2
		
			IF	@StopRow = @MaxRow 
				BREAK
						
			SET	@StartRow = @StopRow + 1
						
			SET	@StopRow = 1 + @StopRow + @ThresholdSMA
						
			IF	@StopRow >= @MaxRow
				SET	@StopRow = @MaxRow
										
		END;
	END;	
	----------------------------------------
	WHILE EXISTS(SELECT 1 FROM #tmpMem)
	BEGIN
		DELETE TOP (500) #tmpMem OUTPUT DELETED.* INTO #tmpCust

		UPDATE a
		SET a.apositiontaking=@PT
		FROM Dep_CustSetting a WITH(ROWLOCK,UPDLOCK)
			INNER JOIN #tmpCust t ON a.CustID=t.CustID 
							
		TRUNCATE TABLE #tmpCust
	END
END
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS -----
--------------------------------------------------------------------------------------
PRINT N'Step 4: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  

CREATE TABLE #supers (custid INT, PT SMALLMONEY)
CREATE TABLE #supersFinal (ID INT IDENTITY(1,1), custid INT, PT SMALLMONEY, NoDownline INT)

DECLARE @max_custid INT, @srecommend INT, @PT SMALLMONEY

SELECT @max_custid = 30000000

INSERT INTO #supers(custid, PT)
SELECT ci.custid, 0.85
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

INSERT INTO #supersFinal (custid, PT, NoDownline)
SELECT ci.srecommend, s.PT, COUNT(1)
FROM #supers s 
	INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.srecommend = s.custid
GROUP BY ci.srecommend, PT
ORDER BY COUNT(1)

-- For deployer info
DECLARE @super_cnt INT, @index INT = 1
DECLARE @msg NVARCHAR(200) = 'Currently at order %d, SuperID: %d.'
DECLARE @msg_total NVARCHAR(200) = 'Total of supers: %d.'

SET @super_cnt = (SELECT COUNT(*) FROM #supers )
RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	SELECT @srecommend = custid, @PT = PT
	FROM #supersFinal
	WHERE ID = @index
	
	IF @@ROWCOUNT = 0 BREAK
		
	RAISERROR (@msg, 0, 1, @index, @srecommend) WITH NOWAIT

	EXEC dbo.Acc_CustSetting_19 @srecommend = @srecommend, @PT = @PT
			,@maxcustid = @max_custid
			,@target = 'REPLICATED'

	SET @index = @index + 1						
	WAITFOR DELAY '00:00:0.100'
END
GO

PRINT N'Step 4: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 

-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
PRINT N'Step 4: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  

CREATE TABLE #supers (custid INT, PT SMALLMONEY)
CREATE TABLE #supersFinal (ID INT IDENTITY(1,1), custid INT, PT SMALLMONEY, NoDownline INT)

DECLARE @max_custid INT, @srecommend INT, @PT SMALLMONEY

SELECT @max_custid = 30000000

INSERT INTO #supers(custid, PT)
SELECT ci.custid, 0.85
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

INSERT INTO #supersFinal (custid, PT, NoDownline)
SELECT ci.srecommend, s.PT, COUNT(1)
FROM #supers s 
	INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.srecommend = s.custid
GROUP BY ci.srecommend, PT
ORDER BY COUNT(1)

-- For deployer info
DECLARE @super_cnt INT, @index INT = 1
DECLARE @msg NVARCHAR(200) = 'Currently at order %d, SuperID: %d.'
DECLARE @msg_total NVARCHAR(200) = 'Total of supers: %d.'

SET @super_cnt = (SELECT COUNT(*) FROM #supers )
RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	SELECT @srecommend = custid, @PT = PT
	FROM #supersFinal
	WHERE ID = @index
	
	IF @@ROWCOUNT = 0 BREAK
		
	RAISERROR (@msg, 0, 1, @index, @srecommend) WITH NOWAIT

	EXEC dbo.Acc_CustSetting_19 @srecommend = @srecommend, @PT = @PT
			,@maxcustid = @max_custid
			,@target = 'REPLICATED'

	SET @index = @index + 1						
	WAITFOR DELAY '00:00:0.100'
END
GO

PRINT N'Step 4: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
