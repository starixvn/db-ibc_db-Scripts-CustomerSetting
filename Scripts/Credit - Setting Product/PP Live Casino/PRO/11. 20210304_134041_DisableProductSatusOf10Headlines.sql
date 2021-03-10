/*
	Created: Tina
	Date: 20210310
	Task: Update status disable for 10 headlines (SDRMB, 266HK, M863HK, SBSR, YKH, S188RM, PYY, POT, SF8, S80R) of PP Live Casino [Redmine: 134041]
	DB: DBCUST/CustDB
*/

USE [CustDB]
GO

--Get Group ID
	CREATE TABLE #Headline (CustID INT, RoleID INT, Currency TINYINT)
	CREATE TABLE #supers (custid int)

	INSERT INTO #Headline(CustID, RoleID, Currency)
	SELECT CI.custid, CI.roleid, CI.currency
	FROM custAccount C WITH (NOLOCK)
		JOIN custInfo CI WITH (NOLOCK) ON C.custid = CI.custid
	WHERE C.groupID IN (
		SELECT CA.groupID
		FROM custAccount CA WITH (NOLOCK)
			JOIN custInfo A WITH (NOLOCK) ON CA.custid = A.custid
		WHERE A.username IN ('SDRMB', '266HK', 'M863HK', 'SBSR', 'YKH', 'S188RM', 'PYY', 'POT', 'SF8', 'S80R')
	)
--Get all line in group M863HK - 157

	INSERT INTO #supers(custid)
	SELECT ci.custid
	FROM #Headline ci WITH (NOLOCK) 
		LEFT JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
	WHERE ci.roleid = 4  
		AND cs.isinternal = 0
		AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
		AND ci.currency IN (13, --CNY(RMB)
							6, --EUR(EURO)
							12, --GBP(GBP)
							5, --HKD(HK$)
							67, --HKD(HKK)
							47, --IDR(DDD)
							33, --IDR(IDD)
							34, --IDR(IDR)
							15, --IDR(IN)
							22, --IDR(IND)
							45, --KRW(Won)
							69, --MMK(MMK)
							2, --MYR(RM)
							43, --THB(THB)
							35, --USD($US)
							3, --USD(US$)
							95, --USD(USD)
							64, --USD(UT)
							16, --USD(Yen)
							51 --VND(INH)
						) --supported currencies
	
	
--------------------------------------Status Setting-------------------------------------------------		
	DECLARE @BitmapOrder TINYINT = 33

	CREATE TABLE #CustList_ST (custid INT)
	CREATE TABLE #CustList_Updated (custid INT)

	--Super
	INSERT INTO #CustList_ST (custid)
	SELECT CS.CustID
	FROM dbo.CustProductStatus cs WITH(NOLOCK)
		INNER JOIN custInfo ci WITH(NOLOCK) ON cs.CustID = ci.custid
		INNER JOIN #supers s WITH (NOLOCK) ON ci.srecommend = s.custid
	WHERE ci.Enabled = 1

	--Master
	INSERT INTO #CustList_ST (custid)
	SELECT CS.CustID
	FROM dbo.CustProductStatus cs WITH(NOLOCK)
		INNER JOIN custInfo ci WITH(NOLOCK) ON cs.CustID = ci.custid
		INNER JOIN #Headline m WITH (NOLOCK) ON ci.mrecommend = m.CustID AND m.RoleID = 3
	WHERE ci.Enabled = 1

	--Agent
	INSERT INTO #CustList_ST (custid)
	SELECT CS.CustID
	FROM dbo.CustProductStatus cs WITH(NOLOCK)
		INNER JOIN custInfo ci WITH(NOLOCK) ON cs.CustID = ci.custid
		INNER JOIN #Headline m WITH (NOLOCK) ON ci.recommend = m.CustID AND m.RoleID = 2
	WHERE ci.Enabled = 1

	--Member
	INSERT INTO #CustList_ST (custid)
	SELECT CS.CustID
	FROM dbo.CustProductStatus cs WITH(NOLOCK)
		INNER JOIN custInfo ci WITH(NOLOCK) ON cs.CustID = ci.custid
		INNER JOIN #Headline m WITH (NOLOCK) ON ci.custid = m.CustID AND m.RoleID = 1
	WHERE ci.[Enabled] = 1


	WHILE EXISTS (SELECT TOP 1 1 FROM #CustList_ST)
	BEGIN
		
		DELETE TOP (3000) FROM #CustList_ST OUTPUT DELETED.* INTO #CustList_Updated

		IF @@ROWCOUNT=0
			BREAK	

		UPDATE cs
		SET cs.bitmapIsHidden = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsHidden,@BitmapOrder,1)),
			bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsDisabled,@BitmapOrder,1)) 	
		FROM [dbo].[CustProductStatus] cs WITH(ROWLOCK,UPDLOCK)
			INNER JOIN #CustList_Updated CI WITH(NOLOCK) ON cs.CustID = ci.CustID

		TRUNCATE TABLE #CustList_Updated

	END

	DROP TABLE #CustList_ST
	DROP TABLE #supers
	DROP TABLE #Headline
	DROP TABLE #CustList_Updated

