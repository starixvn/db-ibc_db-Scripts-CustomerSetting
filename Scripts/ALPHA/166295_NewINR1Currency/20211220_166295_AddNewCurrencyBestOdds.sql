/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created:	Winfred
	Date:		20211220
	Task:		Set up New Currency INR1 for BEST-ODDS RedmineID:#166295
	DB:			DBCust/CustDB
*/

DECLARE @ToCurrency INT, @site INT, @ToStakeLevelID INT, @ResourceId INT, @GameTypeID INT, @Type TINYINT, @GameGroupID INT ,@FromStakeLevelID INT,@MinStake DECIMAL(19,8)

SELECT	@ToCurrency = 10 ,  -- INR1
		@site = 1 -- BEST-ODDS

-------------ProductStatusSiteCurrency
DELETE ProductStatusSiteCurrency WHERE Currency = @ToCurrency AND SiteID = @site

INSERT INTO ProductStatusSiteCurrency (SportType,BetType,Currency,SiteID,IsHidden,IsDisabled,HasSynced)
SELECT 171 AS SportType,3801 AS BetType,@ToCurrency AS Currency, @site AS SiteID, 0 AS IsHidden,0 AS IsDisabled,1 AS HasSynced
UNION ALL
SELECT 200 AS SportType,1611 AS BetType,@ToCurrency AS Currency, @site AS SiteID, 0 AS IsHidden,0 AS IsDisabled,1 AS HasSynced
UNION ALL
SELECT 219 AS SportType,1011 AS BetType,@ToCurrency AS Currency, @site AS SiteID, 1 AS IsHidden,1 AS IsDisabled,1 AS HasSynced
