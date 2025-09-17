/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20250917@Eden
	Task : Delete accounts who incorrect data created during account registration. [#239047]
	DB: DBCUST-CustDB
*/
	USE CustDB
	GO
	DECLARE @CustID INT, @RoleID TINYINT 

	CREATE TABLE #Temp_WrongCusts (CustID INT,RoleID TINYINT, IsFinished BIT DEFAULT 0)

	INSERT INTO #Temp_WrongCusts (CustID,RoleID)
	SELECT CI.custid,ci.roleid
	FROM Custinfo ci WITH(NOLOCK) 
		INNER JOIN GlobCustDB.dbo.CustInfoMini cm WITH(NOLOCK)
			ON ci.custid = cm.CustID
			AND ci.recommend <> cm.recommend
	WHERE ci.CustID IN (262459222,262463511,262465540,262549463)

	WHILE 1 = 1
	BEGIN
		UPDATE TOP(1) t
			SET t.IsFinished = 1,
				@CustID = t.CustID,
				@RoleID = t.RoleID
		FROM #Temp_WrongCusts t
		WHERE t.IsFinished = 0

		IF @@ROWCOUNT = 0
			BREAK;

		-- ROLLBACK Custsetting	
		EXEC Acc_CustomerInsSetting_Rollback @CustID = @CustID, @RoleID = @RoleID
		-- ROLLBACK CustInfo
		EXEC Acc_CustomerInsUserInfo_Rollback @CustID = @CustID
		--Rollback CustinfoMini
		EXEC GLOBCUSTDB.dbo.Acc_CustomerIns_Rollback @custid = @CustID
	END
	
	DROP TABLE #Temp_WrongCusts