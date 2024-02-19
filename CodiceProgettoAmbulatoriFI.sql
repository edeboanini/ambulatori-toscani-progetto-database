# GRUPPO FORMATO DA:	       
#Cognome:		Boanini         
#Nome:			Ede
########## CREAZIONE DATABASE 'ProgettoAmbulatoriFI' ##########

DROP DATABASE IF EXISTS ProgettoAmbulatoriFI;
CREATE DATABASE IF NOT EXISTS ProgettoAmbulatoriFI;
USE ProgettoAmbulatoriFI;

########################## CREAZIONE TABELLE ##########################

DROP TABLE IF EXISTS Ambulatorio;
CREATE TABLE IF NOT EXISTS Ambulatorio (
CodiceAmbulatorio CHAR(5) PRIMARY KEY,
Via VARCHAR(30),
Citta  VARCHAR(20),
CAP INT(5),
Provincia CHAR(2)
) ENGINE=INNODB;


DROP TABLE IF EXISTS Paziente;
CREATE TABLE IF NOT EXISTS Paziente (
CodiceFiscale CHAR(16) PRIMARY KEY,
Cognome VARCHAR(30),
Nome VARCHAR(20),
DataNascita DATE,
Indirizzo VARCHAR(40),
Telefono INT(9)
) ENGINE=INNODB;


DROP TABLE IF EXISTS SettoreSpecialistico;
CREATE TABLE IF NOT EXISTS SettoreSpecialistico (
IDSettore VARCHAR(10) PRIMARY KEY,
NomeSettore VARCHAR(350),
Descrizione VARCHAR(150)
) ENGINE=INNODB;


DROP TABLE IF EXISTS Farmaci;
CREATE TABLE IF NOT EXISTS Farmaci (
ATC CHAR(5) PRIMARY KEY,
Nome VARCHAR(50),
principio_attivo VARCHAR(150)
) ENGINE=INNODB;


DROP TABLE IF EXISTS Appartenenza;
CREATE TABLE IF NOT EXISTS Appartenenza (
CodAmbulatorio CHAR(5),
CodiceFiscalePaziente CHAR(16),
FOREIGN KEY (CodAmbulatorio) REFERENCES Ambulatorio(CodiceAmbulatorio) ON UPDATE CASCADE,
FOREIGN KEY (CodiceFiscalePaziente) REFERENCES Paziente(CodiceFiscale) ON UPDATE CASCADE
) ENGINE=INNODB;


DROP TABLE IF EXISTS CartellaClinica;
CREATE TABLE IF NOT EXISTS CartellaClinica (
CodiceCartella VARCHAR(30) PRIMARY KEY,
CodiceFiscalePaziente CHAR(16),
Sesso CHAR(1),
Altezza FLOAT,
Peso FLOAT,
GruppoSanguigno VARCHAR(3),
Allergie BOOLEAN,
Fumatore CHAR(2),
FOREIGN KEY (CodiceFiscalePaziente) REFERENCES Paziente(CodiceFiscale) ON UPDATE CASCADE
) ENGINE=INNODB;

ALTER TABLE CartellaClinica MODIFY COLUMN Allergie CHAR(2);

DROP TABLE IF EXISTS Medico;
CREATE TABLE IF NOT EXISTS Medico (
CodiceInterno VARCHAR(10) PRIMARY KEY,
Cognome VARCHAR(30) NOT NULL,
Nome VARCHAR(20),
Telefono INT(9),
CodAmbulatorio CHAR(5) NOT NULL,
Specializzazione VARCHAR(10) NOT NULL,
FOREIGN KEY (CodAmbulatorio) REFERENCES Ambulatorio(CodiceAmbulatorio) ON UPDATE CASCADE,
FOREIGN KEY (Specializzazione) REFERENCES SettoreSpecialistico(IDSettore) ON UPDATE CASCADE
) ENGINE=INNODB;

DROP TABLE IF EXISTS Visita;
CREATE TABLE IF NOT EXISTS Visita (
ID_Visita VARCHAR(10) PRIMARY KEY,
DataVisita DATE NOT NULL,
OraVisita TIME,
CodiceFiscalePaziente CHAR(16) NOT NULL,
CodiceInternoMedico VARCHAR(10) NOT NULL,
FOREIGN KEY (CodiceFiscalePaziente) REFERENCES Paziente(CodiceFiscale) ON UPDATE CASCADE,
FOREIGN KEY (CodiceInternoMedico) REFERENCES Medico(CodiceInterno) ON UPDATE CASCADE
) ENGINE=INNODB;


