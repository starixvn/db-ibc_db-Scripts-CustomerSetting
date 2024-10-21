/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20241021@Johnson
	Task: Update Direct accounts [redmine: #211878]
	DB: DBCUST/CustDB
*/
--147628: mmrm
DELETE CustDirectAccount WITH(ROWLOCK)
WHERE custid IN (SELECT custid FROM custinfo WITH(NOLOCK)
				WHERE mrecommend = 147628
					AND roleid IN (2)
				)

DELETE Acc_CustDirect WITH(ROWLOCK)
WHERE custid = 147628
				
INSERT INTO CustDirectAccount(custid,Coll_Status)
SELECT 147628, 0 --mmrm		 	

--156390: mbrmb
DELETE CustDirectAccount WITH(ROWLOCK)
WHERE custid IN (SELECT custid FROM custinfo WITH(NOLOCK)
				WHERE mrecommend = 156390
					AND roleid IN (2)
				)
				
DELETE Acc_CustDirect WITH(ROWLOCK)
WHERE custid = 156390		

INSERT INTO CustDirectAccount(custid,Coll_Status)
SELECT 156390, 0 --mbrmb	

--156404	mbrup
DELETE CustDirectAccount WITH(ROWLOCK)
WHERE custid IN (SELECT custid FROM custinfo WITH(NOLOCK)
				WHERE mrecommend = 156404
					AND roleid IN (2)
				)	

DELETE Acc_CustDirect WITH(ROWLOCK)
WHERE custid = 156404		

INSERT INTO CustDirectAccount(custid,Coll_Status)
SELECT 156404, 0 --mbrup

--56395	midrup	
DELETE CustDirectAccount WITH(ROWLOCK)
WHERE custid IN (SELECT custid FROM custinfo WITH(NOLOCK)
				WHERE mrecommend = 56395
					AND roleid IN (2)
				)	

DELETE Acc_CustDirect WITH(ROWLOCK)
WHERE custid = 56395		

INSERT INTO CustDirectAccount(custid,Coll_Status)
SELECT 56395, 0 --midrup

--8619	billma
DELETE CustDirectAccount WITH(ROWLOCK)
WHERE custid IN (SELECT custid FROM custinfo WITH(NOLOCK)
				WHERE mrecommend = 8619
					AND roleid IN (2)
				)	

DELETE Acc_CustDirect WITH(ROWLOCK)
WHERE custid = 8619		

INSERT INTO CustDirectAccount(custid,Coll_Status)
SELECT 8619, 0 --billma

--4300	mbrm
DELETE CustDirectAccount WITH(ROWLOCK)
WHERE custid IN (SELECT custid FROM custinfo WITH(NOLOCK)
				WHERE mrecommend = 4300
					AND roleid IN (2)
				)	

DELETE Acc_CustDirect WITH(ROWLOCK)
WHERE custid = 4300		

INSERT INTO CustDirectAccount(custid,Coll_Status)
SELECT 4300, 0 --mbrm

--7199	exp
DELETE CustDirectAccount WITH(ROWLOCK)
WHERE custid IN (SELECT custid FROM custinfo WITH(NOLOCK)
				WHERE recommend = 7199
					AND roleid IN (1)
				)	

DELETE Acc_CustDirect WITH(ROWLOCK)
WHERE custid = 7199		

INSERT INTO CustDirectAccount(custid,Coll_Status)
SELECT 7199, 0 --exp

--1412	339BHK
DELETE CustDirectAccount WITH(ROWLOCK)
WHERE custid IN (SELECT custid FROM custinfo WITH(NOLOCK)
				WHERE recommend = 1412
					AND roleid IN (1)
				)	

DELETE Acc_CustDirect WITH(ROWLOCK)
WHERE custid = 1412		

INSERT INTO CustDirectAccount(custid,Coll_Status)
SELECT 1412, 0 --339BHK

--72928935	Mzhong
DELETE CustDirectAccount WITH(ROWLOCK)
WHERE custid IN (SELECT custid FROM custinfo WITH(NOLOCK)
				WHERE recommend = 72928935
					AND roleid IN (1)
				)	

DELETE Acc_CustDirect WITH(ROWLOCK)
WHERE custid = 72928935		

--134456	XYZRM
DELETE CustDirectAccount WITH(ROWLOCK)
WHERE custid IN (SELECT custid FROM custinfo WITH(NOLOCK)
				WHERE recommend = 134456
					AND roleid IN (1)
				)	

DELETE Acc_CustDirect WITH(ROWLOCK)
WHERE custid = 134456		

INSERT INTO CustDirectAccount(custid,Coll_Status)
SELECT 134456, 0 --XYZRM