/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20250417@Helios
	Task: Alpha - Agency Cash Service - [223896]  
	DB: DBCUST-CustDB
*/

IF NOT EXISTS (SELECT TOP 1 1 FROM CustProductStatus_UAT cpsu WITH (NOLOCK) WHERE cpsu.CustID IN (14228863))
BEGIN
	INSERT INTO CustProductStatus_UAT	 
	(
		CustID
	    , bitmapHasSynced
	    , bitmapIsHidden
	    , bitmapIsDisabled
	    , SuspendInfo
	    , Locked
	    , CloseInfo
	    , RepUpdateTime
	    , ServiceType
	)
	SELECT
		CustID
	    , bitmapHasSynced
	    , bitmapIsHidden
	    , bitmapIsDisabled
	    , SuspendInfo
	    , Locked
	    , CloseInfo
	    , SYSDATETIME () AS  RepUpdateTime
	    , 1 AS ServiceType
	FROM CustProductStatus WITH (NOLOCK)
	WHERE CustID IN (14228863)
END