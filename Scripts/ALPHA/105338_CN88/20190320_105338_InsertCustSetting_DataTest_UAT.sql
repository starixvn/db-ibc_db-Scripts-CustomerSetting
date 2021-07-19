/*
	Created: Elodie@20190320
	Task: Create data test for CN88
	DB: DBCUST/CustDB
*/
USE CustDB
GO

CREATE PROCEDURE CS_CustomerInsertDataTest
	@UserName NVARCHAR(50),
	@RoleId TINYINT,	
	@DownlineNumber SMALLINT, -- number of downline
	@Site NVARCHAR(50) = N'CN88',
	@HeadlineUserName NVARCHAR(50) = '',
	@ugroup VARCHAR(5) = 'a'
AS
/*
	EXEC CS_CustomerInsertDataTest @Username = 'SuperTestCNU', @RoleId = 4, @DownlineNumber = 10, @HeadlineUserName = 'MainSH01'
	EXEC CS_CustomerInsertDataTest @Username = 'SuperTestCNU0001', @RoleId = 3, @DownlineNumber = 1
	EXEC CS_CustomerInsertDataTest @Username = 'SuperTestCNU00010001', @RoleId = 2, @DownlineNumber = 1, @ugroup = 'b'
	
	
	DECLARE @UserName NVARCHAR(50) = 'SuperTestCNK', @HeadlineUserName NVARCHAR(50) = 'MainSH01', @UserNameDownline NVARCHAR(50) = ''

	EXEC CS_CustomerInsertDataTest @Username = @UserName, @RoleId = 4, @DownlineNumber = 1, @HeadlineUserName = @HeadlineUserName

	SELECT @UserNameDownline = @UserName + '0001'
	EXEC CS_CustomerInsertDataTest @Username = @UserNameDownline, @RoleId = 3, @DownlineNumber = 4
	
	SELECT @UserNameDownline = @UserName + '00010001'
	EXEC CS_CustomerInsertDataTest @Username = @UserNameDownline, @RoleId = 2, @DownlineNumber = 10, @ugroup = 'a'

	SELECT @UserNameDownline = @UserName + '00010002'
	EXEC CS_CustomerInsertDataTest @Username = @UserNameDownline, @RoleId = 2, @DownlineNumber = 10, @ugroup = 'b'

	SELECT @UserNameDownline = @UserName + '00010003'
	EXEC CS_CustomerInsertDataTest @Username = @UserNameDownline, @RoleId = 2, @DownlineNumber = 10, @ugroup = 'c'

	SELECT @UserNameDownline = @UserName + '00010004'
	EXEC CS_CustomerInsertDataTest @Username = @UserNameDownline, @RoleId = 2, @DownlineNumber = 10, @ugroup = 'd'


	SELECT * FROM custinfo WHERE username LIKE 'SuperTestCNQ%'

*/
BEGIN
	DECLARE @p1 INT, @usernamedonwline NVARCHAR(50), @p120 BIT, @CreditDownline MONEY, @p3 TINYINT, @p4 INT, @p2 BIT
	DECLARE @srecommend INT, @mrecommend INT, @recommend INT, @ErrCode INT, @ErrMsg NVARCHAR(4000), @i SMALLINT = 1
	IF @DownlineNumber > 2000
	BEGIN
		SELECT 'Please input @DownlineNumber <= 2000'
		RETURN
	END

	IF @RoleId <> 4 AND NOT EXISTS (SELECT 1 FROM dbo.custInfo WITH (NOLOCK) WHERE username = @UserName AND @RoleId = @RoleId)
	BEGIN
		SELECT 'Please input info correctly'
		RETURN
	END

	IF @RoleId = 4
	BEGIN
		IF NOT EXISTS (SELECT 1 FROM dbo.custInfo WITH (NOLOCK) WHERE username = @HeadlineUserName AND RoleId = 0)
		BEGIN
			SELECT 'Please input headline correctly'
			RETURN
		END
		
		exec CS_CustomerIns_Com_UAT3 @custid=@srecommend output,@ErrCode=@ErrCode output,@ErrSettingType=@p3 output,@MsgType=@p4 output,@ErrMsg=@ErrMsg output,@IsTest=0,
		@PTSetting='<ROOT><PT SportType="1" BetType="1" IsLive="0" MinPT="20" MaxPT="80" /><PT SportType="9998" BetType="81" IsLive="0" MinPT="10" MaxPT="70" /></ROOT>',
		@fax=N'',@HeadlineUsername=@HeadlineUsername,@CommSetting='<ROOT><Comm SportType="1" BetType="1" IsLive="0" GroupId="1" ValueId="45"/><Comm 
		SportType="1" BetType="1" IsLive="0" GroupId="2" ValueId="30"/><Comm SportType="1" BetType="1" IsLive="0" GroupId="3" ValueId="20"/><Comm SportType="1" BetType="1" IsLive="0" GroupId="4" ValueId="15"/><Comm SportType="1" 
		BetType="1" IsLive="1" GroupId="5" ValueId="45"/><Comm SportType="1" BetType="1" IsLive="1" GroupId="6" ValueId="30"/><Comm SportType="1" BetType="1" IsLive="1" GroupId="7" ValueId="20"/><Comm SportType="1" BetType="1" 
		IsLive="1" GroupId="8" ValueId="15"/><Comm SportType="1" BetType="5" IsLive="0" GroupId="0" ValueId="20"/><Comm SportType="1" BetType="9999" IsLive="0" GroupId="0" ValueId="20"/><Comm SportType="1" BetType="9999" IsLive="1" 
		GroupId="0" ValueId="20"/><Comm SportType="2" BetType="1" IsLive="0" GroupId="9" ValueId="46"/><Comm SportType="2" BetType="1" IsLive="0" GroupId="10" ValueId="31"/><Comm SportType="2" BetType="1" IsLive="0" GroupId="11" 
		ValueId="21"/><Comm SportType="2" BetType="1" IsLive="0" GroupId="12" ValueId="16"/><Comm SportType="2" BetType="1" IsLive="1" GroupId="13" ValueId="46"/><Comm SportType="2" BetType="1" IsLive="1" GroupId="14" 
		ValueId="31"/><Comm SportType="2" BetType="1" IsLive="1" GroupId="15" ValueId="21"/><Comm SportType="2" BetType="1" IsLive="1" GroupId="16" ValueId="16"/><Comm SportType="2" BetType="20" IsLive="0" GroupId="0" 
		ValueId="21"/><Comm SportType="2" BetType="9999" IsLive="0" GroupId="0" ValueId="21"/><Comm SportType="99" BetType="1" IsLive="0" GroupId="17" ValueId="46"/><Comm SportType="99" BetType="1" IsLive="0" GroupId="18" 
		ValueId="31"/><Comm SportType="99" BetType="1" IsLive="0" GroupId="19" ValueId="21"/><Comm SportType="99" BetType="1" IsLive="0" GroupId="20" ValueId="16"/><Comm SportType="99" BetType="1" IsLive="1" GroupId="21" 
		ValueId="46"/><Comm SportType="99" BetType="1" IsLive="1" GroupId="22" ValueId="31"/><Comm SportType="99" BetType="1" IsLive="1" GroupId="23" ValueId="21"/><Comm SportType="99" BetType="1" IsLive="1" GroupId="24" 
		ValueId="16"/><Comm SportType="99" BetType="5" IsLive="0" GroupId="0" ValueId="21"/><Comm SportType="99" BetType="9999" IsLive="0" GroupId="0" ValueId="21"/><Comm SportType="9999" BetType="10" IsLive="0" GroupId="0" ValueId="21"/></ROOT>',
		@userpwd='C268E7827BABD7657E85A85811D281',@Language='E',@IP='10.21.10.30',
		@BetSetting='<ROOT><BetSetting SportType="1" BetType="1" IsLive="0" MaxBet="8000" MaxPerEvent="80000"/><BetSetting SportType="1" BetType="1" IsLive="1" MaxBet="8000" MaxPerEvent="80000"/><BetSetting SportType="1" BetType="5" IsLive="0" MaxBet="8000" MaxPerEvent="80000"/><BetSetting SportType="1" BetType="9999" IsLive="0" MaxBet="8000" MaxPerEvent="80000"/><BetSetting SportType="1" BetType="9999" IsLive="1" MaxBet="8000" MaxPerEvent="80000"/><BetSetting SportType="2" BetType="1" IsLive="0" MaxBet="8000" MaxPerEvent="80000"/><BetSetting SportType="2" BetType="1" IsLive="1" MaxBet="8000" MaxPerEvent="80000"/><BetSetting SportType="2" BetType="20" IsLive="0" MaxBet="8000" MaxPerEvent="80000"/><BetSetting SportType="2" BetType="9999" IsLive="0" MaxBet="8000" MaxPerEvent="80000"/><BetSetting SportType="99" BetType="1" IsLive="0" MaxBet="8000" MaxPerEvent="80000"/><BetSetting SportType="99" BetType="1" IsLive="1" MaxBet="8000" MaxPerEvent="80000"/><BetSetting SportType="99" BetType="5" IsLive="0" MaxBet="8000" MaxPerEvent="80000"/><BetSetting SportType="99" BetType="9999" IsLive="0" MaxBet="8000" MaxPerEvent="80000"/><BetSetting SportType="9999" BetType="10" IsLive="0" MaxBet="8000" MaxPerEvent="80000"/><BetSetting SportType="9998" BetType="81" IsLive="0" MaxBet="8000" MaxPerEvent="80000"/><BetSetting SportType="9998" BetType="1501" IsLive="0" MaxBet="8000" MaxPerEvent="80000"/><BetSetting SportType="9998" BetType="1201" IsLive="0" MaxBet="8000" MaxPerEvent="80000"/></ROOT>',
		@username=@UserName,@credit=1000000.0000,@lastname=N'',@phone=N'',@firstname=N'',@mobilephone=N'',@SystemID=1,
		@site=N'CN88',@creator=8

		IF @ErrCode <> 0 
		BEGIN
			SELECT @ErrMsg
			RETURN
		END

		SELECT @CreditDownline = credit/@DownlineNumber FROM dbo.custInfo WITH (NOLOCK) WHERE custid = @srecommend

		WHILE (@i<=@DownlineNumber)
		BEGIN			
			SELECT @usernamedonwline = @UserName + CASE WHEN @i < 10 THEN '000' + CONVERT(NVARCHAR(4), @i)
														WHEN @i < 100 THEN '00' + CONVERT(NVARCHAR(4), @i)
														WHEN @i < 1000 THEN '0' + CONVERT(NVARCHAR(4), @i)
														ELSE CONVERT(NVARCHAR(4), @i) END


		exec CS_CustomerIns_SAg_UAT3 @custid=@p1 output,@ErrCode=@ErrCode output,@ErrSettingType=@p3 output,@MsgType=@p4 output,@ErrMsg=@ErrMsg output,@IsTest=0,
		@PTSetting='<ROOT><PT SportType="1" BetType="1" IsLive="0" SuperPT="10" /><PT SportType="9998" BetType="81" IsLive="0" SuperPT="5" /></ROOT>',
		@username=@usernamedonwline,@userpwd='C268E7827BABD7657E85A85811D281',@Language='E',@IP='10.21.10.30',
		@BetSetting='<ROOT><BetSetting SportType="1" BetType="1" 
		IsLive="0" MaxBet="8000" MaxPerEvent="80000"/><BetSetting SportType="1" BetType="1" IsLive="1" MaxBet="8000" MaxPerEvent="80000"/><BetSetting SportType="1" BetType="5" IsLive="0" MaxBet="8000" 
		MaxPerEvent="80000"/><BetSetting SportType="1" BetType="9999" IsLive="0" MaxBet="8000" MaxPerEvent="80000"/><BetSetting SportType="1" BetType="9999" IsLive="1" MaxBet="8000" MaxPerEvent="80000"/><BetSetting SportType="2" 
		BetType="1" IsLive="0" MaxBet="8000" MaxPerEvent="80000"/><BetSetting SportType="2" BetType="1" IsLive="1" MaxBet="8000" MaxPerEvent="80000"/><BetSetting SportType="2" BetType="20" IsLive="0" MaxBet="8000" 
		MaxPerEvent="80000"/><BetSetting SportType="2" BetType="9999" IsLive="0" MaxBet="8000" MaxPerEvent="80000"/><BetSetting SportType="99" BetType="1" IsLive="0" MaxBet="8000" MaxPerEvent="80000"/><BetSetting SportType="99" 
		BetType="1" IsLive="1" MaxBet="8000" MaxPerEvent="80000"/><BetSetting SportType="99" BetType="5" IsLive="0" MaxBet="8000" MaxPerEvent="80000"/><BetSetting SportType="99" BetType="9999" IsLive="0" MaxBet="8000" 
		MaxPerEvent="80000"/><BetSetting SportType="9999" BetType="10" IsLive="0" MaxBet="8000" MaxPerEvent="80000"/><BetSetting SportType="9998" BetType="81" IsLive="0" MaxBet="8000" MaxPerEvent="80000"/><BetSetting 
		SportType="9998" BetType="1501" IsLive="0" MaxBet="8000" MaxPerEvent="80000"/><BetSetting SportType="9998" BetType="1201" IsLive="0" MaxBet="8000" MaxPerEvent="80000"/></ROOT>',
		@CommSetting='<ROOT><Comm SportType="1" 
		BetType="1" IsLive="0" GroupId="1" ValueId="44"/><Comm SportType="1" BetType="1" IsLive="0" GroupId="2" ValueId="29"/><Comm SportType="1" BetType="1" IsLive="0" GroupId="3" ValueId="19"/><Comm SportType="1" BetType="1" 
		IsLive="0" GroupId="4" ValueId="14"/><Comm SportType="1" BetType="1" IsLive="1" GroupId="5" ValueId="45"/><Comm SportType="1" BetType="1" IsLive="1" GroupId="6" ValueId="30"/><Comm SportType="1" BetType="1" IsLive="1" 
		GroupId="7" ValueId="20"/><Comm SportType="1" BetType="1" IsLive="1" GroupId="8" ValueId="15"/><Comm SportType="1" BetType="5" IsLive="0" GroupId="0" ValueId="19"/><Comm SportType="1" BetType="9999" IsLive="0" GroupId="0" ValueId="19"/><Comm SportType="1" BetType="9999" IsLive="1" GroupId="0" ValueId="19"/><Comm SportType="2" BetType="1" IsLive="0" GroupId="9" ValueId="46"/><Comm SportType="2" BetType="1" IsLive="0" GroupId="10" ValueId="31"/><Comm SportType="2" BetType="1" IsLive="0" GroupId="11" ValueId="21"/><Comm SportType="2" BetType="1" IsLive="0" GroupId="12" ValueId="16"/><Comm SportType="2" BetType="1" IsLive="1" GroupId="13" ValueId="46"/><Comm SportType="2" BetType="1" IsLive="1" GroupId="14" ValueId="31"/><Comm SportType="2" BetType="1" IsLive="1" GroupId="15" ValueId="21"/><Comm SportType="2" BetType="1" IsLive="1" GroupId="16" ValueId="16"/><Comm SportType="2" BetType="20" IsLive="0" GroupId="0" ValueId="21"/><Comm SportType="2" BetType="9999" IsLive="0" GroupId="0" ValueId="21"/><Comm SportType="99" BetType="1" IsLive="0" GroupId="17" ValueId="46"/><Comm SportType="99" BetType="1" IsLive="0" GroupId="18" ValueId="31"/><Comm SportType="99" BetType="1" IsLive="0" GroupId="19" ValueId="21"/><Comm SportType="99" BetType="1" IsLive="0" GroupId="20" ValueId="16"/><Comm SportType="99" BetType="1" IsLive="1" GroupId="21" ValueId="46"/><Comm SportType="99" BetType="1" IsLive="1" GroupId="22" ValueId="31"/><Comm SportType="99" BetType="1" IsLive="1" GroupId="23" ValueId="21"/><Comm SportType="99" BetType="1" IsLive="1" GroupId="24" ValueId="16"/><Comm SportType="99" BetType="5" IsLive="0" GroupId="0" ValueId="21"/><Comm SportType="99" BetType="9999" IsLive="0" GroupId="0" ValueId="21"/><Comm SportType="9999" BetType="10" IsLive="0" GroupId="0" ValueId="21"/></ROOT>',
		@credit=@CreditDownline,@SubAccID=0,@srecommend=@srecommend,@firstname=N'sa',@SystemID=1,@creator=8
			
			IF @ErrCode <> 0 
			BEGIN
				SELECT @ErrMsg
				RETURN
			END

			SELECT @i = @i + 1
		END

		SELECT @srecommend
	END

	ELSE IF @RoleId = 3
	BEGIN
		SELECT @mrecommend = custid, @CreditDownline = credit/@DownlineNumber FROM dbo.custInfo WITH (NOLOCK) WHERE username = @UserName

		WHILE (@i<=@DownlineNumber)
		BEGIN			
			SELECT @usernamedonwline = @UserName + CASE WHEN @i < 10 THEN '000' + CONVERT(NVARCHAR(4), @i)
														WHEN @i < 100 THEN '00' + CONVERT(NVARCHAR(4), @i)
														WHEN @i < 1000 THEN '0' + CONVERT(NVARCHAR(4), @i)
														ELSE CONVERT(NVARCHAR(4), @i) END

			exec CS_CustomerIns_MAg_UAT3 @custid=@p1 output,@ErrCode=@ErrCode output,@ErrSettingType=@p3 output,@MsgType=@p4 output,@ErrMsg=@ErrMsg output,@IsTest=0,
			@PTSetting='<ROOT><PT SportType="1" BetType="1" IsLive="0" MasterPT="10" AgentPT="40" /><PT SportType="9998" BetType="81" IsLive="0" MasterPT="10" AgentPT="40" 
			/></ROOT>',@username=@usernamedonwline,@userpwd='C268E7827BABD7657E85A85811D281',@Language='E',@mrecommend=@mrecommend,@IP='10.21.10.30',
			@BetSetting='<ROOT><BetSetting SportType="1" BetType="1" IsLive="0" MaxBet="8000" 
			MaxPerEvent="80000"/><BetSetting SportType="1" BetType="1" IsLive="1" MaxBet="8000" MaxPerEvent="80000"/><BetSetting SportType="1" BetType="5" IsLive="0" MaxBet="8000" MaxPerEvent="80000"/><BetSetting SportType="1" 
			BetType="9999" IsLive="0" MaxBet="8000" MaxPerEvent="80000"/><BetSetting SportType="1" BetType="9999" IsLive="1" MaxBet="8000" MaxPerEvent="80000"/><BetSetting SportType="2" BetType="1" IsLive="0" MaxBet="8000" 
			MaxPerEvent="80000"/><BetSetting SportType="2" BetType="1" IsLive="1" MaxBet="8000" MaxPerEvent="80000"/><BetSetting SportType="2" BetType="20" IsLive="0" MaxBet="8000" MaxPerEvent="80000"/><BetSetting SportType="2" 
			BetType="9999" IsLive="0" MaxBet="8000" MaxPerEvent="80000"/><BetSetting SportType="99" BetType="1" IsLive="0" MaxBet="8000" MaxPerEvent="80000"/><BetSetting SportType="99" BetType="1" IsLive="1" MaxBet="8000" 
			MaxPerEvent="80000"/><BetSetting SportType="99" BetType="5" IsLive="0" MaxBet="8000" MaxPerEvent="80000"/><BetSetting SportType="99" BetType="9999" IsLive="0" MaxBet="8000" MaxPerEvent="80000"/><BetSetting SportType="9999" 
			BetType="10" IsLive="0" MaxBet="8000" MaxPerEvent="80000"/><BetSetting SportType="9998" BetType="81" IsLive="0" MaxBet="8000" MaxPerEvent="80000"/><BetSetting SportType="9998" BetType="1501" IsLive="0" MaxBet="8000" 
			MaxPerEvent="80000"/><BetSetting SportType="9998" BetType="1201" IsLive="0" MaxBet="8000" MaxPerEvent="80000"/></ROOT>',
			@CommSetting='<ROOT><Comm SportType="1" BetType="1" IsLive="0" GroupId="1" ValueId="43"/><Comm 
			SportType="1" BetType="1" IsLive="0" GroupId="2" ValueId="28"/><Comm SportType="1" BetType="1" IsLive="0" GroupId="3" ValueId="18"/><Comm SportType="1" BetType="1" IsLive="0" GroupId="4" ValueId="13"/><Comm SportType="1" 
			BetType="1" IsLive="1" GroupId="5" ValueId="45"/><Comm SportType="1" BetType="1" IsLive="1" GroupId="6" ValueId="30"/><Comm SportType="1" BetType="1" IsLive="1" GroupId="7" ValueId="20"/><Comm SportType="1" BetType="1" 
			IsLive="1" GroupId="8" ValueId="15"/><Comm SportType="1" BetType="5" IsLive="0" GroupId="0" ValueId="18"/><Comm SportType="1" BetType="9999" IsLive="0" GroupId="0" ValueId="18"/><Comm SportType="1" BetType="9999" IsLive="1" GroupId="0" ValueId="18"/><Comm SportType="2" BetType="1" IsLive="0" GroupId="9" ValueId="46"/><Comm SportType="2" BetType="1" IsLive="0" GroupId="10" ValueId="31"/><Comm SportType="2" BetType="1" IsLive="0" GroupId="11" ValueId="21"/><Comm SportType="2" BetType="1" IsLive="0" GroupId="12" ValueId="16"/><Comm SportType="2" BetType="1" IsLive="1" GroupId="13" ValueId="46"/><Comm SportType="2" BetType="1" IsLive="1" GroupId="14" ValueId="31"/><Comm SportType="2" BetType="1" IsLive="1" GroupId="15" ValueId="21"/><Comm SportType="2" BetType="1" IsLive="1" GroupId="16" ValueId="16"/><Comm SportType="2" BetType="20" IsLive="0" GroupId="0" ValueId="21"/><Comm SportType="2" BetType="9999" IsLive="0" GroupId="0" ValueId="21"/><Comm SportType="99" BetType="1" IsLive="0" GroupId="17" ValueId="46"/><Comm SportType="99" BetType="1" IsLive="0" GroupId="18" ValueId="31"/><Comm SportType="99" BetType="1" IsLive="0" GroupId="19" ValueId="21"/><Comm SportType="99" BetType="1" IsLive="0" GroupId="20" ValueId="16"/><Comm SportType="99" BetType="1" IsLive="1" GroupId="21" ValueId="46"/><Comm SportType="99" BetType="1" IsLive="1" GroupId="22" ValueId="31"/><Comm SportType="99" BetType="1" IsLive="1" GroupId="23" ValueId="21"/><Comm SportType="99" BetType="1" IsLive="1" GroupId="24" ValueId="16"/><Comm SportType="99" BetType="5" IsLive="0" GroupId="0" ValueId="21"/><Comm SportType="99" BetType="9999" IsLive="0" GroupId="0" ValueId="21"/><Comm SportType="9999" BetType="10" IsLive="0" GroupId="0" ValueId="21"/></ROOT>',
			@credit=@CreditDownline,@SubAccID=0,@firstname=N'sa',@SystemID=1,@creator=8

			IF @ErrCode <> 0 
			BEGIN
				SELECT @ErrMsg
				RETURN
			END

			SELECT @i = @i + 1
		END
	END

	ELSE IF @RoleId = 2
	BEGIN
		SELECT @recommend = custid, @CreditDownline = credit/@DownlineNumber FROM dbo.custInfo WITH (NOLOCK) WHERE username = @UserName

		WHILE (@i<=@DownlineNumber)
		BEGIN
			SELECT @usernamedonwline = @UserName + CASE WHEN @i < 10 THEN '000' + CONVERT(NVARCHAR(4), @i)
														WHEN @i < 100 THEN '00' + CONVERT(NVARCHAR(4), @i)
														WHEN @i < 1000 THEN '0' + CONVERT(NVARCHAR(4), @i)
														ELSE CONVERT(NVARCHAR(4), @i) END

			exec CS_CustomerIns_Ag_UAT3 @custid=@p1 output,@success=@p2 output,@ErrCode=@ErrCode output,@ErrSettingType=@p4 output,@MsgType=@p4 output,@ErrMsg=@ErrMsg 
			output,@IsTest=0,@username=@usernamedonwline,@userpwd='C268E7827BABD7657E85A85811D281',@Language='E',@IP='10.21.10.30',
			@ugroup=@ugroup,@BetSetting='<ROOT><BetSetting SportType="1" BetType="1" IsLive="0" MaxBet="8000" 
			MaxPerEvent="80000"/><BetSetting SportType="1" BetType="1" IsLive="1" MaxBet="8000" MaxPerEvent="80000"/><BetSetting SportType="1" BetType="5" IsLive="0" MaxBet="8000" MaxPerEvent="80000"/><BetSetting SportType="1" 
			BetType="9999" IsLive="0" MaxBet="8000" MaxPerEvent="80000"/><BetSetting SportType="1" BetType="9999" IsLive="1" MaxBet="8000" MaxPerEvent="80000"/><BetSetting SportType="2" BetType="1" IsLive="0" MaxBet="8000" 
			MaxPerEvent="80000"/><BetSetting SportType="2" BetType="1" IsLive="1" MaxBet="8000" MaxPerEvent="80000"/><BetSetting SportType="2" BetType="20" IsLive="0" MaxBet="8000" MaxPerEvent="80000"/><BetSetting SportType="2" BetType="9999" IsLive="0" MaxBet="8000" MaxPerEvent="80000"/><BetSetting SportType="99" BetType="1" IsLive="0" MaxBet="8000" MaxPerEvent="80000"/><BetSetting SportType="99" BetType="1" IsLive="1" MaxBet="8000" MaxPerEvent="80000"/><BetSetting SportType="99" BetType="5" IsLive="0" MaxBet="8000" MaxPerEvent="80000"/><BetSetting SportType="99" BetType="9999" IsLive="0" MaxBet="8000" MaxPerEvent="80000"/><BetSetting SportType="9999" BetType="10" IsLive="0" MaxBet="8000" MaxPerEvent="80000"/><BetSetting SportType="9998" BetType="81" IsLive="0" MaxBet="8000" MaxPerEvent="80000"/><BetSetting SportType="9998" BetType="1501" IsLive="0" MaxBet="8000" MaxPerEvent="80000"/><BetSetting SportType="9998" BetType="1201" IsLive="0" MaxBet="8000" MaxPerEvent="80000"/></ROOT>',
			@CommSetting='<ROOT><Comm SportType="1" BetType="1" IsLive="0" ValueId="13"/><Comm SportType="1" BetType="1" IsLive="1" ValueId="15"/><Comm SportType="1" BetType="5" IsLive="0" ValueId="17"/><Comm SportType="1" BetType="9999" IsLive="0" ValueId="17"/><Comm SportType="1" BetType="9999" IsLive="1" ValueId="17"/><Comm SportType="2" BetType="1" IsLive="0" ValueId="16"/><Comm SportType="2" BetType="1" IsLive="1" ValueId="16"/><Comm SportType="2" BetType="20" IsLive="0" ValueId="21"/><Comm SportType="2" BetType="9999" IsLive="0" ValueId="21"/><Comm SportType="99" BetType="1" IsLive="0" ValueId="16"/><Comm SportType="99" BetType="1" IsLive="1" ValueId="16"/><Comm SportType="99" BetType="5" IsLive="0" ValueId="21"/><Comm SportType="99" BetType="9999" IsLive="0" ValueId="21"/><Comm SportType="9999" BetType="10" IsLive="0" ValueId="21"/></ROOT>',
			@recommend=@recommend,@SubAccID=0,@firstname=N'sa',@SystemID=1,@credit=@CreditDownline,@creator=8

			IF @ErrCode <> 0 
			BEGIN
				SELECT @ErrMsg
				RETURN
			END

			SELECT @i = @i + 1
		END
	END
