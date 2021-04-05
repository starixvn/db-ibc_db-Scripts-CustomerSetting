/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20210223
	Task: Disable status for 10 headlines (SDRMB, 266HK, M863HK, SBSR, YKH, S188RM, PYY, POT, SF8, S80R) API Licensee Deposit  of Sports Lottery [Redmine: 147361]
	DB: DBCUST/CustDB	
	P/s : Step 5 Disable status for 10 headlines API Licensee Deposit
*/
USE [CustDB]
GO

--Get Group ID
	CREATE TABLE #CustomerTemp (CustID INT, RoleID INT, UserName NVARCHAR(128), Groupid INT)
	CREATE TABLE #HeadlineSBOnly (CustID INT, UserName NVARCHAR(128), Groupid INT)

	INSERT INTO #HeadlineSBOnly (CustID, UserName, Groupid)
	SELECT c.custid,username, groupid  
	FROM custinfo c WITH (NOLOCK)
		INNER JOIN CustGroupHeadline cs with (nolock) on cs.custid=c.custid
	WHERE username in ('SDRMB','266HK','M863HK','SBSR','YKH','S188RM','PYY','POT','SF8','S80R')

	INSERT INTO #CustomerTemp (CustID, RoleID, UserName, Groupid)
	SELECT  c.custid, c.roleid, c.username, ca.groupid
	FROM customer c WITH (NOLOCK )
		INNER JOIN custinfo cu WITH (NOLOCK) ON cu.custid=c.custid
		INNER JOIN custAccount ca WITH (NOLOCK) ON ca.custid=c.custid
		INNER JOIN #HeadlineSBOnly t ON t.GroupID=ca.groupID
		INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON cu.custid = cs.custid
	WHERE c.username NOT LIKE '3rdSuper%'
		AND cs.site IN('mansion88','W88','368Cash','alog','12Bet','asiabet88','Lucky88','GamingSoft','Newhonbet','365online','Dawoo','11bet','HONBET',
					  'Wanbo','KeenOcean','IBO','Bobbet','Bodog','SunGame','PKbet','Yibo','Mayfair','BOSSB','AG','HuangMa','Liga','iBET','Happy1668',
					  'KUTECH','TLC','Tianbo','KhmerG','BigGaming','IONclub','Mayayule','Fabet','Mopgaming','Abcasino','MANBETX','zt828','HonorW',
					  'Mybet88','Gampag','CGame','Royal','AEUG','IGPTech','YAYOU','Ae88','Zbet','Boying','BETSUN','WKCUR','396Club','OLE777','Sunwin',
					  'Five88','BSSB168','Wanfang','Bobo88','webet88','FLC','Callmeboss','Red88','Aplus','633esports','MTech','One88','A1game','Sun988',
					  'GMASTER','9Club','HL8','txwl002','Yunji','Sky88','VN88','TGO','24TECH','WKPHIL','3star88','Senibet','Nbbet','MRCATSB','DEWA','FB88',
					  'gbkj','GPIGAME','Nbet','ALPHA88','YTX','Heaven','Boma365','Hecbet','Debet','DingTai','ECLBET','Salon365','Tripleone','Kraton','UwinY',
					  'WINCLUB88','Soon88','ENTAPLAY','B24VN','OPEBET','88Macao','JIBET','N8G','N8B','liv66','OCMS','GGBOOK','e8casino','WBS','weicai','TopGame',
					  'PanguGame','SV88','OXbet','N88','Leng4D','YongBao','TSEnter','TangChao','TCbet','VCBA','Raisetech','ANGbet','AnvoFH','818Bet','Taipanbet',
					  'MYGAME','win365','Onegaming','Champion','XinYo','NukeGaming','US8YAYOU','Zowin','MAX88','hjccasino','Okada','HC6YAYOU','TitanCraft','Gameroom',
					  'Xinbo','MICL','allwincity','erhaozhan','CGame4','HCVIP','Swin','ID88','MFgame','N8BK','Jarvis','BPLE','Kzing2','ManCity','GESAB','Hengcai88',
					  'Lode88','Gaobet','INSERTGAME','HeleThai','Mayibet','7kplatform','Starnet','afb99','BetDeal','ENT22','GAMEBee','Hong88','TitanOne','SSSGaming',
					  '568Win','Bsdbet','Siamgame','BoinGroup','Hejiyongle','TaoCai','Dade','Datang001','NewFuture','bdtt','SDY','JIDU','Jinyazhou','Win88','Sin88',
					  'Uwoniwin','DF88','Brown888','AMG','IBG','Pinbo','BoAPI09','BWGaming','OBline','Asian88','XTDGT','wmcasino','sbt88','HOT99','JZFortune','FHLMSABA',
					  'G2Win','Datang','Bonanza88','Saba789','Man1878','starsoccer','Diamond','WGAMING','QASite','HJTK','WUYICP','Alphalota','iuplay1','TYCgame','pmwint',
					  'GOATbet','BananaTech','BB3','88Goals','DTGW','Newbet','9wickets','Mbet','WKIBPH','Apollo','Bigwiner','Win68Club','Dachen','MSbet','GPgaming88',
					  'Lefu','Weiwei','369588vip','3ge888','7Kplatfrom','Easywin22','XINSHNEG','WBG88','WB101','9wtest','M88ASIA','9w','HOT88','TXG','Sunbet138','UN168',
					  'UNOGAMING','Vwin88','KingBet','LS88','skykey','Comebet','Yabo3','AOGcasino','Pay4d','7Konline','ECBet88','HY6','Opadmin','RICbet','Dabet','Kbet',
					  'TIC88','XO88','Cali','SampleSite')
		AND cu.[enabled] = 1
