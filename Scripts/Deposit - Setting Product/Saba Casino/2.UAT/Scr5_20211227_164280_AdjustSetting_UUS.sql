/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20211227@Eden
	Task: Adjust Setting for Saba Casino [#164280]
	DB: DBCUST/CustDB
*/
USE [CustDB]
GO
-----------------------------------------------------
PRINT N'Step 6: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
CREATE TABLE #supers (custid int,isfinished bit default(0))

INSERT INTO #supers(custid)
SELECT ci.custid
FROM custInfo ci WITH (NOLOCK) 	
	INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.username NOT LIKE '3rdSuper%'
	AND ci.Enabled=1 
	AND cs.site IN('spondemo','Athena000')	
	AND Ci.currency  IN (20)
ORDER BY ci.custid 

DECLARE @currency INT, @BitOrder INT
DECLARE @SportType SMALLINT = 208, @BetType SMALLINT = 2101
DECLARE @BatchSize SMALLINT = 5000

CREATE TABLE #Dummy	(CustID INT PRIMARY KEY)
CREATE TABLE #CustComm_temp (CustID INT, recommend INT)	
DECLARE @CustComm_TempBatch TABLE (CustID INT, recommend INT)

INSERT INTO #Dummy(CustID)
SELECT CustID FROM Customer WITH(NOLOCK) 
WHERE srecommend IN(SELECT CustID FROM #supers) AND roleid=3 AND (username LIKE '%Acc%' OR username LIKE '%LocalBank%' OR username LIKE '%AFF%' OR username LIKE 'AB88'+'CAS%')

-------------Comm----------------------------------------
INSERT INTO #CustComm_temp(CustID,recommend)
SELECT co.custid,ci.recommend
FROM bodb_Licensee.dbo.licenseeCustComm co WITH(NOLOCK) 
	INNER JOIN Custinfo ci WITH(NOLOCK) ON co.CustID = ci.custid
	INNER JOIN #supers s WITH (NOLOCK) ON ci.srecommend = s.custid
WHERE RNGComm <> 0
	AND ci.roleid = 1
	AND ci.Enabled = 1
	AND ci.mrecommend NOT IN (SELECT custid FROM #Dummy)

WHILE (1=1)
BEGIN
	DELETE TOP (@BatchSize) c 
	OUTPUT DELETED.CustID,deleted.recommend INTO @CustComm_TempBatch(CustID,recommend)
	FROM #CustComm_temp c 
		
	IF @@ROWCOUNT = 0
		BREAK;
		
	UPDATE cs
	SET isGroupedComm = 0
	FROM dbo.Dep_CustSettingMode cs WITH(UPDLOCK,ROWLOCK)
		INNER JOIN @CustComm_TempBatch cb 
			ON cb.CustID = cs.CustID
		INNER JOIN bodb_Licensee.dbo.licenseeCustComm co WITH(NOLOCK) 
			ON cs.CustID = co.CustID
		INNER JOIN Dep_CustDiscountGroupSetting_Member gr WITH(NOLOCK)
			ON cb.recommend = gr.AgentID
			AND gr.SportType = @SportType
			AND gr.BetType = @BetType
	WHERE cs.IsGroupedComm = 1
		AND co.RNGComm <> gr.PlayerDiscount
		
	--> UpdatePlayer comm on private Tables (insert if not exist)
	UPDATE dcs_m
	SET dcs_m.PlayerDiscount = co.RNGComm
	FROM Dep_CustSettingMode c WITH (NOLOCK)
		INNER JOIN @CustComm_TempBatch cb 
			ON c.CustID = cb.CustID
		INNER JOIN bodb_Licensee.dbo.licenseeCustComm co WITH(NOLOCK) 
			ON c.CustID = co.CustID
		INNER JOIN Dep_CustDiscountSetting_Member dcs_m WITH (ROWLOCK,UPDLOCK) 
			ON dcs_m.CustID = c.CustID 
			and dcs_m.SportType = @SportType
			AND dcs_m.BetType = @BetType			
	WHERE c.IsGroupedComm = 0
	
	INSERT INTO Dep_CustDiscountSetting_Member (CustID
						,SportType
						,BetType
						,PlayerDiscount
						,AgentDiscount
						,MasterDiscount
						,SuperDiscount)  	
	SELECT c.CustID, @SportType, @BetType,co.RNGComm, 0,0,0
	FROM Dep_CustSettingMode c WITH (NOLOCK)
		INNER JOIN @CustComm_TempBatch cb 
			ON c.CustID = cb.CustID
		INNER JOIN bodb_Licensee.dbo.licenseeCustComm co WITH(NOLOCK) 
			ON c.CustID = co.CustID
		LEFT JOIN Dep_CustDiscountSetting_Member dcs_m WITH (NOLOCK) 
			ON dcs_m.CustID = c.CustID 
			and dcs_m.SportType = @SportType
			AND dcs_m.BetType = @BetType			
	WHERE c.IsGroupedComm = 0 AND dcs_m.custid IS NULL
			
	DELETE FROM @CustComm_TempBatch
END

DROP TABLE #Dummy
DROP TABLE #supers
DROP TABLE #CustComm_temp
PRINT N'Step 6: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 

