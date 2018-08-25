/* mysql */
DROP TABLE IF EXISTS addresses;
CREATE TABLE IF NOT EXISTS addresses (
  id     INT AUTO_INCREMENT PRIMARY KEY,
  street VARCHAR(80),
  city   VARCHAR(40),
  state  VARCHAR(2),
  zip    INT(5),
  lat    FLOAT,  /* latitude */
  lng    FLOAT  /* longitude */
);

DELETE FROM addresses;

INSERT INTO addresses (street, city, state, zip)
  VALUES ("550 E Brokaw Rd", "San Jose", "CA", 95112);

INSERT INTO addresses (street, city, state, zip)
  VALUES ("1077 E Arques Ave", "Sunnyvale", "CA", 94085);
  
INSERT INTO addresses (street, city, state, zip)
  VALUES ("43800 Osgood Rd", "Fremont", "CA", 94539);

INSERT INTO addresses (street, city, state, zip)
  VALUES ("600 E Hamilton Ave", "Campbell", "CA", 95008);

INSERT INTO addresses (street, city, state, zip)
  VALUES ("340 Portage Ave", "Palo Alto", "CA", 94306);
