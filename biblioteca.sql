DROP TABLE IF EXISTS imprumut;
DROP TABLE IF EXISTS scrie;
DROP TABLE IF EXISTS editie;
DROP TABLE IF EXISTS cititor;
DROP TABLE IF EXISTS autor;
DROP TABLE IF EXISTS carte;
DROP TABLE IF EXISTS sectiune;
DROP TABLE IF EXISTS bibliotecar;
DROP TABLE IF EXISTS editura;
DROP TABLE IF EXISTS locatie;

CREATE TABLE Bibliotecar(
	ID_Bibliotecar INT,
    Nume VARCHAR(20) NOT NULL,
    Prenume VARCHAR(40) NOT NULL,
    Data_angajare DATE NOT NULL,
    CONSTRAINT PK_Bibliotecar PRIMARY KEY(ID_Bibliotecar)
);

CREATE TABLE Sectiune(
	Gen_literar VARCHAR(20),
    Nr_rafturi INT,
    ID_Bibliotecar INT,
    CONSTRAINT PK_Sectiune PRIMARY KEY(Gen_literar),
    CONSTRAINT FK_Sectiune_Bibliotecar FOREIGN KEY(ID_Bibliotecar) REFERENCES bibliotecar(ID_Bibliotecar) ON DELETE SET NULL,
    CONSTRAINT CHK_Sectiune_Nr_rafturi_Poz CHECK (Nr_rafturi>0)
);

CREATE TABLE Carte(
	ID_Carte INT,
    Titlu VARCHAR(50) NOT NULL,
    ISBN BIGINT,
    Nr_pagini INT,
    Gen_literar VARCHAR(20),
    CONSTRAINT PK_Carte PRIMARY KEY(ID_Carte),
    CONSTRAINT FK_Carte_Sectiune FOREIGN KEY(Gen_literar) REFERENCES sectiune(Gen_literar) ON DELETE SET NULL, 
    CONSTRAINT CHK_Carte_Nr_pagini_Poz CHECK (Nr_pagini>0)
);

CREATE TABLE Cititor(
	ID_Cititor INT,
    Nume VARCHAR(20) NOT NULL,
    Prenume VARCHAR(40) NOT NULL,
    Nr_telefon VARCHAR(12),
    CONSTRAINT PK_Cititor PRIMARY KEY(ID_Cititor)
);

CREATE TABLE Imprumut(
	ID_Carte INT,
    ID_Cititor INT,
    CONSTRAINT CPK_Imprumut PRIMARY KEY(ID_Carte,ID_Cititor),
    CONSTRAINT FK_Imprumut_Carte FOREIGN KEY(ID_Carte) REFERENCES carte(ID_Carte) ON DELETE CASCADE,
    CONSTRAINT FK_Imprumut_Cititor FOREIGN KEY(ID_Cititor) REFERENCES cititor(ID_Cititor) ON DELETE CASCADE
);

CREATE TABLE Autor(
	ID_Autor INT,
    Nume VARCHAR(20) NOT NULL,
    Prenume VARCHAR(40) NOT NULL,
    Data_nastere DATE,
    Tara_origine VARCHAR(40),
    CONSTRAINT PK_Autor PRIMARY KEY(ID_Autor)
);

CREATE TABLE Scrie(
	ID_Carte INT,
    ID_Autor INT,
    CONSTRAINT CPK_Scrie PRIMARY KEY(ID_Carte,ID_Autor),
    CONSTRAINT FK_Scrie_Carte FOREIGN KEY(ID_Carte) REFERENCES carte(ID_Carte) ON DELETE CASCADE,
    CONSTRAINT FK_Scrie_Autor FOREIGN KEY(ID_Autor) REFERENCES autor(ID_Autor) ON DELETE CASCADE
);

CREATE TABLE Locatie(
	ID_Locatie INT,
    Tara VARCHAR(40) NOT NULL,
    Oras VARCHAR(40) NOT NULL,
    Judet VARCHAR(30),
    Strada VARCHAR(50),
    Numar VARCHAR(5),
    CONSTRAINT PK_Locatie PRIMARY KEY(ID_Locatie)
);

CREATE TABLE Editura(
	ID_Editura INT,
    Nume VARCHAR(50) NOT NULL,
    ID_Locatie INT NOT NULL,
    CONSTRAINT PK_Editura PRIMARY KEY(ID_Editura),
    CONSTRAINT FK_Editura_Locatie FOREIGN KEY(ID_Locatie) REFERENCES locatie(ID_Locatie) ON DELETE CASCADE
);

