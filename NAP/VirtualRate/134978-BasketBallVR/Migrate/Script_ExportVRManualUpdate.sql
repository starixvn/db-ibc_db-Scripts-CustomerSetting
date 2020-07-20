/*
	Creator: 20200622@Eden
	Task: Scan all accounts whose VR is different than upline, if any of the VR >= -50 then mark the account as Manually Updated
		Export the list of account with their VR setting, provide to Jonathan.
	Run at: CustDB@DBCUST 
*/
USE CustDB
GO

SELECT main.CustID
	, ci.username
	, CASE WHEN main.RoleID = 1 THEN 'Member' 
			WHEN main.RoleID = 2 THEN 'Agent' 
			WHEN main.RoleID = 3 THEN 'Master'
			WHEN main.RoleID = 4 THEN 'Super'
		END AS [Level]
	, s.Username Super
	, m.Username [Master]
	, a.Username Agent
	, VRValue_HDPLive = HDPLive.Value
	, VRValue_HDPNonLive = HDPNonLive.Value
	, VRValue_OULive = OULive.Value
	, VRValue_OUNonLive = OUNonLive.Value
	, VRValue_OELive = OELive.Value
	, VRValue_OENonLive = OENonLive.Value
	, VRValue_MNLive = MNLive.Value
	, VRValue_MNNonLive = MNNonLive.Value 
	, main.srecommend, main.mrecommend, main.recommend
FROM [BasketBallVR_Temp] main WITH(NOLOCK) 
	INNER JOIN custInfo ci WITH(NOLOCK) ON main.CustID = ci.custid
	LEFT JOIN Customer a WITH(NOLOCK) ON a.custid = ci.recommend
	LEFT JOIN Customer m WITH(NOLOCK) ON m.custid = ci.mrecommend
	LEFT JOIN Customer s WITH(NOLOCK) ON s.custid = ci.srecommend
	INNER JOIN VRValueMapping HDPLive ON HDPLive.ValueID = main.VRValue_HDPLive
	INNER JOIN VRValueMapping HDPNonLive ON HDPNonLive.ValueID = main.VRValue_HDPNonLive
	INNER JOIN VRValueMapping OULive ON OULive.ValueID = main.VRValue_OULive
	INNER JOIN VRValueMapping OUNonLive ON OUNonLive.ValueID = main.VRValue_OUNonLive
	INNER JOIN VRValueMapping OELive ON OELive.ValueID = main.VRValue_OELive
	INNER JOIN VRValueMapping OENonLive ON OENonLive.ValueID = main.VRValue_OENonLive
	INNER JOIN VRValueMapping MNLive ON MNLive.ValueID = main.VRValue_MNLive
	INNER JOIN VRValueMapping MNNonLive ON MnNonLive.ValueID = main.VRValue_MNNonLive
WHERE main.IsManuallyUpdate = 1 
	AND ci.VirtualMultiplier = 1
ORDER BY main.srecommend, main.mrecommend, main.recommend,main.CustID