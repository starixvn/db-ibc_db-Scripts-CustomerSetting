/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
Created: 20230928@Eden
Task: ROUND 5: 
	IONclub
	365online
	Wanbo
	awc2
	OneSports
DB: DBCUST.CustDB
*/
USE CustDB
GO
--> Delete waiting agents before new scan
SELECT CustID
INTO #TempDeleted
FROM Dep_Customer_Archived WITH(NOLOCK) 
WHERE status = 'waiting'

DELETE d
FROM #TempDeleted t
	INNER JOIN  Dep_Customer_Archived d WITH(ROWLOCK)  
		ON t.CustID = d.CustID
-------------------------------------

DECLARE @MinBalance money = 0
,@Mindays INT = 365

CREATE TABLE #TempAgents (CustID INT PRIMARY KEY)

INSERT INTO #TempAgents(CustID)
SELECT c.custid
FROM customer c(NOLOCK) 
WHERE c.roleid = 2
	AND c.username NOT LIKE '%ACC%'
	AND c.creatdate <= DATEADD(dd,-@Mindays,GETDATE())
	AND c.srecommend IN( SELECT CustID FROM Dep_CustSuper WITH(NOLOCK))
	AND c.site IN (
		'IONclub'
		,'365online'
		,'Wanbo'
		,'awc2'
		,'OneSports'
		)

DECLARE @tmpClearBalCustID INT, 
        @ErrCode           INT           = 0, 
        @ErrMsg            NVARCHAR(200) = '', 
        @CreatorID         INT           = 10278938, 
        @IP                VARCHAR(50)   = '0.0.0.0', 
        @Pass              VARCHAR(100)  = '8058095B7DDB08A608811097E5DB8D', 
        @tmpDumUserName    VARCHAR(30), 
        @AgentID      INT

SELECT c.custid AS Recommend,cu.site,@MinBalance AS MinBalance,@Mindays AS MinDays,ClearBal.CustID AS CustIDBalanceDummy, 0 AS Status,c.username AS Agent
INTO #Dep_Customer_Archived_Config
FROM custInfo c WITH(NOLOCK)
	INNER JOIN Customer cu WITH(NOLOCK) ON c.custid = cu.custid
	OUTER APPLY (	SELECT TOP 1 Custid 
					FROM custInfo ClearBal WITH(NOLOCK) 
					WHERE ClearBal.recommend = c.recommend
						AND ClearBal.roleid = 1
						AND ClearBal.username LIKE '%ClearBal'
					) ClearBal
WHERE c.srecommend IN ( SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	AND c.custid IN ( SELECT custid FROM #TempAgents)

CREATE CLUSTERED INDEX ix_TmpDep_Customer_Archived_Config_recommend ON #Dep_Customer_Archived_Config(recommend)

--> Insert new dummy clearbal if not exists yet
WHILE 1 = 1
BEGIN
	SELECT @AgentID = null, @tmpClearBalCustID = null, @tmpDumUserName = null, @ErrMsg = '',@ErrCode = 0

	SELECT TOP(1) @AgentID = Recommend, @tmpDumUserName = Agent + 'ClearBal'
	FROM #Dep_Customer_Archived_Config
	WHERE CustIDBalanceDummy IS NULL

	IF @@ROWCOUNT = 0
	BREAK

	EXEC Acc_Dep_CustomerInsMember_Ag 
		@custid=@tmpClearBalCustID OUTPUT
		,@creator=@creatorID
		,@username=@tmpDumUserName
		,@userpwd=@Pass
		,@recommend=@AgentID
		,@IP=@IP
		,@ErrCode=@ErrCode OUTPUT
		,@ErrMsg=@ErrMsg OUTPUT

	IF @ErrMsg <> ''
	BEGIN
		PRINT 'AgentID ' + CAST(@AgentID AS VARCHAR) + ': ' + @ErrMsg

		UPDATE #Dep_Customer_Archived_Config
		SET CustIDBalanceDummy = 0
		WHERE Recommend = @AgentID
	END
	ELSE 
	BEGIN
		PRINT 'AgentID ' + CAST(@AgentID AS VARCHAR) + ': Create ClearBal dummy successfully'

		UPDATE #Dep_Customer_Archived_Config
		SET CustIDBalanceDummy = @tmpClearBalCustID
		WHERE Recommend = @AgentID
	END
END

--IF EXISTS (SELECT TOP 1 1
--FROM #Dep_Customer_Archived_Config
--WHERE CustIDBalanceDummy IS NULL
--)
--BEGIN
--SELECT c.Recommend,c.Agent, 'This Agent have not ClearBal account' ERROR
--FROM #Dep_Customer_Archived_Config c
--WHERE c.CustIDBalanceDummy IS NULL

--RETURN
--END

--> Set Status = 2 (pending - do not scan now) for Agent can not create CustIDBalanceDummy
UPDATE cf 
SET cf.Status = 2 --Pending
FROM #Dep_Customer_Archived_Config cf
WHERE cf.CustIDBalanceDummy = 0

IF @@ROWCOUNT > 0
SELECT cf.Agent, 'Adding CustIDBalanceDummy failed'
FROM #Dep_Customer_Archived_Config cf
WHERE cf.CustIDBalanceDummy = 0

--> Update another agents to pending (do not scan now)
UPDATE cf 
SET cf.Status = 2 --Pending
FROM Dep_Customer_Archived_Config cf WITH(ROWLOCK)
WHERE cf.Status = 0

--> INSERT/UPDATE agents ready to scan
INSERT INTO Dep_Customer_Archived_Config (Recommend,Site,MinBalance,MinDays,CustIDBalanceDummy,Status)
SELECT Recommend,Site,MinBalance,MinDays,CustIDBalanceDummy,Status
FROM #Dep_Customer_Archived_Config 
WHERE CustIDBalanceDummy IS NOT NULL
	AND Recommend NOT IN( SELECT Recommend FROM Dep_Customer_Archived_Config WITH(NOLOCK))

UPDATE cf
SET cf.MinDays = c.MinDays,
	cf.MinBalance = c.MinBalance,
	cf.CustIDBalanceDummy = c.CustIDBalanceDummy,
	cf.Status = c.Status
FROM #Dep_Customer_Archived_Config c
	INNER JOIN Dep_Customer_Archived_Config cf WITH(ROWLOCK) ON c.Recommend = cf.Recommend
WHERE c.CustIDBalanceDummy IS NOT NULL

DROP TABLE #TempAgents
DROP TABLE #Dep_Customer_Archived_Config
DROP TABLE #TempDeleted

/*
SELECT * FROM Dep_Customer_Archived_Config WITH(NOLOCK) WHERE Status = 0 AND CustIDBalanceDummy = 0

SELECT * 
FROM Dep_Customer_Archived_Config WITH(NOLOCK) WHERE Status = 0 
*/
