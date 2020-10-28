/*<info serverAlias="DBTXN-bodb02"></info>*/

/*
	Created: 20201028@Tina
	Task: [144296] Insert data to Sport_Bettype_Reference_VirtualRate
		  Offer Moneyline and 1H Moneyline for Football (References: Other Sports - Moneyline)
		  
*/

USE [bodb02]
GO

DECLARE @VirtualRate TABLE(
	[Sporttype] SMALLINT,
	[Bettype] SMALLINT,
	[SporttypeRefVirtualRate] SMALLINT,
	[BettypeRefVirtualRate] SMALLINT,
	[isActive] BIT
) 

INSERT INTO @VirtualRate (Sporttype, Bettype, SporttypeRefVirtualRate, BettypeRefVirtualRate, isActive)
SELECT 3 Sporttype, 20 Bettype, 99 SporttypeRefVirtualRate, 20 BettypeRefVirtualRate, 1 isActive --Football - Moneyline
UNION ALL
SELECT 3 Sporttype, 21 Bettype, 99 SporttypeRefVirtualRate, 20 BettypeRefVirtualRate, 1 isActive --Football - 1H Moneyline

INSERT INTO Sport_Bettype_Reference_VirtualRate (Sporttype, Bettype, SporttypeRefVirtualRate, BettypeRefVirtualRate, isActive)
SELECT VR.Sporttype, VR.Bettype, VR.SporttypeRefVirtualRate, VR.BettypeRefVirtualRate, VR.isActive
FROM @VirtualRate VR
WHERE NOT EXISTS (SELECT 1 
				  FROM Sport_Bettype_Reference_VirtualRate SB WITH (NOLOCK) 
				  WHERE SB.SportType = VR.Sporttype 
						AND SB.BetType = VR.Bettype)

