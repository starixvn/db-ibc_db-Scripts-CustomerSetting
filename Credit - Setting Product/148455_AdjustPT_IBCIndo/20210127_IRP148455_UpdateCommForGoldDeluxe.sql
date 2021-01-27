/*
	Created: 20210127@JOhnson
	Task: update master comm for Gold Deluxe
	DB: DBCUST/CustDB
*/

CREATE TABLE #Supers (custid INT PRIMARY KEY)
CREATE TABLE #Masters (custid INT PRIMARY KEY, srecommend INT, isFinished BIT DEFAULT 0)
CREATE TABLE #tblCustDiscount (custid INT, sporttype INT, bettype INT, Discount DECIMAL(9,8), isFinished BIT DEFAULT 0 PRIMARY KEY (custid,sporttype,bettype))

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


INSERT INTO #tblCustDiscount(custid,sporttype,bettype,Discount)	
SELECT DISTINCT m.custid , cs.sporttype, cs.bettype, scs.sdiscount
FROM CustSettingGame cs WITH (NOLOCK)											
	INNER JOIN #Masters m on m.custid = cs.custid											
	INNER JOIN #Supers su on su.custid = m.srecommend											
	INNER JOIN CustSettingGame scs WITH (NOLOCK) ON scs.custid = su.custid 
													AND scs.SportType = cs.SportType 
													AND scs.BetType = cs.BetType												
WHERE cs.sporttype = 255
	AND cs.adiscount < scs.sdiscount 

DECLARE @custid INT,
		@Discount DECIMAL(9,8)

-- For deployer info
DECLARE @master_cnt INT, @index INT = 0
DECLARE @msg NVARCHAR(200) = 'Currently at order %d, MasterID: %d.'
DECLARE @msg_total NVARCHAR(200) = 'Total of Masters: %d.'

SET @master_cnt = (SELECT COUNT(*) FROM #Masters )
RAISERROR (@msg_total, 0, 1, @master_cnt) WITH NOWAIT
		
WHILE(1=1)
BEGIN
	UPDATE TOP (1) t
	SET isFinished = 1,
		@custid = custid,
		@Discount = Discount
	FROM #tblCustDiscount t
	WHERE isFinished = 0
	
	IF @@ROWCOUNT = 0
		BREAK;
		
	SET @index = @index + 1
	RAISERROR (@msg, 0, 1, @index, @custid) WITH NOWAIT
	
	-- Apply exec rep
	EXEC Acc_CustSetting3rd_06
		@CustId = @custid,
		@RoleId =3,
		@Discount = @Discount,
		@mode = 'GoldDeluxe',
		@Sporttype = 255,
		@Bettype = 1701	
	
	WAITFOR DELAY '0:0:0.28'
END
	