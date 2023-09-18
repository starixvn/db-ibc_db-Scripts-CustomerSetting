/*<info serverAlias="DBCUST-CustDB"></info>*/
USE CustDB
GO
/*
	Created: 20230913@Winfred
	DB: DBCUST/CustDB
	Task: [NAP CM] Customer Class - Support ticket data
	Revisions:
		- 20230913@Winfred: Clear all data of Rule management except Basketball rules
							Clear all basketball rules if CC is 902
							Clear all data of Policy management
							Clear all data of Site management [RedmineID: #193890] 
*/
-- Clear data
--===================================================================================
ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_09]
	@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON

	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN -- run at dbtrans only

	DECLARE @batch INT = 3000

	WHILE EXISTS(SELECT TOP 1 1 FROM CustomerClassSiteManagement WITH(NOLOCK) )
	BEGIN	
	
		DELETE TOP (@batch) cg
		FROM dbo.CustomerClassSiteManagement cg WITH(ROWLOCK)		
		OPTION(MAXDOP 1)

		IF @@ROWCOUNT=0
			BREAK		
				
	END  
END	
GO


	DECLARE @target VARCHAR(20)
	IF @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')
	BEGIN
		SET @target = 'DBCUST'
	END
	ELSE 
	BEGIN	
		SET @target = 'REPLICATED'
	END
	PRINT 'Server Name : ' + @target


	IF @target = 'DBCUST'
	BEGIN
		CREATE TABLE #CustomerClassRule (RuleID INT PRIMARY KEY )
		INSERT INTO #CustomerClassRule(RuleID)
		SELECT RuleID 
		FROM CustomerClassRule WITH(NOLOCK) 
		WHERE SportType <> 2 OR CustomerClass = 902

		DELETE ccl  
		FROM CustomerClassRuleLeagueGroup ccl WITH(ROWLOCK)
			INNER JOIN #CustomerClassRule c ON ccl.RuleID = c.RuleID

		DELETE ccl  
		FROM CustomerClassRule ccl WITH(ROWLOCK)
			INNER JOIN #CustomerClassRule c ON ccl.RuleID = c.RuleID
		DROP TABLE #CustomerClassRule
	
		DELETE ccs FROM CustomerClassPolicyRule ccs WITH(ROWLOCK,UPDLOCK)
	

		DBCC CHECKIDENT ('CustomerClassPolicyManagement', RESEED, 0)
		DELETE ccs FROM CustomerClassPolicyManagement ccs WITH(ROWLOCK,UPDLOCK)
	
	END

	EXEC Acc_Dep_DynamicCustSetting_09 @target = @target

GO