DROP TABLE IF EXISTS Somministrazione;
CREATE TABLE IF NOT EXISTS Somministrazione (
CodiceCartellaClinica VARCHAR(30),
ATC_farmaco CHAR(5),
FOREIGN KEY (CodiceCartellaClinica) REFERENCES CartellaClinica(CodiceCartella) ON UPDATE CASCADE,
FOREIGN KEY (ATC_farmaco) REFERENCES Farmaci(ATC) ON UPDATE CASCADE
) ENGINE=INNODB;

############################# POPOLAMENTO TABELLE #############################################

INSERT INTO Ambulatorio VALUES
('AMB01', 'Via dei Neri 50', 'Firenze', '50122', 'FI'),
('AMB02', 'Via Ghibellina 5', 'Firenze', '50122', 'FI'),
('AMB03', 'Piazza Ludovico Muratori 40', 'Firenze', '50134', 'FI'),
('AMB04', 'Via dei Calzaioli 3', 'Firenze', '50122', 'FI'),
('AMB05', 'Via Faenza 1', 'Firenze', '50123', 'FI');


SHOW VARIABLES LIKE 'local_infile';
SET GLOBAL local_infile = true;
LOAD DATA LOCAL INFILE "Pazienti.txt" INTO TABLE Paziente		#inserire il proprio filepath
FIELDS TERMINATED BY ";"
LINES TERMINATED BY "\n"
IGNORE 1 ROWS;

INSERT INTO Paziente VALUES
("CF44456789000345", "Lombardi", "Federico", "1990-03-01", "Via Giustiniano 90", 655345678),
("CF22012345679901", "Giusti", "Elisabetta", "1992-08-01", "Via Cavour 4", 555678901),
("CF49678901234567", "Landini", "Francesca", "1980-04-06", "Corso Italia 1", 555668901),
("CF66432109876543", "Fermi", "Viola", "1991-11-02", "Viale Kennedy 8", 555673701),
("CF00901234567890", "Poldi", "Piero", "1999-04-01", "Via Mazzini 10", 555987901),
("CF87567890123456", "Pardi", "Matilda", "1984-05-12", "Via Dante 3", 544678901);



INSERT INTO SettoreSpecialistico VALUES
('CARDIO', 'Cardiologia', 'Diagnosi e trattamento delle malattie cardiache'),
('DERMA', 'Dermatologia', 'Specializzazione nei disturbi della pelle'),
('GINEC', 'Ginecologia', 'Specializzazione nella cura delle patologie femminili e della gravidanza'),
('NEURO', 'Neurologia', 'Trattamento delle malattie del sistema nervoso'),
('ORTHO', 'Ortopedia', 'Specializzazione nel trattamento dei disturbi muscolo-scheletrici');



INSERT INTO Farmaci VALUES
('A1234', 'Paracetamol', 'Acetaminophen'),
('B5678', 'Ibuprofen', 'Ibuprofen'),
('C9012', 'Amoxicillin', 'Amoxicillin'),
('D3456', 'Lisinopril', 'Lisinopril'),
('E7890', 'Simvastatin', 'Simvastatin'),
('F2345', 'Omeprazole', 'Omeprazole'),
('G6789', 'Metformin', 'Metformin'),
('H1235', 'Albuterol', 'Albuterol'),
('I5678', 'Fluoxetine', 'Fluoxetine'),
('J9012', 'Atorvastatin', 'Atorvastatin'),
('K3456', 'Losartan', 'Losartan'),
('L7890', 'Levothyroxine', 'Levothyroxine'),
('M2345', 'Aspirin', 'Acetylsalicylic Acid'),
('N6789', 'Metoprolol', 'Metoprolol'),
('O9012', 'Ciprofloxacin', 'Ciprofloxacin'),
('P3456', 'Ranitidine', 'Ranitidine'),
('Q7890', 'Amlodipine', 'Amlodipine'),
('R2345', 'Diazepam', 'Diazepam'),
('S6789', 'Warfarin', 'Warfarin'),
('T1235', 'Hydrochlorothiazide', 'Hydrochlorothiazide'),
('U5678', 'Prednisone', 'Prednisone'),
('V9012', 'Levofloxacin', 'Levofloxacin');


