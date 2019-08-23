
SELECT  DBName			= DB_NAME(),
		SPName			= OBJECT_NAME(id),
		Bullfighting	= MAX(case when text like '%Bull%fighting%'  then 1 else 0 end),
		Lucky3			= MAX(case when text like '%lucky%'  then 1 else 0 end),
		PokerGame		= MAX(case when text like '%poker%game%'   then 1 else 0 end),
		ColossusBet		= MAX(case when text like '%colossus%'  then 1 else 0 end),
		IMBCCricket		= MAX(case when text like '%IMBC%Cricket%' then 1 else 0 end),
		Microgaming		= MAX(case when text like '%Microgaming%'   then 1 else 0 end),
		MyanmarOdds		= MAX(case when text like '%Myanmar%odd%'  then 1 else 0 end),
		LiveCasino		= MAX(case when text like '%Live%casino%'    then 1 else 0 end),
		Bingo			= MAX(case when text like '%bingo%'   then 1 else 0 end),
		P2P				= MAX(case when text like '%p2P%' then 1 else 0 end),
		Racing			= MAX(case when text like '%RACING%'   then 1 else 0 end),
		HorseRacingFO	= MAX(case when text like '%Horse%RACING%'  then 1 else 0 end),
		Custcolumn		= MAX(case when text like '%maxpermatch151%'
									OR text like '%maxpermatch201%'
									OR text like '%DisableHorseRacing%'
									OR text like '%DisableFinancial%'
									OR text like '%DisableOpenTote%'
									OR text like '%maxpermatch151_OT%'
									OR text like '%DisableBingo%'
									OR text like '%SyncBingo%'
									OR text like '%MaxPerMatch151_AU%'
									OR text like '%MaxPerMatch152_UK%'
									OR text like '%MaxPerMatch152_AU%'
									OR text like '%MaxPerMatch153_AU%'
									OR text like '%Disable151_AU%'
									OR text like '%Disable152_UK%'
									OR text like '%Disable152_AU%'
									OR text like '%Disable153_AU%'
									OR text like '%MaxtransferP2P%'
									OR text like '%IsAutoResetP2P%'
									OR text like '%DisableP2P%'
									OR text like '%DisableFunP2P%'
									OR text like '%DisableLiveCasino%'
									OR text like '%SyncLiveCasino%'
									OR text like '%DisableVirtualSports%'
									OR text like '%HideVirtualSports%'
									OR text like '%maxpermatch180%'
									OR text like '%isAutoResetLiveCasino%'
									OR text like '%MaxWinLiveCasino%'
									OR text like '%maxpermatch186%'
									OR text like '%maxpermatch181%'
									OR text like '%maxpermatch182%'
									OR text like '%DisableCasinoBonus%'
									OR text like '%maxpermatch184%'
									OR text like '%DisableHRFixedOdds%'
									OR text like '%maxpermatch154%'
									OR text like '%maxpermatch183%'
									OR text like '%maxpermatch185%'
									OR text like '%MaxPerMatch44%'
									OR text like '%DisableMicrogameLC%'
									OR text like '%DisableMicrogameRNG%'
									OR text like '%DisableBinaryOptions%'  then 1 else 0 end)
FROM syscomments (NOLOCK)
WHERE (
		--Product
		text like '%Bull%fighting%' 
		Or text like '%lucky%' 
		Or text like '%poker%game%' 
		Or text like '%colossus%' 
		Or text like '%IMBC%Cricket%' 
		Or text like '%Microgaming%' 
		Or text like '%Myanmar%odd%'
		---
		Or text like '%Live%casino%' 
		Or text like '%bingo%' 
		Or text like '%p2P%' 
		Or text like '%RACING%'
		Or text like '%Horse%RACING%'

		--column
		OR text like '%maxpermatch151%'
		OR text like '%maxpermatch201%'
		OR text like '%DisableHorseRacing%'
		OR text like '%DisableFinancial%'
		OR text like '%DisableOpenTote%'
		OR text like '%maxpermatch151_OT%'
		OR text like '%DisableBingo%'
		OR text like '%SyncBingo%'
		OR text like '%MaxPerMatch151_AU%'
		OR text like '%MaxPerMatch152_UK%'
		OR text like '%MaxPerMatch152_AU%'
		OR text like '%MaxPerMatch153_AU%'
		OR text like '%Disable151_AU%'
		OR text like '%Disable152_UK%'
		OR text like '%Disable152_AU%'
		OR text like '%Disable153_AU%'
		OR text like '%MaxtransferP2P%'
		OR text like '%IsAutoResetP2P%'
		OR text like '%DisableP2P%'
		OR text like '%DisableFunP2P%'
		OR text like '%DisableLiveCasino%'
		OR text like '%SyncLiveCasino%'
		OR text like '%DisableVirtualSports%'
		OR text like '%HideVirtualSports%'
		OR text like '%maxpermatch180%'
		OR text like '%isAutoResetLiveCasino%'
		OR text like '%MaxWinLiveCasino%'
		OR text like '%maxpermatch186%'
		OR text like '%maxpermatch181%'
		OR text like '%maxpermatch182%'
		OR text like '%DisableCasinoBonus%'
		OR text like '%maxpermatch184%'
		OR text like '%DisableHRFixedOdds%'
		OR text like '%maxpermatch154%'
		OR text like '%maxpermatch183%'
		OR text like '%maxpermatch185%'
		OR text like '%MaxPerMatch44%'
		OR text like '%DisableMicrogameLC%'
		OR text like '%DisableMicrogameRNG%'
		OR text like '%DisableBinaryOptions%'
		)
		AND OBJECT_NAME(id)  not like '%_UAT%'
		AND OBJECT_NAME(id)  not like '%_xpre%'
		AND OBJECT_NAME(id)  not like '%_xtest%'
		AND OBJECT_NAME(id)  not like '%_MO'
		AND OBJECT_NAME(id)  not like '%Elodie%'
		AND OBJECT_NAME(id)  not like '%Helen%'
		AND OBJECT_NAME(id)  not like '%Eden%'
		AND OBJECT_NAME(id)  not like '%testing%'
		AND OBJECT_NAME(id)  not like '%Vicky%'
		AND OBJECT_NAME(id)  not like '%test%'
		AND OBJECT_NAME(id)  not like '%_VK'
GROUP BY  OBJECT_NAME(id)
ORDER BY  OBJECT_NAME(id) 


