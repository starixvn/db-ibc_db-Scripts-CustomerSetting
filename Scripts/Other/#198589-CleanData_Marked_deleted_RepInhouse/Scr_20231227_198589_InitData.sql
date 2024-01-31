/*<info serverAlias="DBCUST-CustDB,DBACC-bodb02,DBAGE-bodb02,DBTXN-CustDB,DBBOF-bodb02,DBTP-bodb02"></info>*/
/*
	Created: 20231227@Eden
	Task : Init data RepInfo_CleanData for some tables [#198589]
	DB: all database of CustDB_Customer_Info, CustDB_DBTrans_CustInfo pub
		(DBCUST-CustDB,DBACC-bodb02,DBAGE-bodb02,DBTXN-CustDB(Include sitedb),DBBOF-bodb02,DBTP-bodb02...)
*/
DELETE FROM RepInfo_CleanData

INSERT INTO RepInfo_CleanData (DatabaseName,TableName,Version_Key, Unique_Key)
SELECT 'CustDB','CustomerClassUtilityOffer','RepUpdateTime','PolicyID' UNION
SELECT 'bodb02','CustomerClassUtilityOffer','RepUpdateTime','PolicyID' UNION
SELECT 'CustDB','CustomerClassUtilityOffer_UAT','RepUpdateTime','PolicyID' UNION
SELECT 'bodb02','CustomerClassUtilityOffer_UAT','RepUpdateTime','PolicyID' UNION
SELECT 'CustDB','CustomerClassUtilityOfferDetail','RepUpdateTime','Currency,CustomerClass,SiteID,PolicyID' UNION
SELECT 'bodb02','CustomerClassUtilityOfferDetail','RepUpdateTime','Currency,CustomerClass,SiteID,PolicyID' UNION
SELECT 'CustDB','CustomerClassUtilityOfferDetail_UAT','RepUpdateTime','Currency,CustomerClass,SiteID,PolicyID' UNION
SELECT 'bodb02','CustomerClassUtilityOfferDetail_UAT','RepUpdateTime','Currency,CustomerClass,SiteID,PolicyID' UNION
SELECT 'CustDB','Dep_CustBonusSharing','RepUpdateTime','CustID,FromDate' UNION
SELECT 'bodb02','Dep_CustBonusSharing','RepUpdateTime','CustID,FromDate' UNION
SELECT 'CustDB','Dep_ProductStakeLevelGroup','RepUpdateTime','Sporttype,GameGroupID,LicenseeGroupID,SiteID' UNION
SELECT 'bodb02','Dep_ProductStakeLevelGroup','RepUpdateTime','Sporttype,GameGroupID,LicenseeGroupID,SiteID' UNION
SELECT 'CustDB','DomainManagement','RepUpdateTime','DomainID' UNION
SELECT 'bodb02','DomainManagement','RepUpdateTime','DomainID' UNION
SELECT 'CustDB','ProductStakeLevelGroup','RepUpdateTime','Sporttype,GameGroupID,CreditGroupID' UNION
SELECT 'bodb02','ProductStakeLevelGroup','RepUpdateTime','Sporttype,GameGroupID,CreditGroupID' UNION
SELECT 'bodb_Credit','ProfilePicture','RepUpdateTime','ImageId' UNION
SELECT 'bodb02','ProfilePicture','RepUpdateTime','ImageId' UNION
SELECT 'CustDB','SportBettypeSettingMatrix','RepUpdateTime','BetType,SportType,isLicensee,isLive,Site' UNION
SELECT 'bodb02','SportBettypeSettingMatrix','RepUpdateTime','BetType,SportType,isLicensee,isLive,Site' UNION
SELECT 'CustDB','CustomerClassNonSports','RepUpdateTime','PolicyID' UNION
SELECT 'bodb02','CustomerClassNonSports','RepUpdateTime','PolicyID' UNION
SELECT 'CustDB','CustomerClassNonSports_UAT','RepUpdateTime','PolicyID' UNION
SELECT 'bodb02','CustomerClassNonSports_UAT','RepUpdateTime','PolicyID' UNION
SELECT 'CustDB','CustomerClassNonSportsDetail','RepUpdateTime','CustomerClass,SiteID,PolicyID' UNION
SELECT 'bodb02','CustomerClassNonSportsDetail','RepUpdateTime','CustomerClass,SiteID,PolicyID' UNION
SELECT 'CustDB','CustomerClassNonSportsDetail_UAT','RepUpdateTime','CustomerClass,SiteID,PolicyID' UNION
SELECT 'bodb02','CustomerClassNonSportsDetail_UAT','RepUpdateTime','CustomerClass,SiteID,PolicyID' UNION
SELECT 'bodb_Credit','CustProfilePicture','RepUpdateTime','CustID' UNION
SELECT 'bodb02','CustProfilePicture','RepUpdateTime','CustID'

SELECT * FROM RepInfo_CleanData WITH(NOLOCK)
--EXEC Task_Repl_CleanDeletedData