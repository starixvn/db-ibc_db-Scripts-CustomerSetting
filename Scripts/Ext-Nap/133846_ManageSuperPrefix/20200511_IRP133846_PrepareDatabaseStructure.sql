/*
	Created: 20200511@Johnson
	Task: structure to  manage super's prefix on EXT-NAP
	DB: DBCUST/CustDB	
*/

CREATE TABLE [dbo].[Acc_SuperPrefix](	
	[GroupName] [varchar](50) NOT NULL,
	[Prefix] VARCHAR(10) NOT NULL,
	AllowNewSuper BIT 
 CONSTRAINT [PK_AccSuperPrefix] PRIMARY KEY NONCLUSTERED 
(
	[GroupName] ASC,
	[Prefix] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DATA]
) ON [DATA]
