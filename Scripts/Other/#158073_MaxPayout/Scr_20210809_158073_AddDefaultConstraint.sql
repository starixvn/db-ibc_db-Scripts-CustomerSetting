/*
	Created: Eden@20210809
	Task: add missing default minbet and max bet of custsetting3rd and custsetting table - credit[Redmine: #154048]   
	DB: all subscribers of CustDB_CustSetting publication is missing this default
*/
ALTER TABLE custsetting3rd ADD CONSTRAINT DF_custSetting3rd_maxbet DEFAULT 0 FOR maxbet
GO
ALTER TABLE custsetting3rd ADD CONSTRAINT DF_custSetting3rd_minbet DEFAULT 0 FOR minbet
GO
ALTER TABLE custsetting ADD CONSTRAINT DF_custSetting_maxbet DEFAULT 0 FOR maxbet
GO
ALTER TABLE custsetting ADD CONSTRAINT DF_custSetting_minbet DEFAULT 0 FOR minbet
GO