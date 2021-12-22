/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created:	Winfred
	Date:		20211222
	Task:		adjust data Leap gaming RedmineID:#166295
	DB:			DBCust/CustDB
*/

--adjust data for Leap gaming
DECLARE @Currency INT, @sportType SMALLINT,@betType SMALLINT,@productID SMALLINT 

SELECT	@Currency = 10   -- INR1
		,@sportType = 231 --Leap gaming
		,@betType = 5301  --Leap gaming
		,@productID = 42  --Saba.club


CREATE TABLE #Supers (custid INT)
INSERT INTO #Supers(custid)				
SELECT 58952555	AS custid --'HR'

UPDATE pbs
SET pbs.MinBet = 100 , pbs.MaxBet = 34000,pbs.DefaultMinBet = 100 , pbs.DefaultMaxBet = 34000
FROM ProductBetSetting pbs  WITH(ROWLOCK, UPDLOCK) 
WHERE pbs.Sporttype = @sportType AND Bettype = @betType AND pbs.Currency = @Currency 

UPDATE cba
SET cba.MinBet = 100 , cba.MaxBet = 34000
FROM CustBetSetting3rd_Agent cba  WITH(ROWLOCK, UPDLOCK) 
INNER JOIN #Supers su  ON su.custid = cba.CustID
WHERE cba.Sporttype = @sportType AND Bettype = @betType  

--remove data for Saba.club 

SELECT @sportType = 200 , @betType = 1611

UPDATE pbs
SET pbs.IsDisabled = 1
FROM ProductStatusSiteCurrency pbs  WITH(ROWLOCK, UPDLOCK) 
WHERE pbs.Sporttype = @sportType AND Bettype = @betType AND pbs.Currency = @Currency 

--Win Loss Limit
DELETE FROM WinLimit_ProductSettingDetail WITH (ROWLOCK) where ProductID = @productID and ExchangeID = @Currency

DELETE FROM CustWinLossLimit_Agent WITH (ROWLOCK) WHERE custid IN (SELECT custid from #Supers)
AND SportType = @sportType AND bettype = @betType 

--Bet Setting	
DELETE sld 
FROM StakeLevelGroupDetail sld WITH(ROWLOCK)
INNER JOIN StakeLevel sl WITH (NOLOCK) ON sld.StakeLevelID = sl.StakeLevelID
WHERE sl.ExchangeId = @Currency AND sl.GameTypeID = @betType

DELETE StakeLevel WHERE ExchangeId = @Currency AND GameTypeID = @betType
DELETE FROM dbo.CustStakeLevel_Agent WITH (ROWLOCK) WHERE custid IN (SELECT custid from #Supers)AND SportType = @sportType AND bettype = @betType 	

--PT
DELETE FROM CustPTSetting3rd_Agent WITH (ROWLOCK) WHERE custid IN (SELECT custid from #Supers) AND SportType = @sportType AND bettype = @betType 	

-- Disabe Status
CREATE TABLE #CustProductStatus(CustID int PRIMARY KEY,bitmapIsHidden binary(32), bitmapIsDisabled binary(32),isfinished BIT DEFAULT(0))

INSERT INTO #CustProductStatus(CustID,bitmapIsHidden,bitmapIsDisabled)
SELECT c.CustID
	,bitmapIsHidden = dbo.f_GenerateProductStatus (c.bitmapIsHidden,psp.bitmapOrder,1)
	,bitmapIsDisabled = dbo.f_GenerateProductStatus (c.bitmapIsDisabled,psp.bitmapOrder,1)
FROM CustProductStatus c WITH(NOLOCK)
	INNER JOIN  dbo.ProductStatusProfile psp WITH (NOLOCK) ON PSP.Bettype = @BetType AND PSP.Sporttype = @SportType
	INNER JOIN  #Supers temp ON temp.CustID = c.custid

UPDATE c 
SET  c.bitmapIsHidden = tmp.bitmapIsHidden
	,c.bitmapIsDisabled = tmp.bitmapIsDisabled
FROM CustProductStatus c WITH(ROWLOCK, UPDLOCK)
	INNER JOIN #CustProductStatus tmp ON c.CustID = tmp.CustID

DROP TABLE #CustProductStatus
DROP TABLE #SUPERS