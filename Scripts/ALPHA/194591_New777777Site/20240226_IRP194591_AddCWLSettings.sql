/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240226@Johnson
	Task: Add CWL settings for new site 777777
	DB: DBCUST/CustDB
*/

DECLARE @siteID INT, @siteID2 INT, @FollowedSite INT, @Currency INT, @FollowedCurrency INT

SELECT @siteID = SiteID 
FROM Site WITH(NOLOCK)
WHERE site = '777777'

SELECT @FollowedSite = SiteID 
FROM Site WITH(NOLOCK)
WHERE site = '733333'

SELECT @Currency = ExchangeId--PC
FROM exchange WITH(NOLOCK)
WHERE currency = 'PC'

SELECT @FollowedCurrency = ExchangeId
FROM exchange WITH(NOLOCK)
WHERE currency = 'RM'
		
--insert cwl settings for new currency for all sites
INSERT INTO dbo.WinLimit_ProductSettingDetail(ProductID, GroupID, ExchangeID, SiteID, LevelID, MaxWinLimit, IsBlockedPlaceBet, IsBlockedTransfer, MaxWinLimit_RM, IsSuspendedAccount)
SELECT ProductID, GroupID, @Currency, p.siteID, LevelID, 
		ROUND(MaxWinLimit_RM / e.actualrate,2) MaxWinLimit, 
		IsBlockedPlaceBet, IsBlockedTransfer, MaxWinLimit_RM, IsSuspendedAccount
FROM WinLimit_ProductSettingDetail p WITH (NOLOCK)	
	CROSS APPLY (SELECT actualrate
				FROM exchange 
				WHERE ExchangeId = @Currency 				 
				) e			
WHERE p.ExchangeID = @FollowedCurrency
	AND NOT EXISTS (SELECT 1
					FROM WinLimit_ProductSettingDetail p1 WITH (NOLOCK)	
					WHERE p1.ExchangeID = @Currency
						AND p1.SiteID = p.siteID
						AND p.ProductID = p1.ProductID
						AND p.GroupID = p1.GroupID
						AND p.LevelID = p1.LevelID
					)
	AND SiteID IN (SELECT SiteID 
					FROM Site (NOLOCK)		
					WHERE isActive = 1 AND isLicensee = 0 
					)
					
--insert cwl settings for site 777777 for all currencies					
INSERT INTO dbo.WinLimit_ProductSettingDetail(ProductID, GroupID, ExchangeID, SiteID, LevelID, MaxWinLimit, IsBlockedPlaceBet, IsBlockedTransfer, MaxWinLimit_RM, IsSuspendedAccount)
SELECT ProductID, GroupID, ExchangeID, @siteID, LevelID,MaxWinLimit,IsBlockedPlaceBet, IsBlockedTransfer, MaxWinLimit_RM, IsSuspendedAccount
FROM WinLimit_ProductSettingDetail p WITH (NOLOCK)				
WHERE p.siteID = @FollowedSite
	AND NOT EXISTS (SELECT 1
					FROM WinLimit_ProductSettingDetail p1 WITH (NOLOCK)	
					WHERE p1.ExchangeID = p.ExchangeID
						AND p1.SiteID = @siteID
						AND p.ProductID = p1.ProductID
						AND p.GroupID = p1.GroupID
						AND p.LevelID = p1.LevelID
					)

SELECT @siteID2 = SiteID 
FROM Site WITH(NOLOCK)
WHERE site = '7a5555'	

--insert cwl settings for site 777777 for all currencies					
INSERT INTO dbo.WinLimit_ProductSettingDetail(ProductID, GroupID, ExchangeID, SiteID, LevelID, MaxWinLimit, IsBlockedPlaceBet, IsBlockedTransfer, MaxWinLimit_RM, IsSuspendedAccount)
SELECT ProductID, GroupID, ExchangeID, @siteID2, LevelID,MaxWinLimit,IsBlockedPlaceBet, IsBlockedTransfer, MaxWinLimit_RM, IsSuspendedAccount
FROM WinLimit_ProductSettingDetail p WITH (NOLOCK)				
WHERE p.siteID = @FollowedSite
	AND NOT EXISTS (SELECT 1
					FROM WinLimit_ProductSettingDetail p1 WITH (NOLOCK)	
					WHERE p1.ExchangeID = p.ExchangeID
						AND p1.SiteID = @siteID2
						AND p.ProductID = p1.ProductID
						AND p.GroupID = p1.GroupID
						AND p.LevelID = p1.LevelID
					)