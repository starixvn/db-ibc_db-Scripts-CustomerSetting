 /*
	Created: Eden
	Date: 2020/01/09
	Task: Adjust PT for MBC site for Virtual games - direct Masters/Agents
	Redmine: https://nexdev.net/issues/122743
	DB: DBCUST/CUSTDB
 */
-- BEGIN STEP 1: RUN THIS SP ON DBCUST/CUSTDB -----
--------------------------------------------------------------------------------------
ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_08]
    @custid int,
	@PT tinyint
AS
BEGIN
	SET NOCOUNT ON
	
	IF dbo.f_CheckRepTable('CustPTSetting3rd_Agent') = 0 RETURN	

	DECLARE @roleid int, @srecommend int, @mrecommend int, @recommend int
	SELECT @roleid = roleid, @srecommend=srecommend, @mrecommend=mrecommend, @recommend=recommend FROM customer WITH (NOLOCK) WHERE custid = @custid

	IF @roleid = 3
	BEGIN
		UPDATE cs 
		SET cs.SuperPT = @PT,
			cs.MasterPT = @PT,					
			cs.AgentPT = @PT,
			cs.MaxPT = @PT
		FROM CustPTSetting3rd_Agent cs WITH (ROWLOCK)
		WHERE cs.sporttype = 245 AND cs.bettype = 4601
			AND cs.CustID = @srecommend
	
		UPDATE cs 
		SET cs.MasterPT = @PT,
			cs.SuperPT = 0,
			cs.MaxPT = @PT
		FROM CustPTSetting3rd_Agent cs WITH (ROWLOCK)
		WHERE cs.sporttype = 245 AND cs.bettype = 4601
			AND cs.CustID = @custid

		--UPDATE MAXPT FOR ALL SMA
		UPDATE cs
		SET cs.MaxPT = @PT		
		FROM dbo.CustPTSetting3rd_Agent cs WITH (ROWLOCK)
			INNER JOIN custinfo c WITH(NOLOCK) ON c.custid = cs.CustID
		WHERE cs.sporttype = 245 AND cs.bettype = 4601
			 AND c.mrecommend = @custid
	END

	IF @roleid = 2
	BEGIN
		UPDATE cs 
		SET cs.SuperPT = @PT,
			cs.MasterPT = @PT,					
			cs.AgentPT = @PT,
			cs.MaxPT = @PT
		FROM CustPTSetting3rd_Agent cs WITH (ROWLOCK)
		WHERE cs.sporttype = 245 AND cs.bettype = 4601
			AND cs.CustID = @srecommend

		UPDATE cs 
		SET cs.MasterPT = @PT,
			cs.SuperPT = 0,
			cs.MaxPT = @PT
		FROM CustPTSetting3rd_Agent cs WITH (ROWLOCK)
		WHERE cs.sporttype = 245 AND cs.bettype = 4601
			AND cs.CustID = @mrecommend
	
		UPDATE cs 
		SET cs.AgentPT = @PT,
			cs.MasterPT = 0,
			cs.SuperPT = 0,
			cs.MaxPT = @PT
		FROM CustPTSetting3rd_Agent cs WITH (ROWLOCK)
		WHERE cs.sporttype = 245 AND cs.bettype = 4601
			AND cs.CustID = @custid
	END            
END    
GO
-- END STEP 1: RUN THIS SP ON DBCUST/CUSTDB -----
--------------------------------------------------------------------------------------

-- BEGIN STEP 2: RUN THIS SCRIPT ON DBCUST/CUSTDB -----
--------------------------------------------------------------------------------------
CREATE TABLE #agents (custid int, AgentID INT, MasterID INT, SuperID INT, roleid tinyint, isfinished bit default(0))
    
DECLARE @custid INT, @roleid tinyint, @PT tinyint = 90
DECLARE @AgentID INT, @MasterID INT, @SuperID INT

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

--Dirrect Master/Agent
INSERT INTO #agents(custid, roleid,AgentID,MasterID,SuperID)
SELECT c.custid,c.roleID,c.recommend,c.mrecommend,c.srecommend
FROM customer c WITH (NOLOCK) 
	INNER JOIN custinfo ci  WITH (NOLOCK) ON c.custid = ci.custid
	INNER JOIN CustPTSetting3rd_Agent pt WITH(NOLOCK) ON c.custid = pt.CustID AND pt.SportType = 245 AND pt.BetType = 4601
WHERE c.roleid IN (2,3)  
 AND ci.Enabled = 1
 AND c.currency <> 67 --HKK
 AND c.site <> '789y'
 AND c.custID IN ( SELECT CustID FROM CustDirectAccount WITH(NOLOCK))

------------- PROCESS --------------------
WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #agents
	SET isfinished = 1
		,@custid = custid
		,@roleid = roleid
		,@AgentID = AgentID
		,@MasterID = MasterID	
		,@SuperID = SuperID	
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK

	--Update MaxPT
	EXEC dbo.[Acc_DynamicCustSetting3rd_08] @custid = @custid					
			,@PT = @PT
	
	--adjust PT
	EXEC dbo.Acc_DynamicCustSetting3rd_07 @SuperID = @SuperID				
			,@MasterID = @MasterID
			,@AgentID = @AgentID
			,@RoleID = @roleid
			,@SportBettypeXML = @SportBettypeXML  

	WAITFOR DELAY '00:00:0.100'
END			

 DROP TABLE #agents
GO		
-- END STEP 2: RUN THIS SCRIPT ON DBCUST/CUSTDB -----
-----------------------------------------------------------------------------------
