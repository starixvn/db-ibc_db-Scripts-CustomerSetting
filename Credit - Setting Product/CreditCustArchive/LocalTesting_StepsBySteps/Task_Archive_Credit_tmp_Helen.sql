/*
	Created: 20200505@Helen
	Task: https://nexdev.net/issues/130032
	DB: DBCUST.CUSTDB
*/
USE CUSTDB
GO
CREATE PROCEDURE dbo.Task_Archive_Credit_tmp_Helen 
( @xmlData NVARCHAR(MAX)
)
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @xml XML
	SET @xml = @xmlData
	INSERT INTO dbo.tmpCustArchived (Super, Master, Agent, MemCnt, recommend)
	SELECT x.v.value('(Super/text())[1]','VARCHAR(50)') AS Super,
		   x.v.value('(Master/text())[1]','VARCHAR(50)') AS Master,
		   x.v.value('(Agent/text())[1]','VARCHAR(50)') AS Agent,
		   x.v.value('(MemCnt/text())[1]','INT') AS MemCnt,
		   x.v.value('(recommend/text())[1]','INT') AS recommend
	FROM @xml.nodes('/r') AS x(v)
	
	SET NOCOUNT OFF 
END			