INSERT INTO Appartenenza VALUES
('AMB01', 'CF00901234567890'),
('AMB02', 'CF12345678901234'),
('AMB03', 'CF22012345679901'),
('AMB04', 'CF23456789012345'),
('AMB05', 'CF34567890123456'),
('AMB01', 'CF44456789000345'),
('AMB02', 'CF45678901234567'),
('AMB03', 'CF49678901234567'),
('AMB04', 'CF56789012345678'),
('AMB05', 'CF65432109876543'),
('AMB01', 'CF66432109876543'),
('AMB02', 'CF78901234567890'),
('AMB03', 'CF87567890123456'),
('AMB04', 'CF89012345678901'),
('AMB03', 'CF98765432109876'),
('AMB02', 'CF12345678901555'),
('AMB05', 'CF23456789011345'),
('AMB05', 'CF56789012345008'),
('AMB01', 'CF98765432109876');



INSERT INTO CartellaClinica VALUES
('1000A001', 'CF00901234567890', 'M', 1.75, 68.0, 'A+', 'Si', 'No'),
('1000B001', 'CF12345678901234', 'M', 1.65, 64.0, 'A-', 'Si', 'Si'),
('1000C001', 'CF22012345679901', 'F', 1.50, 55.0, 'B+', 'No', 'No'),
('1000D001', 'CF23456789012345', 'F', 1.80, 89.0, 'B-', 'Si', 'No'),
('1000E001', 'CF34567890123456', 'F', 1.82, 85.0, 'AB+', 'No', 'No'),
('1000F001', 'CF44456789000345', 'M', 1.67, 67.0, 'AB-', 'Si', 'No'),
('1000G001', 'CF45678901234567', 'F', 1.90, 95.0, '0+', 'Si', 'Si'),
('1000H001', 'CF49678901234567', 'F', 1.55, 60.0, '0-', 'No', 'No'),
('1000I001', 'CF56789012345678', 'M', 1.95, 100.0, '0+', 'No', 'Si'),
('1000L001', 'CF65432109876543', 'M', 1.65, 60.0, 'AB+', 'No', 'No'),
('1000M001', 'CF66432109876543', 'F', 1.75, 67.0, '0-', 'Si', 'Si'),
('1000N001', 'CF78901234567890', 'M', 1.55, 54.0, 'B-', 'Si', 'Si'),
('1000P001', 'CF87567890123456', 'F', 1.78, 70.0, '0+', 'Si', 'Si'),
('1000Q001', 'CF89012345678901', 'F', 1.70, 67.0, 'AB-', 'Si', 'Si'),
('1000R001', 'CF98765432109876', 'F', 1.69, 64.0, 'A-', 'No', 'No');




INSERT INTO Medico VALUES
('MED001', 'Rossi', 'Carlo', '333444555', 'AMB01', 'CARDIO'),
('MED002', 'Verdi', 'Gioele', '333344555', 'AMB01', 'DERMA'),
('MED003', 'Bianchi', 'Mattia', '333334755', 'AMB01', 'GINEC'),
('MED004', 'Neri', 'Paola', '337334555', 'AMB01', 'NEURO'),
('MED005', 'Finchi', 'Elena', '322334005', 'AMB01', 'ORTHO'),

('MED006', 'Fanti', 'Cosimo', '333444661', 'AMB02', 'CARDIO'),
('MED007', 'Miglio', 'Matteo', '333344662', 'AMB02', 'DERMA'),
('MED008', 'Gigli', 'Elisabetta', '333334722', 'AMB02', 'GINEC'),
('MED009', 'Milani', 'Chiara', '337388555', 'AMB02', 'NEURO'),
('MED010', 'Ballerini', 'Helena', '331334005', 'AMB02', 'ORTHO'),

('MED011', 'Olini', 'Emma', '333456755', 'AMB03', 'CARDIO'),
('MED012', 'Baldini', 'Bianca', '320344555', 'AMB03', 'DERMA'),
('MED013', 'Bondi', 'Lorenzo', '333334035', 'AMB03', 'GINEC'),
('MED014', 'Trani', 'Cosimo', '337094555', 'AMB03', 'NEURO'),
('MED015', 'Paldini', 'Monia', '333320005', 'AMB03', 'ORTHO'),

