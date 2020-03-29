/*
	created: 20200329@Johnson
	Task: adjust PT FW for some line [redmine:#131274]
	DB: DBCUST/CUSTDB
*/
CREATE TABLE #tblCust (custid INT, srecommend INT, isFinished BIT DEFAULT 0)

INSERT INTO #tblCust(custid,srecommend)
SELECT custid, srecommend
FROM custinfo WITH(NOLOCK)
WHERE srecommend IN (4664545,--	HD
					14592746,--	MOD
					17916695,--	VJ
					26369026--	DH
					)
	AND roleid = 3					
	
DELETE t
FROM #tblCust t
	INNER JOIN CustPTSetting3rd_Agent cs (NOLOCK) ON t.custid = cs.custid
WHERE cs.sporttype = 219
	AND cs.AutoSuperPT >= 90

DECLARE @AutoPT		VARCHAR(MAX),
		@PT			VARCHAR(MAX),
		@srecommend INT,
		@custid 	INT

SELECT @PT='<ROOT><PT SportType="219" BetType="1011" IsLive="0"/></ROOT>'
		
WHILE (1=1)	
BEGIN
	UPDATE TOP (1) t
	SET @custid = custid,
		@srecommend = srecommend,
		isFinished = 1
	FROM #tblCust t 
	WHERE isFinished = 0
	
	IF @@ROWCOUNT = 0
		BREAK;
	
	SET @AutoPT =(
			SELECT cs.sporttype AS '@SportType'
				,cs.bettype AS '@BetType'
				,cs.isLive AS '@IsLive'			
				,1 AS '@IsAuto_New'
				,cs.isAutoSuperPT AS '@IsAuto_Old'	
				,0 AS '@IsUpdAllMems'
				,0 AS '@UpdAllMems_Value'
			FROM CustPTSetting3rd_Agent cs WITH(NOLOCK)				
			WHERE custid = @custid 
				AND sporttype = 219
			FOR XML PATH('PT'), ROOT('ROOT')
		 )	
	
	UPDATE cs
	SET SuperPT = 0,
		isAutoSuperPT = 1,
		AutoSuperPT = 90
	FROM CustPTSetting3rd_Agent cs WITH(UPDLOCK,ROWLOCK)
	WHERE custid = @custid
		AND sporttype = 219
		
	EXEC dbo.Acc_DynamicCustSetting3rd_05
            @SuperID = @srecommend,
            @MasterID = @custid,
            @RoleID = 3,          
            @AutoPT = @AutoPT
           
	EXEC dbo.Acc_DynamicCustSetting3rd_07
		@SuperID = @srecommend
		,@MasterID = @custid
		,@RoleID = 3
		,@SportBettypeXML = @PT	
	
	WAITFOR DELAY '0:0:0.28'
END




	