/*
	Created: Elodie
	Task: Update PT settings of SB for licensees new cust RedmineID: #110111
	DB: DBCUST/CustDB
	Date: 20190313
*/ 

ALTER PROCEDURE [dbo].Acc_CustSetting_18
	@MaxCustID INT
AS
BEGIN
	SET NOCOUNT ON	
	IF dbo.f_CheckRepTable('CustInfo') = 0 RETURN
	IF dbo.f_CheckRepTable('Customer') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustSetting') = 0 RETURN		

	CREATE TABLE #supers (custid INT, PT SMALLMONEY)
	INSERT INTO #supers(custid, PT)
	SELECT ci.custid, 
		CASE	WHEN cs.site IN ('BBIN2', 'HAIFA') THEN 92.5
				WHEN cs.site IN ('asiabet88', 'TLC', 'IBO', 'ZT828') THEN 0.91
				ELSE 0.88 END
	FROM Custinfo ci WITH (NOLOCK) 	
		INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
	WHERE ci.username NOT LIKE '3rdSuper%'
		AND ci.Enabled=1
		AND cs.site IN(	'12Bet','asiabet88','mansion88','alog','spondemo','TLC','SunGame','MayFair','Zzun88','HAIFA','Bodog','Vwin','Macaubet',
					'Aoncash','ITCBet','Athena000','Avia','W88','9bet','3star88','OLE777','88Macao','Boma365','Salon365','Ae88','Hengcai88',
					'368Cash','Royal','Senibet','Happy1668','AG','M8bola','KeenOcean','9Club','XTD3','HONBET','Q8bola','BE7','iBET','ISC888',
					'Liga','NBCbet','HonorW','WeBet168','DEWA','IBO','Unobet','GamingSoft','Newhonbet','Hecbet','DBP','HL8','Abcasino','TGO',
					'Starnet','365online','NextBet','Bolanation','KhmerG','Gampag','IONclub','Sun988','Mayayule','HuangMa','Webet138','webet88',
					'BigGaming','Boying','Brown888','MrCat','CGame','PKbet','VCBA','Taipanbet','FLC','IGPTech','BetStar','TGame','Dawoo','Ty777',
					'IvoryBet','Uwoniwin','Opal88','Sunrise','Swin','UN168','PanguGame','K8VN','ECLBET','GPIGAME','818Bet','SSSSEA',
					'Heaven','Bobo88','OPEBET','Jinyazhou','Sunriseb2b','Okada','396Club','Mybet88','e8casino','HongChow','TangChao','MAX88',
					'BBIN2','YongBao','Fugui','GMASTER','ALPHA88','Tripleone','GWORLD','ENTAPLAY','MICL','zt828','9wickets','Aplus',
					'Arlocash','WBS','YBTech','Yibo','24TECH','Xinbo','BETSUN','HOT88','Monaco','Opadmin','Bonanza88','SSSGaming','JIBET',
					'WINCLUB88','MARS','Dade','Nbbet','Gameroom','ANGbet','Callmeboss','Hong88','BetDeal','SampleSite','VWIN66',
					'A1game','HJTK','TitanOne','gbkj','skykey','Dachen','Bobbet','laba360','AEUG','XinYo','18Luck','Mbet','Kudatogel','WinWin',
					'HCVIP','ig128','AMG','MRCATSB','VN88','TXG','Sin88','Zbet','Debet','Kraton')
	
	--------------------------------------PT Setting-------------------------------------------------	
	
	CREATE TABLE #tmpMem	(CustID INT PRIMARY KEY, PT SMALLMONEY)	
	CREATE TABLE #tmpSMA	(CustID INT PRIMARY KEY,RoleID INT, PT SMALLMONEY)
	CREATE TABLE #tmpCust	(CustID INT PRIMARY KEY, PT SMALLMONEY)	
	
	CREATE TABLE #DummySMA (CustID INT PRIMARY KEY)
	CREATE TABLE #DummyMember (CustID INT PRIMARY KEY)

	DECLARE @tmpDummyMaster TABLE (custid INT PRIMARY KEY, username VARCHAR(30))

	INSERT INTO @tmpDummyMaster(custid, username)
	SELECT c.CustID, fc.username
	FROM Customer c WITH(NOLOCK) 
		CROSS APPLY (
					SELECT TOP 1 custid, username
					FROM dbo.Customer cc WITH(NOLOCK)
					WHERE c.custid = cc.custid 
					) fc
	WHERE c.srecommend IN(SELECT custid FROM #supers) AND c.roleid =3

	INSERT INTO #DummyMember(CustID)
	SELECT c.custid
	FROM @tmpDummyMaster d
	 INNER JOIN dbo.Customer c 
	  ON d.custid = c.mrecommend AND c.roleid = 1
	WHERE d.username LIKE '%Acc%' OR d.username LIKE '%LocalBank%'

	INSERT INTO #DummySMA(CustID)
	SELECT c.custid
	FROM @tmpDummyMaster d
	 INNER JOIN dbo.Customer c 
	  ON d.custid = c.mrecommend AND c.roleid IN(2,3)
	WHERE d.username LIKE '%Acc%' OR d.username LIKE '%LocalBank%'
	
	INSERT INTO #tmpMem(CustID, PT)
	SELECT ci.CustID, s.PT
	FROM custInfo ci WITH(NOLOCK)
		INNER JOIN #supers s ON ci.srecommend = s.custid		
	WHERE ci.custid > @maxcustid 
		AND roleid = 1 		
		AND ci.CustID NOT IN(SELECT Custid FROM #DummyMember)
		AND ci.custid NOT IN(SELECT Custid FROM dbo.Dep_CustBAActive)

	INSERT INTO #tmpSMA(CustID, RoleID, PT)
	SELECT ci.CustID, RoleID, s.PT
	FROM custInfo ci WITH(NOLOCK)
		INNER JOIN #supers s ON ci.srecommend = s.custid		
	WHERE ci.custid > @maxcustid 
		AND roleid IN(2,3,4)	
		AND ci.CustID NOT IN(SELECT Custid FROM #DummySMA)

	--AGENT LEVEL	
	UPDATE cs
	SET cs.spositiontaking = t.PT,
		cs.mpositiontaking = t.PT,
		cs.apositiontaking = t.PT
	FROM Dep_CustSetting cs WITH(ROWLOCK)
		INNER JOIN #tmpSMA t ON cs.CustID=t.CustID
	WHERE RoleID = 4
	
	UPDATE cs
	SET cs.mpositiontaking = t.PT
	FROM Dep_CustSetting cs WITH(ROWLOCK)
		INNER JOIN #tmpSMA t ON cs.CustID=t.CustID
	WHERE RoleID=3
		
	UPDATE cs
	SET cs.apositiontaking = t.PT
	FROM Dep_CustSetting cs WITH(ROWLOCK)
		INNER JOIN #tmpSMA t ON cs.CustID=t.CustID
	WHERE RoleID = 2 

	
	WHILE EXISTS(SELECT 1 FROM #tmpMem)
	BEGIN
		DELETE TOP (500) #tmpMem OUTPUT DELETED.* INTO #tmpCust

		UPDATE cs
		SET cs.apositiontaking = t.PT
		FROM Dep_CustSetting cs WITH(ROWLOCK,UPDLOCK)
			INNER JOIN #tmpCust t ON cs.CustID=t.CustID
	
		TRUNCATE TABLE #tmpCust
	END

END
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT DBCUST SERVERS -----
--------------------------------------------------------------------------------------
DECLARE @MaxCustID INT
	
SELECT @MaxCustID = xxx
EXEC dbo.Acc_CustSetting_18 @MaxCustID = @MaxCustID