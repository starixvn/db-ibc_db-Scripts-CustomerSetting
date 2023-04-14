/*<info serverAlias="DBCUST-CustDB"></info>*/ 
/*
	Created: Helios@2023/03/17
	Task: CREDIT - Delete Old Data Setting For PP - Pragmatic [RM:#181686]
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
	   AND dbo.f_CheckRepTable('CustStakeLevel_Agent') = 1
	   AND dbo.f_CheckRepTable('CustStakeLevel_Member') = 1
	   )
		RETURN


---------------------------------COLLECT DATA---------------------------------

DECLARE @Old_BetType SMALLINT
	,	@SportType SMALLINT


SELECT @Old_BetType = 4101
	,  @SportType = 248

IF OBJECT_ID('tempdb..#CustListAgent') IS NOT NULL
    DROP TABLE #CustListAgent ;  
IF OBJECT_ID('tempdb..#CustListMember') IS NOT NULL
    DROP TABLE #CustListMember ;  
IF OBJECT_ID('tempdb..#CustStakeLevel_Agent') IS NOT NULL
    DROP TABLE #CustStakeLevel_Agent ;  
IF OBJECT_ID('tempdb..#CustStakeLevel_Member') IS NOT NULL
    DROP TABLE #CustStakeLevel_Member ;  

CREATE TABLE #CustListAgent (CustID INT PRIMARY KEY CLUSTERED,isfinished BIT DEFAULT(0))
CREATE TABLE #CustListMember (CustID INT PRIMARY KEY CLUSTERED,isfinished BIT DEFAULT(0))
CREATE TABLE #CustStakeLevel_Agent  (CustID INT	 PRIMARY KEY(CustID))
CREATE TABLE #CustStakeLevel_Member (CustID INT	 PRIMARY KEY(CustID))
 

INSERT INTO #CustListAgent(CustID)
SELECT  cg.custid
FROM dbo.CustStakeLevel_Agent cg WITH(NOLOCK)	
WHERE SportType = @Sporttype 
AND BetType = @Old_BetType
	
INSERT INTO #CustListMember(CustID)
SELECT cg.custid  
FROM dbo.CustStakeLevel_Member cg WITH(NOLOCK)	
WHERE SportType = @Sporttype
AND BetType = @Old_BetType


DECLARE @BatchSize INT = 5000 

-----------------------------------CustStakeLevel_Agent---------------------------------
WHILE (1 = 1)
	BEGIN
		UPDATE TOP (@BatchSize) c WITH (ROWLOCK)
		SET c.isfinished = 1
		OUTPUT DELETED.CustID INTO #CustStakeLevel_Agent (CustID)
		FROM #CustListAgent c
		WHERE isfinished = 0

		IF @@ROWCOUNT = 0
			BREAK;

		DELETE cM
		FROM CustStakeLevel_Agent cM WITH (ROWLOCK, UPDLOCK)
		INNER JOIN #CustStakeLevel_Agent cust on cM.CustID = cust.CustID
		WHERE SportType = @SportType 
		AND BetType = @Old_BetType 

		DELETE FROM #CustStakeLevel_Agent

	END

-----------------------------------CustStakeLevel_Member---------------------------------

WHILE (1 = 1)
	BEGIN
		UPDATE TOP (@BatchSize) c WITH (ROWLOCK)
		SET c.isfinished = 1
		OUTPUT DELETED.CustID INTO #CustStakeLevel_Member (CustID)
		FROM #CustListMember c
		WHERE isfinished = 0

		IF @@ROWCOUNT = 0
			BREAK;

		DELETE cM
		FROM CustStakeLevel_Member cM WITH (ROWLOCK, UPDLOCK)
		INNER JOIN #CustStakeLevel_Member cust on cM.CustID = cust.CustID
		WHERE SportType = @SportType 
		AND BetType = @Old_BetType 

		DELETE FROM #CustStakeLevel_Member

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


