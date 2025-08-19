/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20250814@Virgil
	Task: fix bug - offer VGaming for site 222227 [RedmineId: #235515]
	DB: DBCust/CustDB
*/

USE CustDB
GO
--==============================================================================
--Offer VGaming for Credit: 222227 which are under supported site

DECLARE @Sporttype SMALLINT = 171,
		@Bettype INT = 3801,
		@currency INT = 20,
		@siteid INT = 25;

IF EXISTS (SELECT TOP 1 1 FROM SportNonOfferedSiteCurrency WITH (NOLOCK) WHERE sporttype = @Sporttype and currency = @currency and siteid = @siteid)
BEGIN
	DELETE d
	OUTPUT deleted.[SportType], deleted.[BetType], deleted.[Currency], deleted.[SiteID], dbo.f_GetDateTime2()
	INTO [dbo].[SportNonOfferedSiteCurrency_Del_InHouse] ([SportType], [BetType], [Currency], [SiteID], [RepUpdateTime])
	FROM SportNonOfferedSiteCurrency d WITH (ROWLOCK)
	WHERE sporttype = @Sporttype AND currency = @currency AND siteid = @siteid
END

GO 

