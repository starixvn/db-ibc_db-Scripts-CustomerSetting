/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Luke
	Date: 20230905
	Task: WM Live Casino - Remove the USD(US$, Yen, $US, UT, USD) bet limit 30-3000 _CREDIT_ [Redmine: #193586]
	DB: DBCUST/CustDB
*/
USE CustDB 
GO
DECLARE @minStake DECIMAL(19,8) = 30
		,@maxStake DECIMAL(19,8) = 3000
		,@GameTypeID INT = 3401

DELETE 
FROM StakeLevel WITH (ROWLOCK)
WHERE GameTypeID = @GameTypeID
		AND MinStake = @minStake
		AND MaxStake = @maxStake
		AND ExchangeId IN (3, 11, 16, 35, 64, 95) -- US$, USTM, Yen, $US, UT, USD

