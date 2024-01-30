/*<info serverAlias="DBCUST-CustDB,DBACC-bodb02,DBAGE-bodb02,DBTXN-CustDB,DBBOF-bodb02,DBTP-bodb02"></info>*/
/*
	Created: 20231227@Eden
	Task : Init data RepInfo_CleanData for some tables [#198589]
	DB: all database of CustDB_Customer_Info, CustDB_DBTrans_CustInfo pub
		(DBCUST-CustDB,DBACC-bodb02,DBAGE-bodb02,DBTXN-CustDB(Include sitedb),DBBOF-bodb02,DBTP-bodb02...)
*/
DELETE FROM RepInfo_CleanData

INSERT INTO RepInfo_CleanData (DatabaseName,TableName,Version_Key, Unique_Key)
SELECT 'CustDB','CustomerClassUtilityOffer','RepUpdateTime','PolicyID'
INSERT INTO RepInfo_CleanData (DatabaseName,TableName,Version_Key, Unique_Key)
SELECT 'CustDB','CustomerClassUtilityOffer_UAT','RepUpdateTime','PolicyID'
INSERT INTO RepInfo_CleanData (DatabaseName,TableName,Version_Key, Unique_Key)
SELECT 'CustDB','CustomerClassUtilityOfferDetail','RepUpdateTime','Currency,CustomerClass,SiteID,PolicyID'
INSERT INTO RepInfo_CleanData (DatabaseName,TableName,Version_Key, Unique_Key)
SELECT 'CustDB','CustomerClassUtilityOfferDetail_UAT','RepUpdateTime','Currency,CustomerClass,SiteID,PolicyID'
INSERT INTO RepInfo_CleanData (DatabaseName,TableName,Version_Key, Unique_Key)
SELECT 'CustDB','SportBettypeSettingMatrix','RepUpdateTime','BetType,SportType,isLicensee,isLive,Site'
INSERT INTO RepInfo_CleanData (DatabaseName,TableName,Version_Key, Unique_Key)
SELECT 'CustDB','Dep_CustBonusSharing','RepUpdateTime','CustID,FromDate'
INSERT INTO RepInfo_CleanData (DatabaseName,TableName,Version_Key, Unique_Key)
SELECT 'CustDB','ProductStakeLevelGroup','RepUpdateTime','Sporttype,GameGroupID,CreditGroupID'
INSERT INTO RepInfo_CleanData (DatabaseName,TableName,Version_Key, Unique_Key)
SELECT 'CustDB','Dep_ProductStakeLevelGroup','RepUpdateTime','Sporttype,GameGroupID,LicenseeGroupID,SiteID'
INSERT INTO RepInfo_CleanData (DatabaseName,TableName,Version_Key, Unique_Key)
SELECT 'CustDB','DomainManagement','RepUpdateTime','DomainID'
INSERT INTO RepInfo_CleanData (DatabaseName,TableName,Version_Key, Unique_Key)
SELECT 'bodb_Credit','ProfilePicture','RepUpdateTime','ImageId'

SELECT * FROM RepInfo_CleanData WITH(NOLOCK)
--EXEC Task_Repl_CleanDeletedData