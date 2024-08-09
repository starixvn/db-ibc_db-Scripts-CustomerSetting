/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240731@Winfred
	Task: [All licensees] - Change Sportsbook minbet to 30 [Redmine: #208605]
	DB: DBCust/CustDB and all replicated servers 
*/
ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_09]
 	 @target VARCHAR(20),
	 @CustList XML,
	 @mode	 TINYINT -- 1 ~ SMA, 2 ~ Member
AS
BEGIN	
	SET NOCOUNT ON;
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN -- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN -- run at dbcust only
	
	IF (dbo.f_CheckRepTable('Dep_CustBetSettingGame_Agent') = 0
		OR dbo.f_CheckRepTable('Dep_CustBetSettingGameGroup_Member') = 0	
		OR dbo.f_CheckRepTable('Dep_CustBetSettingGame_Member') = 0
		)
		RETURN
	
	CREATE TABLE #tbCustomer( CustID	INT, RoleID TINYINT , PRIMARY KEY CLUSTERED (CustID))
	CREATE TABLE #SportBettypeFilter (ProductID TINYINT, Sporttype SMALLINT, Bettype SMALLINT)

	INSERT INTO #SportBettypeFilter (ProductID,SportType,Bettype)
	SELECT 1 AS ProductID, SportType, Bettype 
	FROM dbo.f_Dep_CustSetting_SportBetTypeSettingSelect(1,10,0)

	INSERT INTO #tbCustomer (CustID, RoleID)
	SELECT   t.c.value('@CustID','INT')		AS CustID
			,t.c.value('@RoleID','TINYINT')	AS RoleID
	FROM @CustList.nodes('root') t(c)

	UPDATE d
	SET d.MaxBet = CASE WHEN MaxBet < 30 THEN 30 ELSE MaxBet END,
		d.MaxPerMatch = CASE WHEN MaxPerMatch < 30 THEN 30 ELSE MaxPerMatch END,
		d.MaxPayoutPerMatch = CASE WHEN MaxPayoutPerMatch < 30 THEN 30 ELSE MaxPayoutPerMatch END
	FROM #tbCustomer tmp
	CROSS APPLY #SportBettypeFilter s
	CROSS APPLY(SELECT top 15 minbet, MaxBet, MaxPerMatch, MaxPayoutPerMatch
				FROM Dep_CustBetSettingGame_Member WITH(ROWLOCK)
				WHERE CustID = tmp.CustID AND SportType = s.Sporttype 
					AND BetType = s.Bettype AND MinBet = 30 AND
					(MaxBet < 30 OR MaxPerMatch < 30 OR MaxPayoutPerMatch < 30) ) d
	
	DROP TABLE #tbCustomer
	DROP TABLE #SportBettypeFilter
END
GO

-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

---
---
-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS (06/DBTP) AND DBCUST (Run last)-----
--------------------------------------------------------------------------------------
PRINT N'COPY SETTING: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
PRINT N'--------------------------------------------------------'
DECLARE @target VARCHAR(20)
		,@max_custid INT
		,@CustList   XML
		,@BatchSize	INT = 300
		,@srecommend INT

SELECT @max_custid = xxx

IF @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')
	SET @target = 'DBCUST'
ELSE 
	SET @target = 'REPLICATED'

Print 'Server Name : ' + @target
CREATE TABLE #Supers(CustID INT PRIMARY KEY, site VARCHAR(20),isfinished BIT DEFAULT 0)
CREATE TABLE #Dummy	(CustID INT PRIMARY KEY)
CREATE TABLE #Members (CustID INT PRIMARY KEY)
CREATE TABLE #tbCustomers_batch (CustID INT PRIMARY KEY, RoleID TINYINT)
CREATE TABLE #SportBettypeFilter (ProductID TINYINT, Sporttype SMALLINT, Bettype SMALLINT)
---------------------------------------------------------------------------------------------
INSERT INTO #SportBettypeFilter (ProductID,SportType,Bettype)
SELECT 1 AS ProductID, SportType, Bettype 
FROM dbo.f_Dep_CustSetting_SportBetTypeSettingSelect(1,10,0)

INSERT INTO #Supers(custid, site)
SELECT cs.custid, cs.site
FROM dbo.Dep_CustSuper cs WITH(NOLOCK)
	INNER JOIN bodb_licensee.dbo.Licensees l WITH (NOLOCK) ON l.LicenseeName = cs.site
