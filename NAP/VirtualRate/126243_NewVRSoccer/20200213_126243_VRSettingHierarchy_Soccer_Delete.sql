/*
    Created: Tiara
    Date: 2020-02-11
    Task : Delete data from VRSettingHierarchy- Soccer [Redmine: #126243]
    DB: DBCUST/CustDB
*/
USE CustDB
GO

DELETE V
FROM VRSettingHierarchy V WITH (ROWLOCK)
WHERE V.LevelID > = 154 AND V.SportType = 1