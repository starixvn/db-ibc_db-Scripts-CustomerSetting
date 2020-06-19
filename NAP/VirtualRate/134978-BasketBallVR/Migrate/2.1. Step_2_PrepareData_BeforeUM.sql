/*
	Creator: 20200615@Eden
	Task: Prepare raw data before UM - Redmine: #134978
		Step 1: Get terminated srecommend and IBO srecommend
		Step 2: Insert raw data with custid in [1, MaxCustID1]
	Run at: CustDB@DBCUST 
*/
USE CustDB
GO
	--Step 1: Get terminated srecommend
	CREATE TABLE #ExcludeLicSuper (CustID INT)

	INSERT INTO #ExcludeLicSuper(CustID)
	SELECT ci.custid
	FROM custInfo ci with (nolock)
		INNER JOIN Dep_CustSuper ds with (nolock) on ds.custid = ci.custid
		INNER JOIN bodb_licensee.dbo.Licensees l with (nolock) on ds.site = l.LicenseeName
	WHERE l.IsActive = 0 OR ds.site = 'IBO'

	CREATE UNIQUE CLUSTERED INDEX CIX_CustID ON #ExcludeLicSuper(CustID)


	--Step 2: Insert raw data with custid in [1, MaxCustID1]
	DECLARE @MaxCustID INT = MaxCustID1
	DECLARE @CustID INT = 1			
	DECLARE @ToCustID INT 
	DECLARE @Batch INT = 100000
	DECLARE @sCustID VARCHAR(100)			
	WHILE (@CustID <= @MaxCustID)			
	BEGIN	
		SET @ToCustID = @CustID + @Batch
		IF @ToCustID >@MaxCustID
			SET @ToCustID = @MaxCustID	
				
		INSERT INTO [BasketBallVR_Temp]	WITH(TABLOCK) (
							 VRValue_HDPLive,VRValue_HDPNonLive
							,VRValue_OULive,VRValue_OUNonLive
							,VRValue_OELive,VRValue_OENonLive
							,VRValue_MNLive,VRValue_MNNonLive
							,srecommend
							,mrecommend
							,recommend
							,RoleID
							,CustID
					)	
		SELECT 
				  CASE WHEN c.VirtualMultiplier = 1 THEN dbo.f_GetVirtualSetting(cvs.bitmapVirtual, 14) ELSE 1 END VRValue_HDPLive
				, CASE WHEN c.VirtualMultiplier = 1 THEN dbo.f_GetVirtualSetting(cvs.bitmapVirtual, 13) ELSE 1 END VRValue_HDPNonLive
				, CASE WHEN c.VirtualMultiplier = 1 THEN dbo.f_GetVirtualSetting(cvs.bitmapVirtual, 18) ELSE 1 END VRValue_OULive
				, CASE WHEN c.VirtualMultiplier = 1 THEN dbo.f_GetVirtualSetting(cvs.bitmapVirtual, 17) ELSE 1 END VRValue_OUNonLive
				, CASE WHEN c.VirtualMultiplier = 1 THEN dbo.f_GetVirtualSetting(cvs.bitmapVirtual, 16) ELSE 1 END VRValue_OELive
				, CASE WHEN c.VirtualMultiplier = 1 THEN dbo.f_GetVirtualSetting(cvs.bitmapVirtual, 15) ELSE 1 END VRValue_OENonLive
				, CASE WHEN c.VirtualMultiplier = 1 THEN dbo.f_GetVirtualSetting(cvs2.bitmapVirtual, 132) ELSE 1 END VRValue_MNLive
				, CASE WHEN c.VirtualMultiplier = 1 THEN dbo.f_GetVirtualSetting(cvs2.bitmapVirtual, 131) ELSE 1 END VRValue_MNNonLive
				,c.srecommend
				,c.mrecommend
				,c.recommend
				,c.roleid
				,cvs.CustID
		FROM [dbo].[CustVirtualSetting]  cvs(NOLOCK)	
			INNER JOIN custInfo c(NOLOCK) ON c.custid = cvs.custid
			INNER JOIN [CustVirtualSetting] cvs2(NOLOCK) ON cvs2.custid = cvs.custid
			LEFT JOIN custInfo r(NOLOCK) ON r.custid = c.recommend
			LEFT JOIN [dbo].[CustVirtualSetting] rvs(NOLOCK) ON rvs.custid = r.custid AND rvs.seqNo=cvs.seqNo
			LEFT JOIN [dbo].[CustVirtualSetting] rvs2(NOLOCK) ON rvs2.custid = r.custid AND rvs2.seqNo = cvs2.seqNo
		WHERE cvs.seqNo = 1 
			AND cvs2.seqNo = 3 
			AND c.CustID BETWEEN @CustID AND @ToCustID	
			AND c.srecommend NOT IN (SELECT CustID FROM #ExcludeLicSuper)	
			AND c.Enabled = 1
			AND ( c.roleid IN (2,3,4)
				OR (
					c.roleid = 1 AND
					(
						   CASE WHEN c.VirtualMultiplier = 1 THEN dbo.f_GetVirtualSetting(cvs.bitmapVirtual, 14) ELSE 1 END
							<> CASE WHEN c.VirtualMultiplier = 1 THEN dbo.f_GetVirtualSetting(rvs.bitmapVirtual, 14) ELSE 1 END
						OR CASE WHEN c.VirtualMultiplier = 1 THEN dbo.f_GetVirtualSetting(cvs.bitmapVirtual, 13) ELSE 1 END
							<> CASE WHEN c.VirtualMultiplier = 1 THEN dbo.f_GetVirtualSetting(rvs.bitmapVirtual, 13) ELSE 1 END
						OR CASE WHEN c.VirtualMultiplier = 1 THEN dbo.f_GetVirtualSetting(cvs.bitmapVirtual, 18) ELSE 1 END
							<> CASE WHEN c.VirtualMultiplier = 1 THEN dbo.f_GetVirtualSetting(rvs.bitmapVirtual, 18) ELSE 1 END
						OR CASE WHEN c.VirtualMultiplier = 1 THEN dbo.f_GetVirtualSetting(cvs.bitmapVirtual, 17) ELSE 1 END
							<> CASE WHEN c.VirtualMultiplier = 1 THEN dbo.f_GetVirtualSetting(rvs.bitmapVirtual, 17) ELSE 1 END
						OR CASE WHEN c.VirtualMultiplier = 1 THEN dbo.f_GetVirtualSetting(cvs.bitmapVirtual, 16) ELSE 1 END
							<> CASE WHEN c.VirtualMultiplier = 1 THEN dbo.f_GetVirtualSetting(rvs.bitmapVirtual, 16) ELSE 1 END
						OR CASE WHEN c.VirtualMultiplier = 1 THEN dbo.f_GetVirtualSetting(cvs.bitmapVirtual, 15) ELSE 1 END
							<> CASE WHEN c.VirtualMultiplier = 1 THEN dbo.f_GetVirtualSetting(rvs.bitmapVirtual, 15) ELSE 1 END
						OR CASE WHEN c.VirtualMultiplier = 1 THEN dbo.f_GetVirtualSetting(cvs2.bitmapVirtual, 132) ELSE 1 END
							<> CASE WHEN c.VirtualMultiplier = 1 THEN dbo.f_GetVirtualSetting(rvs2.bitmapVirtual, 132) ELSE 1 END
						OR CASE WHEN c.VirtualMultiplier = 1 THEN dbo.f_GetVirtualSetting(cvs2.bitmapVirtual, 131) ELSE 1 END
							<> CASE WHEN c.VirtualMultiplier = 1 THEN dbo.f_GetVirtualSetting(rvs2.bitmapVirtual, 131) ELSE 1 END
					)
				)
			)	
		OPTION(RECOMPILE)
			
		SELECT @CustID = @ToCustID + 1		
		SELECT @sCustID = CAST(@CustID AS VARCHAR(100))		
			
		RAISERROR(@sCustID, 0, 1) WITH NOWAIT		
		WAITFOR DELAY '00:00:00.020'		
	END			

DROP TABLE #ExcludeLicSuper
GO