/*<info serverAlias="DBCUST-CustDB"></info>*/ 
/*
	Created: Eden@20250325
	Task: Correct data Archive process for Agent 106226153 and downlines [#221624]
	DB: DBCUST/CustDB
*/
USE CUSTDB
GO
DECLARE  @AccName varchar(50),
	@UserID int = 360418,
	@ErrMsg nvarchar(200) = '',
	@ErrCode int = 0,
	@AgentID INT = 106226153,
	@ArchivedDate DATE = GETDATE(), --keep time stamp for Cust_ArchiveAccount
	@ProcessedDate DATETIME = GETDATE()

SELECT @AccName = username
FROM GlobCustDB.dbo.CustinfoMini WITH(NOLOCK) 
WHERE custid = @AgentID

DECLARE @CustIDs VARCHAR(MAX) = ''

SELECT @CustIDs = @CustIDs + cast(custid AS VARCHAR(10)) + ','
FROM GlobCustDB.dbo.CustinfoMini WITH(NOLOCK)  
WHERE recommend = @AgentID	

--Delete CustInfoMini
EXEC DBGLOB.GlobCustDB.dbo.[DBA_ArchiveAccount4_DelCustInfoMini] @CustIDs = @CustIDs

--Write Log archive
DECLARE @LogSPData varchar(2000)
SELECT @LogSPData = '<DBA_ArchiveAccount4_DelCustInfo AccName="'+ coalesce(cast(@AccName as varchar(50)),space(1))+ '" ' +
					'UserID="'+ coalesce(cast(@UserID as varchar(50)),space(1)) + '" ' +
					'ErrMsg="'+ coalesce(cast(@ErrMsg as varchar(400)),space(1))+ '" ' +
					'ErrCode="'+ coalesce(cast(@ErrCode as varchar(50)),space(1))  + '"/>'

EXEC DBLOG.bodb_CustomerLog.dbo.WriteLog_UserLog_RunSP
	@UserID = @UserID,
	@CustID = @AgentID,
	@ActionID = 1500,
	@TrackingValue = @LogSPData	

--Insert data CustArchiveAccount
EXEC dbo.[Acc_DormantAccountList_InsertUpdate] 
	@CustId = @AgentID,
	@RoleID = 2,
	@StageID = 4,
	@ProcessedDate = @ProcessedDate,
	@ArchivedDate = @ArchivedDate
	
--Update tmpCustArchived set IsFinished = 1
UPDATE tmpCustArchived 
SET ErrMsg = @ErrMsg, IsFinished = 1
WHERE Agent = @AccName
