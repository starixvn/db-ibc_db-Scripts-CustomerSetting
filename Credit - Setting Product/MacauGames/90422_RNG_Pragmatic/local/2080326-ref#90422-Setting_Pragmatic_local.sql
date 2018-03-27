/*
    Created: Vicky
    Date: 20180326
    Task: setting for Pragmatic game [RedmineID: 90422]
    DB:DBTXN/bodb02
*/

DECLARE @var_sportType SMALLINT = 248,
        @var_bettype SMALLINT = 4101
        
INSERT INTO Products (ProductID, ProductName, ProductPrefix, [Enabled])
VALUES(32, 'PP', 'PP', 1)

INSERT INTO Sports(SportType, SportName)
VALUES(@var_sportType, 'PP')

INSERT INTO Bettype (typeid, typenamee)
VALUES(4101, '888 Dragons™'),
      (4102, 'Triple Tigers™'),
      (4103, 'Diamonds are Forever 3 Lines'),
      (4104, 'Gold Train™'),
      (4105, '888 Gold™'),
      (4106, '7 Piggies™'),
      (4107, '7 Monkeys'),
      (4108, 'Monkey Madness™'),
      (4109, 'Diamond Strike™'),
      (4110, 'Fairytale Fortune™'),
      (4111, '8 Dragons™'),
      (4112, 'Lady Godiva'),
      (4113, 'Journey to the West'),
      (4114, 'Wolf Gold™'),
      (4115, 'Dragon Kingdom'),
      (4116, 'Hot Safari'),
      (4117, '3 Kingdoms - Battle of Red Cliffs'),
      (4118, 'Chilli Heat'),
      (4119, 'Caishen’s Gold™'),
      (4120, 'Pixie Wings™')

     