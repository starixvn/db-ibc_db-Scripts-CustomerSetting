/*
	Created: 20200121@Eden
	Task: Delete all rows of VRCustSetting table which VR values follow parent
	RM: #121876
	DB: DBCUST/CustDB
*/

DELETE
FROM VRCustSetting WITH(ROWLOCK)
WHERE ValueIDLIVE = 0 AND ValueIDNonLIVE = 0