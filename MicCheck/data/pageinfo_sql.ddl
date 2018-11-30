DROP TABLE PurchasedProduct;
DROP TABLE Purchase;
DROP TABLE Instrument;
DROP TABLE Customers;
DROP TABLE Seller;

CREATE TABLE Customers (
	email			VARCHAR(30) NOT NULL,	
	password		VARCHAR(30) NOT NULL,
	name			VARCHAR(50) NOT NULL,
	shipStreet		VARCHAR(50) NOT NULL,
	shipCity		VARCHAR(20) NOT NULL,
	shipProvince	VARCHAR(2) NOT NULL,		
	billingStreet	VARCHAR(50) NOT NULL,
	billingCity		VARCHAR(20) NOT NULL,
	billingProvince	VARCHAR(2) NOT NULL,
	PRIMARY KEY (email)
);

CREATE TABLE Seller (
	sID			INT NOT NULL,
	name		VARCHAR(30) NOT NULL,
	street  	VARCHAR(30) NOT NULL,
	city		VARCHAR(20) NOT NULL,
	province	VARCHAR(20) NOT NULL,
	rating		DECIMAL(3,2),
	PRIMARY KEY (sID)
);

CREATE TABLE Instrument (
	pID			INT NOT NULL,	
	sID			INT,
	title		VARCHAR(50) NOT NULL,
	description	VARCHAR(1000),
	category	VARCHAR(15),
	price		DECIMAL(9,2) NOT NULL,
	condition	INT,
	brand		VARCHAR(20) NOT NULL,
	year		INT,
	tags		VARCHAR(200),
	PRIMARY KEY (pID),
	CONSTRAINT FK_Instrument_Seller FOREIGN KEY (sID) REFERENCES Seller (sID)
);

CREATE TABLE Purchase (
	orderNum		INT NOT NULL IDENTITY PRIMARY KEY,
	totalPrice		DECIMAL(9,2),
	expectedTime	DATE,
	dateOrdered		DATE,
	email			VARCHAR(30),
	CONSTRAINT FK_Purchase_Customers FOREIGN KEY (email) REFERENCES Customers (email)
);

CREATE TABLE PurchasedProduct (
	orderNum		INT NOT NULL,
	pID				INT NOT NULL,
	quantity		INT,
	price			DECIMAL(9,2) NOT NULL,			
	PRIMARY KEY (orderNum, pID),
	CONSTRAINT FK_PurchasedProduct_Purchase FOREIGN KEY (orderNum) REFERENCES Purchase (orderNum),
	CONSTRAINT FK_PurchasedProduct_Instrument FOREIGN KEY (pID) REFERENCES Instrument (pID)
);

INSERT INTO Seller VALUES (1, 'Rothery Vintage Electrics', '774 Middle of Knowhere', 'Victoria', 'BC', 4.5);
INSERT INTO Seller VALUES (2, 'The Trianglular Post', '4231 Triangle Street', 'Bermuda Triangle', 'Bermuda', 3.14);
INSERT INTO Seller VALUES (3, 'Axe Music', '4116 Macleod Trail', 'Calgary', 'AB', 2.4);
INSERT INTO Seller VALUES (4, 'Ye Ole Used Band Store', '87 Negan Road', 'Gravenhurst', 'ON', 3.2);
INSERT INTO Seller VALUES (5, 'Luthier on the Roof', '324 Whitmont Avenue', 'Abernath', 'MB', 4.8);
INSERT INTO Seller VALUES (6, 'Float & Walsh', '16324 Monty Street', 'Testing', 'NS', 3.9);
INSERT INTO Seller VALUES (7, 'Serenity of Toland', '111 Troy Road', 'Regina', 'SK', 3.5);

