/*<info serverAlias="dbspare-custDB_20240513_0200"></info>*/
/*
	Date: 2024-05-31
	Created: @Helios
	Task: Database - Initialize Other RNG Casino for PT and Win Loss Limit [#205649] 
	DB: dbspare.custDB_20240513_0200
*/

CREATE TABLE tmp_CustPTSetting3rd_Agent_DanielTest33
	(
		CustID	   INT
	    , SportType	   SMALLINT
	    , BetType	   SMALLINT
	    , IsLive	   BIT
	    , IsAutoMasterPT BIT
	    , IsAutoSuperPT  BIT
	    , SuperPT	   SMALLMONEY
	    , MasterPT	   SMALLMONEY
	    , AgentPT	   SMALLMONEY
	    , AutoSuperPT	   SMALLMONEY
	    , AutoMasterPT   SMALLMONEY
	    , MinPT		   SMALLMONEY
	    , MaxPT		   SMALLMONEY
	    , PRIMARY KEY (CustID , SportType , BetType , IsLive)
	)

CREATE TABLE tmp_CustPTSetting3rd_Member_DanielTest33
	(
		CustID	   INT
	    , SportType	   SMALLINT
	    , BetType	   SMALLINT
	    , IsLive	   BIT
	    , IsAutoMasterPT BIT
	    , IsAutoSuperPT  BIT
	    , SuperPT	   SMALLMONEY
	    , MasterPT	   SMALLMONEY
	    , AgentPT	   SMALLMONEY
	    , AutoSuperPT	   SMALLMONEY
	    , AutoMasterPT   SMALLMONEY
	    , PRIMARY KEY (CustID , SportType , BetType , IsLive)
	)

CREATE TABLE tmp_CustWinLossLimit_Agent_DanielTest33
	(
		CustId	 INT
	    , SportType	 SMALLINT
	    , BetType	 SMALLINT
	    , MaxWinLimit	 SMALLMONEY
	    , MaxLossLimit MONEY
	    , IsAutoReset	 BIT
	    , PRIMARY KEY (CustID , SportType , BetType)
	)


CREATE TABLE tmp_CustWinLossLimit_Member_DanielTest33
	(
		CustId	 INT
	    , SportType	 SMALLINT
	    , BetType	 SMALLINT
	    , MaxWinLimit	 SMALLMONEY
	    , MaxLossLimit MONEY
	    , IsAutoReset	 BIT
	    , PRIMARY KEY (CustID , SportType , BetType)
	)

CREATE TABLE tmp_CustProductStatus_DanielTest33
	(
		CustID	     INT
	    , bitmapIsHidden   BINARY(32)
	    , PRIMARY KEY (CustID)
	)