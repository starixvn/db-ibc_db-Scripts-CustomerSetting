/*
	Created: Winnie
	Date: 2018-05-07
	Task: Insert ProductBetSetting for Keno UAT [RedmineID:#92878]
	DB: DBCUST/CUSTDB
*/

INSERT INTO ProductBetSetting (Sporttype, Bettype, Currency, MinBet, IsDep) 
SELECT Sporttype, 1524, Currency, MinBet, IsDep
from ProductBetSetting(NOLOCK)  where Sporttype=202 and Bettype=1515 AND Currency=20

INSERT INTO ProductBetSetting (Sporttype, Bettype, Currency, MinBet, IsDep) 
SELECT Sporttype, 1519, Currency, MinBet, IsDep
from ProductBetSetting(NOLOCK)  where Sporttype=202 and Bettype=1515 AND Currency=20

INSERT INTO ProductBetSetting (Sporttype, Bettype, Currency, MinBet, IsDep) 
SELECT Sporttype, 1520, Currency, MinBet, IsDep
from ProductBetSetting(NOLOCK)  where Sporttype=202 and Bettype=1515 AND Currency=20

INSERT INTO ProductBetSetting (Sporttype, Bettype, Currency, MinBet, IsDep) 
SELECT Sporttype, 1521, Currency, MinBet, IsDep
from ProductBetSetting(NOLOCK)  where Sporttype=202 and Bettype=1515 AND Currency=20

INSERT INTO ProductBetSetting (Sporttype, Bettype, Currency, MinBet, IsDep) 
SELECT Sporttype, 1522, Currency, MinBet, IsDep
from ProductBetSetting(NOLOCK)  where Sporttype=202 and Bettype=1515 AND Currency=20

INSERT INTO ProductBetSetting (Sporttype, Bettype, Currency, MinBet, IsDep) 
SELECT Sporttype, 1517, Currency, MinBet, IsDep
from ProductBetSetting(NOLOCK)  where Sporttype=202 and Bettype=1515 AND Currency=20


