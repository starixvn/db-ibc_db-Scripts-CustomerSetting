/*
    Created: Vicky
    Date: 20180326
    Task: add RefResource for Pragmatic game [RedmineID: 90422]
    DB:DBPRO/bodb02
*/

DELETE FROM RefResource WHERE RefId = 'StakeLevel_GG' AND ResourceId = 6
DELETE FROM RefResource WHERE RefId = 'StakeLevel_GG' AND ResourceId = 7
DELETE FROM RefResource WHERE RefId = 'Product' AND ResourceId = 32

INSERT INTO dbo.RefResource (RefId, ResourceId, Resource_en)
VALUES ('StakeLevel_GG', 6, 'Level 1'),
       ('StakeLevel_GG', 7, 'Level 2'),
       ('Product', 32, 'PP'),