CREATE TABLE Editie(
	ID_Carte INT,
    ID_Editura INT,
    An_aparitie INT,
    CONSTRAINT CPK_Editie PRIMARY KEY(ID_Carte,ID_Editura,An_aparitie),
    CONSTRAINT FK_Editie_Carte FOREIGN KEY(ID_Carte) REFERENCES carte(ID_Carte) ON DELETE CASCADE,
    CONSTRAINT FK_Editie_Editura FOREIGN KEY(ID_Editura) REFERENCES editura(ID_Editura) ON DELETE CASCADE
);

INSERT INTO Bibliotecar VALUES(1, 'Estera', 'Constantin', '2014-03-28');
INSERT INTO Bibliotecar VALUES(2, 'Ilinca', 'Petrescu', '2006-07-04');
INSERT INTO Bibliotecar VALUES(3, 'Miron', 'Albert', '2020-11-15');
INSERT INTO Bibliotecar VALUES(4, 'Stelian', 'Iliescu', '2008-05-19');
INSERT INTO Bibliotecar VALUES(5, 'Damian', 'Negrescu', '1999-06-01');
INSERT INTO Bibliotecar VALUES(6, 'Theodor', 'Matei', '2018-04-04');
INSERT INTO Bibliotecar VALUES(7, 'Emanuela', 'Funar', '2004-09-12');
INSERT INTO Bibliotecar VALUES(8, 'Stelian', 'Iliescu', '2000-05-19');

INSERT INTO Sectiune VALUES('Crimă, Mister', 10, 1);
INSERT INTO Sectiune VALUES('Thriller, Horror', 15, 2);
INSERT INTO Sectiune VALUES('Aventura', 30, 3);
INSERT INTO Sectiune VALUES('Science Fiction', 25, 4);
INSERT INTO Sectiune VALUES('Fantasy', 20, 5);
INSERT INTO Sectiune VALUES('Romance', 8, 6);
INSERT INTO Sectiune VALUES('Istorie', 23, 7);
INSERT INTO Sectiune VALUES('Biografie', 12, 8);
INSERT INTO Sectiune VALUES('Jurnalism', 10, 6);
INSERT INTO Sectiune VALUES('Filosofie', 5, null);

INSERT INTO Carte VALUES(1, 'Moarte printre nori', 9786063380464, 320, 'Crimă, Mister');
INSERT INTO Carte VALUES(2, 'Crima din Orient Express', 9786063375477, 288, 'Crimă, Mister');
INSERT INTO Carte VALUES(3, 'Memoriile lui Sherlock Holmes', 9786063378836, 400, 'Crimă, Mister');
INSERT INTO Carte VALUES(4, 'O minciună perfectă', 9786063373909, 368, 'Crimă, Mister');
INSERT INTO Carte VALUES(5, 'IT', 9781473666931, 1392, 'Thriller, Horror');
INSERT INTO Carte VALUES(6, 'Jocul', 9786063378935, 432, 'Thriller, Horror');
INSERT INTO Carte VALUES(7, 'Povestea lui Lisey', 9786064311801, 608, 'Thriller, Horror');
INSERT INTO Carte VALUES(8, 'Billy Summers', 9786064312204, 608, 'Thriller, Horror');
INSERT INTO Carte VALUES(9, 'În siguranță', 9786069682371, 384, 'Thriller, Horror');
INSERT INTO Carte VALUES(10, 'Aventurile lui Tom Sawyer', 9789975545778, 260, 'Aventura');
INSERT INTO Carte VALUES(11, 'Robinson Crusoe', 9789975545747, 276, 'Aventura');
INSERT INTO Carte VALUES(12, 'Fundația', 9786069000724, 264, 'Science Fiction');
INSERT INTO Carte VALUES(13, 'Jocul lui Ender', 9786064311948, 352, 'Science Fiction');
INSERT INTO Carte VALUES(14, 'Metro 2035', 9786069000915, 608, 'Science Fiction');
INSERT INTO Carte VALUES(15, 'The Hobbit', 9780261102217, 285, 'Fantasy');
INSERT INTO Carte VALUES(16, 'Harry Potter și Camera Secretelor', 9786060861324, 400, 'Fantasy');
INSERT INTO Carte VALUES(17, 'Harry Potter și Piatra Filosofala', 9786060861317, 223, 'Fantasy');
INSERT INTO Carte VALUES(18, 'Harry Potter și Pocalul de Foc', 9786060862338, 721, 'Fantasy');
INSERT INTO Carte VALUES(19, 'Twilight', 9781904233657, 464, 'Romance');
INSERT INTO Carte VALUES(20, 'Monarhiile secolului XXI', 9786065885288, 324, 'Istorie');
INSERT INTO Carte VALUES(21, 'Palatul Elena Kretzulescu', 9786060810797, 184, 'Istorie');
INSERT INTO Carte VALUES(22, 'O fi bun de ceva?', 9786069801505, 448, 'Biografie');
INSERT INTO Carte VALUES(23, 'Jurnal', 9786069783726, 800, 'Biografie');
INSERT INTO Carte VALUES(24, 'Utopia', 9786068395920, 152, 'Filosofie');

