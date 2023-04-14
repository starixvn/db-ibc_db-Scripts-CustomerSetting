/*<info serverAlias="DBCUST-CustDB"></info>*/ 
/*
	Created: Helios@2023/03/27
	Task: Enhance Initial data Setting For PP - Pragmatic [RM:#181686]
	DB: DBCUST/CUSTDB

	Revisions:
		- Change the bet limit setting for Nova88, 789y, IBCBet & licensees [RM:#181686]
*/
use CustDB

DECLARE @Old_BetType SMALLINT
	,   @New_BetType SMALLINT
	,	@SportType SMALLINT


SELECT @Old_BetType = 4101
	,  @New_BetType = 7000
	,  @SportType = 248

--SELECT *
UPDATE p SET BetType = @New_BetType
FROM ProductSettingDetail_UAT p WITH (ROWLOCK, UPDLOCK)
WHERE SportType = @SportType
AND BetType = @Old_BetType
AND SettingType = 8



