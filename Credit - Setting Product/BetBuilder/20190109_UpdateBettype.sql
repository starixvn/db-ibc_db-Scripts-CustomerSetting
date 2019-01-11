/*
	Created: Winnie
	Date: 20190108
	Task: BetBuilder, Update bettype for old products [RedmineID: #105664]
	DB: DBCust/CustDB
*/
USE [CustDB]
GO

UPDATE ProductLaunchedSiteCurrency WITH(ROWLOCK)
	SET BetType=20 
WHERE SportType=44

UPDATE ProductLaunchedSiteCurrency WITH(ROWLOCK)
	SET BetType=1600
WHERE SportType=160

UPDATE ProductLaunchedSiteCurrency WITH(ROWLOCK)
	SET BetType=1401
WHERE SportType=163

UPDATE ProductLaunchedSiteCurrency WITH(ROWLOCK)
	SET BetType=1201
WHERE SportType=180

UPDATE ProductLaunchedSiteCurrency WITH(ROWLOCK)
	SET BetType=2701
WHERE SportType=190

UPDATE ProductLaunchedSiteCurrency WITH(ROWLOCK)
	SET BetType=2701
WHERE SportType=192

UPDATE ProductLaunchedSiteCurrency WITH(ROWLOCK)
	SET BetType=2801
WHERE SportType=193

UPDATE ProductLaunchedSiteCurrency WITH(ROWLOCK)
	SET BetType=2701
WHERE SportType=194

UPDATE ProductLaunchedSiteCurrency WITH(ROWLOCK)
	SET BetType=1004
WHERE SportType=207

UPDATE ProductLaunchedSiteCurrency WITH(ROWLOCK)
	SET BetType=2401
WHERE SportType=211

UPDATE ProductLaunchedSiteCurrency WITH(ROWLOCK)
	SET BetType=1011
WHERE SportType=219

UPDATE ProductLaunchedSiteCurrency WITH(ROWLOCK)
	SET BetType=1021
WHERE SportType=220