/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 2024012@Helios
	Task: Unify Live Casino & RNG slot/RNG Casino - Initial StakeLevel FGG, SABA.games, Saba Casino for REAL Currency [#198960]
		https://nexdev.net/issues/198960
	DB: DBCust/CustDB  
*/

	
	CREATE TABLE #Temp_StakeLevel
	(
		StakeLevelID		INT,
		GameTypeID			INT,
		MinLabel			NVARCHAR(50),
		MaxLabel			NVARCHAR(50),
		MinStake			DECIMAL(19,8),
		MaxStake			DECIMAL(19,8),
		ExchangeID			INT,
		ResourceID			VARCHAR(20),
		GameGroupID			INT
	)
	

	INSERT INTO #Temp_StakeLevel  
	(
		--StakeLevelID
	      GameTypeID
	    , MinLabel
	    , MaxLabel
	    , MinStake
	    , MaxStake
	    , ExchangeID
	    , ResourceID
	    , GameGroupID
	)


		SELECT 8201  AS GameTypeID  ,  '10'  AS MinLabel  , '1,000'  AS MaxLabel  , 10  AS MinStake  , 1000  AS MaxStake  , 2  AS ExchangedID  , '3'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 8201  AS GameTypeID  ,  '30'  AS MinLabel  , '3,000'  AS MaxLabel  , 30  AS MinStake  , 3000  AS MaxStake  , 2  AS ExchangedID  , '5'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 8201  AS GameTypeID  ,  '50'  AS MinLabel  , '5,000'  AS MaxLabel  , 50  AS MinStake  , 5000  AS MaxStake  , 2  AS ExchangedID  , '7'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 8201  AS GameTypeID  ,  '8'  AS MinLabel  , '300'  AS MaxLabel  , 8  AS MinStake  , 300  AS MaxStake  , 3  AS ExchangedID  , '3'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 8201  AS GameTypeID  ,  '20'  AS MinLabel  , '1,000'  AS MaxLabel  , 20  AS MinStake  , 1000  AS MaxStake  , 3  AS ExchangedID  , '5'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 8201  AS GameTypeID  ,  '40'  AS MinLabel  , '2,000'  AS MaxLabel  , 40  AS MinStake  , 2000  AS MaxStake  , 3  AS ExchangedID  , '7'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 8201  AS GameTypeID  ,  '10'  AS MinLabel  , '1,000'  AS MaxLabel  , 10  AS MinStake  , 1000  AS MaxStake  , 5  AS ExchangedID  , '1'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 8201  AS GameTypeID  ,  '50'  AS MinLabel  , '1,500'  AS MaxLabel  , 50  AS MinStake  , 1500  AS MaxStake  , 5  AS ExchangedID  , '3'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 8201  AS GameTypeID  ,  '100'  AS MinLabel  , '5,000'  AS MaxLabel  , 100  AS MinStake  , 5000  AS MaxStake  , 5  AS ExchangedID  , '5'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 8201  AS GameTypeID  ,  '8'  AS MinLabel  , '300'  AS MaxLabel  , 8  AS MinStake  , 300  AS MaxStake  , 6  AS ExchangedID  , '3'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 8201  AS GameTypeID  ,  '20'  AS MinLabel  , '1,000'  AS MaxLabel  , 20  AS MinStake  , 1000  AS MaxStake  , 6  AS ExchangedID  , '5'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 8201  AS GameTypeID  ,  '50'  AS MinLabel  , '1,500'  AS MaxLabel  , 50  AS MinStake  , 1500  AS MaxStake  , 13  AS ExchangedID  , '3'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 8201  AS GameTypeID  ,  '100'  AS MinLabel  , '5,000'  AS MaxLabel  , 100  AS MinStake  , 5000  AS MaxStake  , 13  AS ExchangedID  , '5'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 8201  AS GameTypeID  ,  '200'  AS MinLabel  , '10,000'  AS MaxLabel  , 200  AS MinStake  , 10000  AS MaxStake  , 13  AS ExchangedID  , '7'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 8201  AS GameTypeID  ,  '100'  AS MinLabel  , '10,000'  AS MaxLabel  , 100  AS MinStake  , 10000  AS MaxStake  , 14  AS ExchangedID  , '6'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 8201  AS GameTypeID  ,  '8'  AS MinLabel  , '300'  AS MaxLabel  , 8  AS MinStake  , 300  AS MaxStake  , 16  AS ExchangedID  , '3'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 8201  AS GameTypeID  ,  '20'  AS MinLabel  , '1,000'  AS MaxLabel  , 20  AS MinStake  , 1000  AS MaxStake  , 16  AS ExchangedID  , '5'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 8201  AS GameTypeID  ,  '40'  AS MinLabel  , '2,000'  AS MaxLabel  , 40  AS MinStake  , 2000  AS MaxStake  , 16  AS ExchangedID  , '7'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 8201  AS GameTypeID  ,  '8'  AS MinLabel  , '300'  AS MaxLabel  , 8  AS MinStake  , 300  AS MaxStake  , 35  AS ExchangedID  , '3'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 8201  AS GameTypeID  ,  '20'  AS MinLabel  , '1,000'  AS MaxLabel  , 20  AS MinStake  , 1000  AS MaxStake  , 35  AS ExchangedID  , '5'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 8201  AS GameTypeID  ,  '40'  AS MinLabel  , '2,000'  AS MaxLabel  , 40  AS MinStake  , 2000  AS MaxStake  , 35  AS ExchangedID  , '7'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 8201  AS GameTypeID  ,  '2000'  AS MinLabel  , '200,000'  AS MaxLabel  , 2000  AS MinStake  , 200000  AS MaxStake  , 45  AS ExchangedID  , '3'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 8201  AS GameTypeID  ,  '5000'  AS MinLabel  , '500,000'  AS MaxLabel  , 5000  AS MinStake  , 500000  AS MaxStake  , 45  AS ExchangedID  , '5'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 8201  AS GameTypeID  ,  '10000'  AS MinLabel  , '1,000,000'  AS MaxLabel  , 10000  AS MinStake  , 1000000  AS MaxStake  , 45  AS ExchangedID  , '7'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 2101  AS GameTypeID  ,  '0.1'  AS MinLabel  , '2,500'  AS MaxLabel  , 0.1  AS MinStake  , 2500  AS MaxStake  , 2  AS ExchangedID  , '34'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 2101  AS GameTypeID  ,  '0.1'  AS MinLabel  , '5,000'  AS MaxLabel  , 0.1  AS MinStake  , 5000  AS MaxStake  , 2  AS ExchangedID  , '36'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 8201  AS GameTypeID  ,  '8'  AS MinLabel  , '300'  AS MaxLabel  , 8  AS MinStake  , 300  AS MaxStake  , 64  AS ExchangedID  , '3'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 8201  AS GameTypeID  ,  '20'  AS MinLabel  , '1,000'  AS MaxLabel  , 20  AS MinStake  , 1000  AS MaxStake  , 64  AS ExchangedID  , '5'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 8201  AS GameTypeID  ,  '40'  AS MinLabel  , '2,000'  AS MaxLabel  , 40  AS MinStake  , 2000  AS MaxStake  , 64  AS ExchangedID  , '7'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 8201  AS GameTypeID  ,  '10'  AS MinLabel  , '1,000'  AS MaxLabel  , 10  AS MinStake  , 1000  AS MaxStake  , 67  AS ExchangedID  , '1'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 8201  AS GameTypeID  ,  '50'  AS MinLabel  , '1,500'  AS MaxLabel  , 50  AS MinStake  , 1500  AS MaxStake  , 67  AS ExchangedID  , '3'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 8201  AS GameTypeID  ,  '100'  AS MinLabel  , '5,000'  AS MaxLabel  , 100  AS MinStake  , 5000  AS MaxStake  , 67  AS ExchangedID  , '5'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 8201  AS GameTypeID  ,  '5'  AS MinLabel  , '500'  AS MaxLabel  , 5  AS MinStake  , 500  AS MaxStake  , 69  AS ExchangedID  , '3'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 8201  AS GameTypeID  ,  '20'  AS MinLabel  , '1,000'  AS MaxLabel  , 20  AS MinStake  , 1000  AS MaxStake  , 69  AS ExchangedID  , '5'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 8201  AS GameTypeID  ,  '100'  AS MinLabel  , '3,000'  AS MaxLabel  , 100  AS MinStake  , 3000  AS MaxStake  , 69  AS ExchangedID  , '7'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 1611  AS GameTypeID  ,  '0.1'  AS MinLabel  , '3,000'  AS MaxLabel  , 0.1  AS MinStake  , 3000  AS MaxStake  , 3  AS ExchangedID  , '13'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 2101  AS GameTypeID  ,  '0.1'  AS MinLabel  , '500'  AS MaxLabel  , 0.1  AS MinStake  , 500  AS MaxStake  , 3  AS ExchangedID  , '34'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 2101  AS GameTypeID  ,  '0.1'  AS MinLabel  , '1,000'  AS MaxLabel  , 0.1  AS MinStake  , 1000  AS MaxStake  , 3  AS ExchangedID  , '36'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 8201  AS GameTypeID  ,  '8'  AS MinLabel  , '300'  AS MaxLabel  , 8  AS MinStake  , 300  AS MaxStake  , 95  AS ExchangedID  , '3'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 8201  AS GameTypeID  ,  '20'  AS MinLabel  , '1,000'  AS MaxLabel  , 20  AS MinStake  , 1000  AS MaxStake  , 95  AS ExchangedID  , '5'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 8201  AS GameTypeID  ,  '40'  AS MinLabel  , '2,000'  AS MaxLabel  , 40  AS MinStake  , 2000  AS MaxStake  , 95  AS ExchangedID  , '7'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 1611  AS GameTypeID  ,  '0.1'  AS MinLabel  , '3,000'  AS MaxLabel  , 0.1  AS MinStake  , 3000  AS MaxStake  , 16  AS ExchangedID  , '13'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 2101  AS GameTypeID  ,  '0.1'  AS MinLabel  , '2,500'  AS MaxLabel  , 0.1  AS MinStake  , 2500  AS MaxStake  , 5  AS ExchangedID  , '34'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 2101  AS GameTypeID  ,  '0.1'  AS MinLabel  , '5,000'  AS MaxLabel  , 0.1  AS MinStake  , 5000  AS MaxStake  , 5  AS ExchangedID  , '36'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 1611  AS GameTypeID  ,  '0.1'  AS MinLabel  , '3,000'  AS MaxLabel  , 0.1  AS MinStake  , 3000  AS MaxStake  , 35  AS ExchangedID  , '13'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 1611  AS GameTypeID  ,  '0.1'  AS MinLabel  , '3,000'  AS MaxLabel  , 0.1  AS MinStake  , 3000  AS MaxStake  , 64  AS ExchangedID  , '13'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 2101  AS GameTypeID  ,  '0.1'  AS MinLabel  , '2,000'  AS MaxLabel  , 0.1  AS MinStake  , 2000  AS MaxStake  , 13  AS ExchangedID  , '34'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 2101  AS GameTypeID  ,  '0.1'  AS MinLabel  , '3,500'  AS MaxLabel  , 0.1  AS MinStake  , 3500  AS MaxStake  , 13  AS ExchangedID  , '36'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 2101  AS GameTypeID  ,  '0.1'  AS MinLabel  , '8,000'  AS MaxLabel  , 0.1  AS MinStake  , 8000  AS MaxStake  , 15  AS ExchangedID  , '34'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 2101  AS GameTypeID  ,  '0.1'  AS MinLabel  , '15,000'  AS MaxLabel  , 0.1  AS MinStake  , 15000  AS MaxStake  , 15  AS ExchangedID  , '36'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 2101  AS GameTypeID  ,  '0.1'  AS MinLabel  , '500'  AS MaxLabel  , 0.1  AS MinStake  , 500  AS MaxStake  , 16  AS ExchangedID  , '34'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 2101  AS GameTypeID  ,  '0.1'  AS MinLabel  , '1,000'  AS MaxLabel  , 0.1  AS MinStake  , 1000  AS MaxStake  , 16  AS ExchangedID  , '36'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 8201  AS GameTypeID  ,  '20'  AS MinLabel  , '2,000'  AS MaxLabel  , 20  AS MinStake  , 2000  AS MaxStake  , 15  AS ExchangedID  , '1'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 8201  AS GameTypeID  ,  '200'  AS MinLabel  , '10,000'  AS MaxLabel  , 200  AS MinStake  , 10000  AS MaxStake  , 15  AS ExchangedID  , '5'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 8201  AS GameTypeID  ,  '400'  AS MinLabel  , '20,000'  AS MaxLabel  , 400  AS MinStake  , 20000  AS MaxStake  , 15  AS ExchangedID  , '7'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 8201  AS GameTypeID  ,  '35'  AS MinLabel  , '3,500'  AS MaxLabel  , 35  AS MinStake  , 3500  AS MaxStake  , 51  AS ExchangedID  , '1'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 1611  AS GameTypeID  ,  '0.1'  AS MinLabel  , '3,000'  AS MaxLabel  , 0.1  AS MinStake  , 3000  AS MaxStake  , 95  AS ExchangedID  , '13'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 2101  AS GameTypeID  ,  '0.1'  AS MinLabel  , '8,000'  AS MaxLabel  , 0.1  AS MinStake  , 8000  AS MaxStake  , 22  AS ExchangedID  , '34'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 2101  AS GameTypeID  ,  '0.1'  AS MinLabel  , '15,000'  AS MaxLabel  , 0.1  AS MinStake  , 15000  AS MaxStake  , 22  AS ExchangedID  , '36'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 2101  AS GameTypeID  ,  '0.1'  AS MinLabel  , '8,000'  AS MaxLabel  , 0.1  AS MinStake  , 8000  AS MaxStake  , 33  AS ExchangedID  , '34'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 8201  AS GameTypeID  ,  '20'  AS MinLabel  , '2,000'  AS MaxLabel  , 20  AS MinStake  , 2000  AS MaxStake  , 22  AS ExchangedID  , '1'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 2101  AS GameTypeID  ,  '0.1'  AS MinLabel  , '15,000'  AS MaxLabel  , 0.1  AS MinStake  , 15000  AS MaxStake  , 33  AS ExchangedID  , '36'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 8201  AS GameTypeID  ,  '200'  AS MinLabel  , '10,000'  AS MaxLabel  , 200  AS MinStake  , 10000  AS MaxStake  , 22  AS ExchangedID  , '5'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 8201  AS GameTypeID  ,  '400'  AS MinLabel  , '20,000'  AS MaxLabel  , 400  AS MinStake  , 20000  AS MaxStake  , 22  AS ExchangedID  , '7'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 8201  AS GameTypeID  ,  '20'  AS MinLabel  , '2,000'  AS MaxLabel  , 20  AS MinStake  , 2000  AS MaxStake  , 33  AS ExchangedID  , '1'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 2101  AS GameTypeID  ,  '0.1'  AS MinLabel  , '8,000'  AS MaxLabel  , 0.1  AS MinStake  , 8000  AS MaxStake  , 34  AS ExchangedID  , '34'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 2101  AS GameTypeID  ,  '0.1'  AS MinLabel  , '15,000'  AS MaxLabel  , 0.1  AS MinStake  , 15000  AS MaxStake  , 34  AS ExchangedID  , '36'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 8201  AS GameTypeID  ,  '200'  AS MinLabel  , '10,000'  AS MaxLabel  , 200  AS MinStake  , 10000  AS MaxStake  , 33  AS ExchangedID  , '5'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 8201  AS GameTypeID  ,  '400'  AS MinLabel  , '20,000'  AS MaxLabel  , 400  AS MinStake  , 20000  AS MaxStake  , 33  AS ExchangedID  , '7'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 8201  AS GameTypeID  ,  '20'  AS MinLabel  , '2,000'  AS MaxLabel  , 20  AS MinStake  , 2000  AS MaxStake  , 34  AS ExchangedID  , '1'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 8201  AS GameTypeID  ,  '200'  AS MinLabel  , '10,000'  AS MaxLabel  , 200  AS MinStake  , 10000  AS MaxStake  , 34  AS ExchangedID  , '5'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 2101  AS GameTypeID  ,  '0.1'  AS MinLabel  , '500'  AS MaxLabel  , 0.1  AS MinStake  , 500  AS MaxStake  , 35  AS ExchangedID  , '34'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 2101  AS GameTypeID  ,  '0.1'  AS MinLabel  , '1,000'  AS MaxLabel  , 0.1  AS MinStake  , 1000  AS MaxStake  , 35  AS ExchangedID  , '36'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 1611  AS GameTypeID  ,  '0.1'  AS MinLabel  , '5,000'  AS MaxLabel  , 0.1  AS MinStake  , 5000  AS MaxStake  , 3  AS ExchangedID  , '20'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 8201  AS GameTypeID  ,  '400'  AS MinLabel  , '20,000'  AS MaxLabel  , 400  AS MinStake  , 20000  AS MaxStake  , 34  AS ExchangedID  , '7'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 1611  AS GameTypeID  ,  '0.1'  AS MinLabel  , '5,000'  AS MaxLabel  , 0.1  AS MinStake  , 5000  AS MaxStake  , 16  AS ExchangedID  , '20'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 2101  AS GameTypeID  ,  '0.1'  AS MinLabel  , '20,000'  AS MaxLabel  , 0.1  AS MinStake  , 20000  AS MaxStake  , 43  AS ExchangedID  , '34'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 2101  AS GameTypeID  ,  '0.1'  AS MinLabel  , '20,000'  AS MaxLabel  , 0.1  AS MinStake  , 20000  AS MaxStake  , 43  AS ExchangedID  , '36'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 8201  AS GameTypeID  ,  '50'  AS MinLabel  , '5,000'  AS MaxLabel  , 50  AS MinStake  , 5000  AS MaxStake  , 43  AS ExchangedID  , '1'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 8201  AS GameTypeID  ,  '500'  AS MinLabel  , '25,000'  AS MaxLabel  , 500  AS MinStake  , 25000  AS MaxStake  , 43  AS ExchangedID  , '5'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 8201  AS GameTypeID  ,  '1000'  AS MinLabel  , '50,000'  AS MaxLabel  , 1000  AS MinStake  , 50000  AS MaxStake  , 43  AS ExchangedID  , '7'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 2101  AS GameTypeID  ,  '0.1'  AS MinLabel  , '350,000'  AS MaxLabel  , 0.1  AS MinStake  , 350000  AS MaxStake  , 45  AS ExchangedID  , '34'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 2101  AS GameTypeID  ,  '0.1'  AS MinLabel  , '700,000'  AS MaxLabel  , 0.1  AS MinStake  , 700000  AS MaxStake  , 45  AS ExchangedID  , '36'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 2101  AS GameTypeID  ,  '0.1'  AS MinLabel  , '8,000'  AS MaxLabel  , 0.1  AS MinStake  , 8000  AS MaxStake  , 47  AS ExchangedID  , '34'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 1611  AS GameTypeID  ,  '0.1'  AS MinLabel  , '5,000'  AS MaxLabel  , 0.1  AS MinStake  , 5000  AS MaxStake  , 35  AS ExchangedID  , '20'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 2101  AS GameTypeID  ,  '0.1'  AS MinLabel  , '15,000'  AS MaxLabel  , 0.1  AS MinStake  , 15000  AS MaxStake  , 47  AS ExchangedID  , '36'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 8201  AS GameTypeID  ,  '20'  AS MinLabel  , '2,000'  AS MaxLabel  , 20  AS MinStake  , 2000  AS MaxStake  , 47  AS ExchangedID  , '1'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 8201  AS GameTypeID  ,  '200'  AS MinLabel  , '10,000'  AS MaxLabel  , 200  AS MinStake  , 10000  AS MaxStake  , 47  AS ExchangedID  , '5'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 8201  AS GameTypeID  ,  '400'  AS MinLabel  , '20,000'  AS MaxLabel  , 400  AS MinStake  , 20000  AS MaxStake  , 47  AS ExchangedID  , '7'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 8201  AS GameTypeID  ,  '350'  AS MinLabel  , '17,500'  AS MaxLabel  , 350  AS MinStake  , 17500  AS MaxStake  , 51  AS ExchangedID  , '5'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 8201  AS GameTypeID  ,  '700'  AS MinLabel  , '35,000'  AS MaxLabel  , 700  AS MinStake  , 35000  AS MaxStake  , 51  AS ExchangedID  , '7'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 1611  AS GameTypeID  ,  '0.1'  AS MinLabel  , '50,000,000'  AS MaxLabel  , 0.1  AS MinStake  , 50000000  AS MaxStake  , 72  AS ExchangedID  , '13'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 2101  AS GameTypeID  ,  '0.1'  AS MinLabel  , '6,500'  AS MaxLabel  , 0.1  AS MinStake  , 6500  AS MaxStake  , 51  AS ExchangedID  , '34'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 2101  AS GameTypeID  ,  '0.1'  AS MinLabel  , '50,000'  AS MaxLabel  , 0.1  AS MinStake  , 50000  AS MaxStake  , 51  AS ExchangedID  , '36'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 1611  AS GameTypeID  ,  '0.1'  AS MinLabel  , '5,000'  AS MaxLabel  , 0.1  AS MinStake  , 5000  AS MaxStake  , 64  AS ExchangedID  , '20'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 1611  AS GameTypeID  ,  '0.1'  AS MinLabel  , '5,000'  AS MaxLabel  , 0.1  AS MinStake  , 5000  AS MaxStake  , 95  AS ExchangedID  , '20'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 2101  AS GameTypeID  ,  '0.1'  AS MinLabel  , '500'  AS MaxLabel  , 0.1  AS MinStake  , 500  AS MaxStake  , 64  AS ExchangedID  , '34'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 2101  AS GameTypeID  ,  '0.1'  AS MinLabel  , '1,000'  AS MaxLabel  , 0.1  AS MinStake  , 1000  AS MaxStake  , 64  AS ExchangedID  , '36'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 2101  AS GameTypeID  ,  '0.1'  AS MinLabel  , '2,500'  AS MaxLabel  , 0.1  AS MinStake  , 2500  AS MaxStake  , 67  AS ExchangedID  , '34'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 2101  AS GameTypeID  ,  '0.1'  AS MinLabel  , '5,000'  AS MaxLabel  , 0.1  AS MinStake  , 5000  AS MaxStake  , 67  AS ExchangedID  , '36'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 2101  AS GameTypeID  ,  '0.1'  AS MinLabel  , '500'  AS MaxLabel  , 0.1  AS MinStake  , 500  AS MaxStake  , 69  AS ExchangedID  , '34'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 2101  AS GameTypeID  ,  '0.1'  AS MinLabel  , '1,000'  AS MaxLabel  , 0.1  AS MinStake  , 1000  AS MaxStake  , 69  AS ExchangedID  , '36'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 2101  AS GameTypeID  ,  '0.1'  AS MinLabel  , '500,000'  AS MaxLabel  , 0.1  AS MinStake  , 500000  AS MaxStake  , 72  AS ExchangedID  , '34'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 2101  AS GameTypeID  ,  '0.1'  AS MinLabel  , '1,000,000'  AS MaxLabel  , 0.1  AS MinStake  , 1000000  AS MaxStake  , 72  AS ExchangedID  , '36'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 2101  AS GameTypeID  ,  '0.1'  AS MinLabel  , '500'  AS MaxLabel  , 0.1  AS MinStake  , 500  AS MaxStake  , 95  AS ExchangedID  , '34'  AS ResourceId , 0 AS GameGroupID 
 UNION ALL  SELECT 2101  AS GameTypeID  ,  '0.1'  AS MinLabel  , '1,000'  AS MaxLabel  , 0.1  AS MinStake  , 1000  AS MaxStake  , 95  AS ExchangedID  , '36'  AS ResourceId , 0 AS GameGroupID 

	-- Remove Exchange don't need update min-max Stake
	--Saba Casino : INH (51) , YNG (72)

	DELETE FROM #Temp_StakeLevel
	WHERE GameTypeId = 2101 AND ExchangeID IN (51,72)

	--SABA.games :		   YNG (72) , USD (95)
	DELETE FROM #Temp_StakeLevel
	WHERE GameTypeId = 1611 AND ExchangeID IN (72,95)

	--FGG : Just changed of WON Currency (45)
	DELETE FROM #Temp_StakeLevel
	WHERE GameTypeId = 8201 AND ExchangeID <> 45

	-- Check Data --

	--SELECT  '#Temp_StakeLevel' AS Note , * FROM #Temp_StakeLevel tsl

	--SELECT
	--	 tem_sl.* , '________' AS '________' , sl.* 
	--	--sl.GameTypeID , COUNT(1)
	--FROM #Temp_StakeLevel tem_sl
	--INNER JOIN StakeLevel sl WITH (NOLOCK) ON tem_sl.GameTypeID = sl.GameTypeID AND tem_sl.ExchangeID = sl.ExchangeId AND tem_sl.ResourceID = sl.ResourceId
	--WHERE 
	--tem_sl.GameTypeID = 8201
	--ORDER BY sl.GameTypeID , sl.ExchangeId

	--SELECT 
	--	tem_sl.* , '________' AS '________' , sl.* 
	--	--sl.GameTypeID , COUNT(1)
	--FROM #Temp_StakeLevel tem_sl
	--INNER JOIN StakeLevel sl WITH (NOLOCK) ON tem_sl.GameTypeID = sl.GameTypeID AND tem_sl.ExchangeID = sl.ExchangeId AND tem_sl.ResourceId = sl.GameGroupID
	--WHERE 
	--tem_sl.GameTypeID <> 8201
	--ORDER BY sl.StakeLevelID

	 --End Check Data --

	-- Update  data StakeLevelID Temp Table --

	UPDATE tem_sl
		SET 
			tem_sl.StakeLevelID = sl.StakeLevelID
	FROM #Temp_StakeLevel tem_sl
	INNER JOIN StakeLevel sl WITH (NOLOCK) ON tem_sl.GameTypeID = sl.GameTypeID AND tem_sl.ExchangeID = sl.ExchangeId AND tem_sl.ResourceID = sl.ResourceId
	WHERE 
	tem_sl.GameTypeID = 8201

	UPDATE tem_sl
		SET 
			tem_sl.StakeLevelID = sl.StakeLevelID
	FROM #Temp_StakeLevel tem_sl
	INNER JOIN StakeLevel sl WITH (NOLOCK) ON tem_sl.GameTypeID = sl.GameTypeID AND tem_sl.ExchangeID = sl.ExchangeId AND tem_sl.ResourceId = sl.GameGroupID
	WHERE 
	tem_sl.GameTypeID <> 8201

	-- END Update  data StakeLevelID Temp Table --

	-- Check data Temp Table
	
	--SELECT 
	--	--tem_sl.* , '________' AS '________' , sl.*
	--	tem_sl.StakeLevelID ,
	--	tem_sl.GameTypeID ,
	--	tem_sl.MinLabel ,
	--	tem_sl.MaxLabel ,
	--	tem_sl.MinStake ,
	--	tem_sl.MaxStake ,
	--	tem_sl.ExchangeID ,
	--	e.currency,
	--	CASE
	--		WHEN tem_sl.ResourceID IN ('13','34','3') THEN 'Level 1'
	--		WHEN tem_sl.ResourceID IN ('20','36','5') THEN 'Level 2'
	--		ELSE 'Level 3'
	--	END AS [Level]
	--FROM #Temp_StakeLevel tem_sl
	--INNER JOIN StakeLevel sl ON tem_sl.StakeLevelID = sl.StakeLevelID AND tem_sl.GameTypeID = sl.GameTypeID AND tem_sl.ExchangeID = sl.ExchangeId
	--INNER JOIN exchange e ON tem_sl.ExchangeID = e.ExchangeId
	--ORDER BY tem_sl.GameTypeID , tem_sl.ExchangeID , [Level]

	-- Update StakeLevel Real Table

	UPDATE sl
		SET 
			sl.MinLabel = tem_sl.MinLabel ,
			sl.MaxLabel = tem_sl.MaxLabel ,
			sl.MinStake = tem_sl.MinStake ,
			sl.MaxStake = tem_sl.MaxStake 

	FROM #Temp_StakeLevel tem_sl
	INNER JOIN StakeLevel sl WITH (ROWLOCK , UPDLOCK) ON tem_sl.StakeLevelID = sl.StakeLevelID AND tem_sl.GameTypeID = sl.GameTypeID AND tem_sl.ExchangeID = sl.ExchangeId
	

	DROP TABLE #Temp_StakeLevel


	