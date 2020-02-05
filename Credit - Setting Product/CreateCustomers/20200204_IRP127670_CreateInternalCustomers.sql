/*
	Created: 20200204@Johnson
	Task: create customers request by Hock Lin
	DB: DBCUST/CustDB
*/

DECLARE @playerdiscount DECIMAL(9, 8), 
	@playerdiscountcs DECIMAL(9, 8),
	--1x2 
	@playerdiscount1x2 DECIMAL(9, 8) = 0,
	
	@MinBet MONEY,
	@MaxBet MONEY,
	@MaxPerMatch MONEY,
	
	@MinBetv2 MONEY,
	@MaxBetv2 MONEY,
	@MaxPerMatchv2 MONEY,
	
	@MinBetv3 MONEY,
	@MaxBetv3 MONEY,
	@MaxPerMatchv3 MONEY,

	@MinBetv5 MONEY,
	@MaxBetv5 MONEY,
	@MaxPerMatchv5 MONEY,

	@MinBetv8 MONEY,
	@MaxBetv8 MONEY,
	@MaxPerMatchv8 MONEY,

	@MinBetv10 MONEY,
	@MaxBetv10 MONEY,
	@MaxPerMatchv10 MONEY,

	@MinBetv11 MONEY,
	@MaxBetv11 MONEY,
	@MaxPerMatchv11 MONEY,

	@MinBetv99 MONEY,
	@MaxBetv99 MONEY,
	@MaxPerMatchv99 MONEY,
	
	--Mix Parlay mix sports
	@MinBetv99MP MONEY,
	@MaxBetv99MP MONEY,
	@MaxPerMatchv99MP MONEY,
	
	--Mix Parlay soccer sports
	@MinBetv1MP MONEY,
	@MaxBetv1MP MONEY,
	@MaxPerMatchv1MP MONEY,
	
	--Number game
	@MinBetv161 MONEY,
	@MaxBetv161 MONEY,
	@MaxPerBallv161 MONEY = 0,
	@MaxPerMatchv161 MONEY,
	
	@MinBetv164 MONEY =0,
	@MaxBetv164 MONEY=0,	
	@MaxPerMatchv164 MONEY=0,
	
	@credit MONEY,
		
	@DisableCasino BIT = 0, 
	@DisableNumber BIT = 0,	

	--@Disable180_1201 BIT = 0,
	
	@recommend INT,
	@ugroup VARCHAR(5),
	@closed BIT,
			
	@apositiontaking_1 SMALLMONEY,
	@apositiontaking_2 SMALLMONEY,
	@apositiontaking_3 SMALLMONEY,
	@apositiontaking_4 SMALLMONEY,
	@apositiontaking_5 SMALLMONEY,
	@apositiontaking_6 SMALLMONEY,
	@apositiontaking_7 SMALLMONEY,
	@apositiontaking_8 SMALLMONEY,
	@apositiontaking_9 SMALLMONEY,
	@apositiontaking_10 SMALLMONEY,
	@v2apositiontaking_10 SMALLMONEY,
	@v3apositiontaking_10 SMALLMONEY,
	@v5apositiontaking_10 SMALLMONEY,
	@v8apositiontaking_10 SMALLMONEY,
	@v10apositiontaking_10 SMALLMONEY,
	@v11apositiontaking_10 SMALLMONEY,
	@v99apositiontaking_10 SMALLMONEY,
	
	@apositiontaking_9999 SMALLMONEY = 0,
	
	@alivepositiontaking_1 SMALLMONEY,
	@alivepositiontaking_3 SMALLMONEY,
	@alivepositiontaking_7 SMALLMONEY,
	@alivepositiontaking_8 SMALLMONEY,
	
	@v2apositiontaking_1 SMALLMONEY,
	@v2apositiontaking_2 SMALLMONEY,
	@v2apositiontaking_3 SMALLMONEY,
	@v2apositiontaking_7 SMALLMONEY,
	@v2apositiontaking_8 SMALLMONEY,
	
	--@v2apositiontaking_9 SMALLMONEY=0,
	
	@v2apositiontaking_20 SMALLMONEY,
	
	@v2apositiontaking_9999 SMALLMONEY = 0,
	
	@v3apositiontaking_1 SMALLMONEY,
	@v3apositiontaking_2 SMALLMONEY,
	@v3apositiontaking_3 SMALLMONEY,
	@v3apositiontaking_20 SMALLMONEY,

	@v5apositiontaking_1 SMALLMONEY,
	@v5apositiontaking_2 SMALLMONEY,
	@v5apositiontaking_3 SMALLMONEY,
	@v5apositiontaking_20 SMALLMONEY,
	@v5apositiontaking_9999 SMALLMONEY = 0,

	@v8apositiontaking_1 SMALLMONEY,
	@v8apositiontaking_3 SMALLMONEY,
	@v8apositiontaking_20 SMALLMONEY,

	@v10apositiontaking_1 SMALLMONEY,
	@v10apositiontaking_2 SMALLMONEY,
	@v10apositiontaking_3 SMALLMONEY,
	@v10apositiontaking_20 SMALLMONEY,

	@v11apositiontaking_1 SMALLMONEY,
	@v11apositiontaking_20 SMALLMONEY,

	@v99apositiontaking_1 SMALLMONEY,
	@v99apositiontaking_2 SMALLMONEY,
	@v99apositiontaking_3 SMALLMONEY,
	@v99apositiontaking_9 SMALLMONEY,
	@v99apositiontaking_20 SMALLMONEY,
	@v99apositiontaking_9999 SMALLMONEY,
	
	@v161apositiontaking_81 SMALLMONEY, 
	@v161apositiontaking_83 SMALLMONEY, 
	@v161apositiontaking_86 SMALLMONEY, 
	@v161apositiontaking_88 SMALLMONEY = 0, 
	@v161alivepositiontaking_85 SMALLMONEY,
	@v161alivepositiontaking_86 SMALLMONEY,
	@v161alivepositiontaking_87 SMALLMONEY,
	@v161alivepositiontaking_89 SMALLMONEY = 0,
	@v161alivepositiontaking_90 SMALLMONEY = 0
	

