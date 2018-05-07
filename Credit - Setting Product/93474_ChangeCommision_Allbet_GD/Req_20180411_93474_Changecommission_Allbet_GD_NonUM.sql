/*
	Created: Elodie
	Task: Allbet,GD - Change commission for Super level - Remine: https://nexdev.net/issues/93474
	DB: DBCUST/CustDB
	Date: 20180503
*/ 

ALTER PROCEDURE [dbo].[Acc_Custsetting3rd_18]
	@srecommend INT
	,@NewDiscount DECIMAL(9,8)
	,@target VARCHAR(20) = ''
	,@isExistDirectAccount BIT = 0
	
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME = 'DBCUST') RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME <> 'DBCUST') RETURN -- run at DBCUST only
	
	IF dbo.f_CheckRepTable('CustInfo') = 0 RETURN
	
	IF dbo.f_CheckRepTable('CustDiscount3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustDiscount3rd_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustSettingGame') = 0 RETURN

	CREATE TABLE #DirectMaster (CustID INT PRIMARY KEY)
	CREATE TABLE #DirectAgent (CustID INT PRIMARY KEY, mrecommend INT)
	CREATE TABLE #DirectMember (CustID INT PRIMARY KEY, recommend INT, mrecommend INT)
	
	CREATE TABLE #Cust_tmp (CustID INT PRIMARY KEY,roleID INT)
	DECLARE @Batch TABLE (CustID INT)
	CREATE TABLE #Cust_tmp_isExistDirectAccount (CustID INT PRIMARY KEY,roleID INT,recommend INT, mrecommend INT, srecommend INT)
	
	IF @isExistDirectAccount = 0
	BEGIN	
		INSERT INTO #Cust_tmp (CustID,roleID)
		SELECT ci.custid,ci.roleid
		FROM Customer ci WITH (NOLOCK) 
		WHERE ci.srecommend = @srecommend AND ci.roleid = 1
			
		--Super
		UPDATE cd
		SET Discount = @NewDiscount
		FROM CustDiscount3rd_Agent  cd (ROWLOCK)
		WHERE cd.CustID = @srecommend AND SportType = 211 
			
		UPDATE cs
		SET sdiscount = @NewDiscount
		FROM  CustSettingGame cs WITH(ROWLOCK)
		WHERE cs.CustID = @srecommend AND cs.sporttype = 255

		--Member
		WHILE (1=1)
		BEGIN
			DELETE TOP (4000) #Cust_tmp
			OUTPUT DELETED.CustID INTO @Batch(CustID)			

			IF @@ROWCOUNT = 0 BREAK

			UPDATE cs
			SET SuperDiscount = @NewDiscount
			FROM  CustDiscount3rd_Member cs (ROWLOCK)
				INNER JOIN @Batch c ON c.CustID = cs.CustID
			WHERE cs.SportType = 211

			UPDATE cs
			SET sdiscount = @NewDiscount
			FROM  CustSettingGame cs WITH(ROWLOCK)
				INNER JOIN @Batch c ON c.custid = cs.custid 
			WHERE cs.sporttype = 255

			DELETE FROM @Batch
		END
	END	
	ELSE 
	BEGIN
		
		-- For RoleID = 4
		UPDATE cs
		SET Discount = @NewDiscount
		FROM CustDiscount3rd_Agent  cs (ROWLOCK)
		WHERE cs.SportType = 211 AND CustID = @srecommend
		
		UPDATE cs
		SET sdiscount = @NewDiscount
		FROM  CustSettingGame cs WITH(ROWLOCK)
		WHERE cs.sporttype = 255 AND custid = @srecommend
		
		INSERT INTO #Cust_tmp_isExistDirectAccount (CustID,roleID,recommend,mrecommend,srecommend)
		SELECT ci.custid,ci.roleid,recommend,mrecommend,srecommend
		FROM custInfo ci (NOLOCK) 
		WHERE ci.srecommend = @srecommend
							
		----------- Direct Master PROCESSING ----------------------
		INSERT INTO #DirectMaster (CustID)
		SELECT custid
		FROM #Cust_tmp_isExistDirectAccount with(nolock)
		WHERE srecommend = @srecommend
			AND custid NOT IN (SELECT custid FROM Acc_CustDirect WITH(NOLOCK))
			AND srecommend  IN (SELECT custid FROM Acc_CustDirect WITH(NOLOCK))
			AND roleid=3 --AND  custid <= @maxcustid 
		
		IF EXISTS (SELECT 1 FROM #DirectMaster)
		BEGIN
			-- Role 3
			UPDATE cd
			SET Discount = @NewDiscount
			FROM CustDiscount3rd_Agent  cd (ROWLOCK)
				INNER JOIN #DirectMaster d ON cd.CustID = d.CustID
				INNER JOIN #Cust_tmp_isExistDirectAccount ci ON cd.CustID = ci.custid AND ci.roleid = 3 				
			WHERE SportType = 211 

			UPDATE cs
			SET adiscount = @NewDiscount
			FROM  CustSettingGame cs WITH(ROWLOCK)
				INNER JOIN #DirectMaster d ON cs.CustID = d.CustID
				INNER JOIN #Cust_tmp_isExistDirectAccount ci ON ci.custid = cs.custid AND ci.roleid = 3 
			WHERE cs.sporttype  = 255

			INSERT INTO #Cust_tmp (CustID,roleID)
			SELECT ci.custid,ci.roleid
			FROM #Cust_tmp_isExistDirectAccount CI 
				INNER JOIN #DirectMaster d ON ci.mrecommend = d.CustID
			WHERE ci.roleID = 1

			WHILE (1=1)
			BEGIN
				DELETE TOP (4000) #Cust_tmp
				OUTPUT DELETED.CustID INTO @Batch(CustID)			

				IF @@ROWCOUNT = 0 BREAK

				-- Role 1 UNDER direct Master
				UPDATE cd
				SET SuperDiscount = @NewDiscount, MasterDiscount = @NewDiscount
				FROM  CustDiscount3rd_Member cd (ROWLOCK)
					INNER JOIN @Batch CI ON cd.CustID = ci.custid
				WHERE SportType = 211 
			
				-- Role 1 UNDER direct Master
				UPDATE cs
				SET sdiscount = @NewDiscount, adiscount = @NewDiscount
				FROM  CustSettingGame cs WITH(ROWLOCK)
					INNER JOIN @Batch CI ON cs.CustID = ci.custid
				WHERE cs.sporttype = 255

				DELETE FROM @Batch
			END		
					
		END
		----------- Direct Agent PROCESSING ----------------------
		INSERT INTO #DirectAgent (CustID,mrecommend)
		SELECT custid,mrecommend
		FROM #Cust_tmp_isExistDirectAccount with(nolock)
		WHERE srecommend = @srecommend
			AND custid NOT IN (SELECT custid FROM Acc_CustDirect WITH(NOLOCK))
			AND mrecommend  IN (SELECT custid FROM Acc_CustDirect WITH(NOLOCK))
			AND roleid=2 
			
		IF EXISTS (SELECT 1 FROM #DirectAgent)
		BEGIN
			-- Role 3
			UPDATE cd
			SET Discount = @NewDiscount
			FROM CustDiscount3rd_Agent  cd (ROWLOCK)
				INNER JOIN #Cust_tmp_isExistDirectAccount ci (NOLOCK) ON cd.CustID = ci.custid AND ci.roleid = 3 
			WHERE SportType = 211 
				AND cd.CustID IN (SELECT DISTINCT mrecommend FROM #DirectAgent)

			UPDATE cs
			SET adiscount = @NewDiscount
			FROM  CustSettingGame cs WITH(ROWLOCK)
				INNER JOIN #Cust_tmp_isExistDirectAccount ci WITH(NOLOCK) ON ci.custid = cs.custid AND ci.roleid = 3 
			WHERE cs.sporttype = 255
				AND cs.CustID IN (SELECT DISTINCT mrecommend FROM #DirectAgent)

			-- Role 2
			UPDATE cd
			SET Discount = @NewDiscount
			FROM CustDiscount3rd_Agent  cd (ROWLOCK)
				INNER JOIN #DirectAgent d ON cd.CustID = d.CustID
				INNER JOIN #Cust_tmp_isExistDirectAccount ci (NOLOCK) ON cd.CustID = ci.custid AND ci.roleid = 2 
			WHERE SportType = 211
			
			UPDATE cs
			SET discount = @NewDiscount
			FROM  CustSettingGame cs WITH(ROWLOCK)
				INNER JOIN #DirectAgent d ON cs.CustID = d.CustID
				INNER JOIN #Cust_tmp_isExistDirectAccount ci WITH(NOLOCK) ON ci.custid = cs.custid AND ci.roleid = 2 
			WHERE cs.sporttype = 255
			 
			-- Role 1
			UPDATE cd
			SET SuperDiscount = @NewDiscount, MasterDiscount=@NewDiscount, AgentDiscount=@NewDiscount
			FROM  CustDiscount3rd_Member cd (ROWLOCK)
				INNER JOIN #Cust_tmp_isExistDirectAccount ci (NOLOCK) ON cd.CustID = ci.custid AND ci.roleid = 1 
				INNER JOIN #DirectAgent d ON ci.recommend = d.CustID
			WHERE SportType = 211 
			
			UPDATE cs
			SET sdiscount = @NewDiscount, adiscount = @NewDiscount,discount = @NewDiscount
			FROM  CustSettingGame cs WITH(ROWLOCK)
				INNER JOIN #Cust_tmp_isExistDirectAccount ci WITH(NOLOCK) ON ci.custid = cs.custid  AND ci.roleid = 1 
				INNER JOIN #DirectAgent d ON ci.recommend = d.CustID
			WHERE cs.sporttype = 255
				
			
		END
		----------- Direct Member PROCESSING ----------------------
		INSERT INTO #DirectMember(CustID,mrecommend,recommend)
		SELECT custid,mrecommend,recommend
		FROM #Cust_tmp_isExistDirectAccount with(nolock)
		WHERE srecommend = @srecommend
			AND custid NOT IN (SELECT custid FROM Acc_CustDirect WITH(NOLOCK))
			AND recommend  IN (SELECT custid FROM Acc_CustDirect WITH(NOLOCK))
			AND roleid=1 --AND  custid <= @maxcustid 
			
		IF EXISTS (SELECT 1 FROM #DirectMember)
		BEGIN
			-- Role 3
			UPDATE cd
			SET Discount = @NewDiscount
			FROM CustDiscount3rd_Agent  cd (ROWLOCK)
				INNER JOIN #Cust_tmp_isExistDirectAccount ci (NOLOCK) ON cd.CustID = ci.custid  AND ci.roleid = 3 
			WHERE SportType = 211 
				AND cd.CustID IN (SELECT DISTINCT mrecommend FROM #DirectMember)

			UPDATE cs
			SET adiscount = @NewDiscount
			FROM  CustSettingGame cs WITH(ROWLOCK)
				INNER JOIN #Cust_tmp_isExistDirectAccount ci WITH(NOLOCK) ON ci.custid = cs.custid  AND ci.roleid = 3 
			WHERE cs.sporttype = 255
				AND cs.CustID IN (SELECT DISTINCT mrecommend FROM #DirectMember)

			-- Role 2
			UPDATE cd
			SET Discount = @NewDiscount
			FROM CustDiscount3rd_Agent  cd (ROWLOCK)
				INNER JOIN #Cust_tmp_isExistDirectAccount ci (NOLOCK) ON cd.CustID = ci.custid  AND ci.roleid = 2 
			WHERE SportType = 211 
				AND cd.CustID IN (SELECT DISTINCT recommend FROM #DirectMember)
			
			UPDATE cs
			SET discount = @NewDiscount
			FROM  CustSettingGame cs WITH(ROWLOCK)
				INNER JOIN #Cust_tmp_isExistDirectAccount ci WITH(NOLOCK) ON ci.custid = cs.custid  AND ci.roleid = 2 
			WHERE cs.sporttype = 255
				AND cs.CustID IN (SELECT DISTINCT recommend FROM #DirectMember)

			-- Role 1
			UPDATE cd
			SET SuperDiscount = @NewDiscount,MasterDiscount = @NewDiscount, AgentDiscount = @NewDiscount
			FROM  CustDiscount3rd_Member cd (ROWLOCK)
				INNER JOIN #Cust_tmp_isExistDirectAccount ci (NOLOCK) ON cd.CustID = ci.custid  AND ci.roleid = 1 
				INNER JOIN #DirectMember d ON ci.custid = d.CustID
			WHERE SportType = 211 
						
			UPDATE cs
			SET sdiscount = @NewDiscount, adiscount = @NewDiscount,discount = @NewDiscount
			FROM  CustSettingGame cs WITH(ROWLOCK)
				INNER JOIN #Cust_tmp_isExistDirectAccount ci WITH(NOLOCK) ON ci.custid = cs.custid  AND ci.roleid = 1 
				INNER JOIN #DirectMember d ON ci.custid = d.CustID
			WHERE cs.sporttype = 255
					
		END
		
		-- Update member is not under Direct Master/Direct Agent/Direct member
		UPDATE T
			SET sdiscount = @NewDiscount
		FROM CustSettingGame T (ROWLOCK)
			INNER JOIN #Cust_tmp_isExistDirectAccount ci (NOLOCK) ON T.CustID = CI.custid AND roleid = 1 
		WHERE sdiscount <> @NewDiscount AND T.sporttype = 255
		
		UPDATE T
			SET SuperDiscount = @NewDiscount
		FROM CustDiscount3rd_Member T (ROWLOCK)
			INNER JOIN #Cust_tmp_isExistDirectAccount ci (NOLOCK) ON T.CustID = CI.custid AND roleid = 1 
		WHERE SuperDiscount <> @NewDiscount AND T.SportType = 211
		
	END	
	
	DROP TABLE #DirectAgent
	DROP TABLE #DirectMaster
	DROP TABLE #DirectMember	
	DROP TABLE #Cust_tmp
	DROP TABLE #Cust_tmp_isExistDirectAccount
		
END
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS (06/DBTP) -----
--------------------------------------------------------------------------------------
CREATE TABLE #supers (custid int,isfinished bit default(0), isExistDirectAccount BIT)

DECLARE @maxcustid INT, @srecommend INT, @isExistDirectAccount BIT

--SELECT @maxcustid = xxx

CREATE TABLE #supers_ExistingDirectAccount (custid INT)

INSERT INTO #supers_ExistingDirectAccount (custid)
-- Get direct Master
SELECT DISTINCT srecommend from Customer with(nolock)
WHERE custid not in (select custid from Acc_CustDirect WITH(NOLOCK))
	and srecommend  in (select custid from Acc_CustDirect WITH(NOLOCK))
	and roleid=3 --AND srecommend <= @maxcustid 
--- get direct agent
UNION 
SELECT DISTINCT srecommend from Customer with(nolock)
WHERE custid NOT IN (select custid from Acc_CustDirect WITH(NOLOCK))
	and mrecommend IN (select custid from Acc_CustDirect WITH(NOLOCK))
	and roleid=2 --AND srecommend <= @maxcustid
-- direct member
UNION
SELECT DISTINCT srecommend from Customer WITH(NOLOCK)
WHERE custid NOT IN (select custid from Acc_CustDirect WITH(NOLOCK))
	AND recommend IN (select custid from Acc_CustDirect WITH(NOLOCK))
	AND roleid=1 --AND srecommend <= @maxcustid 

-- list of supers
INSERT INTO #supers(custid,isExistDirectAccount)
SELECT ci.custid,0
FROM dbo.customer c WITH (NOLOCK) 
	INNER JOIN dbo.custinfo ci WITH(NOLOCK) ON c.custid = ci.custid
	INNER JOIN dbo.site s WITH(NOLOCK) ON c.site = s.site
WHERE ci.roleid = 4 	
		AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
		AND ci.custid NOT IN (SELECT custid FROM #supers_ExistingDirectAccount)
		AND ci.custid NOT IN (SELECT custid FROM dbo.CustSuper WITH(NOLOCK) WHERE isInternal = 1)
		AND ci.Enabled = 1
		AND s.islicensee = 0
		AND c.username NOT LIKE '3rdSuper%'
UNION ALL
SELECT custid, 1
FROM #supers_ExistingDirectAccount
		
WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #Supers
	SET isfinished = 1
		,@srecommend = custid	
		,@isExistDirectAccount = isExistDirectAccount
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK
			
	EXEC dbo.Acc_Custsetting3rd_18 @srecommend = @srecommend, @NewDiscount = 0.01
			--,@maxcustid = @maxcustid
			, @isExistDirectAccount = @isExistDirectAccount
			,@target = 'REPLICATED'
			
			
	waitfor delay '00:00:0.100'
END

-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
CREATE TABLE #supers (custid int,isfinished bit default(0), isExistDirectAccount BIT)

DECLARE @maxcustid INT, @srecommend INT, @isExistDirectAccount BIT

SELECT @maxcustid = xxx

CREATE TABLE #supers_ExistingDirectAccount (custid INT)
INSERT INTO #supers_ExistingDirectAccount (custid)
-- Get direct Master
SELECT DISTINCT srecommend from Customer with(nolock)
WHERE custid not in (select custid from Acc_CustDirect WITH(NOLOCK))
	and srecommend  in (select custid from Acc_CustDirect WITH(NOLOCK))
	and roleid=3 --AND srecommend <= @maxcustid 
--- get direct agent
UNION 
SELECT DISTINCT srecommend from Customer with(nolock)
WHERE custid NOT IN (select custid from Acc_CustDirect WITH(NOLOCK))
	and mrecommend IN (select custid from Acc_CustDirect WITH(NOLOCK))
	and roleid=2 --AND srecommend <= @maxcustid
-- direct member
UNION
SELECT DISTINCT srecommend from Customer WITH(NOLOCK)
WHERE custid NOT IN (select custid from Acc_CustDirect WITH(NOLOCK))
	AND recommend IN (select custid from Acc_CustDirect WITH(NOLOCK))
	AND roleid=1 --AND srecommend <= @maxcustid 

-- list of supers
INSERT INTO #supers(custid,isExistDirectAccount)
SELECT ci.custid,0
FROM dbo.customer c WITH (NOLOCK) 
	INNER JOIN dbo.custinfo ci WITH(NOLOCK) ON c.custid = ci.custid
	INNER JOIN dbo.site s WITH(NOLOCK) ON c.site = s.site
WHERE ci.roleid = 4 	
		AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
		AND ci.custid NOT IN (SELECT custid FROM #supers_ExistingDirectAccount)
		AND ci.custid NOT IN (SELECT custid FROM dbo.CustSuper WITH(NOLOCK) WHERE isInternal = 1)
		AND ci.Enabled = 1
		AND s.islicensee = 0
		AND c.username NOT LIKE '3rdSuper%'
UNION ALL
SELECT s.custid, 1
FROM #supers_ExistingDirectAccount s
	INNER JOIN Custinfo ci WITH (NOLOCK) ON s.custid = ci.custid
	INNER JOIN customer c WITH (NOLOCK) ON s.custid = c.custid
	INNER JOIN dbo.site si WITH(NOLOCK) ON c.site = si.site
WHERE ci.custid NOT IN (SELECT custid FROM dbo.CustSuper WITH(NOLOCK) WHERE isInternal = 1)
		AND ci.Enabled = 1
		AND si.islicensee = 0
		AND c.username NOT LIKE '3rdSuper%'

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #Supers
	SET isfinished = 1
		,@srecommend = custid	
		,@isExistDirectAccount = isExistDirectAccount
		
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK

	EXEC dbo.Acc_Custsetting3rd_18 @srecommend = @srecommend, @NewDiscount = 0.01
			--,@maxcustid = @maxcustid
			, @isExistDirectAccount = @isExistDirectAccount
			,@target = 'DBCUST'
						
	WAITFOR DELAY '00:00:0.100'
END