--if some bet type groups = -50, then keep all setting of the member unchanged. Export the list of these members to provide to user.
;WITH TMP AS(
SELECT main.CustID
	, ci.Username
	, main.RoleID
	, main.srecommend, main.mrecommend, main.recommend
	, VRValue_HDPLive = HDPLive.Value
	, VRValue_HDPNonLive = HDPNonLive.Value
	, VRValue_OULive = OULive.Value
	, VRValue_OUNonLive = OUNonLive.Value
	, VRValue_OELive = OELive.Value
	, VRValue_OENonLive = OENonLive.Value
	, VRValue_MNLive = MNLive.Value
	, VRValue_MNNonLive = MNNonLive.Value 
FROM [BasketBallVR_Temp] main WITH(NOLOCK) 
	INNER JOIN Customer ci WITH(NOLOCK) ON ci.custid = main.CustID
	INNER JOIN Customer s WITH(NOLOCK) ON s.custid = main.srecommend
	INNER JOIN VRValueMapping HDPLive ON HDPLive.ValueID = main.VRValue_HDPLive
	INNER JOIN VRValueMapping HDPNonLive ON HDPNonLive.ValueID = main.VRValue_HDPNonLive
	INNER JOIN VRValueMapping OULive ON OULive.ValueID = main.VRValue_OULive
	INNER JOIN VRValueMapping OUNonLive ON OUNonLive.ValueID = main.VRValue_OUNonLive
	INNER JOIN VRValueMapping OELive ON OELive.ValueID = main.VRValue_OELive
	INNER JOIN VRValueMapping OENonLive ON OENonLive.ValueID = main.VRValue_OENonLive
	INNER JOIN VRValueMapping MNLive ON MNLive.ValueID = main.VRValue_MNLive
	INNER JOIN VRValueMapping MNNonLive ON MnNonLive.ValueID = main.VRValue_MNNonLive
WHERE s.site =  'IBO' AND main.RoleID = 1
)
SELECT t.*
FROM TMP t
WHERE (VRValue_HDPLive =0.5 
		OR VRValue_HDPNonLive =0.5 
		OR VRValue_OULive =0.5 
		OR VRValue_OUNonLive =0.5 
		OR VRValue_OELive =0.5 
		OR VRValue_OENonLive =0.5 
		OR VRValue_MNLive =0.5 
		OR VRValue_MNNonLive =0.5 
)
ORDER BY srecommend,mrecommend,recommend
