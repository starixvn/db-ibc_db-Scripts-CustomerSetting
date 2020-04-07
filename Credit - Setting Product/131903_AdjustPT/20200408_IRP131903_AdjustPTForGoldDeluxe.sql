/*
	Created: 20200407@Elodie
	Task: adjust PT Gold Deluxe for some line [redmine:#131903]
	DB: DBCUST/CUSTDB
*/
CREATE TABLE #tblMaster (custid INT, srecommend INT, isFinished BIT DEFAULT 0)

INSERT INTO #tblMaster(custid,srecommend)
SELECT custid, srecommend
FROM custinfo WITH(NOLOCK)
WHERE srecommend IN (21355056	--ACE
					,13744152	--AG
					,5086616	--AN
					,4314665	--AP
					,4212172	--AS
					,39061067	--AV
					,1812820	--AW
					,26369026	--DH
					,21498400	--FAT
					,27783723	--KC
					,39645666	--NO
					,18747621	--WG
					,19984898	--WINB
					,19984899	--WINC
					,20096077	--WING
					,19998069	--WINZ
					,18364243	--WJ
					,40332643	--WO
					)
	AND roleid = 3					
	
DELETE t
FROM #tblMaster t
	INNER JOIN CustSettingGame cs (NOLOCK) ON t.custid = cs.custid
WHERE cs.sporttype = 255
	AND cs.bettype = 1701
	AND cs.autopositiontaking >= 0.93

DECLARE @srecommend INT,
		@custid 	INT,
		@old_isauto BIT

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
	
	SELECT @Old_isauto = isautopositiontaking
	FROM CustSettingGame cs WITH(NOLOCK)
	WHERE custid = @custid
		AND sporttype = 255
	
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
            @old_isauto_v255spositiontaking_1701 = @Old_isauto,
            
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




	