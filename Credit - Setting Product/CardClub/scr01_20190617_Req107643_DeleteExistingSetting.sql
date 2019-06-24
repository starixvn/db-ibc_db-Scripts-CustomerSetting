/*
	Created: Winnie
	Date: 20190617
	Task: Delete existing data of Sporttype=165. Cardclub RedmineID:#107643
	DB: DBCust/CustDB
*/
 
 -- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB ------
------------------------------------------------------
ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_09]
	@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only

	IF dbo.f_CheckRepTable('CustStakeLevel_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustStakeLevel_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('StakeLevel') = 0 RETURN
	IF dbo.f_CheckRepTable('ProductSettingDetail') = 0 RETURN
	IF dbo.f_CheckRepTable('GameGroup') = 0 RETURN
	
	DECLARE @Sporttype SMALLINT 
	
	SELECT @Sporttype = 165

	DELETE FROM ProductSettingDetail WITH(ROWLOCK,UPDLOCK) WHERE SportType=@Sporttype
	DELETE FROM GameGroup WITH(ROWLOCK,UPDLOCK) WHERE RefSportType=@Sporttype
	DELETE FROM StakeLevel WITH(ROWLOCK,UPDLOCK)  WHERE GametypeID=1901
	DELETE FROM StakeLevelGroupDetail  WITH(ROWLOCK,UPDLOCK)  WHERE GametypeID=1901

	WHILE EXISTS(SELECT TOP 1 1 CustID FROM CustStakeLevel_Agent WITH(NOLOCK)  WHERE SportType=@Sporttype)
	BEGIN
		DELETE TOP (3000) FROM CustStakeLevel_Agent WITH(ROWLOCK,UPDLOCK) WHERE SportType=@Sporttype
	END

	WHILE EXISTS(SELECT TOP 1 1 CustID FROM CustStakeLevel_Member WITH(NOLOCK)  WHERE SportType=@Sporttype)
	BEGIN
		DELETE TOP (3000) FROM CustStakeLevel_Member WITH(ROWLOCK,UPDLOCK) WHERE SportType=@Sporttype
	END	
END	
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS -----
--------------------------------------------------------------------------------------
EXEC dbo.Acc_DynamicCustSetting3rd_09 @target = 'REPLICATED'


-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
EXEC dbo.Acc_DynamicCustSetting3rd_09 @target = 'DBCUST'

