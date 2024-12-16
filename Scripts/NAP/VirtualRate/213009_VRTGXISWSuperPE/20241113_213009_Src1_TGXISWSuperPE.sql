/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20241113@Winfred
	Task: HF - NAP- Cannot updating VR value for licensee super line with big downline member (over 500000 members downline)  [redmine: #213009]
	DB: DBCust/CustDB
*/
-- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
ALTER PROCEDURE [dbo].[Acc_CustomerInfo_Execrep_09]	
	@CustList XML, 
	@srecommend INT, 	
	@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON;
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','DBSPARE','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','DBSPARE','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN -- run at dbcust only
	
	IF OBJECT_ID('CustVirtualSetting') IS NULL
	RETURN;
	
	DECLARE @tmpCust TABLE (custid INT PRIMARY KEY)
	
	DECLARE @xml XML = CAST (@CustList as XML)
	DECLARE @batchNo INT
	
	CREATE TABLE #tblCust(CustID	INT PRIMARY KEY)
	
	INSERT INTO #tblCust(CustID)
	SELECT   t.c.value('@CustID','INT')		AS CustID			
	FROM @CustList.nodes('root') t(c)

	--> Update Soccer VR
	UPDATE cvs
	SET cvs.bitmapVirtual = bm.bitmapVirtual
	FROM	#tblCust tmpCust
		CROSS APPLY (
			SELECT TOP 3 cv.seqNo, cv.bitmapVirtual
			FROM CustVirtualSetting	AS cv WITH (NOLOCK)
			WHERE cv.custID = @srecommend
		) bm
		CROSS APPLY (
			SELECT TOP 3 cvs.seqNo, cvs.bitmapVirtual
			FROM CustVirtualSetting	AS cvs WITH (UPDLOCK, ROWLOCK)
			WHERE cvs.custID = tmpCust.custID AND seqNo = bm.seqNo AND cvs.bitmapVirtual <> bm.bitmapVirtual
		) cvs

	DROP TABLE #tblCust
END
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------			


-- BEGIN STEP 2: RUN THIS SCRIPT AT DBCUST AND replicated DB -----
--------------------------------------------------------------------------------------
	SET NOCOUNT ON
	
	IF OBJECT_ID('CustVirtualSetting') IS NULL
	RETURN;

	DECLARE @target VARCHAR(20)
			,@max_custid INT
			,@CustList   XML
			,@BatchSize	INT = 1600
			,@srecommend INT = 108357647 --TGXISWSuperPE
			,@virtualmultiplier	VARCHAR(MAX)	= ''
			,@DocHandler	 INT

	SELECT @max_custid = xxx

	IF @@SERVERNAME IN ('DBCUST','SITDBCUST','DBSPARE','TESTDBCUST','DB-60\DEVDBCUST')
		SET @target = 'DBCUST'
	ELSE 
		SET @target = 'REPLICATED'

	CREATE TABLE #Members (CustID INT PRIMARY KEY)
	CREATE TABLE #BatchCust (CustID INT PRIMARY KEY)
	DECLARE	@tblVirtualrate	 TABLE (
			SportType			INT
		,	BetType				INT
		,	IsLive				BIT
		,	VirtualMultiplier	SMALLMONEY	
		);
	DECLARE	@virtualXML_Soccer	TABLE (
									seqNo				TINYINT PRIMARY KEY
								,	Pos			VARBINARY(64)
								,	Val			VARBINARY(64)
								);
	DECLARE	@virtualXML_Basketball		TABLE ( --Basketball
									seqNo				TINYINT PRIMARY KEY
								,	Pos			VARBINARY(64)
								,	Val			VARBINARY(64)
								);
	DECLARE	@virtualXML_OS		TABLE ( --other sport except basketball and Esport
									seqNo				TINYINT PRIMARY KEY
								,	Pos			VARBINARY(64)
								,	Val			VARBINARY(64)
								);

	SET @virtualmultiplier = '
	<ROOT><Rate SportType="1" BetType="1" IsLive="0" VirtualMultiplier="0.0900" /><Rate SportType="1" BetType="1" IsLive="1" VirtualMultiplier="0.0900" /><Rate SportType="1" BetType="2" IsLive="0" VirtualMultiplier="0.0900" /><Rate SportType="1" BetType="2" IsLive="1" VirtualMultiplier="0.0900" /><Rate SportType="1" BetType="3" IsLive="0" VirtualMultiplier="0.0500" /><Rate SportType="1" BetType="3" IsLive="1" VirtualMultiplier="0.0500" /><Rate SportType="1" BetType="7" IsLive="0" VirtualMultiplier="0.0900" /><Rate SportType="1" BetType="7" IsLive="1" VirtualMultiplier="0.0900" /><Rate SportType="1" BetType="8" IsLive="0" VirtualMultiplier="0.0500" /><Rate SportType="1" BetType="8" IsLive="1" VirtualMultiplier="0.0500" /><Rate SportType="1" BetType="12" IsLive="0" VirtualMultiplier="0.0900" /><Rate SportType="1" BetType="12" IsLive="1" VirtualMultiplier="0.0900" /><Rate SportType="2" BetType="1" IsLive="0" VirtualMultiplier="0.0900" /><Rate SportType="2" BetType="1" IsLive="1" VirtualMultiplier="0.0900" /><Rate SportType="2" BetType="2" IsLive="0" VirtualMultiplier="0.0900" /><Rate SportType="2" BetType="2" IsLive="1" VirtualMultiplier="0.0900" /><Rate SportType="2" BetType="3" IsLive="0" VirtualMultiplier="0.0500" /><Rate SportType="2" BetType="3" IsLive="1" VirtualMultiplier="0.0500" /><Rate SportType="2" BetType="7" IsLive="0" VirtualMultiplier="0.0900" /><Rate SportType="2" BetType="7" IsLive="1" VirtualMultiplier="0.0900" /><Rate SportType="2" BetType="8" IsLive="0" VirtualMultiplier="0.0500" /><Rate SportType="2" BetType="8" IsLive="1" VirtualMultiplier="0.0500" /><Rate SportType="2" BetType="12" IsLive="0" VirtualMultiplier="0.0900" /><Rate SportType="2" BetType="12" IsLive="1" VirtualMultiplier="0.0900" /><Rate SportType="2" BetType="20" IsLive="1" VirtualMultiplier="0.0900" /><Rate SportType="2" BetType="20" IsLive="0" VirtualMultiplier="0.0900" /><Rate SportType="2" BetType="21" IsLive="1" VirtualMultiplier="0.0900" /><Rate SportType="2" BetType="21" IsLive="0" VirtualMultiplier="0.0900" /><Rate SportType="3" BetType="1" IsLive="0" VirtualMultiplier="0.0900" /><Rate SportType="3" BetType="1" IsLive="1" VirtualMultiplier="0.0900" /><Rate SportType="3" BetType="2" IsLive="0" VirtualMultiplier="0.0900" /><Rate SportType="3" BetType="2" IsLive="1" VirtualMultiplier="0.0900" /><Rate SportType="3" BetType="3" IsLive="0" VirtualMultiplier="0.0900" /><Rate SportType="3" BetType="3" IsLive="1" VirtualMultiplier="0.0900" /><Rate SportType="3" BetType="7" IsLive="0" VirtualMultiplier="0.0900" /><Rate SportType="3" BetType="7" IsLive="1" VirtualMultiplier="0.0900" /><Rate SportType="3" BetType="8" IsLive="0" VirtualMultiplier="0.0900" /><Rate SportType="3" BetType="8" IsLive="1" VirtualMultiplier="0.0900" /><Rate SportType="3" BetType="12" IsLive="0" VirtualMultiplier="0.0900" /><Rate SportType="3" BetType="12" IsLive="1" VirtualMultiplier="0.0900" /><Rate SportType="4" BetType="1" IsLive="0" VirtualMultiplier="0.0900" /><Rate SportType="4" BetType="1" IsLive="1" VirtualMultiplier="0.0900" /><Rate SportType="4" BetType="2" IsLive="0" VirtualMultiplier="0.0900" /><Rate SportType="4" BetType="2" IsLive="1" VirtualMultiplier="0.0900" /><Rate SportType="4" BetType="3" IsLive="0" VirtualMultiplier="0.0900" /><Rate SportType="4" BetType="3" IsLive="1" VirtualMultiplier="0.0900" /><Rate SportType="4" BetType="20" IsLive="0" VirtualMultiplier="0.0900" /><Rate SportType="4" BetType="20" IsLive="1" VirtualMultiplier="0.0900" /><Rate SportType="5" BetType="1" IsLive="0" VirtualMultiplier="0.0900" /><Rate SportType="5" BetType="1" IsLive="1" VirtualMultiplier="0.0900" /><Rate SportType="5" BetType="2" IsLive="0" VirtualMultiplier="0.0900" /><Rate SportType="5" BetType="2" IsLive="1" VirtualMultiplier="0.0900" /><Rate SportType="5" BetType="3" IsLive="0" VirtualMultiplier="0.0900" /><Rate SportType="5" BetType="3" IsLive="1" VirtualMultiplier="0.0900" /><Rate SportType="5" BetType="20" IsLive="0" VirtualMultiplier="0.0900" /><Rate SportType="5" BetType="20" IsLive="1" VirtualMultiplier="0.0900" /><Rate SportType="5" BetType="1324" IsLive="0" VirtualMultiplier="0.0900" /><Rate SportType="5" BetType="1324" IsLive="1" VirtualMultiplier="0.0900" /><Rate SportType="6" BetType="1" IsLive="0" VirtualMultiplier="0.0900" /><Rate SportType="6" BetType="1" IsLive="1" VirtualMultiplier="0.0900" /><Rate SportType="6" BetType="2" IsLive="0" VirtualMultiplier="0.0900" /><Rate SportType="6" BetType="2" IsLive="1" VirtualMultiplier="0.0900" /><Rate SportType="6" BetType="3" IsLive="0" VirtualMultiplier="0.0900" /><Rate SportType="6" BetType="3" IsLive="1" VirtualMultiplier="0.0900" /><Rate SportType="6" BetType="20" IsLive="0" VirtualMultiplier="0.0900" /><Rate SportType="6" BetType="20" IsLive="1" VirtualMultiplier="0.0900" /><Rate SportType="7" BetType="1" IsLive="0" VirtualMultiplier="0.0900" /><Rate SportType="7" BetType="1" IsLive="1" VirtualMultiplier="0.0900" /><Rate SportType="7" BetType="2" IsLive="0" VirtualMultiplier="0.0900" /><Rate SportType="7" BetType="2" IsLive="1" VirtualMultiplier="0.0900" /><Rate SportType="7" BetType="3" IsLive="0" VirtualMultiplier="0.0900" /><Rate SportType="7" BetType="3" IsLive="1" VirtualMultiplier="0.0900" /><Rate SportType="7" BetType="20" IsLive="0" VirtualMultiplier="0.0900" /><Rate SportType="7" BetType="20" IsLive="1" VirtualMultiplier="0.0900" /><Rate SportType="8" BetType="1" IsLive="0" VirtualMultiplier="0.0900" /><Rate SportType="8" BetType="1" IsLive="1" VirtualMultiplier="0.0900" /><Rate SportType="8" BetType="3" IsLive="0" VirtualMultiplier="0.0900" /><Rate SportType="8" BetType="3" IsLive="1" VirtualMultiplier="0.0900" /><Rate SportType="8" BetType="7" IsLive="0" VirtualMultiplier="0.0900" /><Rate SportType="8" BetType="7" IsLive="1" VirtualMultiplier="0.0900" /><Rate SportType="8" BetType="8" IsLive="0" VirtualMultiplier="0.0900" /><Rate SportType="8" BetType="8" IsLive="1" VirtualMultiplier="0.0900" /><Rate SportType="8" BetType="20" IsLive="0" VirtualMultiplier="0.0900" /><Rate SportType="8" BetType="20" IsLive="1" VirtualMultiplier="0.0900" /><Rate SportType="8" BetType="21" IsLive="0" VirtualMultiplier="0.0900" /><Rate SportType="8" BetType="21" IsLive="1" VirtualMultiplier="0.0900" /><Rate SportType="9" BetType="1" IsLive="0" VirtualMultiplier="0.0900" /><Rate SportType="9" BetType="1" IsLive="1" VirtualMultiplier="0.0900" /><Rate SportType="9" BetType="2" IsLive="0" VirtualMultiplier="0.0900" /><Rate SportType="9" BetType="2" IsLive="1" VirtualMultiplier="0.0900" /><Rate SportType="9" BetType="3" IsLive="0" VirtualMultiplier="0.0900" /><Rate SportType="9" BetType="3" IsLive="1" VirtualMultiplier="0.0900" /><Rate SportType="9" BetType="20" IsLive="0" VirtualMultiplier="0.0900" /><Rate SportType="9" BetType="20" IsLive="1" VirtualMultiplier="0.0900" /><Rate SportType="11" BetType="1" IsLive="0" VirtualMultiplier="0.0900" /><Rate SportType="11" BetType="1" IsLive="1" VirtualMultiplier="0.0900" /><Rate SportType="11" BetType="2" IsLive="0" VirtualMultiplier="0.0900" /><Rate SportType="11" BetType="2" IsLive="1" VirtualMultiplier="0.0900" /><Rate SportType="11" BetType="3" IsLive="0" VirtualMultiplier="0.0900" /><Rate SportType="11" BetType="3" IsLive="1" VirtualMultiplier="0.0900" /><Rate SportType="11" BetType="20" IsLive="0" VirtualMultiplier="0.0900" /><Rate SportType="11" BetType="20" IsLive="1" VirtualMultiplier="0.0900" /><Rate SportType="27" BetType="1" IsLive="0" VirtualMultiplier="0.0900" /><Rate SportType="27" BetType="1" IsLive="1" VirtualMultiplier="0.0900" /><Rate SportType="27" BetType="2" IsLive="0" VirtualMultiplier="0.0900" /><Rate SportType="27" BetType="2" IsLive="1" VirtualMultiplier="0.0900" /><Rate SportType="27" BetType="3" IsLive="0" VirtualMultiplier="0.0900" /><Rate SportType="27" BetType="3" IsLive="1" VirtualMultiplier="0.0900" /><Rate SportType="27" BetType="20" IsLive="0" VirtualMultiplier="0.0900" /><Rate SportType="27" BetType="20" IsLive="1" VirtualMultiplier="0.0900" /><Rate SportType="27" BetType="5" IsLive="1" VirtualMultiplier="0.0900" /><Rate SportType="27" BetType="5" IsLive="0" VirtualMultiplier="0.0900" /><Rate SportType="99" BetType="1" IsLive="0" VirtualMultiplier="0.0900" /><Rate SportType="99" BetType="1" IsLive="1" VirtualMultiplier="0.0900" /><Rate SportType="99" BetType="2" IsLive="0" VirtualMultiplier="0.0900" /><Rate SportType="99" BetType="2" IsLive="1" VirtualMultiplier="0.0900" /><Rate SportType="99" BetType="3" IsLive="0" VirtualMultiplier="0.0900" /><Rate SportType="99" BetType="3" IsLive="1" VirtualMultiplier="0.0900" /><Rate SportType="99" BetType="7" IsLive="0" VirtualMultiplier="0.0900" /><Rate SportType="99" BetType="7" IsLive="1" VirtualMultiplier="0.0900" /><Rate SportType="99" BetType="8" IsLive="0" VirtualMultiplier="0.0900" /><Rate SportType="99" BetType="8" IsLive="1" VirtualMultiplier="0.0900" /><Rate SportType="99" BetType="12" IsLive="0" VirtualMultiplier="0.0900" /><Rate SportType="99" BetType="12" IsLive="1" VirtualMultiplier="0.0900" /><Rate SportType="99" BetType="20" IsLive="0" VirtualMultiplier="0.0900" /><Rate SportType="99" BetType="20" IsLive="1" VirtualMultiplier="0.0900" /></ROOT>'

	IF	@virtualmultiplier <> ''
		BEGIN			
			-- For read xml					
			EXECUTE sp_xml_preparedocument @DocHandler OUTPUT, @virtualmultiplier;

			INSERT INTO	@tblVirtualrate (
							SportType
						,	BetType
						,	IsLive
						,	VirtualMultiplier
					)
			SELECT	Data.SportType
				,	Data.BetType
				,	Data.IsLive
				,	Data.VirtualMultiplier
			FROM OPENXML (@DocHandler, '/ROOT/Rate',1) 
			WITH (	SportType			SMALLINT
				,	BetType				SMALLINT
				,	IsLive				BIT
				,	VirtualMultiplier	SMALLMONEY	
			) AS Data;

			EXECUTE sp_xml_removedocument @DocHandler;
			-- end read xml
		END;	
	
	INSERT INTO @virtualXML_Soccer
			(	seqNo, Pos, Val                       )
		SELECT	seqNo, p1.Pos, p2.Val
		FROM (
			SELECT	DISTINCT seqNo
			FROM	ProfileVirtualSetting WITH (NOLOCK)
		) pvs
		CROSS APPLY (
			SELECT CONVERT(VARBINARY(64), (
				SELECT	CONVERT(VARCHAR, CAST(ipvs.profileID - 64 * (ipvs.seqNo - 1) AS BINARY(1)), 2)
				FROM		@tblVirtualrate			AS tmp
					INNER JOIN	ProfileVirtualSetting	AS ipvs WITH (NOLOCK)
						ON	tmp.sporttype	= ipvs.sporttype
							AND	tmp.bettype		= ipvs.bettype
							AND	tmp.isLive		= ipvs.islive
				WHERE	ipvs.seqNo = pvs.seqNo AND tmp.SportType = 1
				FOR XML PATH ('')						
			), 2) AS Pos
		) p1
		CROSS APPLY (
			SELECT CONVERT(VARBINARY(64), (
				SELECT	CONVERT(VARCHAR, CAST(CASE WHEN CAST(VirtualMultiplier * 100 AS INT) > 200 THEN ((CAST(VirtualMultiplier * 100 AS INT) - 200) / 5 + 200) ELSE CAST(VirtualMultiplier * 100 AS INT) END AS BINARY(1)), 2)
				FROM		@tblVirtualrate			AS tmp
					INNER JOIN	ProfileVirtualSetting	AS ipvs WITH (NOLOCK)
						ON	tmp.sporttype	= ipvs.sporttype
							AND	tmp.bettype		= ipvs.bettype
							AND	tmp.isLive		= ipvs.islive
				WHERE	ipvs.seqNo = pvs.seqNo AND tmp.SportType = 1
				FOR XML PATH ('')						
			), 2) AS Val
		) p2;
		INSERT INTO @virtualXML_Basketball																														
			(	seqNo, Pos, Val                       )																				
		SELECT	seqNo, p1.Pos, p2.Val																	
		FROM (																							
			SELECT	DISTINCT seqNo																		
			FROM	ProfileVirtualSetting WITH (NOLOCK)													
		) pvs																																			
		CROSS APPLY (																					
			SELECT CONVERT(VARBINARY(64), (																
				SELECT	CONVERT(VARCHAR, CAST(ipvs.profileID - 64 * (ipvs.seqNo - 1) AS BINARY(1)), 2)	
				FROM		@tblVirtualrate			AS tmp												
					INNER JOIN	ProfileVirtualSetting	AS ipvs WITH (NOLOCK)							
						ON	tmp.sporttype	= ipvs.sporttype											
							AND	tmp.bettype		= ipvs.bettype											
							AND	tmp.isLive		= ipvs.islive											
				WHERE	ipvs.seqNo = pvs.seqNo AND tmp.SportType = 2									
				FOR XML PATH ('')																		
			), 2) AS Pos																				
		) p1																							
		CROSS APPLY (																					
			SELECT CONVERT(VARBINARY(64), (																
				SELECT	CONVERT(VARCHAR, CAST(CASE WHEN CAST(VirtualMultiplier * 100 AS INT) > 200 THEN ((CAST(VirtualMultiplier * 100 AS INT) - 200) / 5 + 200) ELSE CAST(VirtualMultiplier * 100 AS INT) END AS BINARY(1)), 2)	
				FROM		@tblVirtualrate			AS tmp												
					INNER JOIN	ProfileVirtualSetting	AS ipvs WITH (NOLOCK)							
						ON	tmp.sporttype	= ipvs.sporttype											
							AND	tmp.bettype		= ipvs.bettype											
							AND	tmp.isLive		= ipvs.islive											
				WHERE	ipvs.seqNo = pvs.seqNo AND tmp.SportType = 2									
				FOR XML PATH ('')																						
			), 2) AS Val																				
		) p2;																							
		INSERT INTO @virtualXML_OS 
			(	seqNo, Pos, Val                       )
		SELECT	seqNo, p1.Pos, p2.Val
		FROM (
			SELECT	DISTINCT seqNo
			FROM	ProfileVirtualSetting WITH (NOLOCK)
		) pvs
		CROSS APPLY (
			SELECT CONVERT(VARBINARY(64), (
				SELECT	CONVERT(VARCHAR, CAST(ipvs.profileID - 64 * (ipvs.seqNo - 1) AS BINARY(1)), 2)
				FROM		@tblVirtualrate			AS tmp
					INNER JOIN	ProfileVirtualSetting	AS ipvs WITH (NOLOCK)
						ON	tmp.sporttype	= ipvs.sporttype
							AND	tmp.bettype		= ipvs.bettype
							AND	tmp.isLive		= ipvs.islive
				WHERE	ipvs.seqNo = pvs.seqNo AND tmp.SportType NOT IN (1, 2, 43)								
				FOR XML PATH ('')						
			), 2) AS Pos
		) p1
		CROSS APPLY (
			SELECT CONVERT(VARBINARY(64), (
				SELECT	CONVERT(VARCHAR, CAST(CASE WHEN CAST(VirtualMultiplier * 100 AS INT) > 200 THEN ((CAST(VirtualMultiplier * 100 AS INT) - 200) / 5 + 200) ELSE CAST(VirtualMultiplier * 100 AS INT) END AS BINARY(1)), 2)
				FROM		@tblVirtualrate			AS tmp
					INNER JOIN	ProfileVirtualSetting	AS ipvs WITH (NOLOCK)
						ON	tmp.sporttype	= ipvs.sporttype
							AND	tmp.bettype		= ipvs.bettype
							AND	tmp.isLive		= ipvs.islive
				WHERE	ipvs.seqNo = pvs.seqNo AND tmp.SportType NOT IN (1, 2, 43)								
				FOR XML PATH ('')						
			), 2) AS Val
		) p2;
	--====================Update VR Super=========================
	--> Update VR for itself --soccer
	UPDATE cvs
	SET cvs.bitmapVirtual = bm.bitmap
	FROM		CustVirtualSetting	AS cvs WITH(UPDLOCK, ROWLOCK)
	INNER JOIN	@virtualXML_Soccer			AS tmp
			ON	cvs.seqNo = tmp.seqNo
	CROSS APPLY (SELECT TOP 1 bitmap FROM dbo.f_GenerateVirtualSetting_inline(cvs.bitmapVirtual, tmp.Val, tmp.Pos)) AS bm
	WHERE	cvs.custid = @srecommend;

	--> Update VR for itself --Basketball									
	UPDATE cvs																
	SET cvs.bitmapVirtual = bm.bitmap									
	FROM		CustVirtualSetting	AS cvs WITH(UPDLOCK, ROWLOCK)										
	INNER JOIN	@virtualXML_Basketball			AS tmp						
			ON	cvs.seqNo = tmp.seqNo										
	CROSS APPLY (SELECT TOP 1 bitmap FROM dbo.f_GenerateVirtualSetting_inline(cvs.bitmapVirtual, tmp.Val, tmp.Pos)) AS bm	
	WHERE	cvs.custid = @srecommend;											

	--> Update VR for itself --Other sports
	UPDATE cvs
	SET cvs.bitmapVirtual = bm.bitmap
	FROM		CustVirtualSetting	AS cvs WITH(UPDLOCK, ROWLOCK)
	INNER JOIN	@virtualXML_OS			AS tmp
			ON	cvs.seqNo = tmp.seqNo
	CROSS APPLY (SELECT TOP 1 bitmap FROM dbo.f_GenerateVirtualSetting_inline(cvs.bitmapVirtual, tmp.Val, tmp.Pos)) AS bm
	WHERE	cvs.custid = @srecommend;
	--====================END Update VR Super=========================

	--Members
	INSERT INTO #Members (CustID)
	SELECT c.custid
	FROM dbo.CustInfo c WITH(NOLOCK)
	WHERE c.srecommend = @srecommend AND c.custid <> @srecommend AND c.custid < @max_custid

	DELETE t
	FROM #Members t
		CROSS APPLY (SELECT TOP 1 custID FROM VRCustLockStatus WITH(NOLOCK) WHERE t.custID = CustID AND Type = 1) l1
		CROSS APPLY (SELECT TOP 1 custID FROM VRCustLockStatus WITH(NOLOCK) WHERE t.custID = CustID AND Type = 2) l2
		CROSS APPLY (SELECT TOP 1 custID FROM VRCustLockStatus WITH(NOLOCK) WHERE t.custID = CustID AND Type = 3) l3	

	DECLARE @msg nvarchar(200) = 'Currently at No. of Customers: %d'
	DECLARE @msg_total nvarchar(200) = 'Total of members: %d.'
	DECLARE @cnt INT = 0,
			@_cnt INT

	SELECT @_cnt = COUNT(1) FROM #Members

	RAISERROR (@msg_total, 0, 1, @_cnt) WITH NOWAIT
	
	--For Member
	WHILE (1 = 1)
	BEGIN
		DELETE FROM #BatchCust

		DELETE TOP (@BatchSize) T
		OUTPUT deleted.CustID
			INTO #BatchCust(CustID)
		FROM #Members t 

		SELECT @_cnt = @@ROWCOUNT
	
		IF @_cnt = 0 
			BREAK;
	
		SELECT @cnt = @cnt + @_cnt
	
		RAISERROR (@msg, 0, 1,@cnt) WITH NOWAIT
	
		SELECT @CustList=(SELECT CustID	AS '@CustID' 							
						FROM #BatchCust
						FOR XML PATH('root')
					)
	
		EXEC dbo.[Acc_CustomerInfo_Execrep_09] 
					@target = @target,
					@srecommend = @srecommend,
					@CustList=@CustList
	
		WAITFOR DELAY '00:00:0.020'
	END		

	DROP TABLE #Members
	DROP TABLE #BatchCust

GO

