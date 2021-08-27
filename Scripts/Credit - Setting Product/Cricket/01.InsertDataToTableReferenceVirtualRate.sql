/*<info serverAlias="DBTXN-bodb02"></info>*/  
/*	
	Created: 20210827@Tina
	Task: Insert data to table Sport_Bettype_Reference_VirtualRate [RedmineID: #154810]
	DB: DBTXN-bodb02
*/

DECLARE @ReferenceVirtualRate TABLE (SportType SMALLINT, BetType SMALLINT, SportTypeRefVirtualRate SMALLINT, BetTypeRefVirtualRate SMALLINT, isActive BIT)

INSERT INTO @ReferenceVirtualRate (SportType, BetType, SportTypeRefVirtualRate, BetTypeRefVirtualRate, isActive)
VALUES
(50, 9434, 27, 20, 0),
(50, 9435, 27, 20, 0),
(50, 9436, 27, 20, 0),
(50, 9437, 27, 20, 0),
(50, 9438, 27, 20, 0),
(50, 9439, 27, 20, 0),
(50, 9442, 27, 20, 0),
(50, 9443, 27, 20, 0),
(50, 9446, 27, 3, 0),
(50, 9447, 27, 3, 0),
(50, 9449, 27, 3, 0),
(50, 9450, 27, 3, 0),
(50, 9452, 27, 3, 0),
(50, 9453, 27, 3, 0),
(50, 9454, 27, 3, 0),
(50, 9455, 27, 3, 0),
(50, 9460, 27, 3, 0),
(50, 9461, 27, 3, 0),
(50, 9527, 27, 2, 0),
(50, 9528, 27, 2, 0),
(50, 9530, 27, 2, 0),
(50, 9532, 27, 2, 0),
(50, 9533, 27, 2, 0),
(50, 9604, 27, 3, 0),
(50, 9605, 27, 2, 0),
(50, 9607, 27, 3, 0),
(50, 9608, 27, 3, 0),
(50, 9609, 27, 3, 0),
(50, 9610, 27, 3, 0),
(50, 9611, 27, 3, 0),
(50, 9612, 27, 3, 0),
(50, 9613, 27, 3, 0),
(50, 9614, 27, 3, 0)

INSERT INTO Sport_Bettype_Reference_VirtualRate(SportType, BetType, SportTypeRefVirtualRate, BetTypeRefVirtualRate, isActive)
SELECT VR.SportType, VR.BetType, VR.SportTypeRefVirtualRate, VR.BetTypeRefVirtualRate, VR.isActive
FROM @ReferenceVirtualRate VR 
	LEFT JOIN Sport_Bettype_Reference_VirtualRate S WITH (NOLOCK) ON VR.SportType = S.SportType AND VR.BetType = S.BetType
WHERE S.SportType IS NULL

/*

SELECT *
FROM Sport_Bettype_Reference_VirtualRate S WITH (NOLOCK)
WHERE S.SportType = 50
	AND s.BetType IN (9434, 9435, 9436, 9437, 9438, 9439, 9442, 9443, 9446, 9447, 9449, 9450, 9452, 9453, 9454, 9455, 9460, 9461, 9527, 9528, 9530, 9532, 9533, 9604, 9605, 9607, 9608, 9609, 9610, 9611, 9612, 9613, 9614)

*/
