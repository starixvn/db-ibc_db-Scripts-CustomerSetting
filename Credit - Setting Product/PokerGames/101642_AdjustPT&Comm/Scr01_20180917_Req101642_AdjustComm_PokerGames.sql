/*
	Created: Elodie
	Date: 20180917
	Task: Adjust Comm setting of Poker Games
	DB: DBCust/CustDB
*/

DECLARE @Discount VARCHAR(MAX)
SELECT @Discount = '<ROOT>
							<Discount 
									SportType="163" 
									BetType="1401" 
									Discount="0.8"
							/>
						</ROOT>'

PRINT N'Step 1: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  

CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @srecommend INT

INSERT INTO #supers(custid)
SELECT c.custid
FROM customer c WITH (NOLOCK) 
 INNER JOIN site s WITH (NOLOCK) ON c.site = s.site
 LEFT JOIN custsuper cs WITH (NOLOCK) ON c.custid = cs.custid
WHERE c.roleid = 4  
 AND c.username NOT LIKE '3rdSuper%'
 AND cs.isinternal = 0
 AND c.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
 AND s.islicensee = 0
 AND c.site = '789y'
 AND c.currency <> 20
 AND c.currency IN (16,64)
 AND c.username <> 'MPK'

-- For deployer info
DECLARE @super_cnt INT, @index INT = 0
DECLARE @msg NVARCHAR(200) = 'Currently at order %d, SuperID: %d.'
DECLARE @msg_total NVARCHAR(200) = 'Total of supers: %d.'

SET @super_cnt = (SELECT COUNT(*) FROM #supers )
RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #Supers
	SET isfinished = 1
		,@srecommend = custid	
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK

	SET @index = @index + 1
	RAISERROR (@msg, 0, 1, @index, @srecommend) WITH NOWAIT

	EXEC dbo.Acc_DynamicCustSetting3rd_06
			@CustId			= @srecommend
			, @RoleId		= 4
			, @SettingType  = 3
			, @Discount_XML = @Discount

	waitfor delay '00:00:0.200'
END

PRINT N'Step 1: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'