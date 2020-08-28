/*
	Created: Helen
	Date: 20200814
	Task: LAP - Offer commission to 3rd party products - Phase 2 - [Redmine: #139238]   
	DB: DBTXN/bodb02
	
	1.SEXY GAMING
	2.SpadeGaming
	3.Keno (non DCS)
	4.Lottery
	5.Virtual Sport
	6.Virtual Sport 2
	7.Table Game
*/
USE bodb02
GO
CREATE TABLE #temp_sportRef(sporttype SMALLINT, SportTypeRefComm SMALLINT,BetTypeRefComm INT, TableComm VARCHAR(50),StructureVerComm VARCHAR(10))
INSERT INTO #temp_sportRef (sporttype,SportTypeRefComm, BetTypeRefComm, TableComm,StructureVerComm )
VALUES (220,220,1021,'Dep_CustDiscountSetting_Member','DCS'),
(202,202,1501,'CustSettingGame','default'),
(243,243,3101,'Dep_CustDiscountSetting_Member','DCS'),
(247,247,4301,'Dep_CustDiscountSetting_Member','DCS'),
(222,222,4901,'Dep_CustDiscountSetting_Member','DCS'),
(180,180,1201,'Dep_CustDiscountSetting_Member','DCS'),
(190,190,2701,'Dep_CustDiscountSetting_Member','DCS')

UPDATE st
	SET SportTypeRefComm = tmp.SportTypeRefComm
	,BetTypeRefComm = tmp.BetTypeRefComm
	,TableComm = tmp.TableComm
	,StructureVerComm = tmp.StructureVerComm
FROM Sport_Bettype_Reference_Setting st	WITH (ROWLOCK)
	INNER JOIN #temp_sportRef tmp ON st.sporttype = tmp.sporttype
WHERE st.sporttype IN (220,202,243,247,222,180,190)
