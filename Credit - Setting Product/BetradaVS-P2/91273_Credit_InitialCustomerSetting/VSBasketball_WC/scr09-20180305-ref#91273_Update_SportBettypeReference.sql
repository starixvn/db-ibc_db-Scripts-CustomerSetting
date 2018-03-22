/*
    Created: 20180320@Vicky 
    Task: Update isActive = 1 for Sport_Bettype_Reference_Setting table
    DB: DBTXN/bodb02
*/ 
USE bodb02
GO

DECLARE @tbl_SportType TABLE (SportType SMALLINT)


INSERT INTO @tbl_SportType(SportType)
VALUES (192), (192)


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
UPDATE ps
SET ps.isActive = 1
FROM dbo.Sport_Bettype_Reference_Setting ps WITH (ROWLOCK,UPDLOCK)
    INNER JOIN @tbl_SportType spt ON spt.SportType = ps.SportType
