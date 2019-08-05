/*
	Created: 20190727@Elodie
	Task: Update global MaxBet AND MaxPerEvent for CN88
	DB: DBCUST/CustDB
*/
USE CustDB
GO

UPDATE pb 
SET pb.MaxPerEvent = 1100000, 
	pb.MaxBet = 330000
FROM CS_ProductBetSetting pb WITH (ROWLOCK)
WHERE SportType IN (1) AND BetType IN (1,5)

UPDATE pb 
SET pb.MaxPerEvent = 220000, 
	pb.MaxBet = 55000
FROM CS_ProductBetSetting pb WITH (ROWLOCK)
WHERE SportType = 1 AND BetType = 9999

UPDATE pb 
SET pb.MaxPerEvent = 1100000, 
	pb.MaxBet = 330000
FROM CS_ProductBetSetting pb WITH (ROWLOCK)
WHERE SportType IN (2,99) AND BetType IN (1)

UPDATE pb 
SET pb.MaxPerEvent = 220000, 
	pb.MaxBet = 55000
FROM CS_ProductBetSetting pb WITH (ROWLOCK)
WHERE SportType = 2 AND BetType = 20

UPDATE pb 
SET pb.MaxPerEvent = 110000, 
	pb.MaxBet = 55000
FROM CS_ProductBetSetting pb WITH (ROWLOCK)
WHERE SportType IN (2,99,9999) AND BetType IN (9999,10)

UPDATE pb 
SET pb.MaxPerEvent = 220000, 
	pb.MaxBet = 55000
FROM CS_ProductBetSetting pb WITH (ROWLOCK)
WHERE SportType = 99 AND BetType = 5

UPDATE pb 
SET pb.MaxPerEvent = 250000, 
	pb.MaxBet = 20000
FROM CS_ProductBetSetting pb WITH (ROWLOCK)
WHERE SportType = 9998

UPDATE pb 
SET pb.MaxPerEvent = MaxPerEvent/10, 
	pb.MaxBet = MaxBet/10
FROM CS_ProductBetSetting pb WITH (ROWLOCK)
WHERE Currency = 20

SELECT *
FROM CS_ProductBetSetting pb WITH (NOLOCK)
WHERE pb.Currency <> 20
