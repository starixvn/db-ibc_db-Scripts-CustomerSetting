/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240716@Winfred
	Task: [TGXI] - Adjust minbet for Virtual Sports new customer[Redmine: #208010]
	DB: DBCust/CustDB
*/

USE CustDB
GO
ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_09]
(@maxcustID INT)
AS
BEGIN			
	
	IF (dbo.f_CheckRepTable('Dep_CustBetSetting_Agent') = 0 
		OR dbo.f_CheckRepTable('Dep_CustBetSetting_Member') = 0 	
		)
		RETURN

	DECLARE @SportType SMALLINT = 9908,@betType SMALLINT = 1201

	DECLARE @srecommend INT = 52761582
	DECLARE @BatchNum INT = 5000 
	
	CREATE TABLE #Member
	( CustID INT PRIMARY KEY CLUSTERED ,InsSetting BIT DEFAULT 0 
	)
	CREATE TABLE #MemberTemp
	( CustID INT PRIMARY KEY CLUSTERED )

	CREATE TABLE #SMATemp
	( CustID INT PRIMARY KEY CLUSTERED ,RoleID TINYINT )


	CREATE TABLE #Dummy	(CustID INT PRIMARY KEY)
	INSERT INTO #Dummy(CustID)
	SELECT CustID FROM Customer WITH(NOLOCK) 
	WHERE srecommend = @srecommend AND roleid=3 
		AND (username LIKE '%Acc%' OR username LIKE '%LocalBank%' OR username LIKE '%AFF%' OR username LIKE 'AB88'+'CAS%')
	
	INSERT INTO #SMATemp(CustID,RoleID)
	SELECT custid, roleid
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend = @srecommend AND roleid IN (2,3,4) AND Enabled = 1 AND custid > @maxcustID 
	AND mrecommend NOT IN (SELECT custid FROM #Dummy)

	INSERT INTO #Member(CustID)
	SELECT custid
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend = @srecommend AND roleid = 1  AND Enabled = 1 AND custid > @maxcustID	
	AND mrecommend NOT IN (SELECT custid FROM #Dummy)

	UPDATE main
	SET main.minbet	= 5
	FROM dbo.Dep_CustBetSetting_Agent main WITH(ROWLOCK)
		INNER JOIN #SMATemp tmp	ON main.CustID=tmp.CustID AND main.sporttype = @SportType AND main.bettype = @betType

	--Member Level
	WHILE (1=1)
	BEGIN
		TRUNCATE TABLE #MemberTemp
		UPDATE TOP (3000)  t SET t.InsSetting = 1 
		OUTPUT DELETED.CustID INTO #MemberTemp(CustID) FROM #Member t WHERE t.InsSetting = 0

		IF @@ROWCOUNT=0
			BREAK

		UPDATE main
		SET main.minbet	= 5
		FROM dbo.Dep_CustBetSetting_Member main WITH(ROWLOCK)
			INNER JOIN #MemberTemp tmp	ON main.CustID=tmp.CustID AND main.sporttype = @SportType AND main.bettype = @betType

	END
	DROP TABLE #MemberTemp
END		
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT DBCUST SERVERS -----
--------------------------------------------------------------------------------------
DECLARE @MaxCustID INT
	
SELECT @MaxCustID = xxx
EXEC dbo.Acc_Dep_DynamicCustSetting_09 @MaxCustID=@MaxCustID
