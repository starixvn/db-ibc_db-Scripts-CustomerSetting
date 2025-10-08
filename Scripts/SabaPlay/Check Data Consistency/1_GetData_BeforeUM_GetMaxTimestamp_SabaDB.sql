/*<info serverAlias="DBSabaPlay-WalletBridgeDB"></info>*/ 
/*
	Created: Helios@20251008
	Task: Check data Consistency from SiteDb03 with WalletBridgeDB - CHECK BEFORE UM [#239774]
	DB: DBSabaPlay-WalletBridgeDB
*/

-- Get Max Timestamp
SELECT MAX(t.Timestamp) AS Max_Timestamp
FROM Tickets t WITH (NOLOCK);