/*
	Created: Winnie
	Task: Update PT settings of VS1&2 for licensees new cust RedmineID: #108062
	DB: DBCUST/CustDB
	Date: 20190117
*/ 

ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_09]
(@MaxCustID INT)
AS
BEGIN
	SET NOCOUNT ON	
	IF dbo.f_CheckRepTable('CustInfo') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustSettingMode') = 0 RETURN		
	IF dbo.f_CheckRepTable('Dep_CustPTSetting_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustPTGroupSetting_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustPTSetting_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustBAActive') = 0 RETURN


	DECLARE @PT SMALLMONEY	
	SELECT @PT=88

	CREATE TABLE #supers (custid int)
	INSERT INTO #supers(custid)
	SELECT ci.custid
	FROM Custinfo ci WITH (NOLOCK) 	
		INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
	WHERE ci.username NOT LIKE '3rdSuper%'
		AND ci.Enabled=1
		AND cs.site IN('12Bet','asiabet88','mansion88','alog','spondemo','TLC','SunGame','MayFair','Zzun88','HAIFA','Bodog','Vwin','Macaubet','Aoncash','ITCBet','Athena000','Avia','W88','9bet','3star88','OLE777',
		'88Macao','Boma365','Salon365','Ae88','Hengcai88','368Cash','Senibet','Happy1668','AG','M8bola','KeenOcean','9Club','XTD3','HONBET','Q8bola','BE7','iBET','ISC888','Liga','NBCbet','HonorW',
		'DEWA','IBO','Unobet','GamingSoft','Newhonbet','Hecbet','DBP','HL8','Abcasino','TGO','Starnet','365online','Bolanation','KhmerG','Gampag','IONclub','Sun988','Mayayule','HuangMa','Webet138','webet88',
		'BigGaming','Boying','Brown888','MrCat','CGame','PKbet','VCBA','Taipanbet','FLC','IGPTech','BetStar','TGame','Dawoo','Ty777','Uwoniwin','Sunrise','Swin','UN168','PanguGame','K8VN','ECLBET','GPIGAME','818Bet','SSSSEA',
		'Heaven','GOAB88','Bobo88','OPEBET','Jinyazhou','Sunriseb2b','Okada','396Club','Mybet88','e8casino','HongChow','TangChao','MAX88','BBIN2','YongBao','Fugui','GMASTER','ALPHA88','Citybk','Tripleone','GWORLD',
		'ENTAPLAY','MICL','zt828','Aplus','Arlocash','WBS','YBTech','Yibo','24TECH','Xinbo','BETSUN','HOT88','Monaco','Opadmin','Bonanza88','SSSGaming','JIBET','WINCLUB88','EU88','MARS','Dade','Nbbet',
		'Gameroom','ANGbet','Hongtu','Callmeboss','Hong88','BetDeal','SampleSite','VWIN66','A1game','HJTK','TitanOne','gbkj','skykey','Dachen','Bobbet','laba360','AEUG','XinYo','18Luck','Mbet','Kudatogel','WinWin',
		'HCVIP','ig128','AMG','MRCATSB','VN88')
	
	
	--------------------------------------PT Setting-------------------------------------------------	
	
	CREATE TABLE #tmpCustBA			(CustID INT PRIMARY KEY)
	CREATE TABLE #tmpCustUpdate		(CustID INT PRIMARY KEY)	
	CREATE TABLE #tmpSMA			(CustID INT PRIMARY KEY,RoleID INT)
	
	INSERT INTO #tmpCustBA(CustID)
	SELECT ci.CustID
	FROM custInfo ci WITH(NOLOCK,INDEX=IX_RoleID)
		INNER JOIN Dep_CustBAActive BA WITH(NOLOCK) ON ci.custid=BA.custid
	WHERE ci.srecommend IN(SELECT custid FROM #supers) AND ci.custid>@maxcustid 
		AND roleid = 1 		
	OPTION ( MAXDOP 2)

	INSERT INTO #tmpSMA(CustID,RoleID)
	SELECT CustID,RoleID
	FROM custInfo ci WITH(NOLOCK,INDEX=IX_RoleID)
	WHERE ci.srecommend IN(SELECT custid FROM #supers) AND ci.custid>@maxcustid 
		AND roleid IN(2,3,4)		
	OPTION ( MAXDOP 2)

	--AGENT LEVEL	
	UPDATE a
		SET a.SuperPT=@PT,a.MasterPT=@PT,a.AgentPT=@PT
	FROM Dep_CustPTSetting_Agent a WITH(ROWLOCK,UPDLOCK)
		INNER JOIN #tmpSMA t ON a.CustID=t.CustID
	WHERE RoleID=4 AND a.SportType BETWEEN 180 AND 194
	
	UPDATE a
		SET a.MasterPT=@PT
	FROM Dep_CustPTSetting_Agent a WITH(ROWLOCK,UPDLOCK)
		INNER JOIN #tmpSMA t ON a.CustID=t.CustID
	WHERE RoleID=3 AND a.SportType BETWEEN 180 AND 194
		
	UPDATE a
		SET a.[AgentPT]=@PT
	FROM Dep_CustPTSetting_Agent a WITH(ROWLOCK,UPDLOCK)
		INNER JOIN #tmpSMA t ON a.CustID=t.CustID
	WHERE RoleID=2 AND a.SportType BETWEEN 180 AND 194

	UPDATE a
		SET a.[AgentPT]=@PT
	FROM Dep_CustPTGroupSetting_Member a WITH(ROWLOCK,UPDLOCK)
		INNER JOIN #tmpSMA t ON a.AgentID=t.CustID
	WHERE RoleID=2 AND a.SportType BETWEEN 180 AND 194
	
	WHILE EXISTS(SELECT 1 FROM #tmpCustBA)
	BEGIN
		DELETE TOP (1000) #tmpCustBA OUTPUT DELETED.* INTO #tmpCustUpdate

		UPDATE a
			SET a.[AgentPT]=@PT
		FROM Dep_CustPTSetting_Member a WITH(ROWLOCK,UPDLOCK)
			INNER JOIN #tmpCustUpdate t ON a.CustID=t.CustID
		WHERE a.SportType BETWEEN 180 AND 194
	
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
EXEC dbo.Acc_DynamicCustSetting3rd_09 @MaxCustID=@MaxCustID