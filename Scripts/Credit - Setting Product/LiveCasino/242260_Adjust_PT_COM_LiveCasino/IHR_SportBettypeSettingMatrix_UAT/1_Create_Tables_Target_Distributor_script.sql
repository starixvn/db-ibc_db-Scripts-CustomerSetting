/*<info serverAlias="IRS_DBTP-bodb02,DBCustRepl-ReplCustDB,IRS_DBAGE-bodb02,IRS_DBBOF-bodb02,IRS_DBACC-bodb02,IRS_DBSIG-CustDB,IRS_DBCTG-CustDB"></info>*/
/*
  Created: 20251027@Eden
  Task: In-House setup by GitHub Copilot
  DB: IRS_DBTP-bodb02,DBCustRepl-ReplCustDB,IRS_DBAGE-bodb02,IRS_DBBOF-bodb02,IRS_DBACC-bodb02,IRS_DBSIG-CustDB,IRS_DBCTG-CustDB
  
  Revisions:
    - 20251027@Eden: Initial [RedmineID: #242260]
    
*/
-- Create table SportBettypeSettingMatrix_UAT on Distributor
CREATE TABLE [dbo].[SportBettypeSettingMatrix_UAT] (
    [BetType] int NOT NULL,
    [SportType] smallint NOT NULL,
    [isLicensee] bit NOT NULL,
    [isLive] bit NOT NULL,
    [Site] varchar(50) NOT NULL,
    [isActive] bit NOT NULL,
    [SportTypeRefPT] smallint NULL,
    [BetTypeRefPT] int NULL,
    [isLivePT] bit NOT NULL,
    [TablePT] varchar(50) NULL,
    [SportTypeRefComm] smallint NULL,
    [BetTypeRefComm] int NULL,
    [TableComm] varchar(50) NULL,
    [SportTypeRefBetSetting] smallint NULL,
    [BetTypeRefBetSetting] int NULL,
    [TableBetSetting] varchar(50) NULL,
    [IsLiveComm] bit NOT NULL,
    [IsLiveBetSetting] bit NOT NULL,
    [TableBettrans] varchar(100) NULL,
    [SporttypeRefWinlossLimit] smallint NULL,
    [BettypeRefWinlossLimit] smallint NULL,
    [RealProductId] tinyint NULL,
    [isDeleted] bit NULL,
    [RepUpdateTime] datetime2 NULL,
    [ProductID] tinyint NULL,
    CONSTRAINT [PK_SportBettypeSettingMatrix_UAT] PRIMARY KEY ([BetType],[SportType],[isLicensee],[isLive],[Site])
);
-- No identity column, skip GRANT ALTER
