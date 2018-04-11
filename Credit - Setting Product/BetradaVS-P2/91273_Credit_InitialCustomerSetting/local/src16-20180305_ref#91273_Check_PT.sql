
ALTER PROCEDURE [dbo].[DBA_CheckPTGame_DCS]
     @srecommend VARCHAR(MAX) 
    ,@SportType SMALLINT = 0
    ,@BetType   SMALLINT = 0
AS
/*
Created: 20180411@Vicky
Task : check DCS PT Setting for Credit Customer 
DB: DBCUST/custDB


Param's Explanation:
Exameple: 
*/
BEGIN
	SET NOCOUNT ON
	
	CREATE TABLE #tmpCheckPT (CustID INT, RoleID SMALLINT, ErrorCode VARCHAR(50))
	CREATE TABLE #MemberTemp(CustID INT PRIMARY KEY CLUSTERED, currency INT)
	
    CREATE TABLE #SMATemp(CustID INT PRIMARY KEY CLUSTERED, currency INT)
	--------------------------------check cust is have no setting---------------------
	
    INSERT INTO #MemberTemp (CustID, currency)
    EXECUTE('SELECT custid, currency FROM Custinfo WITH (NOLOCK) WHERE roleid = 1 AND srecommend IN (' + @srecommendList + ')')

    INSERT INTO #SMATemp (CustID, currency)
    EXECUTE('SELECT custid, currency FROM Custinfo WITH (NOLOCK) WHERE roleid IN (2,3,4) AND srecommend IN (' + @srecommendList + ')')

END 

