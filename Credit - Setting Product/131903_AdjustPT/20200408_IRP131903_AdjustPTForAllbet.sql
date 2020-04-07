/*
	Created: 20200407@Elodie
	Task: adjust PT Allbet for some line [redmine:#131903]
	DB: DBCUST/CUSTDB
*/
CREATE TABLE #tblCust (custid INT, srecommend INT, isFinished BIT DEFAULT 0)

INSERT INTO #tblCust(custid,srecommend)
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
FROM #tblCust t
	INNER JOIN CustPTSetting3rd_Agent cs (NOLOCK) ON t.custid = cs.custid
WHERE cs.sporttype = 211
	AND cs.AutoSuperPT >= 93 

DECLARE @AutoPT		VARCHAR(MAX),
		@PT			VARCHAR(MAX),
		@srecommend INT,
		@custid 	INT

SELECT @PT='<ROOT><PT SportType="211" BetType="2401" IsLive="0"/></ROOT>'
		
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
				AND sporttype = 211
			FOR XML PATH('PT'), ROOT('ROOT')
		 )	
	
	UPDATE cs
	SET SuperPT = 0,
		isAutoSuperPT = 1,
		AutoSuperPT = 93
	FROM CustPTSetting3rd_Agent cs WITH(UPDLOCK,ROWLOCK)
	WHERE custid = @custid
		AND sporttype = 211
		
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




	