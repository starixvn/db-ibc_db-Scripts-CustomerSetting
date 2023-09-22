/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20230727@Helios
	Task: Create New Table Product Profile  [#189389]
	DB: DBCust/CustDB and all replicated server of pub: CustDB_Customer_Info, CustDB_DBTrans_CustInfo
*/

-------------------------------ProductSettingProfile-------------------------------

ALTER TABLE ProductSettingProfile
DROP CONSTRAINT PK_ProductSettingProfile;

ALTER TABLE ProductSettingProfile
ADD CONSTRAINT PK_ProductSettingProfile PRIMARY KEY NONCLUSTERED 
(
	ProductSettingID	ASC )
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA];

CREATE CLUSTERED INDEX CIX_ProductSettingProfile ON ProductSettingProfile(	[SettingType] ASC,	[SportType] ASC,	[BetType] ASC,	[IsLive] ASC) ON [DATA]
-------------------------------ProductSettingProfile_UAT-------------------------------

ALTER TABLE ProductSettingProfile_UAT
DROP CONSTRAINT PK_ProductSettingProfile_UAT;

ALTER TABLE ProductSettingProfile_UAT
ADD CONSTRAINT PK_ProductSettingProfile_UAT PRIMARY KEY NONCLUSTERED 
(
	ProductSettingID	ASC )
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA];

CREATE CLUSTERED INDEX CIX_ProductSettingProfile_UAT ON ProductSettingProfile_UAT(	[SettingType] ASC,	[SportType] ASC,	[BetType] ASC,	[IsLive] ASC) ON [DATA]	