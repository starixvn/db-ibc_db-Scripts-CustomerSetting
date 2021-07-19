/*
	Creator: 20200615@Eden
	Task: Update valueID and HasSameVR - Redmine: #134978
		Step 1: Update IsManuallyUpdate
		Step 2: Update HasSameVR
		Step 3: Update ValueID
	Run at: CustDB@DBCUST 
*/
USE CustDB
GO
	--Step 1 : Mark IsManuallyUpdate = 1 for any of the VR >= -50
	UPDATE BasketBallVR_Temp WITH(ROWLOCK)
	SET IsManuallyUpdate = 1
	WHERE (VRValue_HDPLive >= 0.5 
		OR VRValue_HDPNonLive > = 0.5 
		OR VRValue_OULive > = 0.5 
		OR VRValue_OUNonLive > = 0.5 
		OR VRValue_OELive > = 0.5 
		OR VRValue_OENonLive > = 0.5 
		OR VRValue_MNLive > = 0.5 
		OR VRValue_MNNonLive > = 0.5 
	)
	
	--Step 2: Update [HasSameVR]
	UPDATE main
	SET  main.HasSameVR = 0
	FROM BasketBallVR_Temp main  WITH(ROWLOCK)
	WHERE NOT (
		main.VRValue_HDPLive = main.VRValue_OULive
		AND  main.VRValue_HDPLive = main.VRValue_OELive
		AND  main.VRValue_HDPLive = main.VRValue_MNLive

		AND  main.VRValue_HDPNonLive = main.VRValue_OUNonLive	
		AND  main.VRValue_HDPNonLive = main.VRValue_OENonLive	
		AND  main.VRValue_HDPNonLive = main.VRValue_MNNonLive
	)

	--Step 3: Update ValueID
	UPDATE main
	SET VRValue_HDPLive = HDPLive.ValueID
		, VRValue_HDPNonLive = HDPNonLive.ValueID
		, VRValue_OULive = OULive.ValueID
		, VRValue_OUNonLive = OUNonLive.ValueID
		, VRValue_OELive = OELive.ValueID
		, VRValue_OENonLive = OENonLive.ValueID
		, VRValue_MNLive = MNLive.ValueID
		, VRValue_MNNonLive = MNNonLive.ValueID
	FROM BasketBallVR_Temp main  WITH(ROWLOCK)
		INNER JOIN VRValueMapping HDPLive WITH(NOLOCK) ON HDPLive.Value = main.VRValue_HDPLive
		INNER JOIN VRValueMapping HDPNonLive WITH(NOLOCK) ON HDPNonLive.Value = main.VRValue_HDPNonLive
		INNER JOIN VRValueMapping OULive WITH(NOLOCK) ON OULive.Value = main.VRValue_OULive
		INNER JOIN VRValueMapping OUNonLive WITH(NOLOCK) ON OUNonLive.Value = main.VRValue_OUNonLive
		INNER JOIN VRValueMapping OELive WITH(NOLOCK) ON OELive.Value = main.VRValue_OELive
		INNER JOIN VRValueMapping OENonLive WITH(NOLOCK) ON OENonLive.Value = main.VRValue_OENonLive
		INNER JOIN VRValueMapping MNLive WITH(NOLOCK) ON MNLive.Value = main.VRValue_MNLive
		INNER JOIN VRValueMapping MNNonLive WITH(NOLOCK) ON MnNonLive.Value = main.VRValue_MNNonLive