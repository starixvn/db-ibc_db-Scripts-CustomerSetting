/*
	Created: Elodie
	Task: Check data after running script [RedmineID: #110111]
	DB: DBTXN/bodb02
	Date: 20190313
*/ 

USE bodb02
GO

--1. get list ticket was just settled
SELECT *
FROM bettrans b WITH (NOLOCK)
	INNER JOIN bettrans_UpdatePT_DanielTmp t WITH (NOLOCK) ON b.transid = t.transid
WHERE b.statusid NOT IN (0,1)

--2. Scan If apt does not match with awinlost trên DBtrans => update apt to match with awinlost
SELECT *
FROM bettrans b WITH (NOLOCK)
	INNER JOIN bettrans_UpdatePT_DanielTmp t WITH (NOLOCK) ON b.transid = t.transid
WHERE b.awinlost <> -(b.winlost-b.actual_stake) * b.apositiontaking