('MED016', 'Fuci', 'Livio', '339444555', 'AMB04', 'CARDIO'),
('MED017', 'Lunghi', 'Antonella', '332144555', 'AMB04', 'DERMA'),
('MED018', 'Dimarco', 'Francesca', '333390755', 'AMB04', 'GINEC'),
('MED019', 'Paoletti', 'Sabrina', '337334550', 'AMB04', 'NEURO'),
('MED020', 'Buldi', 'Maria', '333332005', 'AMB04', 'ORTHO'),

('MED021', 'Rugi', 'Pierpaolo', '333222555', 'AMB05', 'CARDIO'),
('MED022', 'Rosa', 'Martina', '333340000', 'AMB05', 'DERMA'),
('MED023', 'Pegolo', 'Filippo', '373334755', 'AMB05', 'GINEC'),
('MED024', 'Innocenti', 'Viola', '337301555', 'AMB05', 'NEURO'),
('MED025', 'Polzi', 'Giuseppe', '333364005', 'AMB05', 'ORTHO'),

('MED026', 'Mantini', 'Daniele', '333364006', 'AMB01', 'CARDIO'),
('MED027', 'Gonzalez', 'Carlo', '333364007', 'AMB02', 'CARDIO'),
('MED028', 'Fonti', 'Ambra', '333364008', 'AMB03', 'CARDIO'),
('MED029', 'Pieri', 'Laura', '333364009', 'AMB04', 'CARDIO'),
('MED030', 'Mallardi', 'Claudia', '333364010', 'AMB05', 'CARDIO');



INSERT INTO Visita VALUES
#AMBULATORIO 1
('VIS0000001', '2023-08-10', '10:00:00', 'CF00901234567890', 'MED001'),
('VIS00000A1', '2023-07-07', '12:00:00', 'CF00901234567890', 'MED002'),
('VIS0000002', '2023-08-11', '10:30:00', 'CF44456789000345', 'MED002'),
('VIS0000003', '2023-07-09', '09:01:00', 'CF22012345679901', 'MED003'),
('VIS00000A2', '2023-06-07', '12:00:00', 'CF00901234567890', 'MED003'),
('VIS00000B1', '2023-08-07', '12:00:00', 'CF98765432109876', 'MED003'),
('VIS0000004', '2023-06-08', '11:00:00', 'CF98765432109876', 'MED004'),
('VIS0000005', '2023-08-07', '12:00:00', 'CF00901234567890', 'MED005'),
('VIS00000B2', '2023-09-07', '12:00:00', 'CF44456789000345', 'MED005'),
('VIS00000X1', '2023-09-07', '11:00:00', 'CF44456789000345', 'MED026'),
#AMBULATORIO 2
('VIS0000006', '2023-01-22', '13:00:00', 'CF12345678901234', 'MED006'),
('VIS0000007', '2023-02-17', '16:00:00', 'CF12345678901234', 'MED007'),
('VIS0000008', '2023-03-11', '17:00:00', 'CF45678901234567', 'MED008'),
('VIS00000D8', '2023-03-11', '17:00:00', 'CF78901234567890', 'MED008'),
('VIS0000009', '2023-03-19', '08:05:00', 'CF45678901234567', 'MED009'),
('VIS00000C6', '2023-04-17', '18:00:00', 'CF78901234567890', 'MED006'),
('VIS00000C7', '2023-04-17', '18:00:00', 'CF45678901234567', 'MED006'),
('VIS00000X2', '2023-04-17', '15:00:00', 'CF45678901234567', 'MED027'),
#AMBULATORIO 3
('VIS0000011', '2023-04-02', '10:05:00', 'CF22012345679901', 'MED011'),
('VIS0000012', '2023-05-10', '17:07:00', 'CF22012345679901', 'MED012'),
('VIS0000013', '2023-06-22', '09:08:00', 'CF49678901234567', 'MED013'),
('VIS0000A12', '2023-06-22', '09:08:00', 'CF22012345679901', 'MED013'),
('VIS0000014', '2023-06-23', '10:01:00', 'CF87567890123456', 'MED014'),
('VIS0000015', '2023-07-09', '19:00:00', 'CF49678901234567', 'MED015'),
('VIS00000X3', '2023-06-22', '09:08:00', 'CF22012345679901', 'MED028'),
#AMBULATORIO 4
('VIS0000016', '2023-07-15', '12:30:00', 'CF23456789012345', 'MED016'),
('VIS0000A16', '2023-07-15', '11:30:00', 'CF56789012345678', 'MED016'),
('VIS0000017', '2023-02-28', '10:15:00', 'CF89012345678901', 'MED018'),
('VIS0000018', '2023-01-02', '10:45:00', 'CF23456789012345', 'MED019'),
('VIS0000B18', '2023-01-02', '11:45:00', 'CF89012345678901', 'MED019'),
('VIS0000C18', '2023-01-02', '10:45:00', 'CF56789012345678', 'MED019'),
('VIS0000019', '2023-03-25', '11:50:00', 'CF23456789012345', 'MED020'),
('VIS00000X6', '2023-03-25', '10:50:00', 'CF23456789012345', 'MED029'),
#AMBULATORIO 5
('VIS0000020', '2023-06-8', '13:07:00', 'CF34567890123456', 'MED021'),
('VIS0000021', '2023-07-8', '12:07:00', 'CF34567890123456', 'MED023'),
('VIS0000022', '2023-04-8', '11:07:00', 'CF65432109876543', 'MED025'),
('VIS0000023', '2023-12-8', '10:07:00', 'CF98765432109876', 'MED030');