WHERE  l.IsActive = 1-- AND l.licenseeName IN ('Athena000')
	AND cs.username NOT LIKE '3rdSuper%'
	AND cs.currency = 51
	AND cs.custid IN(49368693,49149043,35479113,49075996,45955479,18116622,44127973,37727052,37208410,63021841,51517866,10580785,52954084,48936246,55911206,3287311,55917664,17126658,67006097,31680565,49350806,48618439,55539328,49398398,14650260,47161515,53973748,62702209,50340208,65065123,42959910,45152096,38469043,62982137,57160464,45321542,64252393,29336836,60086232,38828894,60658130,63878331,50926688,51499001,48030205,62989735,53453762,66213870,90778708,62983990,57187742,42419097,28731002,47304942,60108867,44674501,45989174,46083718,50671333,46539944,45250318,57152978,66674101,47854331,46522833,49843495,38339088,38506341,50506814,51459358,67224331,59799356,45046023,45421265,54097893,4833492,59042533,46099254,49391615,52714636,52078797,63285298,45421520,38335319,67195651,31545087,61344784,38583557,60317421,59941513,47220105,3167631,33706073,51092808,41780258,24942838,16092800,62771639,57749401,45840755,40349161,60717587,60665751,63060685,28680749,64012894,49849434,81770400,39929385,41617356,65061676,50253186,51092483,52483360,33733096,63614991,46667023,29650394,66441116,35831394,61826119,49055623,66275495,28936846,66936699,37676692,39640832,47023180,62248589,39407073,51351577,48089218,56475424,59108073,40161954,15312124,63611575,31947414,55726936,43049544,21515376,48984447,55223277,94941477,41798779,45805809,26976440,3417070,38321541,67224778,51793117,29721095,54948419,47178610,66664668,54740946,48316615,62732311,8362821,67193094,63326127,40478820,32609813,64845674
)
	
--Dummy line
INSERT INTO #Dummy(CustID)
SELECT c.CustID 
FROM Customer c WITH(NOLOCK) 
	INNER JOIN #Supers s WITH (NOLOCK) ON s.CustID=c.srecommend
WHERE c.roleid=3 
	AND c.custid <= @max_custid
	AND (username LIKE '%Acc%' OR username LIKE '%LocalBank%' OR username LIKE '%AFF%' OR username LIKE 'AB88'+'CAS%')

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #supers
	SET isfinished = 1
		,@srecommend = custid			
	WHERE isfinished = 0

	IF @@ROWCOUNT = 0 BREAK
	
	--Members
	INSERT INTO #Members (CustID)
	SELECT DISTINCT c.custid
	FROM dbo.CustInfo c WITH(NOLOCK)
	WHERE c.srecommend = @srecommend
		--AND mrecommend NOT IN (SELECT custid FROM #Dummy)
		AND c.custid <= @max_custid
		AND c.roleid = 1
		--AND c.Enabled=1
		AND EXISTS (SELECT TOP 1 1 FROM Dep_CustBetSettingGame_Member b WITH(NOLOCK) WHERE CustID = c.CustID AND  MinBet = 30 and MaxBet < MinBet ) 
END		

---------------------------------------------------------------------------------------------
DECLARE @Cust_cnt INT


SELECT @Cust_cnt += COUNT(1)
FROM #Members

DECLARE @msg_total NVARCHAR(200) = 'Total of Customers Affected: %d.'

RAISERROR (@msg_total, 0, 1, @Cust_cnt) WITH NOWAIT
		
	
--For Member
WHILE (1 = 1)
BEGIN
	DELETE FROM #tbCustomers_batch

	DELETE TOP (@BatchSize) T
	OUTPUT deleted.CustID, 1
		INTO #tbCustomers_batch(CustID,RoleID)
	FROM #Members t 

	IF @@ROWCOUNT = 0 BREAK
	
	SELECT @CustList=(SELECT CustID	AS '@CustID' 
							,RoleID AS '@RoleID'
					FROM #tbCustomers_batch
					FOR XML PATH('root')
				)

	EXEC dbo.[Acc_Dep_DynamicCustSetting_09] 
				@target = @target,
				@CustList=@CustList,
				@mode = 2
	
	WAITFOR DELAY '00:00:0.050'

	SET @msg_total = 'Member - Curdt: ' + CONVERT(VARCHAR(50), GETDATE(), 121)

	RAISERROR (@msg_total, 0, 1) WITH NOWAIT
END		
	
PRINT N'--------------------------------------------------------'
PRINT N': End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';

DROP TABLE #Members, #tbCustomers_batch, #Supers, #Dummy, #SportBettypeFilter
GO
-- END STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS (/06/DBTP) AND DBCUST (Run last) -----
-----------------------------------------------------------------------------------	
