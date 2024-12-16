/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20241113@Winfred
	Task: HF - NAP- Cannot updating VR value for licensee super line with 
			big downline member (over 500000 members downline) -- New Account [redmine: #213009]
	DB: DBCust/CustDB
*/
-- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
ALTER PROCEDURE [dbo].[Acc_CustomerInfo_Execrep_09]	
	@max_custid INT
AS
BEGIN
	SET NOCOUNT ON;
		
	IF OBJECT_ID('CustVirtualSetting') IS NULL OR OBJECT_ID('VRCustLockStatus') IS NULL
	RETURN;

	DECLARE @BatchSize	INT = 650
		,@srecommend INT = 108357647 --TGXISWSuperPE

	CREATE TABLE #Members (CustID INT PRIMARY KEY)
	CREATE TABLE #BatchCust (CustID INT PRIMARY KEY)

	--Members
	INSERT INTO #Members (CustID)
	SELECT c.custid
	FROM dbo.CustInfo c WITH(NOLOCK)
	WHERE c.srecommend = @srecommend AND c.custid > @max_custid
	
	DELETE t
	FROM #Members t
	CROSS APPLY (SELECT TOP 1 custID FROM VRCustLockStatus WITH(NOLOCK) WHERE t.custID = CustID AND Type = 1) l1
	CROSS APPLY (SELECT TOP 1 custID FROM VRCustLockStatus WITH(NOLOCK) WHERE t.custID = CustID AND Type = 2) l2
	CROSS APPLY (SELECT TOP 1 custID FROM VRCustLockStatus WITH(NOLOCK) WHERE t.custID = CustID AND Type = 3) l3	

	--For Member
	WHILE (1 = 1)
	BEGIN
		DELETE FROM #BatchCust

		DELETE TOP (@BatchSize) T
		OUTPUT deleted.CustID
		INTO #BatchCust(CustID)
		FROM #Members t 

		IF @@ROWCOUNT = 0 
			BREAK;

		--> Update Soccer VR
		UPDATE cvs
		SET cvs.bitmapVirtual = bm.bitmapVirtual,
			cvs.RepUpdateTime = [dbo].[f_GetDateTime2]()
		FROM	#BatchCust tmpCust
			CROSS APPLY (
				SELECT TOP 3 cv.seqNo, cv.bitmapVirtual
				FROM CustVirtualSetting	AS cv WITH (NOLOCK)
				WHERE cv.custID = @srecommend
			) bm
			CROSS APPLY (
				SELECT TOP 1 cvs.seqNo, cvs.bitmapVirtual, cvs.RepUpdateTime
				FROM CustVirtualSetting	AS cvs WITH (UPDLOCK, ROWLOCK)
				WHERE cvs.custID = tmpCust.custID AND seqNo = bm.seqNo AND cvs.bitmapVirtual <> bm.bitmapVirtual
			) cvs
	END		

	DROP TABLE #Members
	DROP TABLE #BatchCust
END
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------			


-- BEGIN STEP 2: RUN THIS SCRIPT AT DBCUST ONLY -----
--------------------------------------------------------------------------------------
Declare @max_custid INT
SET @max_custid = xxx

EXEC dbo.[Acc_CustomerInfo_Execrep_09] @max_custid = @max_custid

GO

