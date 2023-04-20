/*<info serverAlias="DBCUST-CustDB"></info>*/ 
/*
	Created: 20230419@Helios
	Task: Insert missing setting StakeLevel PP Games
	DB: DBCUST/CustDB

	Revisions:
	- Ininial Script [RM:#187093]
*/
 
DECLARE @BetType SMALLINT
	,	@SportType SMALLINT

SELECT @BetType = 7000
	,  @SportType = 248



IF OBJECT_ID('tempdb..#CustList') IS NOT NULL
    DROP TABLE #CustList ; 
CREATE TABLE #CustList  (CustID INT	 PRIMARY KEY(CustID) , SRecommend INT, MRecommend INT, Recommend INT, RoleId SMALLINT)



						   /*Run Group 1*/
--Group1: (Total 37 cust) Miss data Member --> Collect StakeLevel From Agent

INSERT INTO #CustList ( CustID , SRecommend , MRecommend , Recommend , roleid)
SELECT CustID , srecommend , mrecommend , recommend, roleid
FROM Customer c WITH (NOLOCK)
WHERE CustID IN (85937918,85938573,85937456,85937499,85938478,85937620,85938099,85937450,85937949,85938164,85937548,85938615,85937549,85938569,85938038,85938287,85937909,85937422,85937406,
85937453,85937481,85937502,85937522,85937540,85937565,85937621,85937655,85937685,85937731,85937756,85937825,85937861,85937904,85937931,85937948,85937401,85938289)
AND roleid = 1

