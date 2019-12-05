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
	,@maxcustid INT
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only

	IF dbo.f_CheckRepTable('CustStakeLevel_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustStakeLevel_Member') = 0 RETURN
	
	DECLARE @Sporttype SMALLINT,@Bettype INT 
	
	SELECT @Sporttype = 211
	SELECT @Bettype=2402
	
	WHILE(1=1)
	BEGIN
		DELETE TOP (3000) FROM CustStakeLevel_Agent WITH(ROWLOCK) WHERE CustID<=@maxcustid AND SportType=@Sporttype AND Bettype=@Bettype
		IF @@ROWCOUNT<=3000
			BREAK
	END
			
	WHILE(1=1)
	BEGIN
		DELETE TOP (3000) FROM CustStakeLevel_Member WITH(ROWLOCK) WHERE CustID<=@maxcustid AND SportType=@Sporttype AND Bettype=@Bettype
		IF @@ROWCOUNT<=3000
			BREAK
	END
END	
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS -----
--------------------------------------------------------------------------------------
DECLARE @max_custid INT

SELECT @max_custid = xxx
EXEC dbo.Acc_DynamicCustSetting3rd_09 @target = 'REPLICATED',@maxcustid = @max_custid


-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
DECLARE @max_custid INT

SELECT @max_custid = xxx
EXEC dbo.Acc_DynamicCustSetting3rd_09 @target = 'DBCUST',@maxcustid = @max_custid