UPDATE Visita 
SET OraVisita = '08:45:00'
WHERE CodiceFiscalePaziente = 'CF23456789012345';

INSERT INTO Somministrazione VALUES
('1000A001', 'A1234'),
('1000A001', 'D3456'),
('1000B001', 'A1234'),
('1000B001', 'E7890'),
('1000C001', 'A1234'),
('1000D001', 'A1234'),
('1000D001', 'F2345'),
('1000E001', 'B5678'),
('1000F001', 'B5678'),
('1000F001', 'G6789'),
('1000F001', 'H1235'),
('1000G001', 'B5678'),
('1000G001', 'G6789'),
('1000G001', 'H1235'),
('1000G001', 'I5678'),
('1000G001', 'J9012'),
('1000H001', 'B5678'),
('1000I001', 'B5678'),
('1000I001', 'K3456'),
('1000L001', 'B5678'),
('1000L001', 'L7890'),
('1000L001', 'M2345'),
('1000M001', 'B5678'),
('1000M001', 'L7890'),
('1000M001', 'N6789'),
('1000M001', 'O9012'),
('1000N001', 'B5678'),
('1000N001', 'O9012'),
('1000N001', 'P3456'),
('1000N001', 'Q7890'),
('1000N001', 'R2345'),
('1000P001', 'C9012'),
('1000P001', 'R2345'),
('1000Q001', 'C9012'),
('1000Q001', 'R2345'),
('1000Q001', 'S6789'),
('1000Q001', 'T1235'),
('1000Q001', 'U5678'),
('1000Q001', 'V9012'),
('1000R001', 'C9012'),
('1000R001', 'V9012'),
('1000R001', 'Q7890');


############################################ INTERROGAZIONI ###########################################
#1. Visualizza Codice Fiscale, Cognome, Nome dei pazienti e l'ambulatorio di appartenenza.
SELECT DISTINCT P.CodiceFiscale, P.Cognome, P.Nome, App.CodAmbulatorio
FROM Paziente P
INNER JOIN Appartenenza App ON P.CodiceFiscale = App.CodiceFiscalePaziente
ORDER BY P.Cognome;

#1.1 VIsualizza tutte le visite della paziente 'CF34567890123456' nell'ambulatorio AMB05
SELECT V.ID_Visita, V.DataVisita, V.OraVisita, M.CodiceInterno, M.Cognome AS CognomeMedico, M.Nome AS NomeMedico, M.Specializzazione AS TipoVisita
FROM Visita V 
INNER JOIN Medico M ON V.CodiceInternoMedico = M.CodiceInterno
WHERE V.CodiceFiscalePaziente = 'CF34567890123456' AND M.CodAmbulatorio = 'AMB05';

#1.2 Visualizza quali pazienti appartengono all'ambulatorio AMB01 con Codice Fiscale, Cognome e Nome.
SELECT DISTINCT P.CodiceFiscale, P.Cognome, P.Nome
FROM Paziente P 
INNER JOIN Appartenenza App ON P.CodiceFiscale = App.CodiceFiscalePaziente
WHERE App.CodAmbulatorio = 'AMB01'
ORDER BY P.Cognome;

