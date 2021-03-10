/*
	Created: Winfred
	Date: 20210223
	Task: Disable status disable for 10 headlines (SDRMB, 266HK, M863HK, SBSR, YKH, S188RM, PYY, POT, SF8, S80R) of Sports Lottery [Redmine: 147361]
	DB: DBCUST/CustDB
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
		AND (cs.site IN('Macaubet','Aoncash','ITCBet','9bet','M8bola','Q8bola','BE7','NBCbet','Unobet','Bolanation','Luckywin88','Winn69','Axiawin','Jumbo88','Lagadewa','Ratugg','Monstergol')
		OR  (cs.site IN('spondemo','Athena000') AND cu.currency NOT IN (20,72)))
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