INSERT Instrument VALUES (1, 1, 'Fender Stratocaster Deluxe', 'Lightly used vintage guitar with original hardware', 'Guitar', 2999.99, 0, 'Fender', 1993, null);
INSERT Instrument VALUES (2, 2, 'Triangle', 'The best instrument ever made. The triangle', 'Percussion', 89.99, 1, 'Triangle Co.', 2010, 'Triangle');
INSERT Instrument VALUES (3, 1, 'Gibson Banjo', 'Vintage banjo used in the film, Deliverance', 'Guitar', 9999.99, 0, 'Gibson', 1969, 'Vintage, Gibson, Banjo, Used');
INSERT Instrument VALUES (4, 4, 'Yamaha Drum Set', 'Drum kit used for high school jazz band. Recently changed the drum heads.', 'Percussion', 1599.99, 0, 'Yamaha', 2001, 'Band, Drum kit, Jazz');
INSERT Instrument VALUES (5, 3, 'Jackson PRO SERIES DINKY', 'Awesome looking Jackson Dinky with a beautiful chlorine burst maple top', 'Guitar', 1360.53, 1, 'Jackson', 2018, 'Blue, Jackson, Dinky, Pro');
INSERT Instrument VALUES (6, 4, 'Squir Mustang Bass', 'Good entry level bass', 'Bass', 599.99, 0, 'Squir', 2016, 'Red, Beginner, 4-string');
INSERT Instrument VALUES (7, 6, 'Seagull S6 Original', 'Stunning award-winning S6 Original series. Cedar top and a silver leaf maple neck', 'Guitar', 699.99, 1, 'Seagull', 2018, 'Acoustic, Canadian');
INSERT Instrument VALUES (8, 4, 'Yamaha YTR-200ad Trumpet', 'Comes with a hard case and cleaning kit. Lightly used.', 'Brass', 580.25, 0, 'Yamaha', 2006, 'Band used, Yamaha, Jazz, Trumpet, Brass');
INSERT Instrument VALUES (9, 2, 'Silver Triangle', 'Almost better than the other triangle, but not really', 'Percussion', 90.00, 1, 'Triangle Co.', 2010, 'Triangle, Awesome, Percussion');
INSERT Instrument VALUES (10, 2, 'Triangle Triangle', 'Twice the triangle, twice the awesomeness', 'Percussion', 90.01, 0, 'Triangle Co.', 2011, 'Triangle, Amazing, Percussion');
INSERT Instrument VALUES (11, 3, 'Schecter Hellraiser C-1', 'The best-selling guitar made by Schecter. An awesome guitar for any shredder out there.', 'Guitar', 1179.99, 1, 'Schecter', 2017, 'Shredder, Black, Schecter');
INSERT Instrument VALUES (12, 6, 'Martin & Co. D-35E', 'Top of the line dreadnought style acoustic with spruce top and rosewood fretboard', 'Guitar', 3999.00, 1, 'Martin & Co.', 2018, 'Acoustic, Martin & Co., Spruce');
INSERT Instrument VALUES (13, 1, 'Gibson Custom Shop Slash Les Paul Standard', 'Very special instrument with a beautiful tobacco burst maple top signed by Slash', 'Guitar', 16704.95, 0, 'Gibson', 1958, 'Custom, Electric, Gibson, Vintage');
INSERT Instrument VALUES (14, 5, 'Ernst Heinrich Roth Stradivarius', 'A fine authentic branded Ernst Heinrich Roth Violin Stradivarius copy 1700 cremona.', 'Strings', 3415.15, 0, 'Ernest Heinrich Roth', 1959, 'Replica, Violin');
INSERT Instrument VALUES (15, 7, 'Korg EK-50', '61 key keyboard, touch sensitive keys with over 700 sounds', 'Keyboard', 569.99, 1, 'Korg', 2016, 'Keyboard, ');
INSERT Instrument VALUES (16, 5, 'Gigantau Octobass', 'Vintage octobass, requires two people to play. Also requires elephant style shipment crate', 'Strings', 35000.00, 0, 'Gigantau', 1912, 'Giant, Bass, Violin, Strings');
INSERT Instrument VALUES (17, 1, '1962 Fender Jazz Bass Sunburst', 'Fantastic original Fender Jazz bass with all original hardware. Relic condition with minor use.', 'Bass', 12317.80, 0, 'Fender', 1962, 'Vintage, Fender, Bass, Sunburst');
INSERT Instrument VALUES (18, 7, 'Roland HP605 Electric Piano', 'Classic Roland quality with new age technology. Quality build with stunning sound quality', 'Keyboard', 2654.99, 1, 'Roland', 2014, 'Roland, Piano, Keyboard, Baby-grand');
INSERT Instrument VALUES (19, 4, 'Yamaha YTS-62 Tenor Saxophone', 'Made in Japan, very good condition, ready to play', 'Woodwind', 3745.65, 0, 'Yamaha', '1992', 'Yamaha, Saxophone, Japan');
INSERT Instrument VALUES (20, 3, 'Paul Reed Smith Custom 24 Yellow Tiger', 'Brand new Paul Reed Smith Custom 24 with a beautiful flamed maple top', 'Guitar', 5755.64, 1, 'Paul Reed Smith', 2018, 'New, PRS, Paul Reed Smith, Yellow, Custom');
INSERT Instrument VALUES (21, 6, 'Gretsch Renown Maple Drum Set White Marine Pearl', 'Gretsch Renown Drum Set. Maple kit. 22" x 18" Bass Drum, 16" x 16" Floor Tom, 12" x 10" & 10" x 7" Rack Toms, 14" x 6.5" Snare', 'Percussion', 1859.45, 1, 'Gretsch', 2016, 'Renown, Drum Kit, Maple');
INSERT Instrument VALUES (22, 5, 'Yamaha Ybb641', 'Good condition tuba. There are some slight scratches and a few dents. Comes with mouthpiece and hard case', 'Brass', 5412.34, 0, 'Yamaha', 2002, 'Tuba, Yamaha, Brass');
INSERT Instrument VALUES (23, 3, 'Warwick Rockbass Corvette 4 Nirvana Black', 'A fantastic choice if you are looking for Warwick quality in an affordable package.', 'Bass', 1167.89, 1, 'Warwick', 2015, 'Warwick, Black, Corvette, 4-string, Passive');
INSERT Instrument VALUES (24, 7, 'Hammond B3000', 'Hammond organ in excellent condition', 'Keyboard', 4573.84, 0, 'Hammond', 1975, 'Organ, Vintage');
INSERT Instrument VALUES (25, 2, 'Rare Triangle', 'An instrument of pure chaos. This fabled instrument is known to stir monsters and trick the poor into river dancing', 'Percussion', 2999999.99, null, 'UNKNOWN', null, 'Unholy, Triangle, Death');

INSERT INTO Customers VALUES ('thisisanemail@something.com', 'psswrd123', 'T. Tenison', '54 Dentry Hill Road', 'Calgary', 'AB', '54 Dentry Hill Road', 'Calgary', 'AB');
INSERT INTO Customers VALUES ('chuckthehunk@gugmit.com', 'xyz456', 'G. Heather', '177 Dilbert Avenue', 'Vancouver', 'BC', '177 Dilbert Avenue', 'Vancouver', 'BC');
INSERT INTO Customers VALUES ('mylastattempt59@giveup.com', 'whocares2323', 'A. Rutherford', '23 Hucabee Delta Road', 'Kingston', 'ON', '154 Barlow Avenue', 'Edmonton', 'AB');
INSERT INTO Customers VALUES ('okayonemore345@something.com', 'imtryingagain', 'B. Breton', '454 Coudvere Street', 'Winnipeg', 'MB', '15134 Scanto Reeve Drive', 'Montreal', 'QC');

