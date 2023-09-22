/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: Helios
	Date: 2023/08/14
	Task: Remove Unused Data Customer Setting - Simplify Live Casino Customer Setting [redmine : #189389] 
	DB: DBCUST/CustDB
	Revisions: Modified SP
*/
-----------------------------------BEGIN STEP 1: DEPLOY THIS SP DBCUST-CustDB-----------------------------------
ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_09]
	@ModeCode		VARCHAR (20)
,	@target			VARCHAR (20)

AS

BEGIN
	
	SET NOCOUNT ON  

	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','TESTDBCUST','DB230\SQLSERVER2008R2')) RETURN -- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','TESTDBCUST','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only

-----------------------------------Check Replicate---------------------------------

	IF NOT (dbo.f_CheckRepTable('Custinfo') = 1 
	   AND dbo.f_CheckRepTable('CustWinLossLimit_Agent') = 1
	   AND dbo.f_CheckRepTable('CustWinLossLimit_Member') = 1
	   AND dbo.f_CheckRepTable('CustDiscount3rd_Agent') = 1
	   AND dbo.f_CheckRepTable('CustDiscount3rd_Member') = 1
	   AND dbo.f_CheckRepTable('CustPTSetting3rd_Agent') = 1
	   AND dbo.f_CheckRepTable('CustPTGroupSetting3rd_Member') = 1
	   AND dbo.f_CheckRepTable('CustPTSetting3rd_Member') = 1
	   )
		RETURN

-----------------------------------Remove Data Unused---------------------------------

	IF @ModeCode = 'WLAgent'
	BEGIN
		
		DELETE cs
		FROM CustWinLossLimit_Agent cs WITH (ROWLOCK)
		INNER JOIN #CustAffected		cl
			ON cs.CustId = cl.CustID 
			AND cs.SportType = cl.SportType 
			AND cs.BetType = cl.BetType
	END

	IF @ModeCode = 'WLMember'
	BEGIN
		
		DELETE cs
		FROM CustWinLossLimit_Member cs WITH (ROWLOCK)
		INNER JOIN #CustAffected		cl
			ON cs.CustId = cl.CustID 
			AND cs.SportType = cl.SportType 
			AND cs.BetType = cl.BetType
	END

	IF @ModeCode = 'DiscountAgent'
	BEGIN

		DELETE cs
		FROM CustDiscount3rd_Agent cs WITH (ROWLOCK)
		INNER JOIN #CustAffected		cl
			ON cs.CustId = cl.CustID 
			AND cs.SportType = cl.SportType 
			AND cs.BetType = cl.BetType
	END

	IF @ModeCode = 'DiscountMember'
	BEGIN

		DELETE cs
		FROM CustDiscount3rd_Member cs WITH (ROWLOCK)
		INNER JOIN #CustAffected		cl
			ON cs.CustId = cl.CustID 
			AND cs.SportType = cl.SportType 
			AND cs.BetType = cl.BetType
	END

	IF @ModeCode = 'PTSMA'
		BEGIN
		
			DELETE cs
			FROM CustPTSetting3rd_Agent cs WITH (ROWLOCK)
			INNER JOIN #CustAffected		cl
				ON cs.CustId	= cl.CustID 
			   AND cs.SportType = cl.SportType 
			   AND cs.BetType	= cl.BetType
			   AND cs.IsLive    = cl.IsLive
		END

	IF @ModeCode = 'PTAgent'
		BEGIN
		
			DELETE cs
			FROM CustPTGroupSetting3rd_Member cs WITH (ROWLOCK)
			INNER JOIN #CustAffected		cl
				ON cs.AgentID	= cl.CustID 
			   AND cs.SportType = cl.SportType 
			   AND cs.BetType	= cl.BetType
			   AND cs.IsLive    = cl.IsLive
		END

	IF @ModeCode = 'PTMember'
		BEGIN
		
			DELETE cs
			FROM CustPTSetting3rd_Member cs WITH (ROWLOCK)
			INNER JOIN #CustAffected		cl
				ON cs.CustID	= cl.CustID 
			   AND cs.SportType = cl.SportType 
			   AND cs.BetType	= cl.BetType
			   AND cs.IsLive    = cl.IsLive
		END


END
