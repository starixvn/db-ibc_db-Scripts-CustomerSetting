/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 2024012@Helios
	Task: Unify Live Casino & RNG slot/RNG Casino - Initial with SettingStatus = 2, for UAT testing use tool Initial Data [#198960] 
		https://nexdev.net/issues/193083
	DB: DBCust/CustDB
*/
	
	
	IF NOT EXISTS (SELECT 1 FROM ProductSettingDetail WITH (NOLOCK) WHERE Sporttype = 9918)
	BEGIN
		-- Initital Dummy Sport Other RNG Casino with SettingStatus = 2 For initial data Setting 
		INSERT INTO ProductSettingDetail 
		(
			SettingType
		    , SportType
		    , BetType
		    , IsLive
		    , ProductID
		    , MaxPT
		    , MaxDiscount
		    , IsSync
		    , IsHidden
		    , IsDisabled
		    , SettingLevel
		    , DisplayOrder
		    , SettingStatus
		    , IntervalValue
		    , RealProductId
		    , MaxChoice
		    , ProductSettingID
		    , Parent_ProductSettingID
		    , Child_DisplayOrder
		    , SubType
		)
			SELECT 18 ,  9918 ,  4601 ,  0 ,  18 ,  90 ,  NULL ,  NULL ,  NULL ,  NULL ,  2 ,  3 , 2 ,  NULL ,  18 ,  NULL ,  368 ,  NULL ,  3 ,  NULL   
		UNION SELECT 21 ,  9918 ,  4601 ,  0 ,  18 ,  NULL ,  NULL ,  1 ,  0 ,  0 ,  2 ,  1 , 2 ,  NULL ,  18 ,  NULL ,  367 ,  NULL ,  3 ,  NULL   
		UNION SELECT 22 ,  9918 ,  4601 ,  0 ,  18 ,  NULL ,  NULL ,  NULL ,  NULL ,  NULL ,  2 ,  4 , 2 ,  NULL ,  18 ,  NULL ,  369 ,  NULL ,  3 ,  NULL   

	END
	