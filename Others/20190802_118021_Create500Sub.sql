/*
	Created: 20190801@Winnie
	Task:  Create 500 subsidiary agents for 365online site: http://nexdev.net/issues/118021
	DB: DBCUST.CUSTDB
*/
DECLARE	@ErrCode			INT 
SELECT  @ErrCode=0			
DECLARE	@ErrMsg				NVARCHAR(200) = ''	
DECLARE @Master VARCHAR(30),@MasterID INT,@CreatorID INT,@Pass VARCHAR(100),@SuperID INT,@Currency INT
SELECT @Master='365onlineRMB'
SELECT @Pass='8058095B7DDB08A608811097E5DB8D'
SELECT @MasterID=CustID,@SuperID=srecommend,@Currency=currency FROM Customer WITH(NOLOCK) WHERE username=@Master
SELECT @CreatorID=10278938
DECLARE @startnum INT=02
DECLARE @endnum INT=501
DECLARE @tmpSubCustID INT	
DECLARE @tmpSubUserName VARCHAR(30), @ListCustIDRollBack VARCHAR(MAX)
CREATE TABLE #tempSubCustID (CustID INT,isfinished BIT DEFAULT(0))
;
WITH gen AS (
    SELECT @startnum AS num
    UNION ALL
    SELECT num+1 FROM gen WHERE num+1<=@endnum
)
SELECT CASE WHEN LEN(Num)=1 THEN @Master+'0'+CAST( Num AS VARCHAR(50)) 
	   ELSE @Master+CAST( Num AS VARCHAR(50))  END AS Username,0 AS isfinished
INTO #tempSubUserName
FROM gen
OPTION (MAXRECURSION 600) 

DECLARE @PT_Sportsbook SMALLMONEY=0.88,@PT_NumberGame SMALLMONEY=0.88
DECLARE @MinBetSB MONEY=20,@MaxBetSB MONEY=1000000, @MaxPerMatchSB MONEY=1000000
DECLARE @MinBetSC MONEY=20,@MaxBetSC MONEY=500000, @MaxPerMatchSC MONEY=1000000
DECLARE @MinBetNG MONEY=20,@MaxBetNG MONEY=1000000, @MaxPerMatchNG MONEY=1000000, @MaxPerBallNG MONEY=1000000
DECLARE @DisableNumber BIT=0,@IP VARCHAR(50)='10.18.200.233',@KenoList VARCHAR(MAX),@PTKeno VARCHAR(10)
DECLARE @PT_Esports SMALLMONEY
SELECT @PT_Esports=@PT_Sportsbook*100

CREATE TABLE #BetLimitInput(Sporttype INT,Bettype INT,MinBet MONEY,MaxBet MONEY,MaxPerMatch MONEY,isfinished BIT DEFAULT(0),PRIMARY KEY(Sporttype,Bettype))

SELECT @KenoList='	
		<products><product Bettype="1501" MaxBet="20000" MinBet="10" MaxPerMatch="100000" IsDisable="0" sPositionTaking="0.94" mPositionTaking="0.94" 
			aPositionTaking="0.94"></product></products>'

