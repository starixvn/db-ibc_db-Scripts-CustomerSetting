/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Date: 2024/04/22
	Created: Helios
	Task: Seal Entertainment - Incorporate Arcade Games For Deposit [#204092] 
	DB: DBCust/CustDB
*/
CREATE TABLE #Temp_DepStakeLevelGroup (
		Sporttype		SMALLINT
	    , GameGroupID		TINYINT
	    , MinBet		MONEY
	    , MaxBet		MONEY
	    , LicenseeGroupID	TINYINT
	    PRIMARY KEY (Sporttype , GameGroupID , LicenseeGroupID)
	)


INSERT INTO #Temp_DepStakeLevelGroup 
	(
		Sporttype
	    , GameGroupID
	    , MinBet
	    , MaxBet
	    , LicenseeGroupID
	)
	 SELECT 156 AS Sporttype ,  2 AS GameGroupID ,  0.01 AS MinBet ,  50000 AS MaxBet ,  20 AS LicenseeGroupID
 UNION SELECT 156 AS Sporttype ,  2 AS GameGroupID ,  0.01 AS MinBet ,  750 AS MaxBet ,  11 AS LicenseeGroupID 
 UNION SELECT 156 AS Sporttype ,  2 AS GameGroupID ,  0.01 AS MinBet ,  2500 AS MaxBet ,  18 AS LicenseeGroupID 
 UNION SELECT 156 AS Sporttype ,  2 AS GameGroupID ,  0.01 AS MinBet ,  4000 AS MaxBet ,  5 AS LicenseeGroupID 
 UNION SELECT 156 AS Sporttype ,  2 AS GameGroupID ,  0.01 AS MinBet ,  500 AS MaxBet ,  4 AS LicenseeGroupID 
 UNION SELECT 156 AS Sporttype ,  2 AS GameGroupID ,  0.01 AS MinBet ,  7500 AS MaxBet ,  7 AS LicenseeGroupID 
 UNION SELECT 156 AS Sporttype ,  2 AS GameGroupID ,  0.01 AS MinBet ,  42500 AS MaxBet ,  15 AS LicenseeGroupID 
 UNION SELECT 156 AS Sporttype ,  2 AS GameGroupID ,  0.01 AS MinBet ,  75000 AS MaxBet ,  8 AS LicenseeGroupID 
 UNION SELECT 156 AS Sporttype ,  2 AS GameGroupID ,  0.01 AS MinBet ,  2000 AS MaxBet ,  17 AS LicenseeGroupID 
 UNION SELECT 156 AS Sporttype ,  2 AS GameGroupID ,  0.01 AS MinBet ,  500000 AS MaxBet ,  10 AS LicenseeGroupID 
 UNION SELECT 156 AS Sporttype ,  2 AS GameGroupID ,  0.01 AS MinBet ,  1000 AS MaxBet ,  16 AS LicenseeGroupID 
 UNION SELECT 156 AS Sporttype ,  2 AS GameGroupID ,  0.01 AS MinBet ,  7500 AS MaxBet ,  12 AS LicenseeGroupID 
 UNION SELECT 156 AS Sporttype ,  2 AS GameGroupID ,  0.01 AS MinBet ,  2500 AS MaxBet ,  1 AS LicenseeGroupID 
 UNION SELECT 156 AS Sporttype ,  2 AS GameGroupID ,  0.01 AS MinBet ,  60000 AS MaxBet ,  9 AS LicenseeGroupID 
 UNION SELECT 156 AS Sporttype ,  2 AS GameGroupID ,  0.01 AS MinBet ,  50000 AS MaxBet ,  14 AS LicenseeGroupID 
 UNION SELECT 156 AS Sporttype ,  2 AS GameGroupID ,  0.01 AS MinBet ,  17500 AS MaxBet ,  3 AS LicenseeGroupID 
 UNION SELECT 156 AS Sporttype ,  2 AS GameGroupID ,  0.01 AS MinBet ,  500 AS MaxBet ,  2 AS LicenseeGroupID 
 UNION SELECT 156 AS Sporttype ,  2 AS GameGroupID ,  0.01 AS MinBet ,  12500 AS MaxBet ,  13 AS LicenseeGroupID 
 UNION SELECT 156 AS Sporttype ,  2 AS GameGroupID ,  0.01 AS MinBet ,  500 AS MaxBet ,  6 AS LicenseeGroupID 
 UNION SELECT 156 AS Sporttype ,  2 AS GameGroupID ,  0.01 AS MinBet ,  175000 AS MaxBet ,  23 AS LicenseeGroupID 



 --SELECT *
 --FROM #Temp_DepStakeLevelGroup
 IF NOT EXISTS (SELECT 1
		    FROM Dep_ProductStakeLevelGroup pslg WITH (NOLOCK)
		    INNER JOIN #Temp_DepStakeLevelGroup tslg ON pslg.Sporttype = tslg.Sporttype AND pslg.GameGroupID = tslg.GameGroupID AND pslg.LicenseeGroupID = tslg.LicenseeGroupID AND pslg.SiteID = 0)

BEGIN
	INSERT INTO Dep_ProductStakeLevelGroup 
	(
		Sporttype
	    , GameGroupID
	    , MinBet
	    , MaxBet
	    , LicenseeGroupID
	    , Remark
	    , RepUpdateTime
	    , isDeleted
	    , SiteID
	)
	SELECT 
		Sporttype
	    , GameGroupID
	    , MinBet
	    , MaxBet
	    , LicenseeGroupID
	    , NULL
	    , SYSDATETIME ()
	    , 0
	    , 0
	FROM #Temp_DepStakeLevelGroup
END


 DROP TABLE #Temp_DepStakeLevelGroup