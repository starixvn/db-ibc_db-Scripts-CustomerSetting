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


--Group1: (Total 2 cust) Miss data Member --> Collect StakeLevel From Agent

INSERT INTO #CustList ( CustID , SRecommend , MRecommend , Recommend , roleid)
SELECT CustID , srecommend , mrecommend , recommend, roleid
FROM Customer c WITH (NOLOCK)
WHERE CustID IN (85942492 , 85941647)
AND roleid = 1

IF 
-- Recheck Member need insert is exists in Dep_CustStakeLevel_Member or not
EXISTS (SELECT 1 FROM #CustList c INNER JOIN Dep_CustStakeLevel_Member m WITH(NOLOCK) ON c.CustID = m.CustID AND SportType = @SportType AND BetType = @BetType)
OR 
-- Recheck Agent collect values is exists in Dep_CustStakeLevel_Agent or not
EXISTS (
SELECT 1
FROM #CustList c
LEFT JOIN Dep_CustStakeLevel_Agent a ON a.CustID = c.Recommend AND a.SportType = @SportType AND a.BetType = @BetType
WHERE a.CustID IS NULL)
BEGIN
	PRINT N'Error, Please Recheck cust list member!'
	RETURN
END
ELSE
BEGIN
	INSERT INTO dbo.Dep_CustStakeLevel_Member (CustID ,SportType ,BetType ,StakeLevelList ,LastUpdated)
	SELECT c.custid , a.SportType , a.BetType , a.StakeLevelList , GETDATE()
	FROM #CustList c WITH (NOLOCK)
	INNER JOIN Dep_CustStakeLevel_Agent a WITH (NOLOCK) ON c.Recommend = a.CustID
	WHERE a.SportType = @SportType
	AND a.BetType = @BetType
END