#2. Visualizza pazienti con rispettive cartelle cliniche indicando Cognome, Cognome e Codice Fiscale
SELECT C.CodiceCartella, P.Cognome, P.Nome, P.CodiceFiscale
FROM Paziente P 
INNER JOIN CartellaClinica C ON P.CodiceFiscale = C.CodiceFiscalePaziente;

#3. Visualizza Codice Fiscale, Cognome, Nome, Sesso e Età di tutti i pazienti che potrebbero donare il sangue a tutti gli altri. (0-)
SELECT P.CodiceFiscale, P.Cognome, P.Nome, C.Sesso, TIMESTAMPDIFF(YEAR, P.DataNascita, CURDATE()) AS Età
FROM Paziente P
INNER JOIN CartellaClinica C ON P.CodiceFiscale = C.CodiceFiscalePaziente
WHERE C.GruppoSanguigno = '0-'
ORDER BY P.Cognome;

#3.1 Visualizza il Codice Interno, Cognome, Specializzazione di tutti i medici
SELECT M.CodiceInterno, M.Cognome, SS.NomeSettore AS Specializzazione
FROM Medico M 
INNER JOIN SettoreSpecialistico SS ON M.Specializzazione = SS.IDSettore
ORDER BY M.CodiceInterno;

#3.2 Visualizza quanti medici specializzati in Cardiologia ci sono in totale. 
SELECT COUNT(*) AS NumeroCardiologi
FROM Medico
WHERE Specializzazione = 'CARDIO';

#4. Visualizza le visite effettuate dai medici
SELECT V.ID_Visita AS ID, V.CodiceFiscalePaziente, V.DataVisita, V.OraVisita, M.Specializzazione AS TipoVisita, V.CodiceInternoMedico AS CodiceMedico, M.Cognome AS Dottore
FROM Visita V
INNER JOIN Medico M ON V.CodiceInternoMedico = M.CodiceInterno
ORDER BY M.CodiceInterno;

#5 Visualizza Medici che non hanno effettuato visite
#(Ho utilizzato LEFT JOIN perché restituisce i medici della Tabella Medico (tabella sinistra, la 1ª menzionata nella query))
SELECT M.CodiceInterno AS ID_Dottore, M.Cognome, M.Nome, M.Specializzazione
FROM Medico M 
LEFT JOIN Visita V ON M.CodiceInterno = V.CodiceInternoMedico
WHERE V.ID_Visita IS NULL;

#6. Visualizza pazienti che hanno avuto più di una visita
SELECT P.CodiceFiscale, P.Cognome, P.Nome
FROM Paziente P
INNER JOIN Visita V ON P.CodiceFiscale = V.CodiceFiscalePaziente
GROUP BY P.CodiceFiscale, P.Cognome, P.Nome
HAVING COUNT(V.ID_Visita)>1
ORDER BY P.Cognome;

#6.1 Mostra tutte le visite della paziente 'Barbieri Francesca'
SELECT V.ID_Visita, P.Cognome, P.Nome, V.DataVisita, V.OraVisita
FROM Visita V 
INNER JOIN Paziente P ON V.CodiceFiscalePaziente = P.CodiceFiscale
WHERE P.Cognome = 'Barbieri' AND P.Nome = 'Francesca';

#7. Visualizza il nome del settore e quanti medici vi lavorano in totale
SELECT SS.NomeSettore AS Specializzazione, COUNT(*) AS NumeroMedici
FROM Medico M
INNER JOIN SettoreSpecialistico SS ON M.Specializzazione = SS.IDSettore
GROUP BY SS.NomeSettore;

#8. Mostra visite di un tale giorno
SELECT V.ID_Visita as ID, V.OraVisita, V.CodiceFiscalePaziente AS Paziente, M.Cognome AS Dottore, M.Specializzazione AS TipoVisita
FROM Visita V 
INNER JOIN Medico M ON V.CodiceInternoMedico = M.CodiceInterno
WHERE V.DataVisita = '2023-01-02'
ORDER BY V.OraVisita;

