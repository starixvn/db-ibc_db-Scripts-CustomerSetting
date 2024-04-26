/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Tacy@20240306
	Task: Deposit - Clean VS1, VS2, VS3 - Existed Customers Setting - [redmine: #198008]
	DB: DBCUST/CUSTDB
*/
-- EPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	
ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_09]
 	 @CustList VARCHAR(MAX) --JsonData
	,@TableName VARCHAR(200)
	,@target VARCHAR(20)
AS
/*
	1) Dep_LicenseeProductSetting 
	2) Dep_CustDiscountGroupSetting_Member
	3) Dep_CustDiscountSetting_Member
	4) Dep_CustBetSetting_Agent
	5) Dep_CustBetSetting_Member
	6) Dep_CustPTGroupSetting_Member
	7) Dep_CustPTSetting_Agent
	8) Dep_CustPTSetting_Member
*/

BEGIN	
	SET NOCOUNT ON;
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN -- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN -- run at dbcust only
	
	IF (dbo.f_CheckRepTable('Dep_CustPTSetting_Member') = 0
		OR dbo.f_CheckRepTable('Dep_CustPTSetting_Agent') = 0
		OR dbo.f_CheckRepTable('Dep_CustPTGroupSetting_Member') = 0
		
		OR dbo.f_CheckRepTable('Dep_LicenseeProductSetting') = 0 
		
		OR dbo.f_CheckRepTable('Dep_CustBetSetting_Agent') = 0 
		OR dbo.f_CheckRepTable('Dep_CustBetSetting_Member') = 0 

		OR dbo.f_CheckRepTable('Dep_CustDiscountSetting_Member') = 0 
		OR dbo.f_CheckRepTable('Dep_CustDiscountGroupSetting_Member') = 0 	
		)
		RETURN

	IF @TableName = 'Dep_LicenseeProductSetting' --1)
	BEGIN
		DELETE a
		FROM Dep_LicenseeProductSetting a WITH(ROWLOCK)
		INNER JOIN OPENJSON(@CustList) 
			WITH (CustID			INT	'$.CustID',
				  ProductSettingID	INT	'$.ProductSettingID'
				) AS js
			ON js.CustID=a.CustID AND js.ProductSettingID=a.ProductSettingID
	END

	IF @TableName = 'Dep_CustPTSetting_Agent' --2)
	BEGIN
		DELETE a
		FROM Dep_CustPTSetting_Agent a WITH(ROWLOCK)
		INNER JOIN OPENJSON(@CustList) 
			WITH (  CustID		INT	'$.CustID',
					SportType	SMALLINT	'$.SportType',
					BetType		SMALLINT	'$.BetType'
				) AS js
			ON js.CustID=a.CustID
			AND js.SportType=a.SportType
			AND js.BetType=a.BetType
	END

	IF @TableName = 'Dep_CustPTGroupSetting_Member' --3)
	BEGIN
		DELETE a
		FROM Dep_CustPTGroupSetting_Member a WITH(ROWLOCK)
		INNER JOIN OPENJSON(@CustList) 
			WITH (  CustID		INT	'$.CustID',
					SportType	SMALLINT	'$.SportType',
					BetType		SMALLINT	'$.BetType'
				) AS js
			ON js.CustID=a.AgentID
			AND js.SportType=a.SportType
			AND js.BetType=a.BetType
	END

	IF @TableName = 'Dep_CustPTSetting_Member' --4)
	BEGIN
		DELETE a
		FROM Dep_CustPTSetting_Member a WITH(ROWLOCK)
		INNER JOIN OPENJSON(@CustList) 
			WITH (  CustID		INT	'$.CustID',
					SportType	SMALLINT	'$.SportType',
					BetType		SMALLINT	'$.BetType'
				) AS js
			ON js.CustID=a.CustID
			AND js.SportType=a.SportType
			AND js.BetType=a.BetType
	END

	IF @TableName = 'Dep_CustDiscountGroupSetting_Member' --5)
	BEGIN
		DELETE a
		FROM Dep_CustDiscountGroupSetting_Member a WITH(ROWLOCK)
		INNER JOIN OPENJSON(@CustList) 
			WITH (  CustID		INT	'$.CustID',
					SportType	SMALLINT	'$.SportType',
					BetType		SMALLINT	'$.BetType'
				) AS js
			ON js.CustID=a.AgentID
			AND js.SportType=a.SportType
			AND js.BetType=a.BetType
	END

	IF @TableName = 'Dep_CustDiscountSetting_Member' --6)
	BEGIN
		DELETE a
		FROM Dep_CustDiscountSetting_Member a WITH(ROWLOCK)
		INNER JOIN OPENJSON(@CustList) 
			WITH (  CustID		INT	'$.CustID',
					SportType	SMALLINT	'$.SportType',
					BetType		SMALLINT	'$.BetType'
				) AS js
			ON js.CustID=a.CustID
			AND js.SportType=a.SportType
			AND js.BetType=a.BetType
	END
	
	IF @TableName = 'Dep_CustBetSetting_Agent' --7)
	BEGIN
		DELETE a
		FROM Dep_CustBetSetting_Agent a WITH(ROWLOCK)
		INNER JOIN OPENJSON(@CustList) 
			WITH (  CustID		INT	'$.CustID',
					SportType	SMALLINT	'$.SportType',
					BetType		SMALLINT	'$.BetType'
				) AS js
			ON js.CustID=a.CustID
			AND js.SportType=a.SportType
			AND js.BetType=a.BetType
	END
		
	IF @TableName = 'Dep_CustBetSetting_Member' --8)
	BEGIN
		DELETE a
		FROM Dep_CustBetSetting_Member a WITH(ROWLOCK)
		INNER JOIN OPENJSON(@CustList) 
			WITH (  CustID		INT	'$.CustID',
					SportType	SMALLINT '$.SportType',
					BetType		SMALLINT '$.BetType'
				) AS js
			ON js.CustID=a.CustID
			AND js.SportType=a.SportType
			AND js.BetType=a.BetType
	END
END
GO