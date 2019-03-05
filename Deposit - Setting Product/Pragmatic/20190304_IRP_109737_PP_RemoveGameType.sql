/*
	Created: Winnie
	Task: Pragmatic - Remove setting of the game Jade Butterfly on 07 Mar 2019 . RedmineID: #109737
	DB: DBCUST/CUSTDB
	Date: 20190305
*/ 

DELETE from StakeLevelGroupDetail where GameTypeID=4170

DELETE from Dep_StakeLevelGroupDetail where GameTypeID=4170