declare @tblCust TABLE (recommend INT,agentName VARCHAR(50),repCustID INT, fromID INT, toID INT, isFinished BIT DEFAULT 0)
CREATE TABLE #tblResult (custid INT, ErrCode INT, ErrMsg VARCHAR(1000), i INT, Agent VARCHAR(50))

INSERT INTO @tblCust(recommend,agentName,repCustID,fromID,toID)
SELECT 41431380,'999MYR0101',41431502,108,800 -- 999MYR0101 , 999MYR0101001
UNION SELECT 41431395,'999MYR0102',41431801,101,600 -- 999MYR0102, 999MYR0102001
UNION SELECT 41431412,'999MYR0103',41431706,101,600 -- 999MYR0103, 999MYR0103001
UNION SELECT 41431419,'999MYR0105',41434633,021,600 -- 999MYR0105, 999MYR0105001
UNION SELECT 41431369,'999MYR0201',41434777,021,300 -- 999MYR0201, 999MYR0201001
UNION SELECT 41431404,'999MYR0301',41431514,101,600 -- 999MYR0301, 999MYR0301001


declare @p1 int
set @p1=0
declare @p120 bit
set @p120=0
declare @p125 int
set @p125=0
declare @p126 nvarchar(4000)
set @p126=''

DECLARE @repCustID INT,
		@fromID INT,
		@toID INT,
		@agentName VARCHAR(50),
		@username VARCHAR(50),
		@i INT, 
		@Msg VARCHAR(1000)		
		
