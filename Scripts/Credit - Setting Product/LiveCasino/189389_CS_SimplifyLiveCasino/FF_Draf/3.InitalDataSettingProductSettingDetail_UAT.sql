/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20230727@Helios
	Task: Inital Data Setting: ProductSettingDetail_UAT [#189389]
	DB: DBCust/CustDB and all replicated server of pub: CustDB_Customer_Info, CustDB_DBTrans_CustInfo
*/

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

--> Step 3.1: DELETE Old Data ProductSettingDetail_UAT
		DELETE FROM ProductSettingDetail_UAT WITH(ROWLOCK)

--> Step 3.2: Insert Data: ProductSettingDetail_UAT From ProductSettingDetail WITH SettingStatus = 0
		INSERT INTO ProductSettingDetail_UAT(SettingType,SportType,BetType,IsLive,ProductID,MaxPT,MaxDiscount,IsSync,IsHidden,IsDisabled,SettingLevel
								,DisplayOrder,SettingStatus,IntervalValue,RealProductId,MaxChoice,ProductSettingID,Parent_ProductSettingID,Child_DisplayOrder,SubType
		)
		SELECT SettingType,SportType,BetType,IsLive,ProductID,MaxPT,MaxDiscount,IsSync,IsHidden,IsDisabled,SettingLevel
								,DisplayOrder,SettingStatus,IntervalValue,RealProductId,MaxChoice,ProductSettingID,Parent_ProductSettingID,Child_DisplayOrder,SubType
		FROM ProductSettingDetail WITH(NOLOCK)
		WHERE SettingStatus = 0

--> Step 3.3 Config new setting in ProductSettingDetail_UAT For Live Casino
	
	/*	Remove 
		Win Loss Limit - SettingType : 6						SportType Of: YeeBet, PP Live Casino, Allbet, ION, WM, GDG, BG,     , IBCBet Live Casino, AE Sexy, SA Gaming 
		Product Status - SettingType : 13						SportType Of: YeeBet, PP Live Casino, Allbet, ION, WM, GDG, BG, BBIN, IBCBet Live Casino, AE Sexy, SA Gaming 
		Loss Limit	   - SettingType : 12						SportType Of:												    BBIN
	*/
		DELETE t
		FROM ProductSettingDetail_UAT t WITH(ROWLOCK)
		WHERE ProductID = 41
		AND SportType IN (170, 225, 236, 241, 243, 239, 233, 244, 211, 242, 159)
		AND SettingType IN (6,13,12)

	--Remove Position Talking									SportType Of: YeeBet, PP Live Casino, Allbet, ION, WM, GDG, BG, BBIN,                      AE Sexy, SA Gaming
		DELETE t
		FROM ProductSettingDetail_UAT t WITH(ROWLOCK)
		WHERE ProductID = 41
		AND SportType IN (170, 225, 236, 241, 243, 239, 233, 244, 211,      159)
		AND SettingType = 18
	
	--Remove Discount											SportType Of: YeeBet, PP Live Casino, Allbet, ION, WM, GDG, BG, BBIN,                      AE Sexy, SA Gaming
		DELETE t
		FROM ProductSettingDetail_UAT t WITH(ROWLOCK)
		WHERE ProductID = 41
		AND SportType IN (170, 225, 236, 241, 243, 239, 233, 244, 211,      159)
		AND SettingType = 19

	-- Insert DUMMY SPORT of Win Loss Limit - Product Status - Position Talking - Discount With SettingStatus = 0: 
		INSERT INTO ProductSettingDetail_UAT
		([SettingType],[SportType],[BetType],[IsLive],[ProductID],[MaxPT],[MaxDiscount],[IsSync],[IsHidden],[IsDisabled],[SettingLevel],[DisplayOrder],[SettingStatus],[IntervalValue],[RealProductId],
		[MaxChoice],[ProductSettingID],[Parent_ProductSettingID],[Child_DisplayOrder],[SubType])		
		VALUES
		--Win Loss Limit
		(22 , 9911 ,2400 , 0 ,41 , NULL ,NULL , NULL ,NULL , NULL  ,1 , 4 ,0 , NULL   ,41 , NULL ,329 , NULL ,NULL , NULL ),
		--Product Status
		(13 , 9911 ,2400 , 0 ,41 , NULL ,NULL , 1	 ,0    , 0     ,1 , 1 ,0 , NULL   ,41 , NULL ,330 , NULL ,NULL , NULL ),
		--PositionTaking
		(18 , 9911 ,2400 , 0 ,41 , 90	,NULL , NULL ,NULL , NULL  ,2 , 3 ,0 , NULL   ,41 , NULL ,331 , NULL ,NULL , NULL ),
		--Discount
		(19 , 9911 ,2400 , 0 ,41 , NULL ,0.005 , NULL ,NULL , NULL ,2 , 2 ,0 , 0.0005 ,41 , NULL ,332 , NULL ,NULL , NULL )
	
	--Upd Child_DisplayOrder Comm and PT Of Dummy Sport Live Casino
		UPDATE a SET Child_DisplayOrder = 1										
		FROM ProductSettingDetail_UAT a WITH (ROWLOCK , UPDLOCK)
		WHERE ProductID = 41 AND SettingType IN (18,19) AND SportType = 9911

	--Upd Child_DisplayOrder Comm and PT Of IBCBet Live Casino
		UPDATE a SET Child_DisplayOrder = 2
		FROM ProductSettingDetail_UAT a WITH (ROWLOCK , UPDLOCK)
		WHERE ProductID = 41 AND SettingType IN (18,19) AND SportType = 242

	--Upd RealProductId
		UPDATE a SET RealProductId = ProductID
		FROM ProductSettingDetail_UAT a WITH (ROWLOCK , UPDLOCK)
		WHERE ProductID = 41 