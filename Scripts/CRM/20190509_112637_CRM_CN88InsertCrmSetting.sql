USE [bodb_CRM]
GO

/*
	Created: 20190509@Winnie
	Task: CN88 Insert crmsetting RedmineID:#112637
	DB: DBCRM/bodb_CRM
*/

UPDATE crmSetting WITH(ROWLOCK,UPDLOCK)
	SET SiteOffer=2
WHERE SiteOffer IS NULL OR SiteOffer=0

CREATE TABLE #tmpcrmSettingRelation(
	[SettingID] [int] NOT NULL,
	[ParentID] [int] NOT NULL,
	[DisplayOrder] [int] NULL
) 

GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (1013, 0, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (1014, 0, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (1015, 0, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (1016, 0, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (1017, 0, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (1018, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (1018, 9282, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (1019, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (1020, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (1021, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (1022, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (1023, 0, 0)
GO

INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (1025, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (2055, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (7011, 0, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (7007, 0, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (7008, 0, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (7009, 0, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (7010, 0, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (8085, 46009, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (8086, 46009, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (8087, 46012, 12)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (8088, 46009, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (8089, 46010, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (8090, 46012, 16)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (8091, 46009, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (8092, 46009, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (8093, 46009, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (8094, 46009, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (8095, 46012, 12)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (8096, 46009, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (8097, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (8098, 46009, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (8099, 46009, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (8100, 46009, 2)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (8101, 46009, 3)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (8102, 46009, 4)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (8103, 46009, 5)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (8104, 46009, 6)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (8105, 46009, 7)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (8106, 46009, 8)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (8107, 46009, 9)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (8108, 46009, 10)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (8109, 46009, 11)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (8110, 46009, 12)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (8111, 46009, 13)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (8112, 46009, 14)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (8113, 46009, 15)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (8114, 46009, 16)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (8115, 46009, 17)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (8116, 46009, 18)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (8117, 46009, 19)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (8118, 46010, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (8119, 46010, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (8120, 46010, 2)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (8121, 46010, 3)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (8122, 46010, 4)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (8123, 46010, 5)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (8124, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (8124, 46009, -1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (8124, 46010, -1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (8124, 46002, -1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (8124, 46003, -1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (8124, 46011, -1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (8124, 46005, -1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (8124, 46006, -1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (8124, 46007, -1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (8125, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (8125, 46009, 3)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (8126, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (8126, 46009, 33)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (8127, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (8127, 46010, 35)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (8128, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (8128, 46010, 36)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (8129, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (8129, 46012, 37)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (8130, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (8130, 46009, 38)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (8131, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (8131, 46010, 41)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (8132, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (8132, 46012, 44)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (8133, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (8133, 46010, 45)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (8134, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (8134, 46010, 46)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (8135, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9198, 0, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9198, 8085, NULL)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9198, 8086, 2)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9198, 8088, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9198, 8010, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9198, 8091, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9198, 8092, 2)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9198, 8093, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9198, 8094, 3)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9198, 8096, 2)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9198, 8033, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9198, 8098, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9198, 8099, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9198, 8100, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9198, 8101, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9198, 8102, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9198, 8103, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9198, 8104, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9198, 8105, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9198, 8106, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9198, 8107, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9198, 8109, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9198, 8110, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9198, 8112, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9198, 8113, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9198, 8114, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9198, 8115, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9198, 8117, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9198, 8118, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9198, 8125, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9198, 8071, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9198, 8127, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9198, 8128, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9198, 8130, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9198, 8131, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9198, 8133, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9198, 8134, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9199, 0, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9199, 8085, NULL)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9199, 8086, 4)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9199, 8087, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9199, 8088, 3)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9199, 8010, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9199, 8091, 3)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9199, 8092, 3)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9199, 8093, 3)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9199, 8094, 4)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9199, 8095, 3)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9199, 8096, 3)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9199, 8033, 3)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9199, 8098, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9199, 8099, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9199, 8100, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9199, 8101, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9199, 8102, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9199, 8103, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9199, 8104, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9199, 8105, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9199, 8106, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9199, 8107, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9199, 8109, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9199, 8110, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9199, 8113, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9199, 8114, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9199, 8115, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9199, 8117, 3)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9199, 8118, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9199, 8125, 3)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9199, 8071, 3)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9199, 8127, 3)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9199, 8128, 3)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9199, 8130, 3)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9199, 8131, 3)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9199, 8133, 3)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9199, 8134, 3)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9200, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9200, 8010, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9201, 8087, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9201, 8010, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9201, 8095, 89)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9202, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9202, 8010, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9202, 8118, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9203, 8086, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9203, 8088, 6)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9203, 8091, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9203, 8092, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9203, 8093, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9203, 8096, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9203, 8098, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9203, 8099, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9203, 8100, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9203, 8101, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9203, 8102, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9203, 8103, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9203, 8104, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9203, 8105, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9203, 8106, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9203, 8107, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9203, 8108, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9203, 8109, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9203, 8110, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9203, 8111, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9203, 8112, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9203, 8113, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9203, 8114, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9203, 8115, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9203, 8116, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9203, 8117, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9203, 8120, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9203, 8125, 6)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9203, 8130, 6)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9203, 8077, 6)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9204, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9204, 8010, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9204, 8118, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9205, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9205, 8085, 5)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9205, 8010, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9205, 8033, 4)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9205, 8118, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9205, 8120, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9205, 8127, 4)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9205, 8128, 4)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9206, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9206, 8085, 6)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9206, 8086, 8)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9206, 8010, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9206, 8094, 2)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9206, 8127, 5)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9206, 8128, 5)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9206, 8133, 5)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9206, 8134, 5)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9207, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9207, 8085, 2)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9207, 8086, 3)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9207, 8088, 2)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9207, 8010, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9207, 8093, 7)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9207, 8099, 7)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9207, 8071, 7)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9207, 8127, 7)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9207, 8128, 7)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9208, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9208, 8085, 4)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9208, 8086, 5)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9208, 8088, 4)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9208, 8010, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9208, 8093, 8)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9208, 8099, 8)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9208, 8071, 8)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9208, 8127, 8)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9208, 8128, 8)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9209, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9209, 8085, 9)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9209, 8086, 10)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9209, 8088, 8)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9209, 8010, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9209, 8091, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9209, 8092, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9209, 8094, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9209, 8098, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9209, 8099, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9209, 8100, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9209, 8101, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9209, 8102, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9209, 8103, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9209, 8104, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9209, 8105, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9209, 8106, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9209, 8107, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9209, 8109, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9209, 8110, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9209, 8113, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9209, 8114, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9209, 8115, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9209, 8127, 9)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9209, 8128, 9)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9210, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9210, 8085, 11)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9210, 8086, 9)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9210, 8088, 7)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9210, 8010, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9210, 8091, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9210, 8092, 5)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9210, 8094, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9210, 8096, 10)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9210, 8098, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9210, 8099, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9210, 8100, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9210, 8101, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9210, 8102, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9210, 8103, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9210, 8104, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9210, 8105, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9210, 8106, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9210, 8107, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9210, 8108, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9210, 8109, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9210, 8110, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9210, 8111, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9210, 8112, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9210, 8113, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9210, 8114, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9210, 8115, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9210, 8116, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9210, 8117, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9211, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9211, 8010, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9212, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9212, 8085, 12)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9212, 8086, 7)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9212, 8088, 6)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9212, 8010, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9212, 8096, 12)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9212, 8099, 12)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9213, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9213, 8010, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9214, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9214, 8010, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9215, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9215, 8085, 7)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9215, 8010, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9215, 8127, 15)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9215, 8128, 15)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9215, 8133, 15)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9215, 8134, 15)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9216, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9216, 8010, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9217, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9217, 8010, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9218, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9218, 8010, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9219, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9219, 8010, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9220, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9220, 8010, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9221, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9221, 8010, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9222, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9222, 8085, 8)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9222, 8010, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9223, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9223, 8010, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9224, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9224, 8010, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9225, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9225, 8004, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9225, 8010, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9225, 8012, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9225, 8019, 31)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9225, 8119, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9225, 8121, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9225, 8122, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9225, 8123, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9225, 8135, 31)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9226, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9226, 8004, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9226, 8010, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9226, 8012, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9226, 8019, 32)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9226, 8119, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9226, 8121, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9226, 8122, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9226, 8123, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9226, 8135, 32)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9227, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9227, 8004, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9227, 8010, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9227, 8012, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9227, 8019, 33)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9227, 8119, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9227, 8121, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9227, 8122, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9227, 8123, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9227, 8135, 33)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9228, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9228, 8010, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9229, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9229, 8010, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9230, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9230, 8010, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9231, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9231, 8010, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9232, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9232, 8010, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9233, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9233, 8010, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9234, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9234, 8010, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9235, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9235, 8010, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9236, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9236, 8010, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9237, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9237, 8010, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9238, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9238, 8010, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9239, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9239, 8010, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9240, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9240, 8010, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9241, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9241, 8010, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9242, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9242, 8010, 0)
GO

INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9244, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9244, 8010, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9245, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9245, 8087, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9245, 8010, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9245, 8095, 81)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9246, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9246, 8087, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9246, 8010, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9246, 8095, 82)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9247, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9247, 8087, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9247, 8010, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9247, 8095, 83)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9248, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9248, 8087, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9248, 8010, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9248, 8095, 84)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9249, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9249, 8085, 86)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9249, 8086, 6)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9249, 8087, 86)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9249, 8088, 5)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9249, 8090, 86)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9249, 8091, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9249, 8092, 4)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9249, 8094, 5)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9249, 8095, 86)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9249, 8096, 86)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9249, 8098, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9249, 8099, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9249, 8100, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9249, 8101, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9249, 8102, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9249, 8103, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9249, 8104, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9249, 8105, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9249, 8106, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9249, 8107, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9249, 8109, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9249, 8110, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9249, 8113, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9249, 8114, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9249, 8115, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9249, 8117, 86)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9249, 8125, 86)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9249, 8129, 86)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9249, 8132, 86)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9250, 0, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9250, 8087, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9250, 8095, 30)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9251, 0, 2)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9251, 8087, 2)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9251, 8095, 29)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9252, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9252, 8087, 100)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9252, 8095, 100)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9253, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9253, 8090, 102)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9253, 8129, 102)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9253, 8132, 102)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9254, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9254, 8090, 106)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9255, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9255, 8090, 109)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9256, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9256, 8090, 112)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9256, 8132, 112)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9257, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9257, 8090, 116)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9258, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9258, 8131, 129)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9258, 8133, 129)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9258, 8134, 129)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9259, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9259, 8131, 130)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9259, 8133, 130)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9259, 8134, 130)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9260, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9260, 8085, 10)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9260, 8086, 11)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9260, 8088, 9)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9260, 8091, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9260, 8092, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9260, 8094, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9260, 8098, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9260, 8099, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9260, 8100, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9260, 8101, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9260, 8102, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9260, 8103, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9260, 8104, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9260, 8105, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9260, 8106, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9260, 8107, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9260, 8109, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9260, 8110, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9260, 8113, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9260, 8114, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9260, 8115, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9261, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9261, 8085, 11)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9261, 8088, 133)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9261, 8096, 133)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9261, 8131, 133)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9261, 8133, 133)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9261, 8134, 133)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9262, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9262, 8093, 3)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9263, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9263, 8093, 5)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9264, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9264, 8093, 4)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9265, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9265, 8093, 2)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9266, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9266, 8086, 12)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9267, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9267, 8089, 143)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9268, 8089, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9269, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9269, 8089, 145)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9270, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9270, 8089, 146)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9271, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9271, 8089, 147)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9272, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9272, 8089, 148)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9273, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9273, 8089, 149)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9274, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9274, 8033, 150)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9274, 8118, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9275, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9275, 8094, 151)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9276, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9276, 8092, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9277, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9277, 8120, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9277, 8129, 154)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9278, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9278, 8087, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9278, 8130, 154)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9279, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9279, 8087, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9280, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9280, 8087, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9281, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9281, 8087, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9282, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9282, 8085, -1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9282, 8086, -1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9282, 8003, -1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9282, 8004, -1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9282, 8005, -1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9282, 8006, -1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9282, 8007, -1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9282, 8087, -1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9282, 8088, -1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9282, 8010, -1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9282, 8011, -1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9282, 8012, -1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9282, 8013, -1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9282, 8014, -1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9282, 8016, -1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9282, 8017, -1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9282, 8019, -1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9282, 8089, -1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9282, 8090, -1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9282, 8022, -1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9282, 8023, -1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9282, 8024, -1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9282, 8091, -1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9282, 8026, -1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9282, 8027, -1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9282, 8092, -1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9282, 8093, -1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9282, 8094, -1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9282, 8095, -1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9282, 8096, -1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9282, 8033, -1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9282, 8097, -1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9282, 8035, -1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9282, 8098, -1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9282, 8099, -1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9282, 8100, -1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9282, 8101, -1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9282, 8102, -1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9282, 8103, -1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9282, 8104, -1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9282, 8105, -1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9282, 8106, -1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9282, 8107, -1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9282, 8108, -1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9282, 8109, -1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9282, 8110, -1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9282, 8111, -1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9282, 8112, -1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9282, 8113, -1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9282, 8114, -1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9282, 8115, -1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9282, 8116, -1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9282, 8117, -1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9282, 8118, -1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9282, 8119, -1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9282, 8120, -1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9282, 8121, -1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9282, 8122, -1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9282, 8123, -1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9282, 8062, -1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9282, 8124, -1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9282, 8065, -1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9282, 8069, -1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9282, 8126, -1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9282, 8071, -1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9282, 8130, -1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9282, 8076, -1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9282, 46005, -1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9282, 46006, -1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9282, 46007, -1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9283, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9283, 8085, 155)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9283, 8086, 155)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9283, 8088, 155)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9283, 8091, 155)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9283, 8092, 155)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9283, 8094, 155)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9284, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9284, 8085, 186)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9284, 8126, 186)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9285, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9285, 8126, 187)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9286, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9286, 8126, 188)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9287, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9287, 8126, 189)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9288, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9288, 8126, 190)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9289, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9289, 8088, 191)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9289, 8093, 191)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9290, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9290, 8085, 192)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9290, 8127, 192)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9290, 8128, 192)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9291, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9291, 8129, 193)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9292, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9292, 8129, 194)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9293, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9293, 8129, 195)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9294, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9294, 8126, 196)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9295, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9295, 8132, 197)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9296, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9296, 8132, 198)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9297, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9297, 8088, 199)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9298, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9298, 8088, 200)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9299, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9299, 8096, 201)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9300, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9300, 8096, 202)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9301, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9301, 8096, 203)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9302, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9302, 8088, 204)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9303, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (9303, 8088, 205)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (10004, 0, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (10005, 0, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (10006, 0, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (10007, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (11016, 0, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (11017, 0, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (11018, 0, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (11019, 0, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (11020, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (11023, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (11024, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (11025, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (11028, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (12010, 0, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (12011, 0, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (13002, 0, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (13003, 0, 1)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (22001, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (46009, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (46010, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (46011, 0, 0)
GO
INSERT #tmpcrmSettingRelation ([SettingID], [ParentID], [DisplayOrder]) VALUES (46012, 0, 0)
GO
-----------------

CREATE TABLE #tmpcrmSettingCN88(
	[SettingName] [varchar](50) NOT NULL,
	[SettingID] [int] NOT NULL,
	[SettingValue] [nvarchar](100) NOT NULL,
	[DisplayOrder] [int] NOT NULL,
	[IsActive] [bit] NULL,
	[SiteOffer] [tinyint] NULL
)

GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'Communication', 1013, N'Phone', 1, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'Communication', 1014, N'Email', 2, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'Communication', 1015, N'MSN', 3, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'Communication', 1016, N'Skype', 4, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'Communication', 1017, N'LiveChat', 5, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'Communication', 1018, N'N/A', 0, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'Communication', 1019, N'Yahoo', 6, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'Communication', 1020, N'WeChat', 7, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'Communication', 1021, N'Line', 8, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'Communication', 1022, N'What''sApp', 9, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'Communication', 1023, N'QQ', 10, 1, 1)
GO

INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'Communication', 1025, N'LetsTalk', 12, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'Station', 2055, N'N/A', 0, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'Role', 7011, N'Member', 1, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'Role', 7007, N'Agent', 2, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'Role', 7008, N'Master', 3, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'Role', 7009, N'Super', 4, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'Role', 7010, N'Guest', 5, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'SubProduct', 8085, N'Soccer', 1, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'SubProduct', 8086, N'Other Sports', 5, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'SubProduct', 8087, N'Number Game', 12, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'SubProduct', 8088, N'Basketball', 2, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'SubProduct', 8089, N'Virtual Sports', 15, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'SubProduct', 8090, N'Keno', 16, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'SubProduct', 8091, N'Muay Thai', 4, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'SubProduct', 8092, N'Tennis', 3, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'SubProduct', 8093, N'Baseball', 3, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'SubProduct', 8094, N'Cricket', 4, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'SubProduct', 8095, N'Turbo Number Game', 12, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'SubProduct', 8096, N'E-Sports', 4, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'SubProduct', 8097, N'Outright', 24, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'SubProduct', 8098, N'Badminton', 26, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'SubProduct', 8099, N'American Football', 26, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'SubProduct', 8100, N'Darts', 26, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'SubProduct', 8101, N'Field Hockey', 26, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'SubProduct', 8102, N'Golf', 26, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'SubProduct', 8103, N'Ice Hockey', 26, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'SubProduct', 8104, N'Motorsport', 26, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'SubProduct', 8105, N'Rugby', 26, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'SubProduct', 8106, N'Snooker/Pool', 26, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'SubProduct', 8107, N'Volleyball', 26, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'SubProduct', 8108, N'Athletics', 26, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'SubProduct', 8109, N'Boxing/MMA', 26, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'SubProduct', 8110, N'Cycling', 26, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'SubProduct', 8111, N'Diving', 26, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'SubProduct', 8112, N'Entertainment', 26, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'SubProduct', 8113, N'Handball', 26, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'SubProduct', 8114, N'Netball', 26, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'SubProduct', 8115, N'Squash', 26, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'SubProduct', 8116, N'Swimming', 26, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'SubProduct', 8117, N'Water Polo', 26, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'SubProduct', 8118, N'Virtual Soccer', 26, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'SubProduct', 8119, N'Virtual Horse Racing', 26, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'SubProduct', 8120, N'Virtual Tennis', 26, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'SubProduct', 8121, N'Virtual Greyhound', 26, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'SubProduct', 8122, N'Virtual Speedway', 26, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'SubProduct', 8123, N'Virtual Motorsports', 26, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'SubProduct', 8124, N'N/A.', -1, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'SubProduct', 8125, N'Table Tennis', 3, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'SubProduct', 8126, N'Fast Market', 33, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'SubProduct', 8127, N'Virtual Soccer League', 35, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'SubProduct', 8128, N'Virtual Soccer Nation', 36, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'SubProduct', 8129, N'Keno Lottery', 37, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'SubProduct', 8130, N'Kabaddi', 38, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'SubProduct', 8131, N'Virtual Basketball', 41, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'SubProduct', 8132, N'Happy5', 44, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'SubProduct', 8133, N'Virtual Soccer World Cup', 45, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'SubProduct', 8134, N'Virtual Soccer Asian', 46, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'SubProduct', 8135, N'Virtual Cycling', 47, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9198, N'FT.HDP', 1, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9199, N'FT.O/U', 3, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9200, N'OE', 2, 0, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9201, N'H/L', 89, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9202, N'Double chance', 24, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9203, N'MoneyLine', 6, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9204, N'Total Goal', 6, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9205, N'Correct Score', 4, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9206, N'FT.1X2', 5, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9207, N'1H Handicap', 7, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9208, N'1H Over/Under', 8, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9209, N'Mix Parlay', 9, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9210, N'Outright', 10, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9211, N'Total Corners', 11, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9212, N'1H Odd/Even', 12, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9213, N'Clean Sheet', 13, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9214, N'First Goal/Last Goal', 14, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9215, N'1H 1X2', 15, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9216, N'HT/FT', 16, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9217, N'Substitutes', 19, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9218, N'1st Money Line', 21, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9219, N'Next Goal', 22, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9220, N'Next Corner', 23, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9221, N'Draw No Bet', 25, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9222, N'Both/One/Neither team to score', 26, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9223, N'To win to nil', 27, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9224, N'3Way Handicap', 28, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9225, N'Win', 31, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9226, N'Place', 32, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9227, N'Win/Place', 33, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9228, N'Win.UK Tote', 41, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9229, N'Place.UK Tote', 42, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9230, N'Win/Place.UK Tote', 43, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9231, N'5 min O/U', 51, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9232, N'15 min O/U', 52, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9233, N'30 min O/U', 53, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9234, N'45 min O/U', 54, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9235, N'60 min O/U', 55, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9236, N'End of day O/U', 56, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9237, N'5 min OE', 61, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9238, N'15 min OE', 62, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9239, N'30 min OE', 63, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9240, N'45 min OE', 64, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9241, N'60 min OE', 65, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9242, N'End of day OE', 66, 1, 1)
GO

INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9244, N'P2P Games', 72, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9245, N'1st ball OU', 81, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9246, N'Last ball OU', 82, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9247, N'1st ball OE', 83, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9248, N'Last ball OE', 84, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9249, N'Odd/Even', 86, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9250, N'Warrior', 30, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9251, N'Next Combo', 29, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9252, N'Number Wheel', 100, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9253, N'Big/Small', 102, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9254, N'Dragon/Tiger', 106, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9255, N'Up/Down', 109, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9256, N'Combo', 112, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9257, N'Five Elements', 116, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9258, N'1H HDP', 129, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9259, N'1H O/U', 130, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9260, N'System Parlay', 132, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9261, N'Special Bet Types', 133, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9262, N'1H Total Run', 134, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9263, N'1H Runline', 135, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9264, N'Runline', 136, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9265, N'Total Run', 137, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9266, N'Mixed Sports Parlay', 138, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9267, N'Virtual Soccer', 143, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9268, N'Virtual Horse Racing', 144, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9269, N'Virtual Greyhounds', 145, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9270, N'Virtual Tennis', 146, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9271, N'Virtual Speedway', 147, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9272, N'Virtual Motorsports', 148, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9273, N'Virtual Cycling', 149, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9274, N'1X2', 150, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9275, N'Match Winner', 151, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9276, N'Set X Winner', 154, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9277, N'Total Points', 154, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9278, N'FT. OE', 154, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9279, N'Next OE', 154, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9280, N'Next OU', 154, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9281, N'Next HL', 154, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9282, N'N/A.', -1, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9283, N'Combo Parlay', 155, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9284, N'Next 1 Minute', 186, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9285, N'Next 5 Minute', 187, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9286, N'What will happen first in next 1 minute', 188, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9287, N'What will happen first in next 5 minute', 189, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9288, N'Next 1 Minute Set Piece', 190, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9289, N'1H Moneyline', 191, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9290, N'1H Correct Score', 192, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9291, N'Colour Range', 193, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9292, N'Single Dice Result', 194, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9293, N'Any Triple', 195, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9294, N'Which combination will happen first in next X minutes', 196, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9295, N'Four Seasons', 197, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9296, N'MO/ME', 198, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9297, N'Q X HDP', 199, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9298, N'Q X OU', 200, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9299, N'Map X HDP', 201, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9300, N'Map X OU', 202, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9301, N'Map X ML', 203, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9302, N'Q X OE', 204, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'BetType', 9303, N'Q x ML', 205, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'Response', 10004, N'Satisfied', 2, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'Response', 10005, N'Unsatisfied', 3, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'Response', 10006, N'Neutral', 1, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'Response', 10007, N'inefficient', 4, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'Status', 11016, N'Pending', 1, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'Status', 11017, N'Closed', 2, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'Status', 11018, N'Solved', 3, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'Status', 11019, N'Deleted', 4, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'Status', 11020, N'Checked', 5, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'Status', 11021, N'KIV', 1, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'Status', 11022, N'Open', 1, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'Status', 11023, N'Claimed', 6, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'Status', 11024, N'Expired', 7, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'Status', 11025, N'Cancelled', 8, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'Status', 11026, N'Enabled', 9, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'Status', 11027, N'Disabled', 10, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'Status', 11028, N'Comment', 11, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'Language', 12010, N'Mandarin', 2, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'Language', 12011, N'Cantonese', 3, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'Title', 13002, N'Mr', 1, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'Title', 13003, N'Ms', 3, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'Inform New Product', 22001, N'Inform New Product', 0, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'InformHeadlineStatus', 45008, N'Done', 1, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'InformHeadlineStatus', 45009, N'Request to call back', 2, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'InformHeadlineStatus', 45010, N'No need to call', 3, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'InformHeadlineStatus', 45011, N'No reply', 4, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'InformHeadlineStatus', 45012, N'Uncontactable', 5, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'InformHeadlineStatus', 45013, N'Internal account', 6, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'InformHeadlineStatus', 45014, N'Never touch', 7, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'InformHeadlineStatus', 45015, N'Kept for reference', 8, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'Product', 46009, N'Sportsbook', 1, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'Product', 46010, N'Virtual Sports', 2, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'Product', 46011, N'N/A.', -1, 1, 1)
GO
INSERT #tmpcrmSettingCN88 ([SettingName], [SettingID], [SettingValue], [DisplayOrder], [IsActive], [SiteOffer]) VALUES (N'Product', 46012, N'Numbers', 8, 1, 1)
GO


INSERT INTO crmSetting(SettingID,SettingName,SettingValue,IsActive,DisplayOrder,SiteOffer)
SELECT SettingID,SettingName,SettingValue,IsActive,DisplayOrder,SiteOffer
FROM #tmpcrmSettingCN88

INSERT INTO crmSettingRelation(SettingID,ParentID,DisplayOrder)
SELECT SettingID,ParentID,DisplayOrder
FROM #tmpcrmSettingRelation

