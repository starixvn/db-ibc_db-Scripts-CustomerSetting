/*<info serverAlias="DBPOL-UserControl"></info>*/
/*
	Created by: Tacy@20230628
	Task: Credit - Hide inactive products : GDG, Fishing World, GD, ColosusBet
		https://nexdev.net/issues/174511
		https://nexdev.net/issues/179132

	DB: DBPOL.UserControl
*/ 
-------------------------------------------------
UPDATE eaGroupConfiguration WITH (NOLOCK) 
SET IsShow=0
WHERE ProductId in (59,24,12,15) AND IsShow=1