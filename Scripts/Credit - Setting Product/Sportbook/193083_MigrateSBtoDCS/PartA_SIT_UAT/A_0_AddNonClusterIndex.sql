/*<info serverAlias="DBCust-CustDB"></info>*/
/*
	Created: 20230913@Helios
	Task: Add Non Cluster index for Collumn GroupType  [#193083]
	DB: DBCust/CustDB
*/

CREATE NONCLUSTERED INDEX [IX_ProductSettingProfile_GroupType] ON ProductSettingProfile 
(
	GroupType ASC
) WITH (ONLINE = ON) ON [DATA];  

CREATE NONCLUSTERED INDEX [IX_ProductSettingProfile_UAT_GroupType] ON ProductSettingProfile_UAT 
(
	GroupType ASC
) WITH (ONLINE = ON) ON [DATA];  