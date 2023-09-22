/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20230819@Helios
	Task: Remove Unused Setting [#189389]
	DB: Just RUN DBCust/CustDB 
		- ProductSettingSystemDisplay: Replicated server of DR ( DB061, DB062, DBTP) 
		- ProductStatusSiteCurrency: Replicated server of pub: CustDB_Customer_Info, CustDB_DBTrans_CustInfo
*/

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


	---------------------------1.ProductSettingSystemDisplay------------------------------------
	
	-- Remove data ProductSettingSystemDisplay (Hide on Ext NAP)
	DELETE
	FROM ProductSettingSystemDisplay WITH (ROWLOCK)
	WHERE ProductID = 41
	AND SettingType IN (6,12)

	---------------------------2.ProductStatusSiteCurrency------------------------------------
	
	-- Remove data ProductStatusSiteCurrency
	DELETE
	FROM ProductStatusSiteCurrency WITH (ROWLOCK)
	WHERE SportType IN (159,170,211,225,233,236,239,241,242,243,244)
	AND BetType IN (3151,3701,2401,5601,3401,5701,3501,3300,3201,3101,3001)

	
