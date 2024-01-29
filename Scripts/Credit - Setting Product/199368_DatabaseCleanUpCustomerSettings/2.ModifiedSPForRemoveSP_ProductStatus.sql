/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240104@Helios
	Task: Modified SP execrep for Remove Data [#199368]
		https://nexdev.net/issues/199368
	DB: DBCust/CustDB 
*/

ALTER PROCEDURE [dbo].[Acc_DynamicCustomerInfo_09] 
  @__tableName		VARCHAR(200)  
, @JsonData			VARCHAR(MAX) 
, @target			VARCHAR (20)

AS

BEGIN
	SET NOCOUNT ON  

	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','TESTDBCUST','DB230\SQLSERVER2008R2'))			RETURN -- run at all replicated servers
	IF (@target = 'DBCUST'     AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','TESTDBCUST','DB230\SQLSERVER2008R2'))		RETURN -- run at dbcust only

---------------------------------Check Replicate---------------------------------

	IF NOT (dbo.f_CheckRepTable('Custinfo') = 1 
	   
	   AND dbo.f_CheckRepTable('CustProductStatus') = 1
	   )
		RETURN

-----------------------------------Migrate Data ---------------------------------

	IF @__tableName = 'CustProductStatus'
	BEGIN

		DELETE cpa
		FROM CustProductStatus cpa WITH (ROWLOCK)
		INNER JOIN OPENJSON(@JsonData) 
		WITH (
			CustID		INT '$.CustID'
		) AS js ON cpa.CustID = js.CustID
	END
	

END
