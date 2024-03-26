/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
-- BACKUP DATA --
TRUNCATE TABLE ProductSettingDetail_helios
TRUNCATE TABLE ProductSettingDetail_UAT_helios


TRUNCATE TABLE ProductSettingProfile_helios
TRUNCATE TABLE ProductSettingProfile_UAT_helios



INSERT INTO ProductSettingDetail_helios
SELECT * FROM ProductSettingDetail

INSERT INTO ProductSettingDetail_UAT_helios
SELECT * FROM ProductSettingDetail_UAT

INSERT INTO ProductSettingProfile_helios
SELECT * FROM ProductSettingProfile

INSERT INTO ProductSettingProfile_UAT_helios
SELECT * FROM ProductSettingProfile_UAT

*/
/*
-- CHECK BACKUP DATA --

SELECT * FROM ProductSettingDetail_helios
SELECT * FROM ProductSettingDetail_UAT_helios
SELECT * FROM ProductSettingProfile_helios
SELECT * FROM ProductSettingProfile_UAT_helios
*/

/*

-- INSERT DATA SETTING ORIG FROM UAT --
DELETE FROM ProductSettingDetail 
DELETE FROM ProductSettingProfile

INSERT INTO ProductSettingDetail
SELECT * FROM ProductSettingDetail_UAT


INSERT INTO ProductSettingProfile
SELECT * FROM ProductSettingProfile_UAT
*/

/*
-- ROLLBACK DATA SETTING ORIG --

DELETE FROM ProductSettingDetail 
DELETE FROM ProductSettingProfile

INSERT INTO ProductSettingDetail
SELECT * FROM ProductSettingDetail_helios


INSERT INTO ProductSettingProfile
SELECT * FROM ProductSettingProfile_helios

*/
