 /*
	Created: Eden
	Date: 2020/01/09
	Task: Adjust PT for MBC site for Virtual games - direct Supper
	Redmine: https://nexdev.net/issues/122743
	DB: DBCUST/CUSTDB
 */
-- BEGIN STEP 1: RUN THIS SP ON DBCUST/CUSTDB -----
--------------------------------------------------------------------------------------
ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_09]
    @custid int,
	@PT tinyint
AS
BEGIN
	SET NOCOUNT ON
	
	IF dbo.f_CheckRepTable('CustPTSetting3rd_Agent') = 0 RETURN	

	UPDATE cs 
	SET cs.MaxPT = @PT,
		cs.SuperPT  =  @PT ,
		cs.MasterPT =  cs.MasterPT + @PT - cs.SuperPT ,
		cs.AgentPT  =  cs.AgentPT + @PT - cs.SuperPT
	FROM CustPTSetting3rd_Agent cs WITH (ROWLOCK)
	WHERE cs.sporttype = 245 AND cs.bettype = 4601
			AND cs.CustID = @custid
	
	--UPDATE MAXPT FOR ALL SMA
	UPDATE cs
	SET cs.MaxPT = @PT		
	FROM dbo.CustPTSetting3rd_Agent cs WITH (ROWLOCK)
		INNER JOIN custinfo c WITH(NOLOCK) ON c.custid = cs.CustID
	WHERE cs.sporttype = 245 AND cs.bettype = 4601
		 AND c.srecommend = @custid

	
END    
GO
-- END STEP 1: RUN THIS SP ON DBCUST/CUSTDB -----
--------------------------------------------------------------------------------------

-- BEGIN STEP 2: RUN THIS SCRIPT ON DBCUST/CUSTDB -----
--------------------------------------------------------------------------------------
CREATE TABLE #supers (custid int, isfinished bit default(0))
    
DECLARE @custid INT, @PT tinyint = 90

DECLARE @xml XML;
	SET @xml = (
				SELECT (
						SELECT SportType AS '@SportType'
							, BetType AS '@BetType'
							, IsLive AS '@IsLive'
						FROM dbo.ProductSettingDetail WITH(NOLOCK)
						WHERE settingtype = 1 AND sporttype = 245
						FOR XML PATH('PT')
							, TYPE
						)
				FOR XML PATH('ROOT')
					, TYPE
				);
DECLARE @SportBettypeXML NVARCHAR(MAX) = CONVERT(NVARCHAR(MAX),@xml);

--Dirrect Super MBC site except HKK currency 
INSERT INTO #supers(custid)
SELECT c.custid
FROM customer c WITH (NOLOCK) 
	INNER JOIN custinfo ci  WITH (NOLOCK) ON c.custid = ci.custid
	INNER JOIN CustPTSetting3rd_Agent pt WITH (NOLOCK) ON c.custid = pt.CustID AND pt.SportType = 245 AND pt.BetType = 4601
WHERE c.roleid = 4  
 AND ci.Enabled = 1
 AND c.currency <> 67 --HKK
 AND c.site <> '789y'
 AND c.custID IN ( SELECT CustID FROM CustDirectAccount WITH(NOLOCK))

--Super of 789y site need adjust PT
INSERT INTO #supers(custid)
SELECT custid
FROM custinfo WITH(NOLOCK) 
WHERE username IN (
	 'S312US'
	,'DAU'
	,'S359U'
	,'SKUS'
	,'S318U'
	,'S80U'
	,'S5U'
	,'S56US'
	,'S56AU'
	,'S56BU'
	,'S56CU'
	,'S56DU'
	,'S79U'
	,'S79Y'
	,'S47U'
	,'MOU'
	,'S88US'
	,'SJU'
	,'SHUS'
	,'SHU'
	,'SBSU'
	,'2UA'
	,'2UB'
	,'CKU'
	,'CKV'
	,'S42U'
	,'SRUS'
	,'SRUN'
	,'JAA'
	,'BBBU'
	,'S99U'
	,'MRU'
	,'JU'
	,'SSYU'
	,'U311'
	,'KTV'
	,'KTW'
	,'SLA'
	,'QQUS'
	,'PYU'
	,'KKU'
	,'KKU1'
	,'KKV'
	,'KKP'
	,'KKQ'
	,'KKX'
	,'KKZ'
	,'KKA'
	,'KKW'
	,'KKO'
	,'K1K'
	,'K2K'
	,'K3K'
	,'VKS'
	,'TF1'
	,'SPUS'
	,'JWL'
	,'JWU'
	,'JWA'
	,'JWK'
	,'DJU'
	,'ABS'
	,'ABB'
	,'ABW'
	,'BBA'
	,'BBD'
	,'BBE'
	,'BBF'
	,'PZZ'
	) 		  

------------- PROCESS --------------------
WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #supers
	SET isfinished = 1
		,@custid = custid			
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK

	--Update MaxPT
	EXEC dbo.[Acc_DynamicCustSetting3rd_09] @custid = @custid					
			,@PT = @PT
	
	--adjust PT
	EXEC dbo.Acc_DynamicCustSetting3rd_07 @SuperID = @custid				
			,@RoleID = 4
			,@SportBettypeXML = @SportBettypeXML  

	WAITFOR DELAY '00:00:0.100'

END			

 DROP TABLE #supers
GO		
-- END STEP 2: RUN THIS SCRIPT ON DBCUST/CUSTDB -----
-----------------------------------------------------------------------------------