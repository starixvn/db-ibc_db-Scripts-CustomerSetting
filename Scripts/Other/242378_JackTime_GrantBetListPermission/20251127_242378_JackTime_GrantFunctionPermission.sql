/*<info serverAlias="DBAGE-bodb02" executers="vnteam" viewers="" isFunction="1" isNested="0"></info>*/
/*
    Created: 20251127@Virgil
	Task: BetList - Open Function permission to vnteam [Redmine: #242378]
	DB: DBAGE-bodb02
*/

USE bodb02
GO

GRANT EXECUTE ON OBJECT::[dbo].[PRODUCT] TO vnteam
GO 