/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created By: Johnson@20251112
	Description: Adjust Max PT 90% and Comm 0.8% for Live Casino Product [redmine: #242260]
	DB: DBCust/CustDB	
*/
DECLARE @__delaytime VARCHAR(10),
		@GroupID INT

CREATE TABLE #Supers(CustID INT PRIMARY KEY)
CREATE TABLE #tblMasters(CustID INT PRIMARY KEY, srecommend INT, isFinished BIT DEFAULT 0)

SELECT @GroupID = ca.GroupID
FROM CustAccount ca WITH(NOLOCK)
	INNER JOIN Customer c WITH(NOLOCK) ON ca.CustID = c.CustID
WHERE c.username = 'MG7'

INSERT INTO #Supers(CustID)
SELECT ci.CustID
FROM CustAccount ca WITH(NOLOCK)
	INNER JOIN custinfo ci WITH(NOLOCK) ON ca.CustID = ci.CustID
WHERE ca.GroupID = @GroupID
	AND ci.Enabled = 1
	AND ci.roleid = 4

INSERT INTO #tblMasters(CustID, srecommend)
SELECT CustID, srecommend
FROM custinfo ci WITH(NOLOCK)
WHERE ci.Enabled = 1
	AND ci.roleid = 3
	AND srecommend IN (SELECT custid FROM #Supers)

-- For deployer info
DECLARE @cntCust INT, @index INT = 0, @custid INT, @roleid TINYINT, @srecommend INT

DECLARE @PT SMALLMONEY = 90,		
        @xmlPT VARCHAR(MAX),
		@rule TINYINT

SELECT @xmlPT = '<ROOT><PT SportType="9917" BetType="2400" IsLive="0"/></ROOT>'

SET @cntCust = (SELECT COUNT(*) FROM #tblMasters )

DECLARE @msg NVARCHAR(200) = 'Currently at order %d, CustID: %d.'

DECLARE @msg_total NVARCHAR(200) = 'Total of masters : %d.'

RAISERROR (@msg_total, 0, 1, @cntCust) WITH NOWAIT

WHILE(1=1)
BEGIN
	UPDATE TOP (1) #tblMasters
	SET isfinished = 1
		,@custid = custid
		,@srecommend = srecommend		
	WHERE isfinished = 0
		
	IF @@ROWCOUNT = 0 BREAK
	
	SET @index = @index + 1
	
	RAISERROR (@msg, 0, 1,@index, @custid) WITH NOWAIT

	SELECT @rule = CASE WHEN SuperPT > 0 AND MasterPT > 0 AND MinPT = 0 THEN 1
						WHEN MasterPT = 0 THEN 2
						WHEN MinPT > 0 AND IsAutoSuperPT = 0 THEN 3
						WHEN IsAutoSuperPT = 1 AND MinPT > 0 THEN 4
						WHEN IsAutoSuperPT = 1 AND MinPT = 0 THEN 5 END					
	FROM CustPTSetting3rd_Agent WITH(NOLOCK) 
	WHERE CustID = @custid AND SportType = 9917 AND BetType = 2400 AND IsLive = 0

	IF @rule = 1
	BEGIN
		UPDATE cs
		SET cs.MasterPT = @PT - SuperPT,
			RepUpdateTime = dbo.f_GetDateTime2()
		FROM CustPTSetting3rd_Agent cs WITH(UPDLOCK,ROWLOCK)
		WHERE cs.CustID = @custid
			AND cs.SportType = 9917
			AND cs.BetType = 2400
			AND cs.IsLive = 0
		
		EXEC dbo.Acc_DynamicCustSetting3rd_07
			@SuperID = @srecommend
			,@MasterID = @custid
			,@RoleID = 3
			,@SportBettypeXML = @xmlPT	
	END
	ELSE IF @rule = 2
	BEGIN
		UPDATE cs
		SET cs.SuperPT = @PT,
			RepUpdateTime = dbo.f_GetDateTime2()
		FROM CustPTSetting3rd_Agent cs WITH(UPDLOCK,ROWLOCK)
		WHERE cs.CustID = @custid
			AND cs.SportType = 9917
			AND cs.BetType = 2400
			AND cs.IsLive = 0
		
		EXEC dbo.Acc_DynamicCustSetting3rd_07
			@SuperID = @srecommend
			,@MasterID = @custid
			,@RoleID = 3
			,@SportBettypeXML = @xmlPT	
	END
	ELSE IF @rule = 3
	BEGIN
		UPDATE cs
		SET cs.MasterPT = @PT - SuperPT,
			cs.MinPT = @PT - SuperPT,
			RepUpdateTime = dbo.f_GetDateTime2()
		FROM CustPTSetting3rd_Agent cs WITH(UPDLOCK,ROWLOCK)
		WHERE cs.CustID = @custid
			AND cs.SportType = 9917
			AND cs.BetType = 2400
			AND cs.IsLive = 0

		--update MinPT
		EXEC dbo.Acc_DynamicCustSetting3rd_04 
				@MasterID = @custid
				,@SuperID = @srecommend
				,@RoleID = 3
				,@SportBettypeXML = @xmlPT

		EXEC dbo.Acc_DynamicCustSetting3rd_07
				@SuperID = @srecommend
				,@MasterID = @custid
				,@RoleID = 3
				,@SportBettypeXML = @xmlPT	
	END
	ELSE IF @rule = 4
	BEGIN
		UPDATE cs
		SET cs.MasterPT = cs.MasterPT + 5,
			cs.MinPT = cs.MinPT + 5,
			RepUpdateTime = dbo.f_GetDateTime2()
		FROM CustPTSetting3rd_Agent cs WITH(UPDLOCK,ROWLOCK)
		WHERE cs.CustID = @custid
			AND cs.SportType = 9917
			AND cs.BetType = 2400
			AND cs.IsLive = 0

		--update MinPT
		EXEC dbo.Acc_DynamicCustSetting3rd_04 
				@MasterID = @custid
				,@SuperID = @srecommend
				,@RoleID = 3
				,@SportBettypeXML = @xmlPT

		EXEC dbo.Acc_DynamicCustSetting3rd_07
				@SuperID = @srecommend
				,@MasterID = @custid
				,@RoleID = 3
				,@SportBettypeXML = @xmlPT	

	END	
	ELSE IF @rule = 5
	BEGIN
		UPDATE cs
		SET cs.MasterPT = cs.MasterPT + 5,			
			RepUpdateTime = dbo.f_GetDateTime2()
		FROM CustPTSetting3rd_Agent cs WITH(UPDLOCK,ROWLOCK)
		WHERE cs.CustID = @custid
			AND cs.SportType = 9917
			AND cs.BetType = 2400
			AND cs.IsLive = 0

		EXEC dbo.Acc_DynamicCustSetting3rd_07
				@SuperID = @srecommend
				,@MasterID = @custid
				,@RoleID = 3
				,@SportBettypeXML = @xmlPT	
	END

	SELECT @__delaytime = dbo.f_DelayTime('CS_Adhoc')
	WAITFOR DELAY @__delaytime
END

DROP TABLE #Supers
DROP TABLE #tblMasters