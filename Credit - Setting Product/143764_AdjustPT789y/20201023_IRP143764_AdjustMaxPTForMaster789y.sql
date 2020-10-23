/*
	Created: 20201023@Johnson
	Task: update L3 for list master
	DB: DBCUST/CUSTDB
*/

DECLARE @tmpMaster (custid INT, srecommend INT, isFinished BIT DEFAULT 0)
DECLARE @PT SMALLMONEY = 0.805,
		@custid INT,
		@srecommend INT

INSERT INTO @tmpMaster(custid,srecommend)
SELECT custid, srecommend
FROM custinfo (NOLOCK)
WHERE username IN ('SKC01','SKC03','SKC04','SKC06','SKC11','SKC12','SKC13','SKC22','SKC23','SKC40','SKC41','SKC42','SKC43','SKC44','SKC45','SKC46','SKC47','SKC49','SKC50','SKC53','SKC54','SKC55','SKC56','SKC57','SKC59','SKC60','SKC61','SKC63','SKC64','SKC65','SKC67','SKC68','SKC69','SKC72','SKC73','SKC74','SKC75','SKC76','SKC78','SKC79','SKC80','SKC82','SKC84','SKC85','SKC96','SKC99')

WHILE (1=1)
BEGIN
	UPDATE TOP (1) t
	SET isFinished = 1,
		@custid = custid,
		@srecommend = srecommend
	FROM @tmpMaster
	WHERE isFinished = 0
	
	UPDATE cs 
	SET maxpositiontaking = CASE WHEN @PT > maxpositiontaking THEN @PT ELSE maxpositiontaking END,					
		maxlivepositiontaking = CASE WHEN @PT > maxlivepositiontaking AND sporttype = 1 and bettype IN (1,3,7,8) THEN @PT ELSE maxlivepositiontaking END		
	FROM custoverride cs WITH(ROWLOCK, UPDLOCK)				
	WHERE custid = @custid
	
	UPDATE cs 
	SET maxpositiontaking = CASE WHEN bettype IN (81,83,86,88) AND @PT > maxpositiontaking THEN @PT ELSE maxpositiontaking END,							
		maxlivepositiontaking = CASE WHEN bettype IN (85,86,87,89,90) AND @PT > maxlivepositiontaking THEN @PT ELSE maxlivepositiontaking END	
	FROM custoverride3rd cs WITH(ROWLOCK, UPDLOCK)				
	WHERE custid = @custid
		AND sporttype = 161
		
	EXEC dbo.Acc_CustSetting_04 @mrecommend = @custid, @srecommend = @srecommend, @roleid = 3
    EXEC dbo.Acc_CustSetting3rd_04 @mrecommend = @custid, @srecommend = @srecommend, @roleid = 3, @mode = 'number'	
	
	WAITFOR DELAY '0:0:1'
END