END

------Create new customer
DECLARE @UserName NVARCHAR(50) = 'SuperTestCNA', @HeadlineUserName NVARCHAR(50) = 'HLTest01', @UserNameDownline NVARCHAR(50) = ''

EXEC CS_CustomerInsertDataTest @Username = @UserName, @RoleId = 4, @DownlineNumber = 1, @HeadlineUserName = @HeadlineUserName

SELECT @UserNameDownline = @UserName + '0001'
EXEC CS_CustomerInsertDataTest @Username = @UserNameDownline, @RoleId = 3, @DownlineNumber = 4

SELECT @UserNameDownline = @UserName + '00010001'
EXEC CS_CustomerInsertDataTest @Username = @UserNameDownline, @RoleId = 2, @DownlineNumber = 10, @ugroup = 'a'

SELECT @UserNameDownline = @UserName + '00010002'
EXEC CS_CustomerInsertDataTest @Username = @UserNameDownline, @RoleId = 2, @DownlineNumber = 10, @ugroup = 'b'

SELECT @UserNameDownline = @UserName + '00010003'
EXEC CS_CustomerInsertDataTest @Username = @UserNameDownline, @RoleId = 2, @DownlineNumber = 10, @ugroup = 'c'

SELECT @UserNameDownline = @UserName + '00010004'
EXEC CS_CustomerInsertDataTest @Username = @UserNameDownline, @RoleId = 2, @DownlineNumber = 10, @ugroup = 'd'

SELECT * FROM custinfo WHERE username LIKE 'SuperTestCNA%'