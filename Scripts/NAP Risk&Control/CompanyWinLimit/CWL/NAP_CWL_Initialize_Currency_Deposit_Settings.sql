/*<info serverAlias="DBCUST-CUSTDB" executers="bodbAdminNet" viewers="" isFunction="0" isNested="0"></info>*/

ALTER PROCEDURE NAP_CWL_Initialize_Currency_Deposit_Settings
/*
    Creator	 : 20190515@Robert
    Task		 : Initialize CWL Settings [#112218]
    DB		 : DBCUST/CustDB 
    Revisions: 
		 - 20190515@Robert: #112218 - CWL - New site CN88 integration
     Param:
		  
*/
AS
BEGIN
    DECLARE @SiteId    INT;

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

    DECLARE @ExchangeIds TABLE(
	    ExchangeID    INT);

    DECLARE @SiteIds TABLE(
	    SiteID      INT
	  , IsFinish    BIT);

    DECLARE @Result TABLE(
	    SiteId              INT
	  , NumberOfCurrency    INT);

    DECLARE @LicenseeCust TABLE(
	    LicenseeID    INT
	  , Currency      INT);

    DECLARE @Licensees TABLE(
	    LicenseeID      INT
	  , LicenseeName    VARCHAR(50));

    INSERT INTO @Licensees(LicenseeID
					, LicenseeName)
		 SELECT LicenseeID
			 , LicenseeName
		 FROM bodb_licensee.dbo.Licensees WITH (NOLOCK);

    INSERT INTO @LicenseeCust(LicenseeID
					   , Currency)
		 SELECT DISTINCT
			   LicenseeID
			 , Currency
		 FROM bodb_licensee.dbo.LicenseeCust AS lc WITH (NOLOCK);

    CREATE TABLE #Currency_Deposit(
	    siteid        INT
	  , exchangeid    INT
	  , PRIMARY KEY(siteid, exchangeid));

    INSERT INTO #Currency_Deposit(siteid
						  , exchangeid)
		 SELECT DISTINCT
			   s.siteid
			 , lc.Currency AS Id
		 FROM @LicenseeCust AS lc
			INNER JOIN @Licensees AS l ON l.LicenseeID = lc.LicenseeID
			INNER JOIN dbo.site AS s WITH (NOLOCK) ON s.site = l.LicenseeName
											  AND S.isActive = 1
		 WHERE lc.Currency NOT IN(27, 28);



    INSERT INTO @SiteIds(SiteID
				   , IsFinish)
		 (
			SELECT siteid
				, 0 AS IsFinish
			FROM #Currency_Deposit
		 );


    WHILE 1 = 1
	   BEGIN
		  UPDATE TOP (1) @SiteIds
			    SET
				   @SiteId = SiteID
				 , IsFinish = 1
		  WHERE IsFinish = 0;

		  DELETE FROM @ExchangeIds;
		  DELETE FROM @ProductSettingDetail;

		  INSERT INTO @ExchangeIds(ExchangeID)
			    (
				   SELECT exchangeid
				   FROM #Currency_Deposit
				   WHERE siteid = @SiteId
			    );

		  INSERT INTO @ProductSettingDetail(ProductID
								    , GroupID
								    , ExchangeID
								    , SiteID
								    , LevelID
								    , MaxWinLimit
								    , IsBlockedPlaceBet
								    , IsBlockedTransfer
								    , MaxWinLimit_RM)
			    SELECT g.ProductID
				    , g.GroupID
				    , e.ExchangeID
				    , @SiteId AS SiteId
				    , l.LevelID
				    , 0 AS MaxWinLimit
				    , 0 AS IsBlockedPlaceBet
				    , 0 AS IsBlockedTransfer
				    , 0 AS MaxWinLimit_RM
			    FROM
				    (
					   SELECT DISTINCT
							ProductID
						   , GroupID
					   FROM Winlimit_ProductGlobalSetting WITH (NOLOCK)
				    ) AS g
				   CROSS APPLY
				    (
					   SELECT ExchangeID
					   FROM @ExchangeIds
				    ) AS e
				   CROSS APPLY
				    (
					   SELECT LevelID
					   FROM Winlimit_LevelSetting WITH (NOLOCK)
				    ) AS l;

		  DELETE p1
		  FROM @ProductSettingDetail AS p1
			 INNER JOIN WinLimit_ProductSettingDetail AS p2 WITH (NOLOCK) ON p1.ProductID = p2.ProductID
																AND p1.GroupID = p2.GroupID
																AND p1.ExchangeID = p2.ExchangeID
																AND p1.SiteID = p2.SiteID
																AND p1.LevelID = p2.LevelID;

		  UPDATE p
			    SET
				   p.MaxWinLimit_RM = CASE
									 WHEN p.LevelID = 1
									 THEN g.Level1
									 WHEN p.LevelID = 2
									 THEN g.Level2
									 WHEN p.LevelID = 3
									 THEN g.Level3
									 WHEN p.LevelID = 101
									 THEN g.Level101
									 WHEN p.LevelID = 102
									 THEN g.Level102
								  END
				 , p.IsBlockedTransfer = CASE
									    WHEN p.LevelID = 3
									    THEN g.blockedTransferLvl3
									    ELSE 0
									END
		  FROM @ProductSettingDetail AS p
			 INNER JOIN Winlimit_ProductGlobalSetting AS g WITH (NOLOCK) ON p.ProductID = g.ProductID
															    AND p.GroupID = g.GroupID;

		  UPDATE p
			    SET
				   p.MaxWinLimit = CASE
								   WHEN p.exchangeid = 20
								   THEN p.MaxWinLimit_RM
								   ELSE ROUND(p.MaxWinLimit_RM / e.actualrate, 2)
							    END
		  FROM @ProductSettingDetail p
			 INNER JOIN exchange e WITH (NOLOCK) ON p.ExchangeID = e.exchangeid;
		  INSERT INTO WinLimit_ProductSettingDetail(ProductID
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
					   , ExchangeID
					   , SiteID
					   , LevelID
					   , MaxWinLimit
					   , IsBlockedPlaceBet
					   , IsBlockedTransfer
					   , MaxWinLimit_RM
				   FROM @ProductSettingDetail
			    );


		  INSERT INTO @Result(SiteId
						, NumberOfCurrency)
			    (
				   SELECT SiteID
					   , COUNT(1) AS cnt
				   FROM
					   (
						  SELECT SiteID
							  , ExchangeID
						  FROM @ProductSettingDetail
						  GROUP BY SiteID
							    , ExchangeID
					   ) AS s
				   GROUP BY SiteID
			    );

		  IF
			(
			    SELECT COUNT(1) AS cnt
			    FROM @SiteIds
			    WHERE IsFinish = 0
			) = 0
			 BEGIN
				BREAK;
			 END;
	   END;

    SELECT SiteId
	    , NumberOfCurrency
    FROM @Result
    ORDER BY SiteId;

    DROP TABLE #Currency_Deposit;
END;