/*
	Created: Winnie
	Date: 20191203
	Task: Delete existing data of Sporttype=211 bettype 2402 RedmineID:#124422
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
	IF dbo.f_CheckRepTable('ProductStatusProfile') = 0 RETURN
	IF dbo.f_CheckRepTable('ProductSettingDetail') = 0 RETURN
	
	DECLARE @Sporttype SMALLINT,@Bettype INT 
	
	SELECT @Sporttype = 211
	SELECT @Bettype=2402

	DELETE FROM ProductSettingDetail WITH(ROWLOCK,UPDLOCK) WHERE SportType=@Sporttype AND Bettype=@Bettype	
	DELETE FROM ProductStatusProfile WITH(ROWLOCK,UPDLOCK) WHERE SportType=@Sporttype AND Bettype=@Bettype	
	DELETE FROM StakeLevel WITH(ROWLOCK,UPDLOCK)  WHERE GametypeID=@Bettype

	WHILE EXISTS(SELECT TOP 1 1 CustID FROM CustStakeLevel_Agent WITH(NOLOCK)  WHERE SportType=@Sporttype AND Bettype=@Bettype)
	BEGIN
		DELETE TOP (3000) FROM CustStakeLevel_Agent WITH(ROWLOCK,UPDLOCK) WHERE SportType=@Sporttype AND Bettype=@Bettype
	END

	WHILE EXISTS(SELECT TOP 1 1 CustID FROM CustStakeLevel_Member WITH(NOLOCK)  WHERE SportType=@Sporttype AND Bettype=@Bettype)
	BEGIN
		DELETE TOP (3000) FROM CustStakeLevel_Member WITH(ROWLOCK,UPDLOCK) WHERE SportType=@Sporttype AND Bettype=@Bettype
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

