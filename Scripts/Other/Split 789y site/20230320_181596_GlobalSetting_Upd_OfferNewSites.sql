/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20230320@Tacy
	Task: Saba Games shows on offer sites belong to sitelabel='789y' - SIT/UAT
		 https://nexdev.net/issues/181596
	Database: DBCUST/CustDB
*/
/*
	- ProductStatusSiteCurrency
	- ProductLaunchedSiteCurrency
*/
USE CustDB
GO

DECLARE @tbSite TABLE (SiteID INT)

INSERT INTO @tbSite (SiteID)
SELECT siteid
FROM Site WITH (NOLOCK)
WHERE site IN ('yUT','y789','y889','yOther')

UPDATE P
SET p.IsHidden=ps.IsHidden, p.IsDisabled=ps.IsDisabled, p.HasSynced=ps.HasSynced
FROM ProductStatusSiteCurrency P WITH (ROWLOCK, UPDLOCK)
CROSS APPLY (SELECT IsHidden, IsDisabled, HasSynced 
			 FROM ProductStatusSiteCurrency ps WITH (NOLOCK) 
			 WHERE SiteID=3
				AND ps.SportType=p.SportType
				AND ps.BetType=p.BetType
				AND PS.Currency=P.Currency) ps
WHERE SportType=200 AND SiteID IN (SELECT SiteID FROM @tbSite)
	AND p.Currency=20


UPDATE p
SET p.IsLaunched=ps.IsLaunched
FROM ProductLaunchedSiteCurrency p WITH (ROWLOCK, UPDLOCK)
CROSS APPLY (SELECT IsLaunched 
			 FROM ProductLaunchedSiteCurrency ps WITH (NOLOCK) 
			 WHERE SiteID=3
				AND ps.SportType=p.SportType
				AND ps.BetType=p.BetType
				AND PS.Currency=P.Currency
				AND ps.LaunchedLevel=p.LaunchedLevel) ps
WHERE SportType=200 AND SiteID IN (SELECT SiteID FROM @tbSite)