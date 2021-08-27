/*<info serverAlias="DBTXN-bodb02"></info>*/  
/*	
	Created: 20210827@Tina
	Task: Update isActive for table Sport_Bettype_Reference_VirtualRate [RedmineID: #154810]
	DB: DBTXN-bodb02
*/


UPDATE Sport_Bettype_Reference_VirtualRate WITH (ROWLOCK,UPDLOCK) SET isActive = 1 WHERE SportType = 50 AND isActive = 0 AND bettype IN (9434, 9435, 9436, 9437, 9438, 9439, 9442, 9443, 9446, 9447, 9449, 9450, 9452, 9453, 9454, 9455, 9460, 9461, 9527, 9528, 9530, 9532, 9533, 9604, 9605, 9607, 9608, 9609, 9610, 9611, 9612, 9613, 9614)


/*

SELECT *
FROM Sport_Bettype_Reference_VirtualRate S WITH (NOLOCK)
WHERE S.SportType = 50
	AND s.BetType IN (9434, 9435, 9436, 9437, 9438, 9439, 9442, 9443, 9446, 9447, 9449, 9450, 9452, 9453, 9454, 9455, 9460, 9461, 9527, 9528, 9530, 9532, 9533, 9604, 9605, 9607, 9608, 9609, 9610, 9611, 9612, 9613, 9614)

*/