WHILE (1 = 1)
BEGIN		
	UPDATE TOP (1) #tempSubUserName
	SET isfinished = 1
		,@tmpSubUserName=Username
	WHERE isfinished = 0

	IF @@ROWCOUNT = 0 OR @ErrCode<>0 BREAK 

	EXEC Acc_Dep_CustomerInsMember_MAg 
	@Custid=@tmpSubCustID OUTPUT,@creator=@CreatorID,@Username=@tmpSubUserName,@userpwd=@Pass,@mrecommend=@MasterID
	,@MinBetv1=@MinBetSC,@MaxBetv1=@MaxBetSC,@MaxPerMatchv1=@MaxPerMatchSC,
	@MinBetv2=@MinBetSB,@MaxBetv2=@MaxBetSB,@MaxPerMatchv2=@MaxPerMatchSB,
	@MinBetv3=@MinBetSB,@MaxBetv3=@MaxBetSB,@MaxPerMatchv3=@MaxPerMatchSB,
	@MinBetv5=@MinBetSB,@MaxBetv5=@MaxBetSB,@MaxPerMatchv5=@MaxPerMatchSB,
	@MinBetv8=@MinBetSB,@MaxBetv8=@MaxBetSB,@MaxPerMatchv8=@MaxPerMatchSB,
	@MinBetv10=@MinBetSB,@MaxBetv10=@MaxBetSB,@MaxPerMatchv10=@MaxPerMatchSB,
	@MinBetv11=@MinBetSB,@MaxBetv11=@MaxBetSB,@MaxPerMatchv11=@MaxPerMatchSB,
	@MinBetv44=@MinBetSB,@MaxBetv44=@MaxBetSB,@MaxPerMatchv44=@MaxPerMatchSB,
	@MinBetv99=@MinBetSB,@MaxBetv99=@MaxBetSB,@MaxPerMatchv99=@MaxPerMatchSB,
	@MinBetv99MP=@MinBetSB,@MaxBetv99MP=@MaxBetSB,@MaxPerMatchv99MP=@MaxPerMatchSB,
	@MinBetv161=@MinBetNG,@MaxBetv161=@MaxBetNG,@MaxPerMatchv161=@MaxPerMatchNG,@MaxPerBallv161=@MaxPerBallNG,				
	@v1mpositiontaking_1=@PT_Sportsbook,@v1mpositiontaking_2=@PT_Sportsbook,@v1mpositiontaking_3=@PT_Sportsbook,@v1mpositiontaking_4=@PT_Sportsbook,@v1mpositiontaking_5=@PT_Sportsbook,
	@v1mpositiontaking_6=@PT_Sportsbook,@v1mpositiontaking_7=@PT_Sportsbook,@v1mpositiontaking_8=@PT_Sportsbook,@v1mpositiontaking_9=@PT_Sportsbook,@v1mpositiontaking_10=@PT_Sportsbook,
	@v1mlivepositiontaking_1=@PT_Sportsbook,@v1mlivepositiontaking_3=@PT_Sportsbook,@v1mlivepositiontaking_7=@PT_Sportsbook,@v1mlivepositiontaking_8=@PT_Sportsbook,
	@v2mpositiontaking_1=@PT_Sportsbook,@v2mpositiontaking_2=@PT_Sportsbook,@v2mpositiontaking_3=@PT_Sportsbook,@v2mpositiontaking_7=@PT_Sportsbook,@v2mpositiontaking_8=@PT_Sportsbook,
	@v2mpositiontaking_20=@PT_Sportsbook,
	@v3mpositiontaking_1=@PT_Sportsbook,@v3mpositiontaking_2=@PT_Sportsbook,@v3mpositiontaking_3=@PT_Sportsbook,@v3mpositiontaking_20=@PT_Sportsbook,
	@v5mpositiontaking_1=@PT_Sportsbook,@v5mpositiontaking_2=@PT_Sportsbook,@v5mpositiontaking_3=@PT_Sportsbook,@v5mpositiontaking_20=@PT_Sportsbook,@v8mpositiontaking_1=@PT_Sportsbook,
	@v8mpositiontaking_3=@PT_Sportsbook,@v8mpositiontaking_20=@PT_Sportsbook,
	@v10mpositiontaking_1=@PT_Sportsbook,@v10mpositiontaking_2=@PT_Sportsbook,@v10mpositiontaking_3=@PT_Sportsbook,@v10mpositiontaking_20=@PT_Sportsbook,
	@v11mpositiontaking_1=@PT_Sportsbook,@v11mpositiontaking_20=@PT_Sportsbook,
	@v44mpositiontaking_3=@PT_Sportsbook,
	@v99mpositiontaking_1=@PT_Sportsbook,@v99mpositiontaking_2=@PT_Sportsbook,@v99mpositiontaking_3=@PT_Sportsbook,@v99mpositiontaking_9=@PT_Sportsbook,@v99mpositiontaking_20=@PT_Sportsbook,
	@v161mpositiontaking_81=@PT_NumberGame,@v161mpositiontaking_83=@PT_NumberGame,@v161mpositiontaking_86=@PT_NumberGame,@v161mpositiontaking_88=@PT_NumberGame,@v161mlivepositiontaking_85=@PT_NumberGame,
	@v161mlivepositiontaking_86=@PT_NumberGame,@v161mlivepositiontaking_87=@PT_NumberGame,@v161mlivepositiontaking_89=@PT_NumberGame,@v161mlivepositiontaking_90=@PT_NumberGame,
	@v1apositiontaking_1=@PT_Sportsbook,@v1apositiontaking_2=@PT_Sportsbook,@v1apositiontaking_3=@PT_Sportsbook,@v1apositiontaking_4=@PT_Sportsbook,@v1apositiontaking_5=@PT_Sportsbook,
	@v1apositiontaking_6=@PT_Sportsbook,@v1apositiontaking_7=@PT_Sportsbook,@v1apositiontaking_8=@PT_Sportsbook,@v1apositiontaking_9=@PT_Sportsbook,@v1apositiontaking_10=@PT_Sportsbook,
	@v1alivepositiontaking_1=@PT_Sportsbook,@v1alivepositiontaking_3=@PT_Sportsbook,@v1alivepositiontaking_7=@PT_Sportsbook,@v1alivepositiontaking_8=@PT_Sportsbook,
	@v2apositiontaking_1=@PT_Sportsbook,@v2apositiontaking_2=@PT_Sportsbook,@v2apositiontaking_3=@PT_Sportsbook,@v2apositiontaking_7=@PT_Sportsbook,@v2apositiontaking_8=@PT_Sportsbook,@v2apositiontaking_20=@PT_Sportsbook,
	@v3apositiontaking_1=@PT_Sportsbook,@v3apositiontaking_2=@PT_Sportsbook,@v3apositiontaking_3=@PT_Sportsbook,@v3apositiontaking_20=@PT_Sportsbook,
	@v5apositiontaking_1=@PT_Sportsbook,@v5apositiontaking_2=@PT_Sportsbook,@v5apositiontaking_3=@PT_Sportsbook,@v5apositiontaking_20=@PT_Sportsbook,
	@v8apositiontaking_1=@PT_Sportsbook,@v8apositiontaking_3=@PT_Sportsbook,@v8apositiontaking_20=@PT_Sportsbook,
	@v10apositiontaking_1=@PT_Sportsbook,@v10apositiontaking_2=@PT_Sportsbook,@v10apositiontaking_3=@PT_Sportsbook,@v10apositiontaking_20=@PT_Sportsbook,
	@v11apositiontaking_1=@PT_Sportsbook,@v11apositiontaking_20=@PT_Sportsbook,
	@v44apositiontaking_3=@PT_Sportsbook,@v99apositiontaking_1=@PT_Sportsbook,
	@v99apositiontaking_2=@PT_Sportsbook,@v99apositiontaking_3=@PT_Sportsbook,@v99apositiontaking_9=@PT_Sportsbook,@v99apositiontaking_20=@PT_Sportsbook,
	@v161apositiontaking_81=@PT_NumberGame,@v161apositiontaking_83=@PT_NumberGame,@v161apositiontaking_86=@PT_NumberGame,@v161apositiontaking_88=@PT_NumberGame,@v161alivepositiontaking_85=@PT_NumberGame,
	@v161alivepositiontaking_86=@PT_NumberGame,@v161alivepositiontaking_87=@PT_NumberGame,@v161alivepositiontaking_89=@PT_NumberGame,@v161alivepositiontaking_90=@PT_NumberGame,@DisableNumber=@DisableNumber,
	@KenoList=@KenoList,@IP=@IP,@ErrCode=@ErrCode OUTPUT,@ErrMsg=@ErrMsg OUTPUT	
						
	INSERT INTO #tempSubCustID(CustID)
	SELECT 	@tmpSubCustID	
	 
	IF @ErrCode<>0		
		BREAK;		
END
					
					
IF @ErrCode<>0
BEGIN
	SELECT @ErrMsg = @ErrMsg + 'Create sub agent unsuccessfuly.'			

	SELECT @ListCustIDRollBack=		
		ISNULL(STUFF((Select ','+ CAST(CustID AS VARCHAR(20))
		from #tempSubCustID T1
		FOR XML PATH('')),1,1,''),'')
		EXEC Dot_Dep_RollBackLicensee @ListCustID=@ListCustIDRollBack
	RETURN
END		
								
SELECT @ErrMsg