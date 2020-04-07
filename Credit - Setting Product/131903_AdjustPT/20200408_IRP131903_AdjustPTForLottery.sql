/*
	Created: 20200407@Elodie
	Task: adjust PT Lottery for some line [redmine:#131903]
	DB: DBCUST/CUSTDB
*/
CREATE TABLE #tblCust (custid INT, srecommend INT, isFinished BIT DEFAULT 0)
CREATE TABLE #tblCustSport (custid INT, sporttype INT, bettype INT, isLive BIT)

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

INSERT INTO #tblCustSport(custid,sporttype,bettype,isLive)	
SELECT cs.custid, cs.sporttype, cs.bettype, cs.isLive
FROM #tblCust t
	CROSS JOIN (
				SELECT 220 as sporttype, 1021 as bettype, 0 isLive
				UNION ALL  SELECT 220, 1022, 0
				UNION ALL  SELECT 220, 1023, 0
				UNION ALL  SELECT 220, 1024, 0
				) s
		INNER JOIN CustPTSetting3rd_Agent cs (NOLOCK) ON t.custid = cs.custid 
														AND cs.SportType = s.sporttype 
														AND cs.BetType = s.bettype
WHERE cs.AutoSuperPT < 85

DELETE t
FROM #tblCust t	
WHERE custid NOT IN (SELECT DISTINCT custid FROM #tblCustSport)

DECLARE @AutoPT		VARCHAR(MAX),
		@PT			VARCHAR(MAX),
		@srecommend INT,
		@custid 	INT

SELECT @PT='<ROOT>
<PT SportType="220" BetType="1021" IsLive="0"/>
<PT SportType="220" BetType="1022" IsLive="0"/>
<PT SportType="220" BetType="1023" IsLive="0"/>
<PT SportType="220" BetType="1024" IsLive="0"/>
</ROOT>'
		
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
				INNER JOIN #tblCustSport t ON cs.custid = t.custid 
											AND cs.sporttype = t.sporttype
											AND cs.bettype = t.bettype
											AND cs.isLive = t.isLive
			WHERE t.custid = @custid 				
			FOR XML PATH('PT'), ROOT('ROOT')
		 )	
	
	UPDATE cs
	SET cs.SuperPT = 0,
		cs.isAutoSuperPT = 1,
		cs.AutoSuperPT = 85
	FROM CustPTSetting3rd_Agent cs WITH(UPDLOCK,ROWLOCK)
		INNER JOIN #tblCustSport t ON cs.custid = t.custid 
									AND cs.sporttype = t.sporttype
									AND cs.bettype = t.bettype
									AND cs.isLive = t.isLive
	WHERE t.custid = @custid
		
		
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




	