/*
	Created: 20200505@Helen
	Task: https://nexdev.net/issues/130032
	DB: DBCUST.CUSTDB
*/
USE CUSTDB
GO
IF @@SERVERNAME NOT IN ('DB230\SQLSERVER2008R2','DB233')
	RETURN
-- Please put your agents in the line 31	
ALTER PROCEDURE dbo.Task_Archive_Credit_tmp_Helen 
( @xmlData NVARCHAR(MAX)
)
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @xml XML
	SET @xml = @xmlData
	
	SELECT x.v.value('(Super/text())[1]','VARCHAR(50)') AS Super,
		   x.v.value('(Master/text())[1]','VARCHAR(50)') AS Master,
		   x.v.value('(Agent/text())[1]','VARCHAR(50)') AS Agent,
		   x.v.value('(MemCnt/text())[1]','INT') AS MemCnt,
		   x.v.value('(recommend/text())[1]','INT') AS recommend
	INTO #tempCustArchived	   
	FROM @xml.nodes('/r') AS x(v)
	
	INSERT INTO dbo.tmpCustArchived (Super, Master, Agent, MemCnt, recommend)
	SELECT * FROM #tempCustArchived 
	WHERE recommend IN (XXX)
	
	SET NOCOUNT OFF 
END			