INSERT INTO Autor VALUES(10, 'Twain', 'Mark', '1910-04-21', 'S.U.A.');
INSERT INTO Autor VALUES(11, 'Christie', 'Agatha', '1890-09-15', 'Regatul Unit');
INSERT INTO Autor VALUES(12, 'Doyle', 'Arthur Conan', '1859-07-07', 'Regatul Unit');
INSERT INTO Autor VALUES(13, 'Swanson', 'Peter', '1968-05-26', 'S.U.A.');
INSERT INTO Autor VALUES(14, 'King', 'Stephen', '1947-09-21', 'S.U.A.');
INSERT INTO Autor VALUES(15, 'le Carre', 'John', '1931-10-19', 'Regatul Unit');
INSERT INTO Autor VALUES(16, 'Barnett', 'S.K.', null, null);
INSERT INTO Autor VALUES(17, 'Defoe', 'Daniel', null, 'Regatul Unit');
INSERT INTO Autor VALUES(18, 'Asimov', 'Isaac', '1920-01-02', 'Rusia');
INSERT INTO Autor VALUES(19, 'Card', 'Orson Scott', '1951-08-24', 'S.U.A.');
INSERT INTO Autor VALUES(20, 'Glukhovsky', 'Dmitry', '1979-06-12', 'Rusia');
INSERT INTO Autor VALUES(21, 'Tolkien', 'J. R. R.', '1973-09-02', 'Regatul Unit');
INSERT INTO Autor VALUES(22, 'Rowling', 'J. K.', '1965-07-31', 'Regatul Unit');
INSERT INTO Autor VALUES(23, 'Meyer', 'Stephenie', '1973-12-24', 'S.U.A.');
INSERT INTO Autor VALUES(24, 'Vlad', 'Ioan-Luca', null, 'România');
INSERT INTO Autor VALUES(25, 'Gâtejeanu-Gheorghe', 'Sandra', null, 'România');
INSERT INTO Autor VALUES(26, 'Mucenic', 'Cezara', null, 'România');
INSERT INTO Autor VALUES(27, 'Velescu', 'Oliver', null, 'România');
INSERT INTO Autor VALUES(28, 'Seinfeld', 'Jerry', '1954-04-29', 'S.U.A.');
INSERT INTO Autor VALUES(29, 'Kafka', 'Franz', '1883-06-03', 'Cehia');
INSERT INTO Autor VALUES(30, 'More', 'Thomas', '1478-02-07', 'Regatul Unit');

INSERT INTO Scrie VALUES(1, 11);
INSERT INTO Scrie VALUES(2, 11);
INSERT INTO Scrie VALUES(3, 12);
INSERT INTO Scrie VALUES(4, 13);
INSERT INTO Scrie VALUES(5, 14);
INSERT INTO Scrie VALUES(6, 15);
INSERT INTO Scrie VALUES(7, 14);
INSERT INTO Scrie VALUES(8, 14);
INSERT INTO Scrie VALUES(9, 16);
INSERT INTO Scrie VALUES(10, 10);
INSERT INTO Scrie VALUES(11, 17);
INSERT INTO Scrie VALUES(12, 18);
INSERT INTO Scrie VALUES(13, 19);
INSERT INTO Scrie VALUES(14, 20);
INSERT INTO Scrie VALUES(15, 21);
INSERT INTO Scrie VALUES(16, 22);
INSERT INTO Scrie VALUES(17, 22);
INSERT INTO Scrie VALUES(18, 22);
INSERT INTO Scrie VALUES(19, 23);
INSERT INTO Scrie VALUES(20, 24);
INSERT INTO Scrie VALUES(20, 25);
INSERT INTO Scrie VALUES(21, 26);
INSERT INTO Scrie VALUES(21, 27);
INSERT INTO Scrie VALUES(22, 28);
INSERT INTO Scrie VALUES(23, 29);
INSERT INTO Scrie VALUES(24, 30);

