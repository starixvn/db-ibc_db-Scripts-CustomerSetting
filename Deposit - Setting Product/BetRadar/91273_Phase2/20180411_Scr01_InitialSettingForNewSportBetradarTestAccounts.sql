/*
	Created: Johnson
	Date: 20180411
	Task: Initial setting for new sports Betradar
	DB: DBCUST/CUSTDB
*/	
	DECLARE @super TABLE(custid INT)
	CREATE TABLE #tblCust (custid INT PRIMARY KEY,roleid TINYINT)
	DECLARE @tmpCust TABLE(CustID INT PRIMARY KEY)
	DECLARE @sport TABLE(sporttype SMALLINT, bettype SMALLINT, fromSportType SMALLINT, fromBettype SMALLINT)
		
	INSERT INTO @super
	SELECT custid
	FROM dbo.Dep_CustSuper (NOLOCK)
	WHERE site IN ('spondemo','athena000')
	and currency = 20

	INSERT INTO @sport
	SELECT 192 as sporttype, 2701 as bettype, 191 FromSport, 2701 FromBettype
	UNION SELECT 193, 2801, 190, 2701
	
	--
	INSERT INTO #tblCust (custid,roleid)			
	SELECT custid,roleid
	FROM dbo.Customer WITH(NOLOCK)
	WHERE srecommend IN (SELECT custID FROM @super)
		AND mrecommend NOT IN (SELECT custid FROM dbo.custinfo WITH(NOLOCK)
							   WHERE srecommend IN (SELECT custID FROM @super) 
								and username like '%Acc%' and roleid=3)
								
	DELETE #tblCust
	OUTPUT DELETED.custID
	INTO @tmpCust
	WHERE roleid > 1
		
	INSERT INTO dbo.Dep_CustBetSetting_Agent(
					CustID
					,SportType
					,BetType
					,MinBet
					,MaxBet
					,MaxPerMatch)
	SELECT	cb.custid
			,s.sporttype
			,s.bettype
			,cb.minbet
			,cb.maxbet
			,cb.maxpermatch
	FROM dbo.Dep_CustBetSetting_Agent cb WITH(NOLOCK)
		INNER JOIN @tmpCust t ON cb.custid = t.custid
		INNER JOIN @sport s ON cb.sporttype = s.FromSporttype AND cb.BetType = s.FromBettype
	
	INSERT INTO dbo.Dep_CustBetSetting_Member(
					CustID
					,SportType
					,BetType
					,MinBet
					,MaxBet
					,MaxPerMatch)
	SELECT	cb.custid
			,s.sporttype
			,s.bettype
			,cb.minbet
			,cb.maxbet
			,cb.maxpermatch
	FROM dbo.Dep_CustBetSetting_Member cb WITH(NOLOCK)
		INNER JOIN #tblCust t ON cb.custid = t.custid			
		INNER JOIN @sport s ON cb.sporttype = s.FromSporttype AND cb.BetType = s.FromBettype
	
	--add profile settings
	INSERT INTO [dbo].[Dep_ProductSettingDetail]
           ([ProductSettingID]
           ,[SportType]
           ,[BetType]
           ,[IsLive]
           ,[MaxDefaultValue]
           ,[SettingStatus]
           ,[MinDefaultValue])
	SELECT 13,192,2701,0,0,0,NULL
	UNION SELECT 13,193,2801,0,0,0,NULL	
	GO