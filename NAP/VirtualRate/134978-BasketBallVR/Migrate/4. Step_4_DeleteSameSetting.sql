/*
	Creator: 20200615@Eden
	Task: Delete data for accounts having same settings as direct upline's - Redmine: #134978
		Step 1: Update virtual multiplier to 1 if it is 0 and then delete member's setting
		Step 2: Delete agent's setting
		Step 3: Delete master's setting
		Step 4: Insert global setting
		Step 5: Delete super's setting
		Step 6: Delete Global setting ( Already insert in other script with full info)
	Run at: CustDB@DBCUST 
*/
USE CustDB
GO
	--Step 1: Update virtual multiplier to 1 if it is 0 and then delete member's setting
	UPDATE BasketBallVR_Temp WITH(ROWLOCK) 
	SET VRValue_HDPLive = 1
		,  VRValue_HDPNonLive = 1
		,  VRValue_OULive = 1
		,  VRValue_OUNonLive = 1
		,  VRValue_OELive = 1
		,  VRValue_OENonLive = 1
		,  VRValue_MNLive = 1
		,  VRValue_MNNonLive = 1
	WHERE VRValue_HDPLive = 0

	WHILE (1=1)
	BEGIN
		DELETE TOP (20000) c
		FROM BasketBallVR_Temp c WITH(ROWLOCK) 
			INNER JOIN BasketBallVR_Temp m WITH(NOLOCK) ON c.recommend = m.CustID AND m.RoleID = 2
		WHERE c.RoleID=1
			AND c.VRValue_HDPLive = m.VRValue_HDPLive
			AND c.VRValue_HDPNonLive = m.VRValue_HDPNonLive
			AND c.VRValue_OULive = m.VRValue_OULive
			AND c.VRValue_OUNonLive = m.VRValue_OUNonLive
			AND c.VRValue_OELive = m.VRValue_OELive
			AND c.VRValue_OENonLive = m.VRValue_OENonLive
			AND c.VRValue_MNLive = m.VRValue_MNLive
			AND c.VRValue_MNNonLive = m.VRValue_MNNonLive

		IF @@ROWCOUNT < 20000
			BREAK
	END


	--Step 2: Delete agent's setting
	WHILE (1=1)
	BEGIN
		DELETE TOP (20000)  c
		FROM BasketBallVR_Temp c WITH(ROWLOCK) 
		INNER JOIN BasketBallVR_Temp m WITH(NOLOCK) ON c.mrecommend = m.CustID AND m.RoleID = 3
		WHERE c.RoleID=2
			AND c.VRValue_HDPLive = m.VRValue_HDPLive
			AND c.VRValue_HDPNonLive = m.VRValue_HDPNonLive
			AND c.VRValue_OULive = m.VRValue_OULive
			AND c.VRValue_OUNonLive = m.VRValue_OUNonLive
			AND c.VRValue_OELive = m.VRValue_OELive
			AND c.VRValue_OENonLive = m.VRValue_OENonLive
			AND c.VRValue_MNLive = m.VRValue_MNLive
			AND c.VRValue_MNNonLive = m.VRValue_MNNonLive

		IF @@ROWCOUNT < 20000
			BREAK
	END

	--Step 3: Delete master's setting
	WHILE (1=1)
	BEGIN
		DELETE TOP (20000)  c
		FROM BasketBallVR_Temp c WITH(ROWLOCK) 
		INNER JOIN BasketBallVR_Temp m WITH(NOLOCK) ON c.srecommend = m.CustID AND m.RoleID = 4
		WHERE c.RoleID=3
			AND c.VRValue_HDPLive = m.VRValue_HDPLive
			AND c.VRValue_HDPNonLive = m.VRValue_HDPNonLive
			AND c.VRValue_OULive = m.VRValue_OULive
			AND c.VRValue_OUNonLive = m.VRValue_OUNonLive
			AND c.VRValue_OELive = m.VRValue_OELive
			AND c.VRValue_OENonLive = m.VRValue_OENonLive
			AND c.VRValue_MNLive = m.VRValue_MNLive
			AND c.VRValue_MNNonLive = m.VRValue_MNNonLive

		IF @@ROWCOUNT < 20000
			BREAK
	END

	--Step 4: Insert global setting
	INSERT INTO BasketBallVR_Temp(VRValue_HDPLive,VRValue_HDPNonLive,VRValue_OULive,VRValue_OUNonLive
							,VRValue_OELive,VRValue_OENonLive,VRValue_MNLive,VRValue_MNNonLive
							,HasSameVR
							,CustID
							,RoleID
					)	
	SELECT 0.12 VRValue_HDPLive, 0.1 VRValue_HDPNonLive
		, 0.08 VRValue_OULive, 0.08 VRValue_OUNonLive
		, 0.15 VRValue_OELive,0.15 VRValue_OENonLive
		, 0.15 VRValue_MNLive, 0.15 VRValue_MNNonLive
		, 1 HasSameVR
		, 0 CustID
		, 5 RoleID

	--Step 5: Delete super's setting
	DELETE main
	FROM BasketBallVR_Temp main WITH(ROWLOCK) 
	INNER JOIN BasketBallVR_Temp g WITH(NOLOCK) ON g.CustID = 0
		AND main.VRValue_HDPLive = g.VRValue_HDPLive
		AND main.VRValue_HDPNonLive = g.VRValue_HDPNonLive
		AND  main.VRValue_OULive = g.VRValue_OULive
		AND  main.VRValue_OUNonLive = g.VRValue_OUNonLive
		AND  main.VRValue_OELive = g.VRValue_OELive
		AND  main.VRValue_OENonLive = g.VRValue_OENonLive
		AND  main.VRValue_MNLive = g.VRValue_MNLive
		AND  main.VRValue_MNNonLive = g.VRValue_MNNonLive
	WHERE main.RoleID=4

	--Step 6: Delete Global setting
	DELETE FROM BasketBallVR_Temp WITH(ROWLOCK) WHERE custid = 0
	