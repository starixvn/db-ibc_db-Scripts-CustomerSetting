/*
	Created: Winnie
	Date: 20191203
	Task: Delete existing data of Sporttype=211 bettype 2402 RedmineID:#124422
	DB: DBCust/CustDB
*/
 
 -- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB ------
------------------------------------------------------
DECLARE @maxcustid INT,@Sporttype SMALLINT,@Bettype INT 
	
SELECT @Sporttype = 211
SELECT @Bettype=2402
SELECT @maxcustid=xxx

WHILE EXISTS(SELECT TOP 1 1 CustID FROM CustStakeLevel_Agent WITH(NOLOCK)  WHERE CustID>@maxcustid AND SportType=@Sporttype AND Bettype=@Bettype)
BEGIN
	DELETE TOP (3000) FROM CustStakeLevel_Agent WITH(ROWLOCK) WHERE CustID>@maxcustid AND SportType=@Sporttype AND Bettype=@Bettype
END

WHILE EXISTS(SELECT TOP 1 1 CustID FROM CustStakeLevel_Member WITH(NOLOCK)  WHERE CustID>@maxcustid AND SportType=@Sporttype AND Bettype=@Bettype)
BEGIN
	DELETE TOP (3000) FROM CustStakeLevel_Member WITH(ROWLOCK) WHERE CustID>@maxcustid AND SportType=@Sporttype AND Bettype=@Bettype
END	