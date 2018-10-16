/*
	Created: 20181011@Winnie
	Task: Add new column to the replicated table Dep_ProductSettingDetail
	DB: DBCUST/CustDB
*/
ALTER TABLE Dep_ProductSettingDetail
ADD IsApplyBA BIT

UPDATE Dep_ProductSettingDetail WITH(ROWLOCK,UPDLOCK)
	SET IsApplyBA=0

ALTER TABLE Dep_ProductSettingDetail
ALTER COLUMN IsApplyBA BIT NOT NULL