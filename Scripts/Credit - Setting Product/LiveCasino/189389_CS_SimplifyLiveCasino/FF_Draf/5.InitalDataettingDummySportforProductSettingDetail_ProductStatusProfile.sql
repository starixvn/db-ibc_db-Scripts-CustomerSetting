/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20230727@Helios
	Task: Inital Data Setting DummySport for ProductSettingDetail and ProductStatusProfile   [#189389]
	DB: DBCust/CustDB and all replicated server of pub: CustDB_Customer_Info, CustDB_DBTrans_CustInfo 
*/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


--> Step 5.1: Initial Data DummySport for ProductSettingDetail With SettingStatus = 2

	--  DELETE existing data DummySport
		DELETE p
		FROM ProductSettingDetail p WITH(ROWLOCK) 
		WHERE SportType = 9911


	-- Insert DUMMY SPORT of Win Loss Limit - Product Status - Position Talking - Discount With SettingStatus = 2: 
		INSERT INTO ProductSettingDetail
		([SettingType],[SportType],[BetType],[IsLive],[ProductID],[MaxPT],[MaxDiscount],[IsSync],[IsHidden],[IsDisabled],[SettingLevel],[DisplayOrder],[SettingStatus],[IntervalValue],[RealProductId],
		[MaxChoice],[ProductSettingID],[Parent_ProductSettingID],[Child_DisplayOrder],[SubType])		
		VALUES
		--Win Loss Limit
		(22 , 9911 ,2400 , 0 ,41 , NULL ,NULL , NULL ,NULL , NULL  ,1 , 4 ,2 , NULL   ,41 , NULL ,329 , NULL ,NULL , NULL ),
		--Product Status
		(13 , 9911 ,2400 , 0 ,41 , NULL ,NULL , 1	 ,0    , 0     ,1 , 1 ,2 , NULL   ,41 , NULL ,330 , NULL ,NULL , NULL ),
		--PositionTaking
		(18 , 9911 ,2400 , 0 ,41 , 90	,NULL , NULL ,NULL , NULL  ,2 , 3 ,2 , NULL   ,41 , NULL ,331 , NULL ,NULL , NULL ),
		--Discount
		(19 , 9911 ,2400 , 0 ,41 , NULL ,0.005 , NULL ,NULL , NULL ,2 , 2 ,2 , 0.0005 ,41 , NULL ,332 , NULL ,NULL , NULL )


--> Step 5.2: Insert bitmap order of DummySport to test Status (will be delete when release)
	IF NOT EXISTS( 
					SELECT 1 
					FROM ProductStatusProfile WITH(NOLOCK) 
					WHERE Sporttype = 9911 AND bitmapOrder = 7
				)
	INSERT INTO [dbo].[ProductStatusProfile]
			   ([Sporttype]
			   ,[Bettype]
			   ,[bitmapOrder])
	SELECT 9911 , 2400 , 7

--> Step 5.3: Initial Data ProductSettingSystemDisplay

	-- INSERT ProductSettingSystemDisplay Of WinLostLimit (SetingType = 22)
	INSERT INTO ProductSettingSystemDisplay(SystemID,ProductID,SettingType,DisplayMode)
			SELECT	5,	41,	22,	3
	UNION 	SELECT	9,	41,	22,	3

