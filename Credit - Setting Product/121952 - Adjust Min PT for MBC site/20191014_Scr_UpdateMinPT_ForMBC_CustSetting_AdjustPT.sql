 /*
	Created: Eden
	Date: 2019/10/14
	Task: Update MinPT= MaxPT and adjust PT for CustSetting (SportBook and SportBook2)
	Redmine: https://nexdev.net/issues/121952
	DB: DBCUST/CUSTDB
 */

-- BEGIN STEP 1: RUN THIS SCRIPT AT ALL REPLICATED SERVERS -----
--------------------------------------------------------------------------------------
CREATE TABLE #tmpCust (custid int, isfinished bit default(0))
    
DECLARE @custid INT

--> FOR Muay Thai, E-Sports
DECLARE @xml XML;
	SET @xml = (
				SELECT (
						SELECT SportType AS '@SportType'
							, BetType AS '@BetType'
							, IsLive AS '@IsLive'
						FROM dbo.ProductSettingDetail WITH(NOLOCK)
						WHERE settingtype = 1 
							  AND SportType IN (43,44)
						FOR XML PATH('PT')
							, TYPE
						)
				FOR XML PATH('ROOT')
					, TYPE
				);
DECLARE @SportBettypeXML NVARCHAR(MAX) = CONVERT(NVARCHAR(MAX),@xml);

----CustomerList
INSERT INTO #tmpCust(custid)					
	  SELECT '5603319'				--BHK
UNION ALL SELECT '1146496'				--BNE

------------- PROCESS --------------------
WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #tmpCust
	SET isfinished = 1
		,@custid = custid			
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK

	EXEC dbo.[Acc_CustSetting_19] @custid = @custid					
			,@SportBettypeXML = @SportBettypeXML
			,@target = 'REPLICATED'

	--WAITFOR DELAY '00:00:0.100'
END			

 DROP TABLE #tmpCust
GO		
-- END STEP 1: RUN THIS SCRIPT AT ALL REPLICATED SERVERS -----
-----------------------------------------------------------------------------------

-- BEGIN STEP 2: RUN THIS SCRIPT AT DBCUST----
--------------------------------------------------------------------------------------
CREATE TABLE #tmpCust (custid int, isfinished bit default(0))
    
DECLARE @custid INT

--> FOR Muay Thai, E-Sports
DECLARE @xml XML;
	SET @xml = (
				SELECT (
						SELECT SportType AS '@SportType'
							, BetType AS '@BetType'
							, IsLive AS '@IsLive'
						FROM dbo.ProductSettingDetail WITH(NOLOCK)
						WHERE settingtype = 1 
							  AND SportType IN (43,44)
						FOR XML PATH('PT')
							, TYPE
						)
				FOR XML PATH('ROOT')
					, TYPE
				);
DECLARE @SportBettypeXML NVARCHAR(MAX) = CONVERT(NVARCHAR(MAX),@xml);

----CustomerList
INSERT INTO #tmpCust(custid)					
	  SELECT '5603319'				--BHK
UNION ALL SELECT '1146496'				--BNE

------------- PROCESS --------------------
WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #tmpCust
	SET isfinished = 1
		,@custid = custid			
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK

	EXEC dbo.[Acc_CustSetting_19] @custid = @custid					
			,@SportBettypeXML = @SportBettypeXML
			,@target = 'DBCUST'

	--WAITFOR DELAY '00:00:0.100'
END			

 DROP TABLE #tmpCust
GO	
-- END STEP 2: RUN THIS SCRIPT AT DBCUST -----
-----------------------------------------------------------------------------------