--------------------------------------Status Setting-------------------------------------------------		
	DECLARE @BitmapOrder TINYINT = 25

	CREATE TABLE #CustList_ST (custid INT)
	CREATE TABLE #CustList_Updated (custid INT)

	--Super
	INSERT INTO #CustList_ST (custid)
	SELECT CS.CustID
	FROM dbo.Dep_CustProductStatus cs WITH(NOLOCK)
		INNER JOIN custInfo ci WITH(NOLOCK) ON cs.CustID = ci.custid
		INNER JOIN #CustomerTemp s WITH (NOLOCK) ON ci.srecommend = s.custid AND s.RoleID = 4
	WHERE ci.Enabled = 1

	--Master
	INSERT INTO #CustList_ST (custid)
	SELECT CS.CustID
	FROM dbo.Dep_CustProductStatus cs WITH(NOLOCK)
		INNER JOIN custInfo ci WITH(NOLOCK) ON cs.CustID = ci.custid
		INNER JOIN #CustomerTemp m WITH (NOLOCK) ON ci.mrecommend = m.CustID AND m.RoleID = 3
	WHERE ci.Enabled = 1

	--Agent
	INSERT INTO #CustList_ST (custid)
	SELECT CS.CustID
	FROM dbo.Dep_CustProductStatus cs WITH(NOLOCK)
		INNER JOIN custInfo ci WITH(NOLOCK) ON cs.CustID = ci.custid
		INNER JOIN #CustomerTemp m WITH (NOLOCK) ON ci.recommend = m.CustID AND m.RoleID = 2
	WHERE ci.Enabled = 1

	--Member
	INSERT INTO #CustList_ST (custid)
	SELECT CS.CustID
	FROM dbo.Dep_CustProductStatus cs WITH(NOLOCK)
		INNER JOIN custInfo ci WITH(NOLOCK) ON cs.CustID = ci.custid
		INNER JOIN #CustomerTemp m WITH (NOLOCK) ON ci.custid = m.CustID AND m.RoleID = 1
	WHERE ci.[Enabled] = 1


	WHILE EXISTS (SELECT TOP 1 1 FROM #CustList_ST)
	BEGIN
		
		DELETE TOP (3000) FROM #CustList_ST OUTPUT DELETED.* INTO #CustList_Updated

		IF @@ROWCOUNT=0
			BREAK	

		UPDATE cs
		SET cs.bitmapIsHidden = dbo.f_GenerateProductStatus (cs.bitmapIsHidden,@BitmapOrder,1)	,
			bitmapIsDisabled = dbo.f_GenerateProductStatus (cs.bitmapIsDisabled,@BitmapOrder,1)	
		FROM [dbo].[Dep_CustProductStatus] cs WITH(ROWLOCK,UPDLOCK)
			INNER JOIN #CustList_Updated CI WITH(NOLOCK) ON cs.CustID = ci.CustID

		TRUNCATE TABLE #CustList_Updated

	END

	DROP TABLE #CustList_ST
	DROP TABLE #CustomerTemp
	DROP TABLE #CustList_Updated
	DROP TABLE #HeadlineSBOnly

