/*
	Created: 20210127@JOhnson
	Task: update master comm for DCS(Live Casino)
	DB: DBCUST/CustDB
*/


CREATE TABLE #Supers (custid INT PRIMARY KEY)
CREATE TABLE #Masters (custid INT PRIMARY KEY, srecommend INT, isFinished BIT DEFAULT 0)

INSERT INTO #Supers(custid)		
SELECT c.custid
FROM vw_customer c WITH (NOLOCK)			
	INNER JOIN CustSuper cs WITH (NOLOCK) ON cs.custid = c.custid			
WHERE roleid = 4			
	AND c.site= 'IBCINDO'			
	AND currency <> 20			
	AND IsInternal = 0			
			
INSERT INTO #Masters(custid,srecommend)
SELECT c.custid, c.srecommend 			
FROM vw_customer c WITH (NOLOCK)			
	INNER JOIN custInfo cu WITH (NOLOCK) ON cu.custid = c.custid			
	INNER JOIN #Supers s on s.custid = c.srecommend			
WHERE c.roleid= 3			
	AND cu.Enabled= 1	

--Live Casino
DECLARE @ProductID INT = 41,
	@SettingStatus BIT = 0,
	@SettingType TINYINT = 19-- Live CS
	
SELECT SportType,Bettype,SettingType
INTO #SportBettypeFilter
FROM dbo.f_CustSetting_SportBetTypeSettingSelect(@ProductID,19,@SettingStatus) --Commission

DECLARE @custid INT,
		@srecommend INT,
		@xml VARCHAR(MAX)

-- For deployer info
DECLARE @master_cnt INT, @index INT = 0
DECLARE @msg NVARCHAR(200) = 'Currently at order %d, MasterID: %d.'
DECLARE @msg_total NVARCHAR(200) = 'Total of Masters: %d.'

SET @master_cnt = (SELECT COUNT(*) FROM #Masters )
RAISERROR (@msg_total, 0, 1, @master_cnt) WITH NOWAIT
		
WHILE(1=1)
BEGIN
	SET @xml = ''
	
	UPDATE TOP (1) t
	SET isFinished = 1,
		@custid = custid,
		@srecommend = srecommend
	FROM #Masters t
	WHERE isFinished = 0
	
	IF @@ROWCOUNT = 0
		BREAK;
		
	SET @index = @index + 1
	RAISERROR (@msg, 0, 1, @index, @custid) WITH NOWAIT
	
	SELECT @xml = (
				SELECT cs.SportType, cs.BetType, cs.Discount
				FROM CustDiscount3rd_Agent cs WITH(NOLOCK)
					INNER JOIN #SportBettypeFilter s ON cs.sporttype = s.sporttype
													AND cs.bettype = s.bettype
				WHERE custid = @srecommend									
				FOR XML RAW('Discount')
				)

	SELECT @xml = '<ROOT>' + @xml + '</ROOT>'

	--execrept to update commission
	EXEC dbo.Acc_DynamicCustSetting3rd_09
			@CustId			= @custid
			, @RoleId		= 3
			, @SettingType  = @SettingType
			, @Discount_XML = @xml
	
	WAITFOR DELAY '0:0:0.28'
END	
	