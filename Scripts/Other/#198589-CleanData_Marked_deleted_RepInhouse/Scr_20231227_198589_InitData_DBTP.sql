/*<info serverAlias=DBTP-bodb02></info>*/
/*
	Created: 20231227@Eden
	Task : Init data RepInfo_CleanData for some tables [#198589]
	DB:  DBTP-bodb02
*/
USE bodb02
GO
DELETE FROM RepInfo_CleanData

INSERT INTO RepInfo_CleanData (DatabaseName,TableName,Version_Key, Unique_Key)
SELECT 'bodb02','SportBettypeSettingMatrix','RepUpdateTime','BetType,SportType,isLicensee,isLive,Site'
INSERT INTO RepInfo_CleanData (DatabaseName,TableName,Version_Key, Unique_Key)
SELECT 'bodb02','Dep_CustBonusSharing','RepUpdateTime','CustID,FromDate'
INSERT INTO RepInfo_CleanData (DatabaseName,TableName,Version_Key, Unique_Key)
SELECT 'bodb02','ProductStakeLevelGroup','RepUpdateTime','Sporttype,GameGroupID,CreditGroupID'
INSERT INTO RepInfo_CleanData (DatabaseName,TableName,Version_Key, Unique_Key)
SELECT 'bodb02','Dep_ProductStakeLevelGroup','RepUpdateTime','Sporttype,GameGroupID,LicenseeGroupID,SiteID'
INSERT INTO RepInfo_CleanData (DatabaseName,TableName,Version_Key, Unique_Key)
SELECT 'bodb02','DomainManagement','RepUpdateTime','DomainID'
INSERT INTO RepInfo_CleanData (DatabaseName,TableName,Version_Key, Unique_Key)
SELECT 'bodb02','ProfilePicture','RepUpdateTime','ImageId'
INSERT INTO RepInfo_CleanData (DatabaseName,TableName,Version_Key, Unique_Key)
SELECT 'bodb02','CustomerClassUtilityOffer','RepUpdateTime','PolicyID'
INSERT INTO RepInfo_CleanData (DatabaseName,TableName,Version_Key, Unique_Key)
SELECT 'bodb02','CustomerClassUtilityOffer_UAT','RepUpdateTime','PolicyID'
INSERT INTO RepInfo_CleanData (DatabaseName,TableName,Version_Key, Unique_Key)
SELECT 'bodb02','CustomerClassUtilityOfferDetail','RepUpdateTime','Currency,CustomerClass,SiteID,PolicyID'
INSERT INTO RepInfo_CleanData (DatabaseName,TableName,Version_Key, Unique_Key)
SELECT 'bodb02','CustomerClassUtilityOfferDetail_UAT','RepUpdateTime','Currency,CustomerClass,SiteID,PolicyID'

SELECT * FROM RepInfo_CleanData WITH(NOLOCK)
--EXEC Task_Repl_CleanDeletedData