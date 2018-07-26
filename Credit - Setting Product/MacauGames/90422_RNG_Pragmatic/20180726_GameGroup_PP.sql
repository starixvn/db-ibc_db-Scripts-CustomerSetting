 /*
	Created: Elodie
    Date: 20180726
    Task: setting for Pragmatic game
    DB:DBCust/CustDB
 */
 USE CustDB
 GO

INSERT INTO dbo.GameGroup
        ( GameGroupID ,
          RefSportType ,
          RefBetType ,
          GroupName ,
          IsDeposit
        )
VALUES  ( 6 , -- GameGroupID - int
          248 , -- RefSportType - smallint
          4101 , -- RefBetType - int
          N'Level 1' , -- GroupName - nvarchar(100)
          0  -- IsDeposit - bit
        )

INSERT INTO dbo.GameGroup
        ( GameGroupID ,
          RefSportType ,
          RefBetType ,
          GroupName ,
          IsDeposit
        )
VALUES  ( 7 , -- GameGroupID - int
          248 , -- RefSportType - smallint
          4101 , -- RefBetType - int
          N'Level 2' , -- GroupName - nvarchar(100)
          0  -- IsDeposit - bit
        )