/*<info serverAlias="DBCTG-bodb02"></info>*/
/*
	Creator: 20240516@Tacy
	Task: Drop unused SP [Redmine: #202974]
		- NAP_PayoutPromotion_MatchSel
		- NAP_PayoutPromotion_VerfiySel
		- NAP_PayoutPromotion_Sel
	Database: DBCTG-bodb02
*/

USE bodb02
GO

--NAP_PayoutPromotion_MatchSel
IF EXISTS(SELECT 1 FROM sys.objects WHERE type = 'P' AND name = 'NAP_PayoutPromotion_MatchSel')
	DROP PROCEDURE NAP_PayoutPromotion_MatchSel 

IF EXISTS(SELECT 1 FROM sys.objects WHERE type = 'P' AND name = 'NAP_PayoutPromotion_MatchSel_xpre')
	DROP PROCEDURE NAP_PayoutPromotion_MatchSel_xpre 

--NAP_PayoutPromotion_VerfiySel
IF EXISTS(SELECT 1 FROM sys.objects WHERE type = 'P' AND name = 'NAP_PayoutPromotion_VerfiySel')
	DROP PROCEDURE NAP_PayoutPromotion_VerfiySel 

IF EXISTS(SELECT 1 FROM sys.objects WHERE type = 'P' AND name = 'NAP_PayoutPromotion_VerfiySel_xpre')
	DROP PROCEDURE NAP_PayoutPromotion_VerfiySel_xpre 

--NAP_PayoutPromotion_Sel
IF EXISTS(SELECT 1 FROM sys.objects WHERE type = 'P' AND name = 'NAP_PayoutPromotion_Sel')
	DROP PROCEDURE NAP_PayoutPromotion_Sel 

IF EXISTS(SELECT 1 FROM sys.objects WHERE type = 'P' AND name = 'NAP_PayoutPromotion_Sel_xpre')
	DROP PROCEDURE NAP_PayoutPromotion_Sel_xpre 
	