IF 
-- Recheck Member need insert is exists in CustStakeLevel_Member or not
EXISTS (SELECT 1 FROM #CustList c INNER JOIN CustStakeLevel_Member m WITH(NOLOCK) ON c.CustID = m.CustID AND SportType = @SportType AND BetType = @BetType)
OR 
-- Recheck Agent collect values is exists in CustStakeLevel_Agent or not
EXISTS (
SELECT 1
FROM #CustList c
LEFT JOIN CustStakeLevel_Agent a ON a.CustID = c.Recommend AND a.SportType = @SportType AND a.BetType = @BetType
WHERE a.CustID IS NULL)
BEGIN
	PRINT N'Error, Please Recheck cust list member!'
	RETURN
END
ELSE
BEGIN
	INSERT INTO dbo.CustStakeLevel_Member (CustID ,SportType ,BetType ,StakeLevelList ,LastUpdated)
	SELECT c.custid , a.SportType , a.BetType , a.StakeLevelList , GETDATE()
	FROM #CustList c WITH (NOLOCK)
	INNER JOIN CustStakeLevel_Agent a WITH (NOLOCK) ON c.Recommend = a.CustID
	WHERE a.SportType = @SportType
	AND a.BetType = @BetType
END
						   /*END Run Group 1*/






						   /*Run Group 2*/
--Group2: (Total 3 cust) Miss Data Agent, Member -> Collect StakeLevel from Master
TRUNCATE TABLE #CustList

INSERT INTO #CustList ( CustID , SRecommend , MRecommend , Recommend , roleid)
SELECT CustID , srecommend , mrecommend , recommend, roleid
FROM Customer c WITH (NOLOCK)
WHERE CustID IN (85937592, 86128674, 86167997)

IF 
-- Recheck Member need insert is exists in CustStakeLevel_Member or not
EXISTS (SELECT 1 FROM #CustList c INNER JOIN CustStakeLevel_Member m WITH(NOLOCK) ON c.CustID = m.CustID AND SportType = @SportType AND BetType = @BetType AND c.RoleId = 1)
OR 
-- Recheck Agent need insert is exists in CustStakeLevel_Agent or not
EXISTS (SELECT 1 FROM #CustList c INNER JOIN CustStakeLevel_Agent a WITH(NOLOCK) ON c.Recommend = a.CustID AND SportType = @SportType AND BetType = @BetType AND c.RoleId = 2)
OR 
-- Recheck Master collect values is exists in CustStakeLevel_Agent or not
EXISTS (
SELECT 1
FROM #CustList c
LEFT JOIN CustStakeLevel_Agent a ON a.CustID = c.MRecommend AND a.SportType = @SportType AND a.BetType = @BetType
WHERE a.CustID IS NULL)
BEGIN
	PRINT N'Error, Please Recheck cust list member!'
	RETURN
END
ELSE
BEGIN
	INSERT INTO  dbo.CustStakeLevel_Agent ( CustID , SportType , BetType , StakeLevelList )
	SELECT c.custid , a.SportType , a.BetType , a.StakeLevelList
	FROM #CustList c WITH (NOLOCK)
	INNER JOIN CustStakeLevel_Agent a WITH (NOLOCK) ON c.MRecommend = a.CustID 
	WHERE a.SportType = @SportType
	AND a.BetType = @BetType

	INSERT INTO dbo.CustStakeLevel_Member (CustID ,SportType ,BetType ,StakeLevelList ,LastUpdated)
	SELECT c.custid , a.SportType , a.BetType , a.StakeLevelList , GETDATE()
	FROM #CustList c WITH (NOLOCK)
	INNER JOIN CustStakeLevel_Agent a WITH (NOLOCK) ON c.MRecommend = a.CustID
	WHERE a.SportType = @SportType
	AND a.BetType = @BetType
END
						   /*END Run Group 2*/






						   /*Run Group 3*/
--Group3: (Total 4 cust) Miss data Master, Agent → Collect StakeLevel from Super
TRUNCATE TABLE #CustList

INSERT INTO #CustList ( CustID , SRecommend , MRecommend , Recommend , roleid)
SELECT CustID , srecommend , mrecommend , recommend, roleid
FROM Customer c WITH (NOLOCK)
WHERE CustID IN (85937709,85938225,85938470,85938585)

IF 
-- Recheck Master , Agent need insert is exists in CustStakeLevel_Agent or not
EXISTS (SELECT 1 FROM #CustList c INNER JOIN CustStakeLevel_Agent a WITH(NOLOCK) ON c.CustID = a.CustID AND SportType = @SportType AND BetType = @BetType AND c.RoleId IN (3,2))
OR 
-- Recheck Super collect values is exists in CustStakeLevel_Agent or not
EXISTS (
SELECT 1
FROM #CustList c
LEFT JOIN CustStakeLevel_Agent a ON a.CustID = c.SRecommend AND a.SportType = @SportType AND a.BetType = @BetType
WHERE a.CustID IS NULL)
BEGIN
	PRINT N'Error, Please Recheck cust list member!'
	RETURN
END
ELSE
BEGIN
	INSERT INTO  dbo.CustStakeLevel_Agent ( CustID , SportType , BetType , StakeLevelList )
	SELECT c.custid , a.SportType , a.BetType , a.StakeLevelList
	FROM #CustList c WITH (NOLOCK)
	INNER JOIN CustStakeLevel_Agent a WITH (NOLOCK) ON c.SRecommend = a.CustID
	WHERE a.SportType = @SportType
	AND a.BetType = @BetType
END
						   /*END Run Group 3*/




						   /*Run Group 4*/
--Group4: (Total 5 cust) Miss data Master, Agent, Member → Collect StakeLevel from Super
TRUNCATE TABLE #CustList

INSERT INTO #CustList ( CustID , SRecommend , MRecommend , Recommend , roleid)
SELECT CustID , srecommend , mrecommend , recommend, roleid
FROM Customer c WITH (NOLOCK)
WHERE CustID IN (85937951,85991252,85991469,85991665,85991769,
86381757, 86382150)

IF 
-- Recheck Member need insert is exists in CustStakeLevel_Member or not
EXISTS (SELECT 1 FROM #CustList c INNER JOIN CustStakeLevel_Member m WITH(NOLOCK) ON c.CustID = m.CustID AND SportType = @SportType AND BetType = @BetType AND c.RoleId = 1)
OR 
-- Recheck Master , Agent need insert is exists in CustStakeLevel_Agent or not
EXISTS (SELECT 1 FROM #CustList c INNER JOIN CustStakeLevel_Agent a WITH(NOLOCK) ON c.CustID = a.CustID AND SportType = @SportType AND BetType = @BetType AND c.RoleId IN (3,2))
OR 
-- Recheck Super collect values is exists in CustStakeLevel_Agent or not
EXISTS (
SELECT 1
FROM #CustList c
LEFT JOIN CustStakeLevel_Agent a ON a.CustID = c.SRecommend AND a.SportType = @SportType AND a.BetType = @BetType
WHERE a.CustID IS NULL)
BEGIN
	PRINT N'Error, Please Recheck cust list member!'
	RETURN
END
ELSE
BEGIN
	INSERT INTO  dbo.CustStakeLevel_Agent ( CustID , SportType , BetType , StakeLevelList )
	SELECT c.custid , a.SportType , a.BetType , a.StakeLevelList
	FROM #CustList c WITH (NOLOCK)
	INNER JOIN CustStakeLevel_Agent a WITH (NOLOCK) ON c.SRecommend = a.CustID AND RoleId IN (2,3)
	WHERE a.SportType = @SportType
	AND a.BetType = @BetType

	INSERT INTO dbo.CustStakeLevel_Member (CustID ,SportType ,BetType ,StakeLevelList ,LastUpdated)
	SELECT c.custid , a.SportType , a.BetType , a.StakeLevelList , GETDATE()
	FROM #CustList c WITH (NOLOCK)
	INNER JOIN CustStakeLevel_Agent a WITH (NOLOCK) ON c.SRecommend = a.CustID AND RoleId = 1
	WHERE a.SportType = @SportType
	AND a.BetType = @BetType
END
						   /*END Run Group 4*/