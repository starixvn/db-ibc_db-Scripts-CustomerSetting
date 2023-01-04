/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20230104@Winfred
	Task : NAP CM -  Limit Monthly PT Update [Redmine: #182469]
	DB:  DBCUST/CustDB 
*/
USE CustDB
GO

INSERT INTO LimitPTDailySetting (ProductID, CustID, Currency, SiteID, MaxCount, Type, SettingStatus)
SELECT 18 AS ProductID, CustID, Currency, SiteID, MaxCount, Type, SettingStatus
FROM LimitPTDailySetting a WITH (NOLOCK)
WHERE NOT EXISTS( SELECT TOP 1 1 FROM LimitPTDailySetting WITH (NOLOCK)
				  WHERE ProductID = 18 AND  CustID = a.CustID AND Currency = a.Currency AND SiteID	 = a.SiteID
						)
AND ProductID = 22

