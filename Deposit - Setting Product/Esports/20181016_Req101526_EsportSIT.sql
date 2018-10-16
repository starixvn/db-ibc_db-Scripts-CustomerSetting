/*
	Created: Winnie
	Date: 20181011
	Task: Delete existing data of Deposit Esports SIT
	DB: DBCust/CustDB
*/
 

DECLARE @srecommend INT,@mrecommend INT,@recommend INT
DECLARE @fSportType INT = 99, @fBetType INT=1
DECLARE @Sporttype	INT = 43	

SELECT @srecommend=srecommend,@mrecommend=mrecommend,@recommend=recommend FROM Customer WITH(NOLOCK) WHERE username IN('SPONUUS01246','SPONUUS01026','SPONUUS01327')

INSERT INTO dbo.Dep_CustPTSetting_Agent
		(	[CustID]
		   ,[SportType]
		   ,[BetType]
		   ,[IsLive]
		   ,[SuperPT]
		   ,[MasterPT]
		   ,[AgentPT]
		 )
SELECT 
		cs.custid, @Sporttype, @fBetType, 0
		,cs.spositiontaking  *100
		,cs.mpositiontaking  *100
		,cs.apositiontaking  *100	
	FROM dbo.Dep_custSetting cs WITH(NOLOCK) 
	WHERE cs.CustID IN( @srecommend,@mrecommend,@recommend)
		AND cs.sporttype=@fSportType AND cs.bettype=@fBetType


INSERT INTO [dbo].[Dep_CustPTGroupSetting_Member]
           ([AgentID]
           ,[SportType]
           ,[BetType]
           ,[IsLive]
           ,[SuperPT]
           ,[MasterPT]
           ,[AgentPT])
SELECT 
		cs.custid, @Sporttype, @fBetType, 0
		,cs.spositiontaking  *100
		,cs.mpositiontaking  *100
		,cs.apositiontaking  *100	
	FROM dbo.Dep_custSetting cs WITH(NOLOCK) 
	WHERE cs.custid = @recommend 
		AND cs.sporttype=@fSportType AND cs.bettype=@fBetType

IF NOT EXISTS (SELECT 1 FROM Dep_CustSettingMode a WITH(NOLOCK)
						INNER JOIN Customer b WITH(NOLOCK) ON a.CustID=b.custid 
						WHERE b.username='SPONUUS01246')
	INSERT INTO Dep_CustSettingMode(CustID,IsGroupedPT)
	SELECT Custid,1
	FROM Customer b WITH(NOLOCK) 
	WHERE b.username='SPONUUS01246'

IF NOT EXISTS (SELECT 1 FROM Dep_CustSettingMode a WITH(NOLOCK)
						INNER JOIN Customer b WITH(NOLOCK) ON a.CustID=b.custid 
						WHERE b.username='SPONUUS01026')
	INSERT INTO Dep_CustSettingMode(CustID,IsGroupedPT)
	SELECT Custid,1
	FROM Customer b WITH(NOLOCK) 
	WHERE b.username='SPONUUS01026'

IF NOT EXISTS (SELECT 1 FROM Dep_CustSettingMode a WITH(NOLOCK)
						INNER JOIN Customer b WITH(NOLOCK) ON a.CustID=b.custid 
						WHERE b.username='SPONUUS01026')
	INSERT INTO Dep_CustSettingMode(CustID,IsGroupedPT)
	SELECT Custid,1
	FROM Customer b WITH(NOLOCK) 
	WHERE b.username='SPONUUS01327'

INSERT INTO dbo.Dep_CustBetSetting_Agent(CustID, SportType, BetType, MinBet, MaxBet, MaxPerMatch)
SELECT 
		ci.CustID			,	
		@Sporttype			,
		@fBetType			,		
		MinBet				,
		MaxBet				,
		maxpermatch99			
	FROM custInfo ci WITH(NOLOCK)
		 INNER JOIN dbo.Dep_custSetting cs WITH(NOLOCK) ON ci.custid=cs.custid
	WHERE cs.CustID IN( @srecommend,@mrecommend,@recommend) AND cs.sporttype=@fSportType AND cs.bettype=@fBetType	


INSERT INTO dbo.Dep_CustBetSetting_Member(CustID, SportType, BetType, MinBet, MaxBet, MaxPerMatch)
SELECT 
		ci.CustID			,	
		@Sporttype			,
		@fBetType			,		
		MinBet				,
		MaxBet				,
		maxpermatch99			
	FROM custInfo ci WITH(NOLOCK)
		 INNER JOIN dbo.Dep_custSetting cs WITH(NOLOCK) ON ci.custid=cs.custid
	WHERE ci.username IN ('SPONUUS01246','SPONUUS01026','SPONUUS01327') AND cs.sporttype=@fSportType AND cs.bettype=@fBetType	

