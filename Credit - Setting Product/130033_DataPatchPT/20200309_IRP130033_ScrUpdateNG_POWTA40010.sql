/*
	Created: 20200309@Johnson
	Task: update setting for NG for member POWTRP2100,POWTA40010[redmine: 130033]
	DB: DBCUST/CUSTDB
*/

UPDATE cs
SET spositiontaking = CASE WHEN bettype IN (81,83,86,88) THEN 0.15 ELSE spositiontaking END,
	slivepositiontaking = CASE WHEN bettype IN (85,86,87,89,90) THEN 0.15 ELSE slivepositiontaking END
FROM CustSetting3rd cs WITH(UPDLOCK,ROWLOCK)
WHERE custid IN (42147929,42152044)
	AND sporttype = 161
	