#9. Visualizza tutte le visite neurologiche effettuate, indicando: ID_Visita, la data, l'ora, l'ambulatorio dove è stata effettuata,
#da chi è stata effettuata (medico), il codice fiscale e il tipo di visita per precisare che sono del settore di neurologia 
SELECT V.ID_Visita AS ID, V.DataVisita, V.OraVisita, A.CodiceAmbulatorio AS ID_Amb, M.Cognome AS Dottore, V.CodiceFiscalePaziente AS Paziente, SS.NomeSettore AS TipoVisita
FROM Visita V
INNER JOIN Medico M ON V.CodiceInternoMedico = M.CodiceInterno
INNER JOIN Ambulatorio A ON M.CodAmbulatorio = A.CodiceAmbulatorio
INNER JOIN SettoreSpecialistico SS ON M.Specializzazione = SS.IDSettore
WHERE M.Specializzazione = 'NEURO'
ORDER BY V.DataVisita, V.OraVisita;

#10. Pazienti che non hanno effettuato nessuna visita 
#(ma che la avranno in futuro, quindi sono parte del database e dell'ambulatorio a cui appartengono)
SELECT P.Cognome, P.Nome 
FROM Paziente P 
LEFT JOIN Visita V ON P.CodiceFiscale = V.CodiceFiscalePaziente
WHERE V.ID_Visita IS NULL;


############################################ VISTE ###########################################
#1. Creare vista che indica per Ambulatorio, il numero di visite effettuate in totale
CREATE VIEW NumeroVisitePerAmbulatorio AS
SELECT A.CodiceAmbulatorio, COUNT(V.ID_Visita) AS NumeroVisite
FROM Ambulatorio A 
LEFT JOIN Medico M ON A.CodiceAmbulatorio = M.CodAmbulatorio
LEFT JOIN Visita V ON M.CodiceInterno = V.CodiceInternoMedico
GROUP BY A.CodiceAmbulatorio;

SELECT * FROM NumeroVisitePerAmbulatorio;


#2. Crea una vista che indica il numero di visite che ha effettuato ogni paziente
CREATE VIEW NumeroVisitePerPaziente AS
SELECT P.CodiceFiscale, P.Cognome, P.Nome, COUNT(V.CodiceFiscalePaziente) AS NumeroVisite
FROM Paziente P 
LEFT JOIN Visita V ON P.CodiceFiscale = V.CodiceFiscalePaziente
GROUP BY P.CodiceFiscale;

SELECT * FROM NumeroVisitePerPaziente;


#3. Crea una vista che mostra il CF, Cognome e nome del paziente e ATC e il nome del farmaco che gli hanno prescritto 
#durante la loro storia clinica
CREATE VIEW FarmaciPaziente AS
SELECT C.CodiceFiscalePaziente AS CF, P.Cognome, P.Nome, SM.ATC_farmaco AS ATC, F.Nome AS Farmaco
FROM CartellaClinica C
INNER JOIN Paziente P ON C.CodiceFiscalePaziente = P.CodiceFiscale
LEFT JOIN Somministrazione SM ON C.CodiceCartella = SM.CodiceCartellaClinica
LEFT JOIN Farmaci F ON SM.ATC_farmaco = F.ATC;

SELECT * FROM FarmaciPaziente;


#4. Crea una vista che indica il CF, Cognome e Nome del Paziente e il numero di farmaci prescritti 
CREATE VIEW NumeroFarmaciPerPaziente AS
SELECT C.CodiceFiscalePaziente AS CF, P.Cognome, P.Nome, COUNT(DISTINCT SM.ATC_farmaco) AS NumFarmaci
FROM CartellaClinica C 
INNER JOIN Paziente P ON C.CodiceFiscalePaziente = P.CodiceFiscale
LEFT JOIN Somministrazione SM ON C.CodiceCartella = SM.CodiceCartellaClinica
GROUP BY C.CodiceFiscalePaziente, P.Cognome, P.Nome;

SELECT * FROM NumeroFarmaciPerPaziente;


############################################ PROCEDURE ###########################################
#1. Crea procedura che inserito un dato codice fiscale, ti restituisca il numero delle visite

DROP PROCEDURE IF EXISTS ContaVisitePerPaziente;
DELIMITER $$
CREATE PROCEDURE ContaVisitePerPaziente(CodiceFiscale CHAR(16), OUT contaVisite INT)
BEGIN
	SELECT COUNT(ID_Visita) INTO contaVisite
    FROM Visita
    WHERE CodiceFiscalePaziente = CodiceFiscale;
