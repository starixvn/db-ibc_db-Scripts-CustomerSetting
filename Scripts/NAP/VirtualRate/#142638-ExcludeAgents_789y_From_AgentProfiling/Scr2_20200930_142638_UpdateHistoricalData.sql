/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20200930@Eden
	Task: Update Historical Data when remove 789y from VRAgentProfile [RM#142638]
		Step 1: Update VR = Follow Super's for Agents and their member who were adjusted VR = 0 (Abnormal Agents)
		Step 2: Remove Agents of 789y from VRAgentAutoAdjustment
	DB: DBCUST/CustDB
*/
USE [CustDB]
GO
	--Step 1 : 
	DECLARE @AgentTbl TABLE(AgentID  INT PRIMARY KEY , Status TINYINT)

	INSERT INTO @AgentTbl(AgentID,Status)
	SELECT v.AgentID,v.Status
	FROM VRAgentAutoAdjustment v WITH(NOLOCK)
		INNER JOIN customer c WITH(NOLOCK) ON v.AgentID = c.custid
	WHERE c.site = '789y'
	
	DECLARE @Update_CustTbl TABLE (CustID INT PRIMARY KEY, srecommend INT, IsFinish BIT DEFAULT 0)

	--> get Agents and their member who were adjusted VR = 0
	INSERT INTO @Update_CustTbl(CustID,srecommend)
	SELECT c.custid,c.srecommend
	FROM @AgentTbl t
		INNER JOIN custInfo c WITH(NOLOCK) ON c.recommend = t.AgentID 
	WHERE t.Status = 2
		AND c.Enabled = 1

	--Exclude list of Auto Update VR Job 
	DELETE t
	FROM @Update_CustTbl t
	WHERE EXISTS (
					SELECT 1
					FROM DBLOG.bodb_CustomerLog.dbo.UserLog_VirtualRateSettings AS ulvrs WITH (NOLOCK)
					WHERE ulvrs.CustID = t.CustID
					)

	--SET Other sport VR = super's
	DECLARE	@tblVirtualrate		TABLE (
								CustID				INT
							,	SportType			INT
							,	BetType				INT
							,	IsLive				BIT
							,	VirtualMultiplier	SMALLMONEY	
							);
										
	INSERT INTO	@tblVirtualrate (CustID,SportType,BetType,IsLive,VirtualMultiplier)
	SELECT t.custid, 
			pvs.sporttype, 
			pvs.bettype, 
			pvs.islive, 
			dbo.f_GetVirtualSetting(cvs.bitmapVirtual, pvs.profileID) AS virtualMultiplier
	FROM @Update_CustTbl t 
			INNER JOIN CustVirtualSetting AS cvs WITH(NOLOCK)
			ON cvs.custid = t.srecommend
			INNER JOIN ProfileVirtualSetting AS pvs WITH(NOLOCK)
			ON cvs.seqNo = pvs.seqNo
	WHERE pvs.sporttype NOT IN( 2, 43);

	DECLARE	@virtualXML	TABLE (
							seqNo		TINYINT
						,	Pos			VARBINARY(64)
						,	Val			VARBINARY(64)
						,	CustID		INT
						);
										
	INSERT INTO @virtualXML(CustID,seqNo, Pos, Val)
	SELECT	t.CustID, pvs.seqNo, p1.Pos, p2.Val
	FROM @Update_CustTbl t 
			CROSS APPLY (
				SELECT	DISTINCT seqNo
				FROM	ProfileVirtualSetting WITH (NOLOCK)
			) pvs
			CROSS APPLY (
				SELECT CONVERT(VARBINARY(64), (
					SELECT	CONVERT(VARCHAR, CAST(ipvs.profileID - 64 * (ipvs.seqNo - 1) AS BINARY(1)), 2)
					FROM		@tblVirtualrate			AS tmp
						INNER JOIN	ProfileVirtualSetting	AS ipvs WITH (NOLOCK)
							ON	tmp.sporttype	= ipvs.sporttype
								AND	tmp.bettype		= ipvs.bettype
								AND	tmp.isLive		= ipvs.islive
					WHERE	ipvs.seqNo = pvs.seqNo AND tmp.CustID = t.CustID
					FOR XML PATH ('')						
				), 2) AS Pos
			) p1
			CROSS APPLY (
				SELECT CONVERT(VARBINARY(64), (
					SELECT	CONVERT(VARCHAR, CAST(CASE WHEN CAST(VirtualMultiplier * 100 AS INT) > 200 THEN ((CAST(VirtualMultiplier * 100 AS INT) - 200) / 5 + 200) ELSE CAST(VirtualMultiplier * 100 AS INT) END AS BINARY(1)), 2)
					FROM		@tblVirtualrate			AS tmp
						INNER JOIN	ProfileVirtualSetting	AS ipvs WITH (NOLOCK)
							ON	tmp.sporttype	= ipvs.sporttype
								AND	tmp.bettype		= ipvs.bettype
								AND	tmp.isLive		= ipvs.islive
					WHERE	ipvs.seqNo = pvs.seqNo AND tmp.CustID = t.CustID
					FOR XML PATH ('')						
				), 2) AS Val
			) p2

	DECLARE @tempUpdate_tbl TABLE (CustID INT)
	WHILE 1 = 1
	BEGIN
		DELETE FROM @tempUpdate_tbl

		UPDATE TOP(3000) t
		SET t.IsFinish = 1
		OUTPUT inserted.CustID INTO @tempUpdate_tbl(CustID)
		FROM @Update_CustTbl t
		WHERE t.IsFinish = 0

		IF @@ROWCOUNT = 0 BREAK;
		
		UPDATE cvs
		SET cvs.bitmapVirtual = bm.bitmap
		FROM CustVirtualSetting	AS cvs WITH(UPDLOCK, ROWLOCK)
			INNER JOIN @tempUpdate_tbl t ON cvs.custid = t.CustID			
			INNER JOIN	@virtualXML	AS tmp
					ON	cvs.seqNo = tmp.seqNo
					AND cvs.custid = tmp.CustID
			CROSS APPLY (SELECT TOP 1 bitmap FROM dbo.f_GenerateVirtualSetting_inline(cvs.bitmapVirtual, tmp.Val, tmp.Pos)) AS bm

		WAITFOR DELAY '00:00:00.010'
	END

	--Step 2 : Remove Agents of 789y from VRAgentAutoAdjustment
	

	WHILE 1 = 1
	BEGIN
		DELETE TOP(3000)
		FROM VRAgentAutoAdjustment WITH(ROWLOCK)
		WHERE AgentID IN ( SELECT AgentID FROM @AgentTbl)

		IF @@ROWCOUNT = 0
		BREAK;

		WAITFOR DELAY '00:00:00.010'
	END