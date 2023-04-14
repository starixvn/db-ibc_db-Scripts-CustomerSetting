/*<info serverAlias="DBCUST-CustDB"></info>*/ 
/*
	Created: Helios@2023/03/17
	Task: DEPOSIT - Delete Old Data Setting For PP - Pragmatic [RM:#181686]
	DB: DBCUST/CUSTDB

	Revisions:
		- Change the bet limit setting for Nova88, 789y, IBCBet & licensees [RM:#181686] 
*/

ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_09]
	@target VARCHAR(20)

AS
BEGIN
	SET NOCOUNT ON  
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','TESTDBCUST','DB230\SQLSERVER2008R2')) RETURN -- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','TESTDBCUST','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only 

-----Check Replicate	
	IF NOT (dbo.f_CheckRepTable('Custinfo') = 1 
	   AND dbo.f_CheckRepTable('Dep_CustStakeLevel_Agent') = 1
	   AND dbo.f_CheckRepTable('Dep_CustStakeLevel_Member') = 1
	   )
		RETURN


---------------------------------COLLECT DATA---------------------------------

DECLARE @Old_BetType SMALLINT
	,	@SportType SMALLINT


SELECT @Old_BetType = 4101
	,  @SportType = 248

IF OBJECT_ID('tempdb..#Dep_CustListAgent') IS NOT NULL
    DROP TABLE #Dep_CustListAgent ;  
IF OBJECT_ID('tempdb..#Dep_CustListMember') IS NOT NULL
    DROP TABLE #Dep_CustListMember ;  
IF OBJECT_ID('tempdb..#Dep_CustStakeLevel_Agent') IS NOT NULL
    DROP TABLE #Dep_CustStakeLevel_Agent ;  
IF OBJECT_ID('tempdb..#Dep_CustStakeLevel_Member') IS NOT NULL
    DROP TABLE #Dep_CustStakeLevel_Member ;  

CREATE TABLE #Dep_CustListAgent (CustID INT PRIMARY KEY CLUSTERED,isfinished BIT DEFAULT(0))
CREATE TABLE #Dep_CustListMember (CustID INT PRIMARY KEY CLUSTERED,isfinished BIT DEFAULT(0))
CREATE TABLE #Dep_CustStakeLevel_Agent  (CustID INT	 PRIMARY KEY(CustID))
CREATE TABLE #Dep_CustStakeLevel_Member (CustID INT	 PRIMARY KEY(CustID))
 

INSERT INTO #Dep_CustListAgent(CustID)
SELECT  cg.custid
FROM dbo.Dep_CustStakeLevel_Agent cg WITH(NOLOCK)	
WHERE SportType = @Sporttype 
AND BetType = @Old_BetType
	
INSERT INTO #Dep_CustListMember(CustID)
SELECT cg.custid  
FROM dbo.Dep_CustStakeLevel_Member cg WITH(NOLOCK)	
WHERE SportType = @Sporttype
AND BetType = @Old_BetType


DECLARE @BatchSize INT = 5000 

-----------------------------------Dep_CustStakeLevel_Agent---------------------------------
WHILE (1 = 1)
	BEGIN
		UPDATE TOP (@BatchSize) c WITH (ROWLOCK)
		SET c.isfinished = 1
		OUTPUT DELETED.CustID INTO #Dep_CustStakeLevel_Agent (CustID)
		FROM #Dep_CustListAgent c
		WHERE isfinished = 0

		IF @@ROWCOUNT = 0
			BREAK;

		DELETE cM
		FROM Dep_CustStakeLevel_Agent cM WITH (ROWLOCK, UPDLOCK)
		INNER JOIN #Dep_CustStakeLevel_Agent cust on cM.CustID = cust.CustID
		WHERE SportType = @SportType 
		AND BetType = @Old_BetType 

		DELETE FROM #Dep_CustStakeLevel_Agent

	END

-----------------------------------Dep_CustStakeLevel_Member---------------------------------

WHILE (1 = 1)
	BEGIN
		UPDATE TOP (@BatchSize) c WITH (ROWLOCK)
		SET c.isfinished = 1
		OUTPUT DELETED.CustID INTO #Dep_CustStakeLevel_Member (CustID)
		FROM #Dep_CustListMember c
		WHERE isfinished = 0

		IF @@ROWCOUNT = 0
			BREAK;

		DELETE cM
		FROM Dep_CustStakeLevel_Member cM WITH (ROWLOCK, UPDLOCK)
		INNER JOIN #Dep_CustStakeLevel_Member cust on cM.CustID = cust.CustID
		WHERE SportType = @SportType 
		AND BetType = @Old_BetType 

		DELETE FROM #Dep_CustStakeLevel_Member

	END
END
GO

--END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
----------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS -----
----------------------------------------------------------------------------------
EXEC dbo.Acc_DynamicCustSetting3rd_09 @target = 'REPLICATED'


-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
EXEC dbo.Acc_DynamicCustSetting3rd_09 @target = 'DBCUST'


	
