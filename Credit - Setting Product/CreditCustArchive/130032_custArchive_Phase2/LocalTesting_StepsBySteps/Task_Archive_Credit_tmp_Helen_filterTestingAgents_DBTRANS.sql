/*
	Created: 20200505@Helen
	Task: https://nexdev.net/issues/130032
	DB: DBTXN.bodb02
*/
USE bodb02
GO
-- Please put your agents in the line 31	
ALTER PROCEDURE dbo.Task_Archive_Credit_tmp_Helen 
( @xmlData NVARCHAR(MAX)
)
AS
BEGIN
	IF @@SERVERNAME NOT IN ('DB230','DB206')
	RETURN
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
	SELECT Super, Master, Agent, MemCnt, recommend FROM #tempCustArchived 
	WHERE recommend IN (XXX)
		--recommend IN  (42780012,42780013,42780014,42780015,42780016,42780017,42780018,42780020)
	
	SET NOCOUNT OFF 
END			