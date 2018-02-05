
-- Koodiston määrittely

DELETE FROM koodi;
DELETE FROM koodisto;

INSERT INTO koodisto VALUES
  	(1, 'sukupuoli', 'Sukupuolen koodaus'),
  	(2, 'lähdejärjestelmä', 'Järjestelmä, josta tieto on alun perin ladattu'),
	(3, 'potilas_asia', 'Asiataulu, johon potilas_asia viittaa, esim. palvelutapahtuma'),
  	(4, 'mittayksikko', 'Yhteismitallinen mittayksikkö'),
	(5, 'tiedon_omistaja', 'Tiedon omistaja ja rekisterinpitäjä'),
	(6, 'puuttuva_arvo', 'Puuttuvien arvojen koodaus')
	(7, 'patologian taulukkotyyppi', 'patologian taulukkotyyppien listaus, esim. lausuntotaulukko, esitietotaulukko jne.');


INSERT INTO koodi VALUES 
	 (1, 1, 'mies', 'Mieshenkilö'), 
	 (2, 1, 'nainen', 'Naishenkilö'),
	 (3, 2, 'uraods', 'jdbc:oracle:thin:@uranus-raportointi.vsshp.net:1521/uraods'),
	 (4, 2, 'medbit_dw', 'jdbc:jtds:sqlserver://SQLCLU09:1433/Varsat_DW_VSSHP;instance=DW_Tuotanto;domain=VSSHP'),
	 (5, 2, 'medbit_dm', 'jdbc:jtds:sqlserver://SQLCLU09:1433/Varsat_DM_VSSHP;instance=DW_Tuotanto;domain=VSSHP'),
	 (6, 2, 'ktp_hadoop', 'jdbc:hive2://ktphadoop.vsshp.net:10000/ktp'),
	 (7, 3, 'palvelutapahtuma', 'Osastohoito, käynti, toimenpide tai muu palvelutapahtuma'),
	 (8, 3, 'leikkaus', 'leikkaushoito'),
	 (9, 3, 'labra', 'laboratoriotutkimus'),
	(10, 3, 'kuvantaminen', 'kuvantamistutkimus'),
	(11, 3, 'sytostaattiannos', NULL),
	(12, 3, 'sytostaattikuuri', NULL),
	(13, 3, 'sadehoito', NULL),
	(14, 3, 'patologia', NULL),
  	(15, 4, 'kategorisoimaton', 'Luokittelematon mittayksikkö'),	
	(16, 5, 'kategorisoimaton', 'Luokittelematon tieton omistaja'),	
	(17, 5, 'VSSHP', 'Varsinais-Suomen Sairaanhoitopiiri'),
  	(18, 5, 'tuntematon_omistaja', 'Tuntematon tiedon omistaja'),
	(19, 6, 'tuntematon_potilas', 'Potilaan henkilötunnusta ei löydy henkilon_identiteetti -taulusta'),
	(20, 2, 'qpati', 'QPati-XML Matin altaasta'),
	(21, 7,'lausunto', 'Lausuntotaulukko');
