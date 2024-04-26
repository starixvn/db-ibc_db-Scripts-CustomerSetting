

IF NOT EXISTS (SELECT 1 FROM SportNonOfferedSiteCurrency WITH (NOLOCK) WHERE SportType IN (176,208,224,245) AND Currency = 20)
BEGIN
	INSERT INTO SportNonOfferedSiteCurrency 
	(
		SportType
	    , BetType
	    , Currency
	    , SiteID
	    , RealProductID
	)
	SELECT 176 AS SportType , 8201 AS BetType,  20 AS CurrencyUD  ,  1 AS SiteID  ,  70 AS RealProductID 
UNION SELECT 176 AS SportType , 8201 AS BetType,  20 AS CurrencyUD  ,  11 AS SiteID  ,  70 AS RealProductID 
UNION SELECT 176 AS SportType , 8201 AS BetType,  20 AS CurrencyUD  ,  13 AS SiteID  ,  70 AS RealProductID 
UNION SELECT 176 AS SportType , 8201 AS BetType,  20 AS CurrencyUD  ,  16 AS SiteID  ,  70 AS RealProductID 
UNION SELECT 176 AS SportType , 8201 AS BetType,  20 AS CurrencyUD  ,  20 AS SiteID  ,  70 AS RealProductID 
UNION SELECT 176 AS SportType , 8201 AS BetType,  20 AS CurrencyUD  ,  21 AS SiteID  ,  70 AS RealProductID 
UNION SELECT 176 AS SportType , 8201 AS BetType,  20 AS CurrencyUD  ,  22 AS SiteID  ,  70 AS RealProductID 
UNION SELECT 176 AS SportType , 8201 AS BetType,  20 AS CurrencyUD  ,  23 AS SiteID  ,  70 AS RealProductID 
UNION SELECT 176 AS SportType , 8201 AS BetType,  20 AS CurrencyUD  ,  25 AS SiteID  ,  70 AS RealProductID 
UNION SELECT 176 AS SportType , 8201 AS BetType,  20 AS CurrencyUD  ,  35 AS SiteID  ,  70 AS RealProductID 
UNION SELECT 176 AS SportType , 8201 AS BetType,  20 AS CurrencyUD  ,  109 AS SiteID  ,  70 AS RealProductID 
UNION SELECT 176 AS SportType , 8201 AS BetType,  20 AS CurrencyUD  ,  147 AS SiteID  ,  70 AS RealProductID 
UNION SELECT 176 AS SportType , 8201 AS BetType,  20 AS CurrencyUD  ,  188 AS SiteID  ,  70 AS RealProductID 
UNION SELECT 176 AS SportType , 8201 AS BetType,  20 AS CurrencyUD  ,  329 AS SiteID  ,  70 AS RealProductID 
UNION SELECT 176 AS SportType , 8201 AS BetType,  20 AS CurrencyUD  ,  487 AS SiteID  ,  70 AS RealProductID 
UNION SELECT 176 AS SportType , 8201 AS BetType,  20 AS CurrencyUD  ,  547 AS SiteID  ,  70 AS RealProductID 
UNION SELECT 176 AS SportType , 8201 AS BetType,  20 AS CurrencyUD  ,  1045 AS SiteID  ,  70 AS RealProductID 
UNION SELECT 176 AS SportType , 8201 AS BetType,  20 AS CurrencyUD  ,  1046 AS SiteID  ,  70 AS RealProductID 
UNION SELECT 176 AS SportType , 8201 AS BetType,  20 AS CurrencyUD  ,  1047 AS SiteID  ,  70 AS RealProductID 
UNION SELECT 176 AS SportType , 8201 AS BetType,  20 AS CurrencyUD  ,  1048 AS SiteID  ,  70 AS RealProductID 
UNION SELECT 176 AS SportType , 8201 AS BetType,  20 AS CurrencyUD  ,  1216 AS SiteID  ,  70 AS RealProductID 
UNION SELECT 176 AS SportType , 8201 AS BetType,  20 AS CurrencyUD  ,  1233 AS SiteID  ,  70 AS RealProductID 
UNION SELECT 176 AS SportType , 8201 AS BetType,  20 AS CurrencyUD  ,  1369 AS SiteID  ,  70 AS RealProductID 
UNION SELECT 176 AS SportType , 8201 AS BetType,  20 AS CurrencyUD  ,  1370 AS SiteID  ,  70 AS RealProductID 
UNION SELECT 208 AS SportType , 2101 AS BetType,  20 AS CurrencyUD  ,  1 AS SiteID  ,  6 AS RealProductID 
UNION SELECT 208 AS SportType , 2101 AS BetType,  20 AS CurrencyUD  ,  11 AS SiteID  ,  6 AS RealProductID 
UNION SELECT 208 AS SportType , 2101 AS BetType,  20 AS CurrencyUD  ,  13 AS SiteID  ,  6 AS RealProductID 
UNION SELECT 208 AS SportType , 2101 AS BetType,  20 AS CurrencyUD  ,  16 AS SiteID  ,  6 AS RealProductID 
UNION SELECT 208 AS SportType , 2101 AS BetType,  20 AS CurrencyUD  ,  20 AS SiteID  ,  6 AS RealProductID 
UNION SELECT 208 AS SportType , 2101 AS BetType,  20 AS CurrencyUD  ,  21 AS SiteID  ,  6 AS RealProductID 
UNION SELECT 208 AS SportType , 2101 AS BetType,  20 AS CurrencyUD  ,  22 AS SiteID  ,  6 AS RealProductID 
UNION SELECT 208 AS SportType , 2101 AS BetType,  20 AS CurrencyUD  ,  23 AS SiteID  ,  6 AS RealProductID 
UNION SELECT 208 AS SportType , 2101 AS BetType,  20 AS CurrencyUD  ,  25 AS SiteID  ,  6 AS RealProductID 
UNION SELECT 208 AS SportType , 2101 AS BetType,  20 AS CurrencyUD  ,  35 AS SiteID  ,  6 AS RealProductID 
UNION SELECT 208 AS SportType , 2101 AS BetType,  20 AS CurrencyUD  ,  109 AS SiteID  ,  6 AS RealProductID 
UNION SELECT 208 AS SportType , 2101 AS BetType,  20 AS CurrencyUD  ,  147 AS SiteID  ,  6 AS RealProductID 
UNION SELECT 208 AS SportType , 2101 AS BetType,  20 AS CurrencyUD  ,  188 AS SiteID  ,  6 AS RealProductID 
UNION SELECT 208 AS SportType , 2101 AS BetType,  20 AS CurrencyUD  ,  329 AS SiteID  ,  6 AS RealProductID 
UNION SELECT 208 AS SportType , 2101 AS BetType,  20 AS CurrencyUD  ,  487 AS SiteID  ,  6 AS RealProductID 
UNION SELECT 208 AS SportType , 2101 AS BetType,  20 AS CurrencyUD  ,  547 AS SiteID  ,  6 AS RealProductID 
UNION SELECT 208 AS SportType , 2101 AS BetType,  20 AS CurrencyUD  ,  1045 AS SiteID  ,  6 AS RealProductID 
UNION SELECT 208 AS SportType , 2101 AS BetType,  20 AS CurrencyUD  ,  1046 AS SiteID  ,  6 AS RealProductID 
UNION SELECT 208 AS SportType , 2101 AS BetType,  20 AS CurrencyUD  ,  1047 AS SiteID  ,  6 AS RealProductID 
UNION SELECT 208 AS SportType , 2101 AS BetType,  20 AS CurrencyUD  ,  1048 AS SiteID  ,  6 AS RealProductID 
UNION SELECT 208 AS SportType , 2101 AS BetType,  20 AS CurrencyUD  ,  1216 AS SiteID  ,  6 AS RealProductID 
UNION SELECT 208 AS SportType , 2101 AS BetType,  20 AS CurrencyUD  ,  1233 AS SiteID  ,  6 AS RealProductID 
UNION SELECT 208 AS SportType , 2101 AS BetType,  20 AS CurrencyUD  ,  1369 AS SiteID  ,  6 AS RealProductID 
UNION SELECT 208 AS SportType , 2101 AS BetType,  20 AS CurrencyUD  ,  1370 AS SiteID  ,  6 AS RealProductID 
UNION SELECT 224 AS SportType , 5500 AS BetType,  20 AS CurrencyUD  ,  1 AS SiteID  ,  50 AS RealProductID 
UNION SELECT 224 AS SportType , 5500 AS BetType,  20 AS CurrencyUD  ,  11 AS SiteID  ,  50 AS RealProductID 
UNION SELECT 224 AS SportType , 5500 AS BetType,  20 AS CurrencyUD  ,  13 AS SiteID  ,  50 AS RealProductID 
UNION SELECT 224 AS SportType , 5500 AS BetType,  20 AS CurrencyUD  ,  16 AS SiteID  ,  50 AS RealProductID 
UNION SELECT 224 AS SportType , 5500 AS BetType,  20 AS CurrencyUD  ,  20 AS SiteID  ,  50 AS RealProductID 
UNION SELECT 224 AS SportType , 5500 AS BetType,  20 AS CurrencyUD  ,  21 AS SiteID  ,  50 AS RealProductID 
UNION SELECT 224 AS SportType , 5500 AS BetType,  20 AS CurrencyUD  ,  22 AS SiteID  ,  50 AS RealProductID 
UNION SELECT 224 AS SportType , 5500 AS BetType,  20 AS CurrencyUD  ,  23 AS SiteID  ,  50 AS RealProductID 
UNION SELECT 224 AS SportType , 5500 AS BetType,  20 AS CurrencyUD  ,  25 AS SiteID  ,  50 AS RealProductID 
UNION SELECT 224 AS SportType , 5500 AS BetType,  20 AS CurrencyUD  ,  35 AS SiteID  ,  50 AS RealProductID 
UNION SELECT 224 AS SportType , 5500 AS BetType,  20 AS CurrencyUD  ,  109 AS SiteID  ,  50 AS RealProductID 
UNION SELECT 224 AS SportType , 5500 AS BetType,  20 AS CurrencyUD  ,  147 AS SiteID  ,  50 AS RealProductID 
UNION SELECT 224 AS SportType , 5500 AS BetType,  20 AS CurrencyUD  ,  188 AS SiteID  ,  50 AS RealProductID 
UNION SELECT 224 AS SportType , 5500 AS BetType,  20 AS CurrencyUD  ,  329 AS SiteID  ,  50 AS RealProductID 
UNION SELECT 224 AS SportType , 5500 AS BetType,  20 AS CurrencyUD  ,  487 AS SiteID  ,  50 AS RealProductID 
UNION SELECT 224 AS SportType , 5500 AS BetType,  20 AS CurrencyUD  ,  547 AS SiteID  ,  50 AS RealProductID 
UNION SELECT 224 AS SportType , 5500 AS BetType,  20 AS CurrencyUD  ,  1045 AS SiteID  ,  50 AS RealProductID 
UNION SELECT 224 AS SportType , 5500 AS BetType,  20 AS CurrencyUD  ,  1046 AS SiteID  ,  50 AS RealProductID 
UNION SELECT 224 AS SportType , 5500 AS BetType,  20 AS CurrencyUD  ,  1047 AS SiteID  ,  50 AS RealProductID 
UNION SELECT 224 AS SportType , 5500 AS BetType,  20 AS CurrencyUD  ,  1048 AS SiteID  ,  50 AS RealProductID 
UNION SELECT 224 AS SportType , 5500 AS BetType,  20 AS CurrencyUD  ,  1216 AS SiteID  ,  50 AS RealProductID 
UNION SELECT 224 AS SportType , 5500 AS BetType,  20 AS CurrencyUD  ,  1233 AS SiteID  ,  50 AS RealProductID 
UNION SELECT 224 AS SportType , 5500 AS BetType,  20 AS CurrencyUD  ,  1369 AS SiteID  ,  50 AS RealProductID 
UNION SELECT 224 AS SportType , 5500 AS BetType,  20 AS CurrencyUD  ,  1370 AS SiteID  ,  50 AS RealProductID 
UNION SELECT 245 AS SportType , 4601 AS BetType,  20 AS CurrencyUD  ,  1 AS SiteID  ,  38 AS RealProductID 
UNION SELECT 245 AS SportType , 4601 AS BetType,  20 AS CurrencyUD  ,  11 AS SiteID  ,  38 AS RealProductID 
UNION SELECT 245 AS SportType , 4601 AS BetType,  20 AS CurrencyUD  ,  13 AS SiteID  ,  38 AS RealProductID 
UNION SELECT 245 AS SportType , 4601 AS BetType,  20 AS CurrencyUD  ,  16 AS SiteID  ,  38 AS RealProductID 
UNION SELECT 245 AS SportType , 4601 AS BetType,  20 AS CurrencyUD  ,  20 AS SiteID  ,  38 AS RealProductID 
UNION SELECT 245 AS SportType , 4601 AS BetType,  20 AS CurrencyUD  ,  21 AS SiteID  ,  38 AS RealProductID 
UNION SELECT 245 AS SportType , 4601 AS BetType,  20 AS CurrencyUD  ,  22 AS SiteID  ,  38 AS RealProductID 
UNION SELECT 245 AS SportType , 4601 AS BetType,  20 AS CurrencyUD  ,  23 AS SiteID  ,  38 AS RealProductID 
UNION SELECT 245 AS SportType , 4601 AS BetType,  20 AS CurrencyUD  ,  25 AS SiteID  ,  38 AS RealProductID 
UNION SELECT 245 AS SportType , 4601 AS BetType,  20 AS CurrencyUD  ,  35 AS SiteID  ,  38 AS RealProductID 
UNION SELECT 245 AS SportType , 4601 AS BetType,  20 AS CurrencyUD  ,  109 AS SiteID  ,  38 AS RealProductID 
UNION SELECT 245 AS SportType , 4601 AS BetType,  20 AS CurrencyUD  ,  147 AS SiteID  ,  38 AS RealProductID 
UNION SELECT 245 AS SportType , 4601 AS BetType,  20 AS CurrencyUD  ,  188 AS SiteID  ,  38 AS RealProductID 
UNION SELECT 245 AS SportType , 4601 AS BetType,  20 AS CurrencyUD  ,  329 AS SiteID  ,  38 AS RealProductID 
UNION SELECT 245 AS SportType , 4601 AS BetType,  20 AS CurrencyUD  ,  487 AS SiteID  ,  38 AS RealProductID 
UNION SELECT 245 AS SportType , 4601 AS BetType,  20 AS CurrencyUD  ,  547 AS SiteID  ,  38 AS RealProductID 
UNION SELECT 245 AS SportType , 4601 AS BetType,  20 AS CurrencyUD  ,  1045 AS SiteID  ,  38 AS RealProductID 
UNION SELECT 245 AS SportType , 4601 AS BetType,  20 AS CurrencyUD  ,  1046 AS SiteID  ,  38 AS RealProductID 
UNION SELECT 245 AS SportType , 4601 AS BetType,  20 AS CurrencyUD  ,  1047 AS SiteID  ,  38 AS RealProductID 
UNION SELECT 245 AS SportType , 4601 AS BetType,  20 AS CurrencyUD  ,  1048 AS SiteID  ,  38 AS RealProductID 
UNION SELECT 245 AS SportType , 4601 AS BetType,  20 AS CurrencyUD  ,  1216 AS SiteID  ,  38 AS RealProductID 
UNION SELECT 245 AS SportType , 4601 AS BetType,  20 AS CurrencyUD  ,  1233 AS SiteID  ,  38 AS RealProductID 
UNION SELECT 245 AS SportType , 4601 AS BetType,  20 AS CurrencyUD  ,  1369 AS SiteID  ,  38 AS RealProductID 
UNION SELECT 245 AS SportType , 4601 AS BetType,  20 AS CurrencyUD  ,  1370 AS SiteID  ,  38 AS RealProductID 
UNION SELECT 245 AS SportType , 4602 AS BetType,  20 AS CurrencyUD  ,  1 AS SiteID  ,  38 AS RealProductID 
UNION SELECT 245 AS SportType , 4602 AS BetType,  20 AS CurrencyUD  ,  11 AS SiteID  ,  38 AS RealProductID 
UNION SELECT 245 AS SportType , 4602 AS BetType,  20 AS CurrencyUD  ,  13 AS SiteID  ,  38 AS RealProductID 
UNION SELECT 245 AS SportType , 4602 AS BetType,  20 AS CurrencyUD  ,  16 AS SiteID  ,  38 AS RealProductID 
UNION SELECT 245 AS SportType , 4602 AS BetType,  20 AS CurrencyUD  ,  20 AS SiteID  ,  38 AS RealProductID 
UNION SELECT 245 AS SportType , 4602 AS BetType,  20 AS CurrencyUD  ,  21 AS SiteID  ,  38 AS RealProductID 
UNION SELECT 245 AS SportType , 4602 AS BetType,  20 AS CurrencyUD  ,  22 AS SiteID  ,  38 AS RealProductID 
UNION SELECT 245 AS SportType , 4602 AS BetType,  20 AS CurrencyUD  ,  23 AS SiteID  ,  38 AS RealProductID 
UNION SELECT 245 AS SportType , 4602 AS BetType,  20 AS CurrencyUD  ,  25 AS SiteID  ,  38 AS RealProductID 
UNION SELECT 245 AS SportType , 4602 AS BetType,  20 AS CurrencyUD  ,  35 AS SiteID  ,  38 AS RealProductID 
UNION SELECT 245 AS SportType , 4602 AS BetType,  20 AS CurrencyUD  ,  109 AS SiteID  ,  38 AS RealProductID 
UNION SELECT 245 AS SportType , 4602 AS BetType,  20 AS CurrencyUD  ,  147 AS SiteID  ,  38 AS RealProductID 
UNION SELECT 245 AS SportType , 4602 AS BetType,  20 AS CurrencyUD  ,  188 AS SiteID  ,  38 AS RealProductID 
UNION SELECT 245 AS SportType , 4602 AS BetType,  20 AS CurrencyUD  ,  329 AS SiteID  ,  38 AS RealProductID 
UNION SELECT 245 AS SportType , 4602 AS BetType,  20 AS CurrencyUD  ,  487 AS SiteID  ,  38 AS RealProductID 
UNION SELECT 245 AS SportType , 4602 AS BetType,  20 AS CurrencyUD  ,  547 AS SiteID  ,  38 AS RealProductID 
UNION SELECT 245 AS SportType , 4602 AS BetType,  20 AS CurrencyUD  ,  1045 AS SiteID  ,  38 AS RealProductID 
UNION SELECT 245 AS SportType , 4602 AS BetType,  20 AS CurrencyUD  ,  1046 AS SiteID  ,  38 AS RealProductID 
UNION SELECT 245 AS SportType , 4602 AS BetType,  20 AS CurrencyUD  ,  1047 AS SiteID  ,  38 AS RealProductID 
UNION SELECT 245 AS SportType , 4602 AS BetType,  20 AS CurrencyUD  ,  1048 AS SiteID  ,  38 AS RealProductID 
UNION SELECT 245 AS SportType , 4602 AS BetType,  20 AS CurrencyUD  ,  1216 AS SiteID  ,  38 AS RealProductID 
UNION SELECT 245 AS SportType , 4602 AS BetType,  20 AS CurrencyUD  ,  1233 AS SiteID  ,  38 AS RealProductID 
UNION SELECT 245 AS SportType , 4602 AS BetType,  20 AS CurrencyUD  ,  1369 AS SiteID  ,  38 AS RealProductID 
UNION SELECT 245 AS SportType , 4602 AS BetType,  20 AS CurrencyUD  ,  1370 AS SiteID  ,  38 AS RealProductID 


END