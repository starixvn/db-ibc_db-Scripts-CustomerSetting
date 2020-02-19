/*
	Created: 20200121@Eden
	Task: Delete all rows of VRCustSetting table which VR values follow parent
	RM: #121876
	DB: DBCUST/CustDB
*/
---------Step 1-------------
ALTER PROCEDURE [Acc_CustSetting3rd_19] 
AS	
BEGIN	
	DELETE
	FROM VRCustSetting WITH(ROWLOCK)
	WHERE ValueIDLIVE = 0 AND ValueIDNonLIVE = 0
END
GO
-------------Step 2---------
EXEC [Acc_CustSetting3rd_19] 
GO