INSERT INTO Cititor VALUES(1, 'Traian', 'Apostol', '+40702032756');
INSERT INTO Cititor VALUES(2, 'Ardelean', 'Costache', '+40702015109');
INSERT INTO Cititor VALUES(3, 'Constantin', 'Remus', '+40702039282');
INSERT INTO Cititor VALUES(4, 'Albu', 'Dragoș', null);
INSERT INTO Cititor VALUES(5, 'Lupei', 'Teodora', null);
INSERT INTO Cititor VALUES(6, 'Radu', 'Carmen', '+40702005823');
INSERT INTO Cititor VALUES(7, 'Gheorghe', 'Clara', '+40710215288');
INSERT INTO Cititor VALUES(8, 'Petrescu', 'Casandra', null);
INSERT INTO Cititor VALUES(9, 'Albert', 'Iuliana', '+40702030837');

INSERT INTO Imprumut VALUES(12, 1);
INSERT INTO Imprumut VALUES(21, 2);
INSERT INTO Imprumut VALUES(14, 3);
INSERT INTO Imprumut VALUES(8, 4);
INSERT INTO Imprumut VALUES(12, 4);
INSERT INTO Imprumut VALUES(1, 5);
INSERT INTO Imprumut VALUES(24, 7);
INSERT INTO Imprumut VALUES(7, 7);
INSERT INTO Imprumut VALUES(16, 7);
INSERT INTO Imprumut VALUES(5, 8);
INSERT INTO Imprumut VALUES(2, 9);
INSERT INTO Imprumut VALUES(19, 9);

INSERT INTO Locatie VALUES(1, 'România', 'București', 'Sector 6', 'Str. Independenței', '319A');
INSERT INTO Locatie VALUES(2, 'România', 'București', 'Sector 1', 'Str. Iani Buzoiani', null);
INSERT INTO Locatie VALUES(3, 'Regatul Unit', 'Londra', null, 'Victoria Embankment', '50');
INSERT INTO Locatie VALUES(4, 'România', 'București', 'Sector 1', 'Str. Moeciu', '7A');
INSERT INTO Locatie VALUES(5, 'România', 'București', 'Sector 3', 'Bvd. Lacul Tei', '124');
INSERT INTO Locatie VALUES(6, 'România', 'București', 'Sector 1', 'Piața Presei Libere', '1');

INSERT INTO Editura VALUES(10, 'Vellant', 1);
INSERT INTO Editura VALUES(11, 'Nemira', 2);
INSERT INTO Editura VALUES(12, 'Hodder & Stoughton', 3);
INSERT INTO Editura VALUES(13, 'Litera', 4);
INSERT INTO Editura VALUES(14, 'Humanitas', 6);

INSERT INTO Editie VALUES(1, 10, 2004);
INSERT INTO Editie VALUES(1, 10, 2006);
INSERT INTO Editie VALUES(2, 10, 2010);
INSERT INTO Editie VALUES(3, 10, 2009);
INSERT INTO Editie VALUES(4, 10, 2002);
INSERT INTO Editie VALUES(5, 12, 2007);
INSERT INTO Editie VALUES(6, 11, 2016);
INSERT INTO Editie VALUES(6, 13, 2013);
INSERT INTO Editie VALUES(7, 11, 2012);
INSERT INTO Editie VALUES(8, 11, 2009);
INSERT INTO Editie VALUES(9, 11, 2020);
INSERT INTO Editie VALUES(10, 11, 2004);
INSERT INTO Editie VALUES(11, 11, 2018);
INSERT INTO Editie VALUES(12, 11, 2019);
INSERT INTO Editie VALUES(13, 11, 2017);
INSERT INTO Editie VALUES(14, 12, 2004);
INSERT INTO Editie VALUES(15, 12, 2004);
INSERT INTO Editie VALUES(16, 13, 2011);
INSERT INTO Editie VALUES(16, 10, 2009);
INSERT INTO Editie VALUES(16, 11, 2007);
INSERT INTO Editie VALUES(17, 13, 2012);
INSERT INTO Editie VALUES(18, 13, 2013);
INSERT INTO Editie VALUES(19, 12, 2006);
INSERT INTO Editie VALUES(20, 11, 2006);
INSERT INTO Editie VALUES(21, 11, 2019);
INSERT INTO Editie VALUES(22, 11, 2012);
INSERT INTO Editie VALUES(23, 11, 2013);
INSERT INTO Editie VALUES(24, 11, 2021);

COMMIT;