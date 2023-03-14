/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Helios@20230309
	Task: Enhance Initial data Setting For Jili [RM:#181791]
	DB: DBCUST/CustDB

	Revisions:
		- 20230308@Helios: Insert new Product profile for Jili Games [redmine:#182869]
*/

use CustDB


--SELECT  *
UPDATE sportmatrix SET BetTypeRefBetSetting = 5299
FROM SportBettypeSettingMatrix sportmatrix WITH (ROWLOCK , UPDLOCK)
WHERE SportType = 158 and BetType = 5100