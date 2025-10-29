/*<info serverAlias="DBSabaPlay-WalletBridgeDB_Admin"></info>*/
/*
	Created: Helios@20251009
	Task: SabaPlay - Integrate new product Vertex Play (VP) [#240871] 
	DB: DBSabaPlay-WalletBridgeDB_Admin
*/

USE WalletBridgeDB_Admin

GO

-- Insert VendorAgentInfo
EXEC [dbo].[BA_VendorAgentInfo_Ins] @OperatorId = 1, @VendorId = 116, @VendorAgentId = N'4100900', @VendorAgentKey = N'22', @VendorAgentCode = N'Credit', @VendorAgentType = N'SABA', @RefName = N'i01idr',@RefKey = N'aZwny1vc+5kS2xFlK6XeoljEdzPmgy2K', @RefCode = N'IDR',@Note='03eee726'
EXEC [dbo].[BA_VendorAgentInfo_Ins] @OperatorId = 1, @VendorId = 116, @VendorAgentId = N'4100900', @VendorAgentKey = N'33', @VendorAgentCode = N'Credit', @VendorAgentType = N'SABA', @RefName = N'i01idr',@RefKey = N'aZwny1vc+5kS2xFlK6XeoljEdzPmgy2K', @RefCode = N'IDR',@Note='03eee726'
EXEC [dbo].[BA_VendorAgentInfo_Ins] @OperatorId = 1, @VendorId = 116, @VendorAgentId = N'4100200', @VendorAgentKey = N'72', @VendorAgentCode = N'Credit', @VendorAgentType = N'SABA', @RefName = N'testvnd1',@RefKey = N'aZwny1vc+5mMS3aBsjFGxw1N4xtLt+V3', @RefCode = N'VND',@Note='542af364'
EXEC [dbo].[BA_VendorAgentInfo_Ins] @OperatorId = 1, @VendorId = 116, @VendorAgentId = N'4100900', @VendorAgentKey = N'72', @VendorAgentCode = N'Credit', @VendorAgentType = N'SABA', @RefName = N'testvnd1',@RefKey = N'aZwny1vc+5mMS3aBsjFGxw1N4xtLt+V3', @RefCode = N'VND',@Note='542af364'
EXEC [dbo].[BA_VendorAgentInfo_Ins] @OperatorId = 1, @VendorId = 116, @VendorAgentId = N'4100300', @VendorAgentKey = N'72', @VendorAgentCode = N'Credit', @VendorAgentType = N'SABA', @RefName = N'testvnd1',@RefKey = N'aZwny1vc+5mMS3aBsjFGxw1N4xtLt+V3', @RefCode = N'VND',@Note='542af364'
EXEC [dbo].[BA_VendorAgentInfo_Ins] @OperatorId = 1, @VendorId = 116, @VendorAgentId = N'4200000', @VendorAgentKey = N'3', @VendorAgentCode = N'Cash', @VendorAgentType = N'SABA', @RefName = N'l01usd',@RefKey = N'aZwny1vc+5nCuGqVSdW5hqSXu+haCIM6', @RefCode = N'USD',@Note='64bba4fe'
EXEC [dbo].[BA_VendorAgentInfo_Ins] @OperatorId = 1, @VendorId = 116, @VendorAgentId = N'4200000', @VendorAgentKey = N'6', @VendorAgentCode = N'Cash', @VendorAgentType = N'SABA', @RefName = N'l01eur',@RefKey = N'aZwny1vc+5kl6pMmajQi2/PkwSgosj0K', @RefCode = N'EUR',@Note='64bba4fe'
EXEC [dbo].[BA_VendorAgentInfo_Ins] @OperatorId = 1, @VendorId = 116, @VendorAgentId = N'4200000', @VendorAgentKey = N'13', @VendorAgentCode = N'Cash', @VendorAgentType = N'SABA', @RefName = N'l01cny',@RefKey = N'aZwny1vc+5mQWE3aUA6xmaYqj2DdVvn9', @RefCode = N'CNY',@Note='64bba4fe'
EXEC [dbo].[BA_VendorAgentInfo_Ins] @OperatorId = 1, @VendorId = 116, @VendorAgentId = N'4200000', @VendorAgentKey = N'15', @VendorAgentCode = N'Cash', @VendorAgentType = N'SABA', @RefName = N'l01idr',@RefKey = N'aZwny1vc+5kn8uD8cF+gEAycurhtsP71', @RefCode = N'IDR',@Note='64bba4fe'
EXEC [dbo].[BA_VendorAgentInfo_Ins] @OperatorId = 1, @VendorId = 116, @VendorAgentId = N'4200000', @VendorAgentKey = N'51', @VendorAgentCode = N'Cash', @VendorAgentType = N'SABA', @RefName = N'l01vnd',@RefKey = N'aZwny1vc+5m/NuHKVDdAO8UAj6vYfeYy', @RefCode = N'VND',@Note='64bba4fe'
EXEC [dbo].[BA_VendorAgentInfo_Ins] @OperatorId = 1, @VendorId = 116, @VendorAgentId = N'4100300', @VendorAgentKey = N'3', @VendorAgentCode = N'Credit', @VendorAgentType = N'SABA', @RefName = N'y01usd',@RefKey = N'aZwny1vc+5mE7nfkzaEAs0/yhN3xNKRR', @RefCode = N'USD',@Note='c6c63b44'
EXEC [dbo].[BA_VendorAgentInfo_Ins] @OperatorId = 1, @VendorId = 116, @VendorAgentId = N'4100300', @VendorAgentKey = N'16', @VendorAgentCode = N'Credit', @VendorAgentType = N'SABA', @RefName = N'y01usd',@RefKey = N'aZwny1vc+5mE7nfkzaEAs0/yhN3xNKRR', @RefCode = N'USD',@Note='c6c63b44'
EXEC [dbo].[BA_VendorAgentInfo_Ins] @OperatorId = 1, @VendorId = 116, @VendorAgentId = N'4100300', @VendorAgentKey = N'51', @VendorAgentCode = N'Credit', @VendorAgentType = N'SABA', @RefName = N'y01vnd',@RefKey = N'aZwny1vc+5kgZL3qG0h2kV1t8gvGnm8H', @RefCode = N'VND',@Note='c6c63b44'
EXEC [dbo].[BA_VendorAgentInfo_Ins] @OperatorId = 1, @VendorId = 116, @VendorAgentId = N'4100300', @VendorAgentKey = N'64', @VendorAgentCode = N'Credit', @VendorAgentType = N'SABA', @RefName = N'y01usd',@RefKey = N'aZwny1vc+5mE7nfkzaEAs0/yhN3xNKRR', @RefCode = N'USD',@Note='c6c63b44'
EXEC [dbo].[BA_VendorAgentInfo_Ins] @OperatorId = 1, @VendorId = 116, @VendorAgentId = N'4100200', @VendorAgentKey = N'2', @VendorAgentCode = N'Credit', @VendorAgentType = N'SABA', @RefName = N'n01myr',@RefKey = N'aZwny1vc+5kGEBe5GbG+XRiwuiORWppK', @RefCode = N'MYR',@Note='fa79239e'
EXEC [dbo].[BA_VendorAgentInfo_Ins] @OperatorId = 1, @VendorId = 116, @VendorAgentId = N'4100200', @VendorAgentKey = N'3', @VendorAgentCode = N'Credit', @VendorAgentType = N'SABA', @RefName = N'n01usd',@RefKey = N'aZwny1vc+5lxkEiGQOgvexE3apkoNLzR', @RefCode = N'USD',@Note='fa79239e'
EXEC [dbo].[BA_VendorAgentInfo_Ins] @OperatorId = 1, @VendorId = 116, @VendorAgentId = N'4100200', @VendorAgentKey = N'6', @VendorAgentCode = N'Credit', @VendorAgentType = N'SABA', @RefName = N'n01eur',@RefKey = N'aZwny1vc+5lvl473zvIan3QDE/shvICr', @RefCode = N'EUR',@Note='fa79239e'
EXEC [dbo].[BA_VendorAgentInfo_Ins] @OperatorId = 1, @VendorId = 116, @VendorAgentId = N'4100200', @VendorAgentKey = N'13', @VendorAgentCode = N'Credit', @VendorAgentType = N'SABA', @RefName = N'n01cny',@RefKey = N'aZwny1vc+5ljLKP+1pRJnpwVpdF2qnY+', @RefCode = N'CNY',@Note='fa79239e'
EXEC [dbo].[BA_VendorAgentInfo_Ins] @OperatorId = 1, @VendorId = 116, @VendorAgentId = N'4100200', @VendorAgentKey = N'15', @VendorAgentCode = N'Credit', @VendorAgentType = N'SABA', @RefName = N'n01idr',@RefKey = N'aZwny1vc+5nCxf2jyO1g6US1tAefJK+H', @RefCode = N'IDR',@Note='fa79239e'
EXEC [dbo].[BA_VendorAgentInfo_Ins] @OperatorId = 1, @VendorId = 116, @VendorAgentId = N'4100200', @VendorAgentKey = N'22', @VendorAgentCode = N'Credit', @VendorAgentType = N'SABA', @RefName = N'n01idr',@RefKey = N'aZwny1vc+5nCxf2jyO1g6US1tAefJK+H', @RefCode = N'IDR',@Note='fa79239e'
EXEC [dbo].[BA_VendorAgentInfo_Ins] @OperatorId = 1, @VendorId = 116, @VendorAgentId = N'4100200', @VendorAgentKey = N'33', @VendorAgentCode = N'Credit', @VendorAgentType = N'SABA', @RefName = N'n01idr',@RefKey = N'aZwny1vc+5nCxf2jyO1g6US1tAefJK+H', @RefCode = N'IDR',@Note='fa79239e'
EXEC [dbo].[BA_VendorAgentInfo_Ins] @OperatorId = 1, @VendorId = 116, @VendorAgentId = N'4100200', @VendorAgentKey = N'43', @VendorAgentCode = N'Credit', @VendorAgentType = N'SABA', @RefName = N'n01thb',@RefKey = N'aZwny1vc+5meUfpgby4DWQ9zqkIq1h2Z', @RefCode = N'THB',@Note='fa79239e'
EXEC [dbo].[BA_VendorAgentInfo_Ins] @OperatorId = 1, @VendorId = 116, @VendorAgentId = N'4100200', @VendorAgentKey = N'45', @VendorAgentCode = N'Credit', @VendorAgentType = N'SABA', @RefName = N'n01krw',@RefKey = N'aZwny1vc+5kzSwXJ/6DxKaWYyL4ggvs3', @RefCode = N'KRW',@Note='fa79239e'
EXEC [dbo].[BA_VendorAgentInfo_Ins] @OperatorId = 1, @VendorId = 116, @VendorAgentId = N'4100200', @VendorAgentKey = N'47', @VendorAgentCode = N'Credit', @VendorAgentType = N'SABA', @RefName = N'n01idr',@RefKey = N'aZwny1vc+5nCxf2jyO1g6US1tAefJK+H', @RefCode = N'IDR',@Note='fa79239e'
EXEC [dbo].[BA_VendorAgentInfo_Ins] @OperatorId = 1, @VendorId = 116, @VendorAgentId = N'4100200', @VendorAgentKey = N'67', @VendorAgentCode = N'Credit', @VendorAgentType = N'SABA', @RefName = N'n01myr',@RefKey = N'aZwny1vc+5kGEBe5GbG+XRiwuiORWppK', @RefCode = N'MYR',@Note='fa79239e'
EXEC [dbo].[BA_VendorAgentInfo_Ins] @OperatorId = 1, @VendorId = 116, @VendorAgentId = N'4100200', @VendorAgentKey = N'69', @VendorAgentCode = N'Credit', @VendorAgentType = N'SABA', @RefName = N'n01mmk',@RefKey = N'aZwny1vc+5kGEBe5GbG+Xc/H4pRf1xEY', @RefCode = N'MMK',@Note='fa79239e'


-- Insert OperatorGameSetting
EXEC [dbo].[sabaplay_spbu_BA_OperatorGameSetting_Ins] @OperatorId	   = 1
								    , @SubOperatorId = 0
								    , @VendorId	   = 116
								    , @SettingType   = N'OperatorEndPoint'
								    , @ValidatePwd   = NULL
								    , @ValidateKey   = NULL
								    , @Url		   = N'http://saba-wallet-group-preprod.3rd-party.klt2p.gamora.prod:32280/api/VertexPlay'
								    , @OtherInfo	   = NULL

EXEC [dbo].[sabaplay_spbu_BA_OperatorGameSetting_Ins] @OperatorId	   = 1
								    , @SubOperatorId = 0
								    , @VendorId	   = 116
								    , @SettingType   = N'VendorEndPoint_General'
								    , @ValidatePwd   = NULL
								    , @ValidateKey   = NULL
								    , @Url		   = N'https://{0}.xprogame.com'
								    , @OtherInfo	   = NULL
