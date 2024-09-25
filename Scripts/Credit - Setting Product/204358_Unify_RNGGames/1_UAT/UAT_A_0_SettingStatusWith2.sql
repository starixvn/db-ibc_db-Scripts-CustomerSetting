/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: @Helios
	Date: 03/05/2024
	Task: Inital Data Product Profile Setting  [#204358] 
	DB: DBCust/CustDB 
*/


	
IF NOT EXISTS (SELECT 1 FROM ProductStatusProfile psp WITH (NOLOCK) WHERE psp.Sporttype = 9919)
BEGIN
	INSERT INTO ProductStatusProfile 
	(
		Sporttype
		, Bettype
		, bitmapOrder
	)
	SELECT 9919 , 1501 , 44
END

IF NOT EXISTS (SELECT 1 FROM ProductSettingDetail psd WITH (NOLOCK) WHERE psd.SportType IN (9919,9909) AND psd.SettingStatus = 2)
BEGIN
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
	VALUES
		(18, 9909, 3700, CONVERT(bit, 'False'), 44, 90.00, NULL, CONVERT(bit, 'False'), CONVERT(bit, 'True'), CONVERT(bit, 'False'), 2, 3, 2, NULL, 44, NULL, 372, 0, 1, NULL),
		(21, 9919, 1501, CONVERT(bit, 'False'), 44, NULL, NULL, CONVERT(bit, 'True'), CONVERT(bit, 'False'), CONVERT(bit, 'False'), 2, 1, 2, NULL, 44, NULL, 370, NULL, 3, NULL),
		(23, 9919, 1501, CONVERT(bit, 'False'), 44, NULL, NULL, CONVERT(bit, 'False'), CONVERT(bit, 'True'), CONVERT(bit, 'False'), 2, 2, 2, NULL, 44, NULL, 371, 370, 2, 1)

END

	