/*
	created: 20200328@Johnson
	Task: adjust PT Gold Deluxe for some line [redmine:#131274]
	DB: DBCUST/CUSTDB
*/
CREATE TABLE #tblMaster (custid INT, srecommend INT, isFinished BIT DEFAULT 0)

INSERT INTO #tblMaster(custid,srecommend)
SELECT custid, srecommend
FROM custinfo WITH(NOLOCK)
WHERE srecommend IN (4664545,--	HD
					14592746,--	MOD
					17916695,--	VJ
					26369026--	DH
					)
	AND roleid = 3					
	
DELETE t
FROM #tblMaster t
	INNER JOIN CustSettingGame cs (NOLOCK) ON t.custid = cs.custid
WHERE cs.sporttype = 255
	AND cs.bettype = 1701
	AND NOT (cs.isautopositiontaking = 1 AND cs.autopositiontaking = 0.80) 

DECLARE @srecommend INT,
		@custid 	INT

WHILE (1=1)	
BEGIN
	UPDATE TOP (1) t
	SET @custid = custid,
		@srecommend = srecommend,
		isFinished = 1
	FROM #tblMaster t 
	WHERE isFinished = 0
	
	IF @@ROWCOUNT = 0
		BREAK;
		
	UPDATE cs
	SET spositiontaking = 0,
		isautopositiontaking = 1,
		autopositiontaking = 0.93
	FROM CustSettingGame cs WITH(UPDLOCK,ROWLOCK)
	WHERE custid = @custid
		AND sporttype = 255
		
	EXEC dbo.Acc_CustSetting3rd_05
            @srecommend = @srecommend,
            @mrecommend = @custid,
            @roleid = 3,
            @mode = 'GoldDeluxe',
            
            @isauto_v255spositiontaking_1701 = 1,
            @old_isauto_v255spositiontaking_1701 = 1,
            
            @auto_v255spositiontaking_1701 = 0.93, 
            
            @Updateallmembers = 0,
            @newspositiontaking = 0
			
	EXEC dbo.Acc_CustSetting3rd_07
            @srecommend = @srecommend,
            @mrecommend = @custid,
            @roleid = 3,
            @mode = 'GoldDeluxe',
            @sporttype = 255,
            @bettype = 1701
	
	WAITFOR DELAY '0:0:0.28'
END




	