WHILE(1=1)
BEGIN
	UPDATE TOP (1) t
	SET isFinished = 1,
		@recommend = recommend,
		@AgentName = agentName,
		@repCustID = repCustID,
		@fromID = fromID,
		@toID = toID
	FROM @tblCust t
	WHERE t.isFinished =0
	
	IF @@rowcount = 0 BREAK;
		
	SELECT @i = @fromID
	
	SELECT @playerdiscount=0,
		@playerdiscountcs=0,
		@playerdiscount1x2=0,
		@MinBet=0,
		@MaxBet=0,
		@MaxPerMatch=0,
		@MinBetv2=0,
		@MaxBetv2=0,
		@MaxPerMatchv2=0,
		@MinBetv3=0,
		@MaxBetv3=0,
		@MaxPerMatchv3=0,
		@MinBetv5=0,
		@MaxBetv5=0,
		@MaxPerMatchv5=0,
		@MinBetv8=0,
		@MaxBetv8=0,
		@MaxPerMatchv8=0,
		@MinBetv10=0,
		@MaxBetv10=0,
		@MaxPerMatchv10=0,
		@MinBetv11=0,
		@MaxBetv11=0,
		@MaxPerMatchv11=0,
		@MinBetv99=0,
		@MaxBetv99=0,
		@MaxPerMatchv99=0,
		@MinBetv99MP=0,
		@MaxBetv99MP=0,
		@MaxPerMatchv99MP=0,
		@MinBetv1MP=0,
		@MaxBetv1MP=0,
		@MaxPerMatchv1MP=0,
		@MinBetv161=0,
		@MaxBetv161=0,
		@MaxPerBallv161=0,
		@MaxPerMatchv161=0,
		@MinBetv164=0,
		@MaxBetv164=0,
		@MaxPerMatchv164=0,
		
		@apositiontaking_1=0,
		@apositiontaking_2=0,
		@apositiontaking_3=0,
		@apositiontaking_4=0,
		@apositiontaking_5=0,
		@apositiontaking_6=0,
		@apositiontaking_7=0,
		@apositiontaking_8=0,
		@apositiontaking_9=0,
		@apositiontaking_10=0,
		@v2apositiontaking_10=0,
		@v3apositiontaking_10=0,
		@v5apositiontaking_10=0,
		@v8apositiontaking_10=0,
		@v10apositiontaking_10=0,
		@v11apositiontaking_10=0,
		@v99apositiontaking_10=0,
		@apositiontaking_9999=0,
		@alivepositiontaking_1=0,
		@alivepositiontaking_3=0,
		@alivepositiontaking_7=0,
		@alivepositiontaking_8=0,
		@v2apositiontaking_1=0,
		@v2apositiontaking_2=0,
		@v2apositiontaking_3=0,
		@v2apositiontaking_7=0,
		@v2apositiontaking_8=0,
		@v2apositiontaking_20=0,
		@v2apositiontaking_9999=0,
		@v3apositiontaking_1=0,
		@v3apositiontaking_2=0,
		@v3apositiontaking_3=0,
		@v3apositiontaking_20=0,
		@v5apositiontaking_1=0,
		@v5apositiontaking_2=0,
		@v5apositiontaking_3=0,
		@v5apositiontaking_20=0,
		@v5apositiontaking_9999=0,
		@v8apositiontaking_1=0,
		@v8apositiontaking_3=0,
		@v8apositiontaking_20=0,
		@v10apositiontaking_1=0,
		@v10apositiontaking_2=0,
		@v10apositiontaking_3=0,
		@v10apositiontaking_20=0,
		@v11apositiontaking_1=0,
		@v11apositiontaking_20=0,
		@v99apositiontaking_1=0,
		@v99apositiontaking_2=0,
		@v99apositiontaking_3=0,
		@v99apositiontaking_9=0,
		@v99apositiontaking_20=0,
		@v99apositiontaking_9999=0,
		@v161apositiontaking_81=0,
		@v161apositiontaking_83=0,
		@v161apositiontaking_86=0,
		@v161apositiontaking_88=0,
		@v161alivepositiontaking_85=0,
		@v161alivepositiontaking_86=0,
		@v161alivepositiontaking_87=0,
		@v161alivepositiontaking_89=0,
		@v161alivepositiontaking_90=0
		
	SELECT @MaxPerMatch = maxpermatch,
		@MaxPerMatchv2 = maxpermatch2,
		@MaxPerMatchv3 = maxpermatch3,
		@MaxPerMatchv5 = maxpermatch5,
		@MaxPerMatchv8 = maxpermatch8,
		@MaxPerMatchv10 = maxpermatch10,
		@MaxPerMatchv11 = maxpermatch11,
		@MaxPerMatchv99 = maxpermatch99,
		@MaxPerMatchv99MP = MaxPerMatch99MP,
		@MaxPerMatchv1MP = MaxPerMatch1MP,
		@MaxPerMatchv161 = maxpermatch161,
		@MaxPerMatchv164 = maxpermatch164,
		@MaxPerBallv161 = MaxPerBall161
	FROM custinfo ci WITH(NOLOCK)
	WHERE custid = @repCustID
	
	SELECT @MinBet = MAX(CASE WHEN sporttype = 1 AND bettype = 1 THEN MinBet ELSE 0 END),
		@MaxBet = MAX(CASE WHEN sporttype = 1 AND bettype = 1 THEN maxbet ELSE 0 END),
		@MinBetV2 = MAX(CASE WHEN sporttype = 2 AND bettype = 1 THEN MinBet ELSE 0 END),
		@MaxBetV2 = MAX(CASE WHEN sporttype = 2 AND bettype = 1 THEN maxbet ELSE 0 END),
		@MinBetV3 = MAX(CASE WHEN sporttype = 3 AND bettype = 1 THEN MinBet ELSE 0 END),
		@MaxBetV3 = MAX(CASE WHEN sporttype = 3 AND bettype = 1 THEN maxbet ELSE 0 END),
		@MinBetV5 = MAX(CASE WHEN sporttype = 5 AND bettype = 1 THEN MinBet ELSE 0 END),
		@MaxBetV5 = MAX(CASE WHEN sporttype = 5 AND bettype = 1 THEN maxbet ELSE 0 END),
		@MinBetV8 = MAX(CASE WHEN sporttype = 8 AND bettype = 1 THEN MinBet ELSE 0 END),
		@MaxBetV8 = MAX(CASE WHEN sporttype = 8 AND bettype = 1 THEN maxbet ELSE 0 END),
		@MinBetV10 = MAX(CASE WHEN sporttype = 10 AND bettype = 1 THEN MinBet ELSE 0 END),
		@MaxBetV10 = MAX(CASE WHEN sporttype = 10 AND bettype = 1 THEN maxbet ELSE 0 END),
		@MinBetV11 = MAX(CASE WHEN sporttype = 11 AND bettype = 1 THEN MinBet ELSE 0 END),
		@MaxBetV11 = MAX(CASE WHEN sporttype = 11 AND bettype = 1 THEN maxbet ELSE 0 END),
		@MinBetV99 = MAX(CASE WHEN sporttype = 99 AND bettype = 1 THEN MinBet ELSE 0 END),
		@MaxBetV99 = MAX(CASE WHEN sporttype = 99 AND bettype = 1 THEN maxbet ELSE 0 END),
		@MinBetV99MP = MAX(CASE WHEN sporttype = 99 AND bettype = 9 THEN MinBet ELSE 0 END),
		@MaxBetV99MP = MAX(CASE WHEN sporttype = 99 AND bettype = 9 THEN maxbet ELSE 0 END),
		@MinBetV1MP = MAX(CASE WHEN sporttype = 1 AND bettype = 9 THEN MinBet ELSE 0 END),
		@MaxBetV1MP = MAX(CASE WHEN sporttype = 1 AND bettype = 9 THEN maxbet ELSE 0 END),
		
		--PT
		@apositiontaking_1 = MAX(CASE WHEN sporttype = 1 AND bettype = 1 THEN apositiontaking ELSE 0 END),
		@apositiontaking_2 = MAX(CASE WHEN sporttype = 1 AND bettype = 2 THEN apositiontaking ELSE 0 END),
		@apositiontaking_3 = MAX(CASE WHEN sporttype = 1 AND bettype = 3 THEN apositiontaking ELSE 0 END),
		@apositiontaking_4 = MAX(CASE WHEN sporttype = 1 AND bettype = 4 THEN apositiontaking ELSE 0 END),
		@apositiontaking_5 = MAX(CASE WHEN sporttype = 1 AND bettype = 5 THEN apositiontaking ELSE 0 END),
		@apositiontaking_6 = MAX(CASE WHEN sporttype = 1 AND bettype = 6 THEN apositiontaking ELSE 0 END),
		@apositiontaking_7 = MAX(CASE WHEN sporttype = 1 AND bettype = 7 THEN apositiontaking ELSE 0 END),
		@apositiontaking_8 = MAX(CASE WHEN sporttype = 1 AND bettype = 8 THEN apositiontaking ELSE 0 END),
		@apositiontaking_9 = MAX(CASE WHEN sporttype = 1 AND bettype = 9 THEN apositiontaking ELSE 0 END),
		@apositiontaking_10 = MAX(CASE WHEN sporttype = 1 AND bettype = 10 THEN apositiontaking ELSE 0 END),
		@apositiontaking_9999 = MAX(CASE WHEN sporttype = 1 AND bettype = 9999 THEN apositiontaking ELSE 0 END),
		
		@v2apositiontaking_10 = MAX(CASE WHEN sporttype = 2 AND bettype = 10 THEN apositiontaking ELSE 0 END),
		@v3apositiontaking_10 = MAX(CASE WHEN sporttype = 3 AND bettype = 10 THEN apositiontaking ELSE 0 END),
		@v5apositiontaking_10 = MAX(CASE WHEN sporttype = 5 AND bettype = 10 THEN apositiontaking ELSE 0 END),
		@v8apositiontaking_10 = MAX(CASE WHEN sporttype = 8 AND bettype = 10 THEN apositiontaking ELSE 0 END),
		@v10apositiontaking_10 = MAX(CASE WHEN sporttype = 10 AND bettype = 10 THEN apositiontaking ELSE 0 END),
		@v11apositiontaking_10 = MAX(CASE WHEN sporttype = 11 AND bettype = 10 THEN apositiontaking ELSE 0 END),
		@v99apositiontaking_10 = MAX(CASE WHEN sporttype = 99 AND bettype = 10 THEN apositiontaking ELSE 0 END),
				
		@alivepositiontaking_1 = MAX(CASE WHEN sporttype = 1 AND bettype = 1 THEN alivepositiontaking ELSE 0 END),
		@alivepositiontaking_3 = MAX(CASE WHEN sporttype = 1 AND bettype = 3 THEN alivepositiontaking ELSE 0 END),
		@alivepositiontaking_7 = MAX(CASE WHEN sporttype = 1 AND bettype = 7 THEN alivepositiontaking ELSE 0 END),
		@alivepositiontaking_8 = MAX(CASE WHEN sporttype = 1 AND bettype = 8 THEN alivepositiontaking ELSE 0 END),
		
		@v2apositiontaking_1 = MAX(CASE WHEN sporttype = 2 AND bettype = 1 THEN apositiontaking ELSE 0 END),
		@v2apositiontaking_2 = MAX(CASE WHEN sporttype = 2 AND bettype = 2 THEN apositiontaking ELSE 0 END),
		@v2apositiontaking_3 = MAX(CASE WHEN sporttype = 2 AND bettype = 3 THEN apositiontaking ELSE 0 END),
		@v2apositiontaking_7 = MAX(CASE WHEN sporttype = 2 AND bettype = 7 THEN apositiontaking ELSE 0 END),
		@v2apositiontaking_8 = MAX(CASE WHEN sporttype = 2 AND bettype = 8 THEN apositiontaking ELSE 0 END),
		@v2apositiontaking_20 = MAX(CASE WHEN sporttype = 2 AND bettype = 20 THEN apositiontaking ELSE 0 END),
		@v2apositiontaking_9999 = MAX(CASE WHEN sporttype = 2 AND bettype = 9999 THEN apositiontaking ELSE 0 END),
		
		@v3apositiontaking_1 = MAX(CASE WHEN sporttype = 3 AND bettype = 1 THEN apositiontaking ELSE 0 END),
		@v3apositiontaking_2 = MAX(CASE WHEN sporttype = 3 AND bettype = 2 THEN apositiontaking ELSE 0 END),
		@v3apositiontaking_3 = MAX(CASE WHEN sporttype = 3 AND bettype = 3 THEN apositiontaking ELSE 0 END),
		@v3apositiontaking_20 = MAX(CASE WHEN sporttype = 3 AND bettype = 20 THEN apositiontaking ELSE 0 END),
		
		@v5apositiontaking_1 = MAX(CASE WHEN sporttype = 5 AND bettype = 1 THEN apositiontaking ELSE 0 END),
		@v5apositiontaking_2 = MAX(CASE WHEN sporttype = 5 AND bettype = 2 THEN apositiontaking ELSE 0 END),
		@v5apositiontaking_3 = MAX(CASE WHEN sporttype = 5 AND bettype = 3 THEN apositiontaking ELSE 0 END),
		@v5apositiontaking_20 = MAX(CASE WHEN sporttype = 5 AND bettype = 20 THEN apositiontaking ELSE 0 END),
		@v5apositiontaking_9999 = MAX(CASE WHEN sporttype = 5 AND bettype = 9999 THEN apositiontaking ELSE 0 END),
		
		@v8apositiontaking_1 = MAX(CASE WHEN sporttype = 8 AND bettype = 1 THEN apositiontaking ELSE 0 END),
		@v8apositiontaking_3 = MAX(CASE WHEN sporttype = 8 AND bettype = 3 THEN apositiontaking ELSE 0 END),
		@v8apositiontaking_20 = MAX(CASE WHEN sporttype = 8 AND bettype = 20 THEN apositiontaking ELSE 0 END),
		
		@v10apositiontaking_1 = MAX(CASE WHEN sporttype = 10 AND bettype = 1 THEN apositiontaking ELSE 0 END),
		@v10apositiontaking_2 = MAX(CASE WHEN sporttype = 10 AND bettype = 2 THEN apositiontaking ELSE 0 END),
		@v10apositiontaking_3 = MAX(CASE WHEN sporttype = 10 AND bettype = 3 THEN apositiontaking ELSE 0 END),
		@v10apositiontaking_20 = MAX(CASE WHEN sporttype = 10 AND bettype = 20 THEN apositiontaking ELSE 0 END),
		
		@v11apositiontaking_1 = MAX(CASE WHEN sporttype = 11 AND bettype = 1 THEN apositiontaking ELSE 0 END),
		@v11apositiontaking_20 = MAX(CASE WHEN sporttype = 11 AND bettype = 20 THEN apositiontaking ELSE 0 END),
		
		@v99apositiontaking_1 = MAX(CASE WHEN sporttype = 99 AND bettype = 1 THEN apositiontaking ELSE 0 END),
		@v99apositiontaking_2 = MAX(CASE WHEN sporttype = 99 AND bettype = 2 THEN apositiontaking ELSE 0 END),
		@v99apositiontaking_3 = MAX(CASE WHEN sporttype = 99 AND bettype = 3 THEN apositiontaking ELSE 0 END),
		@v99apositiontaking_9 = MAX(CASE WHEN sporttype = 99 AND bettype = 9 THEN apositiontaking ELSE 0 END),
		@v99apositiontaking_20 = MAX(CASE WHEN sporttype = 99 AND bettype = 20 THEN apositiontaking ELSE 0 END),
		@v99apositiontaking_9999 = MAX(CASE WHEN sporttype = 99 AND bettype = 9999 THEN apositiontaking ELSE 0 END)
				
	FROM custsetting WITH(NOLOCK)
	WHERE custid = @repCustID
	
	SELECT @MinBetV161 = MAX(CASE WHEN sporttype = 161 AND bettype = 81 THEN MinBet ELSE 0 END),
		@MaxBetv161 = MAX(CASE WHEN sporttype = 161 AND bettype = 81 THEN maxbet ELSE 0 END),
		@MinBetV164 = MAX(CASE WHEN sporttype = 164 AND bettype = 8101 THEN MinBet ELSE 0 END),
		@MaxBetv164 = MAX(CASE WHEN sporttype = 164 AND bettype = 8101 THEN maxbet ELSE 0 END),
		
		--PT
		@v161apositiontaking_81 = MAX(CASE WHEN sporttype = 161 AND bettype = 81 THEN apositiontaking ELSE 0 END),
		@v161apositiontaking_83 = MAX(CASE WHEN sporttype = 161 AND bettype = 83 THEN apositiontaking ELSE 0 END),
		@v161apositiontaking_86 = MAX(CASE WHEN sporttype = 161 AND bettype = 86 THEN apositiontaking ELSE 0 END),
		@v161apositiontaking_88 = MAX(CASE WHEN sporttype = 161 AND bettype = 88 THEN apositiontaking ELSE 0 END),
		@v161alivepositiontaking_85 = MAX(CASE WHEN sporttype = 161 AND bettype = 85 THEN alivepositiontaking ELSE 0 END),
		@v161alivepositiontaking_86 = MAX(CASE WHEN sporttype = 161 AND bettype = 86 THEN alivepositiontaking ELSE 0 END),
		@v161alivepositiontaking_87 = MAX(CASE WHEN sporttype = 161 AND bettype = 87 THEN alivepositiontaking ELSE 0 END),
		@v161alivepositiontaking_89 = MAX(CASE WHEN sporttype = 161 AND bettype = 89 THEN alivepositiontaking ELSE 0 END),
		@v161alivepositiontaking_90 = MAX(CASE WHEN sporttype = 161 AND bettype = 90 THEN alivepositiontaking ELSE 0 END)		
	FROM custsetting3rd WITH(NOLOCK)
	WHERE custid = @repCustID	
	
	SELECT  @agentName as 'Agent UserName'
	
	--add agent into custNoComm
	INSERT INTO [CustDB].[dbo].[CustNoComm]
           ([CustID]
           ,[ModifiedDate]
           ,[Remark]
           ,[UserID])    
	SELECT @recommend, CURRENT_TIMESTAMP, 'Requested by HockLin' as Remark, 10278938 as userid --starixIT 
		
	WHILE(1=1)
	BEGIN
		SELECT @msg = 'Agent: ' + @agentName + '- i =' + CONVERT(VARCHAR(10),@i)
		
		RAISERROR (@Msg,0,1) WITH NOWAIT 
		
		SELECT @username = @agentName + RIGHT('000'+CONVERT(VARCHAR(10),@i),3)
		
		exec Acc_CustomerInsMember_Ag @custid=@p1 output,
		@firstname=N'',
		@lastname=N'',
		@creator=10278938, --starixIT
		@username=@username,
		@userpwd='20F7652A7F07F8407F856AD8319E75',
		@phone=N'',
		@fax=N'',
		@mobilephone=N'',
		@playerdiscount=@playerdiscount,
		@playerdiscountcs=@playerdiscountcs,
		@playerdiscount1x2=@playerdiscount1x2,
		@MinBet=@MinBet,
		@MaxBet=@MaxBet,
		@MaxPerMatch=@MaxPerMatch,
		@MinBetv2=@MinBetv2,
		@MaxBetv2=@MaxBetv2,
		@MaxPerMatchv2=@MaxPerMatchv2,
		@MinBetv3=@MinBetv3,
		@MaxBetv3=@MaxBetv3,
		@MaxPerMatchv3=@MaxPerMatchv3,
		@MinBetv5=@MinBetv5,
		@MaxBetv5=@MaxBetv5,
		@MaxPerMatchv5=@MaxPerMatchv5,
		@MinBetv8=@MinBetv8,
		@MaxBetv8=@MaxBetv8,
		@MaxPerMatchv8=@MaxPerMatchv8,
		@MinBetv10=@MinBetv10,
		@MaxBetv10=@MaxBetv10,
		@MaxPerMatchv10=@MaxPerMatchv10,
		@MinBetv11=@MinBetv11,
		@MaxBetv11=@MaxBetv11,
		@MaxPerMatchv11=@MaxPerMatchv11,
		@MinBetv99=@MinBetv99,
		@MaxBetv99=@MaxBetv99,
		@MaxPerMatchv99=@MaxPerMatchv99,
		@MinBetv99MP=@MinBetv99MP,
		@MaxBetv99MP=@MaxBetv99MP,
		@MaxPerMatchv99MP=@MaxPerMatchv99MP,
		@MinBetv1MP=@MinBetv1MP,
		@MaxBetv1MP=@MaxBetv1MP,
		@MaxPerMatchv1MP=@MaxPerMatchv1MP,
		@MinBetv161=@MinBetv161,
		@MaxBetv161=@MaxBetv161,
		@MaxPerBallv161=@MaxPerBallv161,
		@MaxPerMatchv161=@MaxPerMatchv161,
		@MinBetv164=@MinBetv164,
		@MaxBetv164=@MaxBetv164,
		@MaxPerMatchv164=@MaxPerMatchv164,
		@credit=0.0000,
		@DisableCasino=default,
		@DisableNumber=default,
		@recommend=@recommend,
		@ugroup='a',
		@closed=0,
		@apositiontaking_1=@apositiontaking_1,
		@apositiontaking_2=@apositiontaking_2,
		@apositiontaking_3=@apositiontaking_3,
		@apositiontaking_4=@apositiontaking_4,
		@apositiontaking_5=@apositiontaking_5,
		@apositiontaking_6=@apositiontaking_6,
		@apositiontaking_7=@apositiontaking_7,
		@apositiontaking_8=@apositiontaking_8,
		@apositiontaking_9=@apositiontaking_9,
		@apositiontaking_10=@apositiontaking_10,
		@v2apositiontaking_10=@v2apositiontaking_10,
		@v3apositiontaking_10=@v3apositiontaking_10,
		@v5apositiontaking_10=@v5apositiontaking_10,
		@v8apositiontaking_10=@v8apositiontaking_10,
		@v10apositiontaking_10=@v10apositiontaking_10,
		@v11apositiontaking_10=@v11apositiontaking_10,
		@v99apositiontaking_10=@v99apositiontaking_10,
		@apositiontaking_9999=@apositiontaking_9999,
		@alivepositiontaking_1=@alivepositiontaking_1,
		@alivepositiontaking_3=@alivepositiontaking_3,
		@alivepositiontaking_7=@alivepositiontaking_7,
		@alivepositiontaking_8=@alivepositiontaking_8,
		@v2apositiontaking_1=@v2apositiontaking_1,
		@v2apositiontaking_2=@v2apositiontaking_2,
		@v2apositiontaking_3=@v2apositiontaking_3,
		@v2apositiontaking_7=@v2apositiontaking_7,
		@v2apositiontaking_8=@v2apositiontaking_8,
		@v2apositiontaking_20=@v2apositiontaking_20,
		@v2apositiontaking_9999=@v2apositiontaking_9999,
		@v3apositiontaking_1=@v3apositiontaking_1,
		@v3apositiontaking_2=@v3apositiontaking_2,
		@v3apositiontaking_3=@v3apositiontaking_3,
		@v3apositiontaking_20=@v3apositiontaking_20,
		@v5apositiontaking_1=@v5apositiontaking_1,
		@v5apositiontaking_2=@v5apositiontaking_2,
		@v5apositiontaking_3=@v5apositiontaking_3,
		@v5apositiontaking_20=@v5apositiontaking_20,
		@v5apositiontaking_9999=@v5apositiontaking_9999,
		@v8apositiontaking_1=@v8apositiontaking_1,
		@v8apositiontaking_3=@v8apositiontaking_3,
		@v8apositiontaking_20=@v8apositiontaking_20,
		@v10apositiontaking_1=@v10apositiontaking_1,
		@v10apositiontaking_2=@v10apositiontaking_2,
		@v10apositiontaking_3=@v10apositiontaking_3,
		@v10apositiontaking_20=@v10apositiontaking_20,
		@v11apositiontaking_1=@v11apositiontaking_1,
		@v11apositiontaking_20=@v11apositiontaking_20,
		@v99apositiontaking_1=@v99apositiontaking_1,
		@v99apositiontaking_2=@v99apositiontaking_2,
		@v99apositiontaking_3=@v99apositiontaking_3,
		@v99apositiontaking_9=@v99apositiontaking_9,
		@v99apositiontaking_20=@v99apositiontaking_20,
		@v99apositiontaking_9999=@v99apositiontaking_9999,
		@v161apositiontaking_81=@v161apositiontaking_81,
		@v161apositiontaking_83=@v161apositiontaking_83,
		@v161apositiontaking_86=@v161apositiontaking_86,
		@v161apositiontaking_88=@v161apositiontaking_88,
		@v161alivepositiontaking_85=@v161alivepositiontaking_85,
		@v161alivepositiontaking_86=@v161alivepositiontaking_86,
		@v161alivepositiontaking_87=@v161alivepositiontaking_87,
		@v161alivepositiontaking_89=@v161alivepositiontaking_89,
		@v161alivepositiontaking_90=@v161alivepositiontaking_90,
		@IP=N'-',
		@SystemID=1,
		@success=@p120 output,
		@Language='E',
		@SubAccID=0,
		@isSearchAndCopy=default,
		@copyFromCustID=default,
		@ErrCode=@p125 output,
		@ErrMsg=@p126 output
				
		--add phone betting
		IF @p125 = 0
		BEGIN 						
			INSERT INTO phonebettingCustomerList (username,addedby,addedby_custid,DATE,remark)
			SELECT @username, 'starixIT', 10278938, CURRENT_TIMESTAMP, 'Requested by HockLin'
		END 
		
		INSERT INTO #tblResult(custid,ErrCode,ErrMsg,i,Agent)
		select @p1 as custid,@p125 as errcode,@p126 as errMsg,@i as i,@agentName
		
		SELECT @i = @i + 1
		
		IF @i > @toID
			BREAK;
	END
END			 


select * from #tblResult where ErrCode > 0
