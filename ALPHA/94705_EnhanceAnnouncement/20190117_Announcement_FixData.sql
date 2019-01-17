/*
	Created: 20190117@Elodie
	Task: Insert data MsgCustReadStatus
	DB: DB05BK1/bodb_Message

*/
USE bodb_Message

INSERT INTO MsgCustReadStatus (CustID, SubAccID, LastSeenNormalMsg, LastSeenPersonalMsg, LastSeenSpecialMsg, LastSeenSystemUpdMsg)
SELECT ci.CustID, SubAccID, cs.createdate, cs.createdate, cs.createdate, cs.createdate
FROM bodb02.dbo.Custinfo ci WITH (NOLOCK)
	INNER JOIN bodb02.dbo.custSub cs WITH (NOLOCK) ON cs.custid = ci.custid
WHERE cs.username IN (	'SD6S0404Sub01','SD6S0404Sub02','TVA1HTM0HSub05','TVA1HTM0HSub06','DTC8880GSub01','TVA1HTM0HSub04','PYY0C4SSub01',
					'PYY0C4SSub02','PYY0C4SSub03','SUPERTESTGR01Sub05','SUPERTESTPA1Sub01','SUPERTESTSHI701Sub02','PYY0C4SSub05',
					'PYY0C4SSub00','SUPERTESTTE1001Sub03','SUPERTESTSHI701Sub03','PYY0C4SSub11','SUPERTESTTE010A01Sub04','SUPERTEST91S01Sub01')