END $$ 
DELIMITER ;

CALL ContaVisitePerPaziente('CF00901234567890', @NumVisitePaziente);
SELECT @NumVisitePaziente;

############################################ FUNZIONI ###############################################
##################################FUNZIONE1###############################
DROP FUNCTION IF EXISTS CalcolaIMC;
#Data l'altezza e il peso del paziente in input, calcola l'indice di massa corporea (IMC)
#Formula = [Peso / (Altezza * Altezza)]
DELIMITER $$
CREATE FUNCTION CalcolaIMC(Peso DECIMAL(5, 2), Altezza DECIMAL(4, 2)) RETURNS DECIMAL(4, 2)
BEGIN
    DECLARE BMI DECIMAL(4, 2);
    SET BMI = Peso / (Altezza * Altezza);
    RETURN BMI;
END $$
DELIMITER ;
##################################FUNZIONE2###############################
DROP FUNCTION IF EXISTS CalcolaCategoriaPeso;
#Dato il valore IMC (indice di Massa Corporea), calcola categorie tra:
#Sottopeso, Peso forma, Sovrappeso, Obeso
DELIMITER $$
CREATE FUNCTION CalcolaCategoriaPeso(IMC DECIMAL(5, 2)) RETURNS VARCHAR(20)
BEGIN
    DECLARE categoria VARCHAR(20);
    IF IMC < 18.5 THEN
        SET categoria = 'Sottopeso';
    ELSEIF IMC < 24.9 THEN
        SET categoria = 'Peso forma';
    ELSEIF IMC < 29.9 THEN
        SET categoria = 'Sovrappeso';
    ELSE
        SET categoria = 'Obeso';
    END IF;
    RETURN categoria;
END $$
DELIMITER ;

SET GLOBAL log_bin_trust_function_creators=1;

SELECT P.CodiceFiscale, P.Cognome, P.Nome, C.Peso, C.Altezza, CalcolaIMC(C.Peso, C.Altezza) AS IMC, 
CalcolaCategoriaPeso(CalcolaIMC(C.Peso, C.Altezza)) AS CategoriaPeso 
FROM Paziente P
INNER JOIN CartellaClinica C ON P.CodiceFiscale = C.CodiceFiscalePaziente;


############################################ TRIGGER ###############################################
#Creo un trigger 'AvvisoNuovaVisita' in cui fa sapere quando un nuova visita viene registrata. 
#1. Creo una tabella chiamata AvvNuovaVisita in modo da poter visualizzare il numero
	#delle visite aggiunte; Data e Ora in cui è stata registrata una nuova visita; Un messaggio
	#che indichi 'aggiunta nuova visita'.
#2. Per poter creare il trigger correttamente, eseguire alla fine di 'DELIMITER ; (line 575)'
	#dopo END$$
#3. Inserire i nuovi valori nella tabella visita (basterà levare il commento ed eseguire il comando)
#4. Eseguire il comando 'SELECT * FROM AvvNuovaVisita;' per poter visualizzare Data e Ora in cui è stata 
	#registrata una nuova visita
#5. Eseguire il comando 'SELECT * FROM Visita;' per poter vedere che è stata aggiunta correttamente
	#alla tabella Visita

#######TABELLA AvvNuovaVisita#######
DROP TABLE IF EXISTS AvvNuovaVisita;
CREATE TABLE AvvNuovaVisita (
    Numero INT AUTO_INCREMENT PRIMARY KEY,
    DataVisita_OraVisita TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Messaggio VARCHAR(255)
);

#######TRIGGER AvvisoNuovaVisita#######
DROP TRIGGER IF EXISTS AvvisoNuovaVisita;
DELIMITER $$
CREATE TRIGGER AvvisoNuovaVisita AFTER INSERT ON Visita
FOR EACH ROW
BEGIN
    INSERT INTO AvvNuovaVisita (messaggio) VALUES ('aggiunta nuova visita');
END $$
DELIMITER ;

#INSERT INTO Visita VALUES('VIS000KK19','2023-01-02','12:50:00', 'CF56789012345678', 'MED006');
#INSERT INTO Visita VALUES('VIS000XK22','2023-01-03','17:50:00', 'CF56789012345678', 'MED005');

SELECT * FROM AvvNuovaVisita;
SELECT * FROM Visita;

