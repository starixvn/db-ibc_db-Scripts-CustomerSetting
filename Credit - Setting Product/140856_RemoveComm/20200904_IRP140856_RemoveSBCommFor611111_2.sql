/*
	Created: 20200904@Johnson
	Task: Remove Sportsbook Comm from 611111 Site
	DB: DBCUST/CustDB	
*/

DECLARE @custid INT,
		@roleid INT,
		@Errcode INT,
		@ErrMsg NVARCHAR(1000)

CREATE TABLE #tblSMA(CustID INT, roleid INT, isfinished BIT DEFAULT(0))

CREATE TABLE #result (custid int, errcode int, errmsg varchar(1000))

INSERT INTO #tblSMA(custid,roleid)
SELECT c.custid, c.roleid
FROM vw_customer c WITH(NOLOCK)
	INNER JOIN custinfo ci WITH(NOLOCK) ON c.custid = ci.custid
WHERE c.currency IN (2,	--	RM
					5,	--	HK$
					13	--	RMB
				)
	AND c.roleid = 4
	AND c.site IN ('611111')
	AND ci.enabled = 1
	
--direct master/agent	
INSERT INTO #tblSMA(custid,roleid)
SELECT c.custid, c.roleid
FROM vw_customer c WITH(NOLOCK)
	INNER JOIN custinfo ci WITH(NOLOCK) ON c.custid = ci.custid
	INNER JOIN CustDirectAccount d WITH(NOLOCK) ON c.custid = d.custid
	INNER JOIN CustSuper s WITH(NOLOCK) ON s.custid = c.srecommend 
										AND s.IsInternal = 0
WHERE c.currency IN (2,	--	RM
					5,	--	HK$
					13	--	RMB
					)
	AND c.roleid < 4
	AND c.site IN ('611111')	
	AND ci.enabled = 1

-- For deployer info
DECLARE @super_cnt INT, @index INT = 0

SET @super_cnt = (SELECT COUNT(*) FROM #tblSMA )

DECLARE @msg NVARCHAR(200) = 'Currently at order %d, CustID: %d.'

DECLARE @msg_total NVARCHAR(200) = 'Total of SMA: %d.'

RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	SELECT @Errcode = 0,
			@ErrMsg = ''

	UPDATE TOP (1) #tblSMA
	SET isfinished = 1
		,@custid = custid	
		,@roleid = roleid		
	WHERE isfinished = 0				
				
	IF @@ROWCOUNT = 0 BREAK
	
	SET @index = @index + 1
	
	RAISERROR (@msg, 0, 1,@index, @custid) WITH NOWAIT
	
	IF @roleid = 4
	BEGIN
		EXEC [dbo].[Acc_CustomerUpdSuper_Commission]
			@custid = @custid,-- superid
			
			@groupa = 0,
			@groupb = 0,
			@groupc = 0,
			@groupd = 0,
			@discountcs = 0,    
			@discount1x2 =0,   
			@updatecomm_old =1,
			@UserID = 10278938, --starixIT
			@Language = 'E',
			@IP = '10.3.11.200',
			@ErrCode = @Errcode OUTPUT ,
			@ErrMsg = @ErrMsg OUTPUT 
	END
	ELSE IF @roleid = 3
	BEGIN
		EXEC Acc_CustomerUpdMaster_Commission
			@custid = @custid,-- masterId    
			@groupa = 0,
			@groupb = 0,
			@groupc = 0,
			@groupd = 0,
			@discountcs = 0,
			@discount1x2 =0,
			@updatecomm_old = 1,
			@SubAccID = 0, --Sub-AccountID    
			@UserID  = 10278938,    
			@Language = 'E',
			@IP ='10.3.11.200',
			@ErrCode = @Errcode OUTPUT ,
			@ErrMsg = @ErrMsg OUTPUT
	END
	ELSE IF @roleid = 2
	BEGIN
		EXEC Acc_CustomerUpdAgent_Commission
			@custid = @custid,-- AgentId
			@groupa = 0,
			@groupb = 0,
			@groupc  = 0,
			@groupd  = 0,
			@discountcs =0,
			@discount1x2 =0,
			@updatecomm_old = 1,
			@SubAccID = 0, --Sub-AccountID
			@UserID = 10278938,	
			@Language = 'E',
			@IP ='10.3.11.200',
			@ErrCode = @Errcode OUTPUT ,
			@ErrMsg = @ErrMsg OUTPUT
	END

	INSERT INTO #result(custid,errcode,errmsg)
	select @custid, @Errcode, @ErrMsg
	
	WAITFOR DELAY '0:0:0.28'
END	

select * from #result where errcode > 0