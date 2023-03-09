/*<info serverAlias="DBACC-bodb02"></info>*/
/*
	Created: Helios@20230309
	Task: Enhance Initial data Setting For Jili [RM:#181791]
	DB: DBACC/bodb02

	Revisions:
		- 20230308@Helios: Insert new Product profile for Jili Games [redmine:#182869]
*/

use bodb02


--SELECT  *
UPDATE sportmatrix SET BetTypeRefBetSetting = 5299
FROM SportBettypeSettingMatrix sportmatrix WITH (ROWLOCK , UPDLOCK)
WHERE SportType = 158 and BetType = 5100