/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: 20221130@Johnson
	Task: update hideKeno = 0 for list supers [redmine: #181009]
	DB: DBCUST/CustDB
*/
-- BEGIN STEP 1: Deploy this SP at DBCUST.CustDB
------------------------------------------------------
ALTER PROCEDURE [dbo].[Acc_CustomerInfo_Execrep_09]
	@srecommend INT, 
	@target VARCHAR(20)
AS	
BEGIN
SET NOCOUNT ON;
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DBSPARE')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','TESTDBCUST','DBSPARE')) RETURN -- run at dbcust only

	
	IF dbo.f_CheckRepTable('Custinfo') = 0 RETURN	
	
	CREATE TABLE #tblCust (custid INT PRIMARY KEY, isfinished BIT DEFAULT(0))
	DECLARE @tmpCust TABLE (custid INT PRIMARY KEY)

	INSERT INTO #tblCust(custid)
	SELECT custid
	FROM custinfo c WITH(NOLOCK)				
	WHERE c.srecommend = @srecommend
		AND c.HideKeno = 1
		AND c.enabled = 1
		
	WHILE(1=1)
	BEGIN
		DELETE TOP (5000) t
		OUTPUT DELETED.custid INTO @tmpCust(custid)
		FROM #tblCust t
		
		IF @@ROWCOUNT = 0
			BREAK;
			
		UPDATE c
		SET HideKeno = 0
		FROM custinfo c WITH(ROWLOCK)
		WHERE custid IN (SELECT custid FROM @tmpCust)

		DELETE @tmpCust
	END
	
END	
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

---
-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS & DBCUST -----
--------------------------------------------------------------------------------------
DECLARE @target VARCHAR(20)

IF @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DBSPARE')
	SET @target = 'DBCUST'
ELSE 
	SET @target = 'REPLICATED'

Print 'Server Name : ' + @target

CREATE TABLE #Supers(CustID INT, isfinished BIT DEFAULT(0))
DECLARE @srecommend INT,
	@super_cnt INT,
	@index INT = 0
	
INSERT INTO #Supers(custid)
SELECT custid 
FROM customer WITH(NOLOCK)
WHERE username IN ('S5','S5P','S58R','S32CH','S32DH','S32EH','S32H','S32HH','S32HK','S32RMB','KCR','KHH','KR','KRR','JIP','CLR','CYH','D5M','SMOF','GK','GV','HAK','HHS','HL','SX5','HT','JEY','JV','KEN','KHR','KJC','KJD','KJE','KJI','KJT','KPW','KW','DAB','DAC','HDN','HDQ','HG','HN','HQ','S55G','M8HHHH','SGBT','SGCT','NBV','OH','OH5','POD','RHW','S11RP','s176h','S1P','S23RM','S30R','S31MR','S31R','S36RMB','S47R','S52RM','S666H','S77X','S688H','S76R','S90R','S98R','S9K','SAXX','SB11R','SB12R','SB13R','SB7R','SBLH','SCH','SCHK','SCI','SED','SEH','SMA','MOA','MOE','MOW','SMOCNY','SMOL','SMON','SMOP','SMOR','SMORMB','SSO','STE1A','STE5H','STE5M','STE6M','STEM','STIR','SWKR','SZR','TAM','ASG','HHHK2','HIR','ITSA5','sa-pppp','SBKKwrong','SMX','SROC','VVH','VVG','XKH','ZZ19')

	
SELECT @super_cnt = @@ROWCOUNT

DECLARE @msg NVARCHAR(200) = 'Currently at order %d, SuperID: %d.'

DECLARE @msg_total NVARCHAR(200) = 'Total of supers: %d.'

RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #supers
	SET isfinished = 1		
		,@srecommend = custid		
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK
		
	SET @index = @index + 1
	
	RAISERROR (@msg, 0, 1,@index, @srecommend) WITH NOWAIT
	
	EXEC dbo.Acc_CustomerInfo_Execrep_09 
			@srecommend = @srecommend,			
			@target = @target	
				
	WAITFOR DELAY '00:00:00.280'		
END		
GO	
-- END STEP 2: Run this SP at replicated DB & DBCUST -----
-----------------------------------------------------------------------------------
	  
