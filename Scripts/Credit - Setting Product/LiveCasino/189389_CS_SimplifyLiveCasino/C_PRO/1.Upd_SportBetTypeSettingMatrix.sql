/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20230819@Helios
	Task: Inital Data Setting SportBettypeSettingMatrix in Replicate  [#189389]
	DB: DBCUST-CustDB
*/

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

	---------------------------SportBettypeSettingMatrix------------------------------------
	--> UPD RefPT , RefComm 
	UPDATE mt 
		SET [SportTypeRefPT]		= 9911
		  , [BetTypeRefPT]			= 2400
		  , [SportTypeRefComm]		= 9911
		  , [BetTypeRefComm]		= 2400
		  , [RepUpdateTime]			= SYSDATETIME()
	FROM SportBettypeSettingMatrix mt WITH (ROWLOCK,UPDLOCK)
	WHERE ProductID = 41
	AND SportType <> 242
	AND isLicensee = 0
	AND Site = 'All'