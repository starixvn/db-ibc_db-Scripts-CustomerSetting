DECLARE @IsDeposit      BIT
	 , @CurrencyIds    VARCHAR(50) = '1,2,3,4,5,6,9,12,13,15,16,17,22,30,32,33,34,35,40,41,43,45,46,47,49,51,52,53,54,55,56,57,58,61,63,64,66,67,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89'
	 , @SiteId         INT         = 329
	 , @Level1         MONEY       = 1
	 , @Level2         MONEY       = 2
	 , @Level3         MONEY       = 3
	 , @Level101       MONEY       = -101
	 , @Level102       MONEY       = -102;

SELECT @IsDeposit = isDeposit
FROM Site WITH (NOLOCK)
WHERE siteid = @SiteId;

DECLARE @ProductSettingDetail TABLE(
	ProductID            TINYINT
   , GroupID              SMALLINT
   , ExchangeID           INT
   , SiteID               INT
   , LevelID              TINYINT
   , MaxWinLimit          MONEY
   , IsBlockedPlaceBet    BIT
   , IsBlockedTransfer    BIT
   , MaxWinLimit_RM       MONEY);

IF @IsDeposit = 1 -- clone settings from 12bet as default
    BEGIN
	   INSERT INTO @ProductSettingDetail(ProductID
								, GroupID
								, ExchangeID
								, SiteID
								, LevelID
								, MaxWinLimit
								, IsBlockedPlaceBet
								, IsBlockedTransfer
								, MaxWinLimit_RM)
			SELECT ProductID
				, GroupID
				, ExchangeID
				, @SiteId AS SiteID
				, LevelID
				, MaxWinLimit
				, IsBlockedPlaceBet
				, IsBlockedTransfer
				, MaxWinLimit_RM
			FROM WinLimit_ProductSettingDetail WITH (NOLOCK)
			WHERE SiteId = 30;
    END;
    ELSE
    BEGIN -- clone settings from BEST-ODDS as default
	   INSERT INTO @ProductSettingDetail(ProductID
								, GroupID
								, ExchangeID
								, SiteID
								, LevelID
								, MaxWinLimit
								, IsBlockedPlaceBet
								, IsBlockedTransfer
								, MaxWinLimit_RM)
	   SELECT ProductID
		   , GroupID
		   , ExchangeID
		   , @SiteId SiteID
		   , LevelID
		   , MaxWinLimit
		   , IsBlockedPlaceBet
		   , IsBlockedTransfer
		   , MaxWinLimit_RM
	   FROM WinLimit_ProductSettingDetail WITH (NOLOCK)
	   WHERE SiteId = 1;
    END;

DELETE p1
FROM @ProductSettingDetail AS p1
    INNER JOIN WinLimit_ProductSettingDetail AS p2 WITH (NOLOCK) ON p1.ProductID = p2.ProductID
													   AND p1.GroupID = p2.GroupID
													   AND p1.ExchangeID = p2.ExchangeID
													   AND p1.SiteID = p2.SiteID
													   AND p1.LevelID = p2.LevelID;


INSERT INTO @ProductSettingDetail(ProductID
						  , GroupID
						  , ExchangeID
						  , SiteID
						  , LevelID
						  , MaxWinLimit
						  , IsBlockedPlaceBet
						  , IsBlockedTransfer
						  , MaxWinLimit_RM)
	  (
		 SELECT ProductID
			 , GroupID
			 , e.ExChangeId
			 , SiteID
			 , LevelID
			 , MaxWinLimit
			 , IsBlockedPlaceBet
			 , IsBlockedTransfer
			 , MaxWinLimit_RM
		 FROM @ProductSettingDetail AS p
			CROSS APPLY
			 (
				SELECT CAST(val AS INT) AS ExChangeId
				FROM dbo.strSplit
					(@CurrencyIds, ',')
			 ) AS e
		 WHERE p.ExchangeID IN(2)
			  AND e.ExChangeId > 0
	  );

UPDATE p
	  SET
		 p.MaxWinLimit_RM = CASE
						    WHEN LevelID = 1
						    THEN @Level1
						    WHEN LevelID = 2
						    THEN @Level2
						    WHEN LevelID = 3
						    THEN @Level3
						    WHEN LevelID = 101
						    THEN @Level101
						    WHEN LevelID = 102
						    THEN @Level102
						END
FROM @ProductSettingDetail p;

UPDATE p
	  SET
		 p.MaxWinLimit = CASE
						 WHEN p.exchangeid = 20
						 THEN p.MaxWinLimit_RM
						 ELSE ROUND(p.MaxWinLimit_RM / e.actualrate, 2)
					  END
FROM @ProductSettingDetail p
    INNER JOIN exchange e WITH (NOLOCK) ON p.ExchangeID = e.exchangeid;

SELECT ProductID
	, GroupID
	, ExchangeID
	, SiteID
	, LevelID
	, MaxWinLimit
	, IsBlockedPlaceBet
	, IsBlockedTransfer
	, MaxWinLimit_RM
FROM @ProductSettingDetail
ORDER BY ProductID
	  , GroupID
	  , ExchangeID
	  , LevelID;
--- insert @ProductSettingDetail into ProductSettingDetail là xong