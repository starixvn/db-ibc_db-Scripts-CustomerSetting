/*
	Created: 20181011@Winnie
	Task: Add new column to the replicated table Dep_ProductSettingDetail
	DB: DBCUST/CustDB
*/
ALTER TABLE Dep_ProductSettingDetail
ADD IsApplyBA BIT NOT NULL CONSTRAINT [DF_Dep_ProductSettingDetail_IsApplyBA]  DEFAULT ((0))

UPDATE Dep_ProductSettingDetail WITH(ROWLOCK,UPDLOCK)
	SET IsApplyBA=0

