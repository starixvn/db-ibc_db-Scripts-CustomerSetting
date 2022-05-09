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
	AND cs.site IN ('11bet'
					,'12Bet'
					,'368Cash'
					,'3star88'
					,'88Macao'
					,'9bet'
					,'9Club'
					,'9wickets'
					,'Ae88'
					,'AG'
					,'AOGcasino'
					,'Aoncash'
					,'asiabet88'
					,'Athena000'
					,'BE7'
					,'Bolanation'
					,'Boma365'
					,'Dabet'
					,'DEWA'
					--,'Fabet'
					,'FB88'
					,'Happy1668'
					,'Heaven'
					,'HonorW'
					,'iBET'
					,'IONclub'
					,'ISC888'
					,'ITCbet'
					,'Kbet'
					,'Liga'
					,'LIGAWLHKB'
					--,'Lucky88'
					,'M8bola'
					,'Macaubet'
					,'N88'
					,'N8B'
					,'N8G'
					,'Nova88'
					,'OLE777'
					,'One88'
					,'OXbet'
					,'Q8bola'
					--,'Red88'
					,'RICbet'
					,'Saba789'
					,'Senibet'
					,'Sin88'
					,'Sky88'
					,'spondemo'
					,'TIC88'
					,'TLC'
					,'UN168'
					,'Unobet'
					,'Uwoniwin'
					,'webet88'
					,'XO88'
					,'Zbet'
					)
	AND Ci.currency IN (
						 	2	-- 	RM
						,	3	-- 	US$
						,	4	-- 	TB
						,	6	-- 	EURO
						,	12	-- 	GBP
						,	13	-- 	RMB
						,	15	-- 	IN
						,	45	-- 	WON
						,	51	-- 	INH
						,	61	-- 	INR
						,	66	-- 	YUN
						,	70	-- 	MKK
						,	96	-- 	USDT
						,   20  --	UUS
						)
ORDER BY ci.custid 

DECLARE @currency INT, @BitOrder INT
DECLARE @SportType SMALLINT = 208, @BetType SMALLINT = 2101
DECLARE @BatchSize SMALLINT = 5000
	 
SELECT @BitOrder= bitmapOrder 
FROM Dep_ProductStatusProfile WITH(NOLOCK) 
WHERE SportType=@Sporttype AND Bettype = @BetType

CREATE TABLE #Dummy	(CustID INT PRIMARY KEY)
CREATE TABLE #CustComm_temp (CustID INT, recommend INT)	
DECLARE @CustComm_TempBatch TABLE (CustID INT, recommend INT)
CREATE TABLE #CustStatus_Temp  (CustID INT, IsDisabled BIT)	
DECLARE @CustStatus_TempBatch TABLE (CustID INT, IsDisabled BIT)

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
		
	--> insert comm on private tables if not exists (get all sport offered from agent)
	INSERT INTO Dep_CustDiscountSetting_Member (
		CustID
		,SportType
		,BetType
		,PlayerDiscount
		,AgentDiscount
		,MasterDiscount
		,SuperDiscount
	)
	SELECT c.CustID, ag.Sporttype, ag.BetType,ag.PlayerDiscount,ag.AgentDiscount,ag.MasterDiscount,ag.SuperDiscount
	FROM Dep_CustSettingMode c WITH (NOLOCK)
		INNER JOIN @CustComm_TempBatch cb 
			ON c.CustID = cb.CustID
		INNER JOIN Dep_CustDiscountGroupSetting_Member ag WITH(NOLOCK)
			ON cb.recommend = ag.AgentID
		LEFT JOIN Dep_CustDiscountSetting_Member dcs_m WITH (NOLOCK) 
			ON dcs_m.CustID = c.CustID 
			and dcs_m.SportType = ag.Sporttype
			AND dcs_m.BetType = ag.BetType			
	WHERE c.IsGroupedComm = 0 
		AND dcs_m.custid IS NULL
	
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
			
	DELETE FROM @CustComm_TempBatch
END

--------------------------------------------Adjust Status--------------------------------------------------
INSERT INTO #CustStatus_Temp(custid,IsDisabled)
SELECT c.CustID,ci.DisableCasino
FROM dbo.Dep_CustProductStatus C WITH(NOLOCK)
	CROSS APPLY dbo.f_CustSetting_ProductStatusSel(C.bitmapIsDisabled, @BitOrder) as isDisabled
	CROSS APPLY dbo.f_CustSetting_ProductStatusSel(C.bitmapIsHidden, @BitOrder) as isHidden
	INNER JOIN custInfo ci WITH(NOLOCK) ON C.CustID = ci.custid
	INNER JOIN #supers s WITH (NOLOCK) ON ci.srecommend = s.custid
WHERE ci.roleid IN (1,2,3,4) 
	AND Enabled = 1
	AND ci.mrecommend NOT IN (SELECT custid FROM #Dummy)
	AND (isDisabled.value <> ci.DisableCasino OR isHidden.value <> 0)

WHILE 1 = 1
BEGIN
	DELETE TOP(@BatchSize) t
	OUTPUT deleted.custid,deleted.IsDisabled INTO @CustStatus_TempBatch(custid,IsDisabled)
	FROM #CustStatus_Temp t

	IF @@ROWCOUNT = 0
		BREAK

	UPDATE cs
	SET cs.bitmapIsHidden = hid.NewBitmap,
		bitmapIsDisabled = dis.NewBitmap
	FROM [dbo].[Dep_CustProductStatus] cs WITH(ROWLOCK,UPDLOCK)
		INNER JOIN @CustStatus_TempBatch ci ON cs.CustID = ci.CustID
		CROSS APPLY dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsHidden,@BitOrder,0) as Hid
		CROSS APPLY dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsDisabled,@BitOrder,ci.IsDisabled) as Dis

	DELETE FROM @CustStatus_TempBatch
END

DROP TABLE #Dummy
DROP TABLE #supers
DROP TABLE #CustComm_temp
DROP TABLE #CustStatus_Temp
PRINT N'Step 6: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 

