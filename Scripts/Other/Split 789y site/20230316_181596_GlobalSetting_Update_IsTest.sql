/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20230316@Tacy
	Task: Update IsTest=0 & Product status on PRO
		 https://nexdev.net/issues/181596 [RedmineID: #181596]
	Database: DBCUST/CustDB
*/
/*
	- GameLaunchPerSite
	- ProductLaunchedSiteCurrency
*/
USE CustDB
GO

DECLARE @tbSite TABLE (SiteID INT, site NVARCHAR(50))

INSERT INTO @tbSite (SiteID, site)
SELECT siteid, site
FROM Site WITH (NOLOCK)
WHERE site IN ('yUT','y789','y889','yOther')

-- GameLaunchPerSite
UPDATE p
SET p.IsTest=0
FROM GameLaunchPerSite p WITH (ROWLOCK, UPDLOCK)
WHERE p.siteid IN (SELECT SITEID FROM @tbSite)

-- ProductLaunchedSiteCurrency
UPDATE p
SET p.IsTest=0
FROM ProductLaunchedSiteCurrency p WITH (ROWLOCK, UPDLOCK)
WHERE p.siteid IN (SELECT SITEID FROM @tbSite)

--ProductStatusSiteCurrency
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
	AND p.Currency<>20