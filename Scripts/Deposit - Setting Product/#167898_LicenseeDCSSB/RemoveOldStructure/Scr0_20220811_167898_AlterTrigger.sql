/*<info serverAlias="DBTP-bodb02"></info>*/
/*
	Created: Eden@20220811
	Task: Alter trigger remove unused columns [Redmine: #167898]   
	DB: DBTP/bodb02
*/
USE [bodb02]
GO
/****** Object:  Trigger [dbo].[custsetting_update]    Script Date: 9/27/2021 2:26:51 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TRIGGER [dbo].[custsetting_update] ON [dbo].[custSetting]
AFTER UPDATE
AS
/*
	Created by: 
	Task: Trigger for updating custsetting table 
	DB: DBTP/bodb02
	Revisions: 

	- 20150615@Lukas: Migrate history tables to new database bodb_CustHistory on DBTP
	- 20220811@Eden: Remove unused columns [Redmine: #167898]   
*/
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

	INSERT INTO bodb_CustHistory.dbo.custsetting_history (
						custid, bettype, sporttype, apositiontaking, mpositiontaking, spositiontaking, alivepositiontaking, mlivepositiontaking, slivepositiontaking,
						  playerdiscount, discount, adiscount, sdiscount, groupa, groupb, groupc, groupd,
							--groupe, groupf, --exclude these fields as they are not in use.
						 autopositiontaking,
						  autolivepositiontaking, isautopositiontaking, isautolivepositiontaking, autompositiontaking, autolivempositiontaking, isautompositiontaking,
						  isautolivempositiontaking)
	SELECT
						custid, bettype, sporttype, apositiontaking, mpositiontaking, spositiontaking, alivepositiontaking, mlivepositiontaking, slivepositiontaking,
						  playerdiscount, discount, adiscount, sdiscount, groupa, groupb, groupc, groupd,
							--groupe, groupf, --exclude these fields as they are not in use.
						 autopositiontaking,
						  autolivepositiontaking, isautopositiontaking, isautolivepositiontaking, autompositiontaking, autolivempositiontaking, isautompositiontaking,
						  isautolivempositiontaking
	FROM [DELETED]
	
	 
END 
GO
------------------------------------------------------------------------------------------------------
/****** Object:  Trigger [dbo].[custsetting3rd_update]    Script Date: 9/27/2021 2:27:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TRIGGER [dbo].[custsetting3rd_update] ON [dbo].[CustSetting3rd]
AFTER UPDATE
AS
/*
	Created by: 
	Task: Trigger for updating custsetting3rd table 
	DB: DBTP/bodb02
	Revisions: 

	- 20150615@Lukas: Migrate history tables to new database bodb_CustHistory on DBTP
	- 20220811@Eden: Remove unused columns [Redmine: #167898]    
*/
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
	SET NOCOUNT ON;

	INSERT INTO bodb_CustHistory.dbo.custsetting3rd_history
			(    custid, bettype, sporttype, apositiontaking, mpositiontaking, spositiontaking,
				playerdiscount, discount, adiscount, sdiscount,
				autopositiontaking,
				isautopositiontaking, autompositiontaking, isautompositiontaking
				,[alivepositiontaking]
			  ,[mlivepositiontaking]
			  ,[slivepositiontaking]
			  ,[autolivepositiontaking]
			  ,[isautolivepositiontaking]
			  ,[autolivempositiontaking]
			  ,[isautolivempositiontaking])
	SELECT
				custid, bettype, sporttype, apositiontaking, mpositiontaking, spositiontaking,
				playerdiscount, discount, adiscount, sdiscount,
				autopositiontaking,
				isautopositiontaking, autompositiontaking, isautompositiontaking
				,[alivepositiontaking]
			  ,[mlivepositiontaking]
			  ,[slivepositiontaking]
			  ,[autolivepositiontaking]
			  ,[isautolivepositiontaking]
			  ,[autolivempositiontaking]
			  ,[isautolivempositiontaking]
	FROM [DELETED]
END
------------------------------------------------------------------------------------------------------
GO
