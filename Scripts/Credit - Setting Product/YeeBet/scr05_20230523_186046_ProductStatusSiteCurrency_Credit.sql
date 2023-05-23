/*
	Created: 20230423@Luke
	Task: Update ProductStatusSiteCurrency for YeeBet [Redmine: #186046]
	DB: DBCUST/CustDB
*/
USE CustDB
GO

DECLARE @Sporttype INT, @Bettype INT
SELECT @Sporttype = 159, @Bettype = 3151

IF EXISTS(
	SELECT 1
	FROM ProductStatusSiteCurrency WITH (NOLOCK)
	WHERE SportType = @Sporttype AND BetType = @Bettype
)
BEGIN
	RAISERROR('Data for this SportType & BetType has been initial.', 16, 1)
END
ELSE
BEGIN
	CREATE TABLE #NonOfferedCurency (Currency INT) 

	INSERT INTO #NonOfferedCurency (Currency)
	SELECT exchangeid 
	FROM exchange WITH(NOLOCK) 
	WHERE exchangeid NOT IN (2,		--RM
							3,		--US$
							5,		--HK$
							13,		--RMB
							15,		--IN
							16,		--Yen
							20,		--UUS
							22,		--IND
							33,		--IDD
							34,		--IDR
							43,		--THB
							45,		--Won
							47,		--DDD
							51,		--INH
							64,		--UT
							67,		--HKK
							69,		--MMK
							72		--YNG
					) --supported currencies
		AND OfferSite IN (0, 1) 
		AND IsActive = 1

	INSERT INTO ProductStatusSiteCurrency (SportType, BetType, SiteID, Currency, IsHidden, IsDisabled, HasSynced)
	SELECT DISTINCT @Sporttype, @Bettype, 0, Currency, 1, 1, 1  
	FROM #NonOfferedCurency WITH (NOLOCK)
END

DROP TABLE #NonOfferedCurency
