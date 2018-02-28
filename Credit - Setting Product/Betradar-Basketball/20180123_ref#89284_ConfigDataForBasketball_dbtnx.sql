/*
    Created: 20180123@Vicky
    Task: Insert product profile for Basketball
    DB: DBTXN/bodb02
*/

IF NOT EXISTS(SELECT 1 FROM bettype WHERE typeid IN (2801,2802,2803,2804,2805,2806,2807,2808,2809,2811,2812))
BEGIN
	INSERT INTO bettype (typeid,typenamee,ParentTypeid,DisplayedTypeID)
	VALUES (2801,'Match Winner',2801,2801),
		   (2802,'1H Winner',2802,2802),
		   (2803,'Over/Under',2803,2803),
		   (2804,'1H Over/Under',2804,2804),		   
		   (2805,'Handicap',2805,2805),
	       (2806,'1H Handicap',2806,2806),
	       (2807,'Winning Margin 6 Way',2807,2807),
	       (2808,'1H Winning Margin 7 Way',2808,2808),
	       (2809,'FT Race To X Points',2809,2809),
	       --(2810,'Highest Scoring Quarter',2810,2810),
	       (2811,'Home Team Over/Under',2811,2811),
	       (2812,'Away Team Over/Under',2812,2812)
END	 


IF NOT EXISTS(SELECT 1 FROM [SportBettypeMatrix] WHERE SportType = 193)
BEGIN
	INSERT INTO SportBettypeMatrix (SportType, BetType, IsLive, ProductID, [Enabled], IsTest, EventType, SubProduct, RefTable)
	VALUES                                            (193      , 2801   , 0     , 193      , 1        , 1     , 1        , ''        , 0       )  
END


UPDATE TABLE sports SET SportName='Virtual Soccer World Cup' WHERE SportType=192