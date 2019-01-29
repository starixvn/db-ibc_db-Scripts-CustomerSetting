/*
	Created: Winnie
	Task: Update PT settings of NG for licensees new cust RedmineID: #108062
	DB: DBCUST/CustDB
	Date: 20190117
*/ 

ALTER PROCEDURE [dbo].Acc_CustSetting_19
(@MaxCustID INT)
AS
BEGIN
	SET NOCOUNT ON	
	IF dbo.f_CheckRepTable('CustInfo') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustSetting3rd') = 0 RETURN		
	IF dbo.f_CheckRepTable('Customer') = 0 RETURN

	DECLARE @PT SMALLMONEY	
	SELECT @PT=0.88

	CREATE TABLE #supers (custid int)
	INSERT INTO #supers(custid)
	SELECT ci.custid
	FROM Custinfo ci WITH (NOLOCK) 	
		INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
	WHERE ci.username NOT LIKE '3rdSuper%'
		AND ci.Enabled=1
		AND cs.site IN('12Bet','asiabet88','mansion88','alog','spondemo','TLC','SunGame','MayFair','Zzun88','Bodog','Vwin','Macaubet','Aoncash','ITCBet','Athena000','Avia','W88','9bet','3star88','OLE777',
		'88Macao','Boma365','Salon365','Ae88','Hengcai88','368Cash','Senibet','Happy1668','AG','M8bola','9Club','XTD3','HONBET','Q8bola','BE7','iBET','ISC888','Liga','NBCbet','HonorW','Royal',
		'DEWA','IBO','Unobet','GamingSoft','Newhonbet','Hecbet','DBP','HL8','Abcasino','TGO','Starnet','365online','Bolanation','KhmerG','Gampag','IONclub','Sun988','Mayayule','HuangMa','Webet138','webet88',
		'BigGaming','Boying','Brown888','MrCat','CGame','PKbet','VCBA','Taipanbet','FLC','IGPTech','BetStar','TGame','Dawoo','Ty777','Uwoniwin','Sunrise','Swin','UN168','PanguGame','K8VN','ECLBET','GPIGAME','818Bet','SSSSEA',
		'Heaven','GOAB88','Bobo88','OPEBET','Jinyazhou','Sunriseb2b','Okada','396Club','Mybet88','e8casino','HongChow','TangChao','MAX88','YongBao','Fugui','GMASTER','ALPHA88','Citybk','Tripleone','GWORLD',
		'ENTAPLAY','MICL','zt828','Aplus','Arlocash','WBS','YBTech','Yibo','24TECH','Xinbo','BETSUN','HOT88','Monaco','Opadmin','Bonanza88','SSSGaming','JIBET','WINCLUB88','EU88','MARS','Dade','Nbbet',
		'Gameroom','ANGbet','Hongtu','Callmeboss','Hong88','BetDeal','SampleSite','VWIN66','A1game','HJTK','TitanOne','gbkj','skykey','Dachen','Bobbet','laba360','AEUG','XinYo','18Luck','Mbet','Kudatogel','WinWin',
		'HCVIP','ig128','AMG','MRCATSB','VN88')
	
	
	--------------------------------------PT Setting-------------------------------------------------	
	
	
	CREATE TABLE #tmpCust			(CustID INT PRIMARY KEY)
	CREATE TABLE #tmpCustUpdate		(CustID INT PRIMARY KEY)	
	CREATE TABLE #tmpSMA			(CustID INT PRIMARY KEY,RoleID INT)
	
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
	WHERE c.srecommend IN(SELECT custid FROM #supers)
	 AND c.roleid =3

	INSERT INTO #DummyMember(CustID)
	SELECT c.custid
	FROM @tmpDumMaster d
	 INNER JOIN dbo.Customer c 
	  ON d.custid = c.mrecommend AND c.roleid = 1
	WHERE d.username LIKE '%Acc%' OR d.username LIKE '%LocalBank%'

	INSERT INTO #DummySMA(CustID)
	SELECT c.custid
	FROM @tmpDumMaster d
	 INNER JOIN dbo.Customer c 
	  ON d.custid = c.mrecommend AND c.roleid IN(2,3)
	WHERE d.username LIKE '%Acc%' OR d.username LIKE '%LocalBank%'
	
	INSERT INTO #tmpCust(CustID)
	SELECT ci.CustID
	FROM custInfo ci WITH(NOLOCK)		
	WHERE ci.srecommend IN(SELECT custid FROM #supers) AND ci.custid>@maxcustid 
		AND roleid = 1 		
		AND ci.CustID NOT IN(SELECT Custid FROM #DummyMember)

	INSERT INTO #tmpSMA(CustID,RoleID)
	SELECT CustID,RoleID
	FROM custInfo ci WITH(NOLOCK)
	WHERE ci.srecommend IN(SELECT custid FROM #supers)  AND ci.custid>@maxcustid 
		AND roleid IN(2,3,4)	
		AND ci.CustID NOT IN(SELECT Custid FROM #DummySMA)

	--AGENT LEVEL	
	UPDATE a
		SET a.spositiontaking=@PT,a.mpositiontaking=@PT,a.apositiontaking=@PT
	FROM Dep_CustSetting3rd a WITH(ROWLOCK,UPDLOCK)
		INNER JOIN #tmpSMA t ON a.CustID=t.CustID
	WHERE RoleID=4 AND a.bettype BETWEEN 81 AND 90
	
	UPDATE a
		SET a.mpositiontaking=@PT
	FROM Dep_CustSetting3rd a WITH(ROWLOCK,UPDLOCK)
		INNER JOIN #tmpSMA t ON a.CustID=t.CustID
	WHERE RoleID=3 AND a.bettype BETWEEN 81 AND 90
		
	UPDATE a
		SET a.apositiontaking=@PT
	FROM Dep_CustSetting3rd a WITH(ROWLOCK,UPDLOCK)
		INNER JOIN #tmpSMA t ON a.CustID=t.CustID
	WHERE RoleID=2 AND a.bettype BETWEEN 81 AND 90

	
	WHILE EXISTS(SELECT 1 FROM #tmpCust)
	BEGIN
		DELETE TOP (500) #tmpCust OUTPUT DELETED.* INTO #tmpCustUpdate

		UPDATE a
			SET a.apositiontaking=@PT
		FROM Dep_CustSetting3rd a WITH(ROWLOCK,UPDLOCK)
			INNER JOIN #tmpCustUpdate t ON a.CustID=t.CustID
		WHERE  a.bettype BETWEEN 81 AND 90
	
		TRUNCATE TABLE #tmpCustUpdate
	END

END
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT DBCUST SERVERS -----
--------------------------------------------------------------------------------------
DECLARE @MaxCustID INT
	
SELECT @MaxCustID = xxx
EXEC dbo.Acc_CustSetting_19 @MaxCustID=@MaxCustID