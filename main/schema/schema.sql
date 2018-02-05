
CREATE TABLE main.laitos (
                id INTEGER NOT NULL,
                dm_dmd_laitos_pk BIGINT NOT NULL,
                koodi VARCHAR NOT NULL,
                nimi VARCHAR NOT NULL,
                on_sisainen BOOLEAN,
                CONSTRAINT laitos_pk PRIMARY KEY (id)
);
COMMENT ON TABLE main.laitos IS 'perustuu DataMartin tauluun Yhteinen.DMD_LAITOS.';
COMMENT ON COLUMN main.laitos.id IS 'generoitu pääavain';
COMMENT ON COLUMN main.laitos.dm_dmd_laitos_pk IS 'pääavain DataMartin taulussa Yhteinen.dmd_laitos. business key';
COMMENT ON COLUMN main.laitos.koodi IS 'laitoskoodi';
COMMENT ON COLUMN main.laitos.nimi IS 'laitosnimi';
COMMENT ON COLUMN main.laitos.on_sisainen IS 'lähteessä sarake laitossisainenlippu';


CREATE TABLE main.osasto (
                id INTEGER NOT NULL,
                dm_dmd_osasto_pk BIGINT,
                ods_yksikko_numero VARCHAR,
                koodi VARCHAR NOT NULL,
                nimi VARCHAR NOT NULL,
                laitos_id INTEGER NOT NULL,
                toimialue_koodi_id BIGINT,
                toimialue VARCHAR,
                lahde_koodi_id BIGINT NOT NULL,
                lahde VARCHAR NOT NULL,
                CONSTRAINT osasto_pk PRIMARY KEY (id)
);
COMMENT ON TABLE main.osasto IS 'tähän tauluun viittaavat taulut leikkaus ja palvelutapahtuma. osastot poimittu joko DataMartista taulusta Yhteinen.DMD_OSASTO tai uraodsista taulusta YKSIKKO_ODS.';
COMMENT ON COLUMN main.osasto.dm_dmd_osasto_pk IS 'pääavain DataMartin taulussa Yhteinen.DMD_OSASTO. business key. voi olla null jos lähde on jokin muu kuin DataMart. Jos käytetään lähteenä ODSia ja siellä on yksiköitä, jotka eivät tähän sovi, sen pääavaimelle täytyy luoda oma kenttä.';
COMMENT ON COLUMN main.osasto.ods_yksikko_numero IS 'pääavain uraodsin taulusta yksikko_ods, jos rivi on sieltä peräisin (katsotaan lähde-sarakkeesta mistä on)';
COMMENT ON COLUMN main.osasto.laitos_id IS 'viittaus laitos-tauluun';
COMMENT ON COLUMN main.osasto.toimialue_koodi_id IS 'tähän pitäisi jostain lähteestä selvittää toimialue johon osasto kuuluu. En tiedä, kuuluvatko kaikki mihinkään toimialueeseen';
COMMENT ON COLUMN main.osasto.toimialue IS 'selite em. koodi_id:lle';
COMMENT ON COLUMN main.osasto.lahde_koodi_id IS 'tiedon lähde, kooditettuna koodistotaulussa';
COMMENT ON COLUMN main.osasto.lahde IS 'lähteen selite koodistotaulusta';


CREATE TABLE main.koodisto (
                id INTEGER NOT NULL,
                nimi VARCHAR,
                koodiston_selite VARCHAR,
                CONSTRAINT koodisto_pk PRIMARY KEY (id)
);
COMMENT ON COLUMN main.koodisto.nimi IS 'Koodiston nimi';


CREATE TABLE main.koodi (
                id INTEGER NOT NULL,
                koodisto_id INTEGER NOT NULL,
                koodin_arvo VARCHAR,
                koodin_selite VARCHAR,
                CONSTRAINT koodi_pk PRIMARY KEY (id)
);
COMMENT ON COLUMN main.koodi.koodin_arvo IS 'koodinarvo';


CREATE SEQUENCE main.potilas_id_seq;

CREATE TABLE main.potilas (
                id INTEGER NOT NULL DEFAULT nextval('main.potilas_id_seq'),
                lahde_koodi_id INTEGER NOT NULL,
                lahde_paivityshetki TIMESTAMP NOT NULL,
                yhd_viite VARCHAR NOT NULL,
                syntymaaika_pvm DATE NOT NULL,
                kuolinaika_pvm DATE,
                paivityshetki TIMESTAMP NOT NULL,
                CONSTRAINT potilas_pk PRIMARY KEY (id)
);
COMMENT ON TABLE main.potilas IS 'Taulussa on ne potilastiedot, joihin ei tule muutoksia.';
COMMENT ON COLUMN main.potilas.id IS 'Asiakannnan oma potilas id
Esim. 1';
COMMENT ON COLUMN main.potilas.syntymaaika_pvm IS 'Esim. 1900-01_01';
COMMENT ON COLUMN main.potilas.kuolinaika_pvm IS 'Esim. 
kun  puuttuu, käytetään jotain "null" pvm:ää';


ALTER SEQUENCE main.potilas_id_seq OWNED BY main.potilas.id;

CREATE SEQUENCE main.potilasnumero_id_seq;

CREATE TABLE main.potilasnumero (
                id INTEGER NOT NULL DEFAULT nextval('main.potilasnumero_id_seq'),
                potilas_id INTEGER NOT NULL,
                lahde_koodi_id INTEGER NOT NULL,
                lahde_paivityshetki TIMESTAMP,
                potilasnumero VARCHAR NOT NULL,
                paivityshetki TIMESTAMP NOT NULL,
                CONSTRAINT potilasnumero_pk PRIMARY KEY (id)
);
COMMENT ON COLUMN main.potilasnumero.potilas_id IS 'Asiakannnan oma potilas id
Esim. 1';


ALTER SEQUENCE main.potilasnumero_id_seq OWNED BY main.potilasnumero.id;

CREATE SEQUENCE main.potilas_tieto_id_seq;

CREATE TABLE main.potilas_tieto (
                id INTEGER NOT NULL DEFAULT nextval('main.potilas_tieto_id_seq'),
                potilas_id INTEGER NOT NULL,
                lahde_koodi_id INTEGER NOT NULL,
                lahde_paivityshetki TIMESTAMP,
                ammatti VARCHAR,
                ammatti_koodi_id INTEGER,
                tyossakaynti VARCHAR,
                tyossakaynti_koodi_id INTEGER,
                aidinkieli VARCHAR,
                aidinkieli_koodi_id INTEGER,
                as_kieli VARCHAR,
                as_kieli_koodi_id INTEGER,
                jakeluosoite VARCHAR,
                postinumero VARCHAR,
                postitoimipaikka VARCHAR,
                sahkoposti_osoite VARCHAR,
                pot_kotikunta_koodi VARCHAR,
                pot_kotikunta_selite VARCHAR,
                vrk_kotikunta_koodi VARCHAR,
                vrk_kotikunta_selite VARCHAR,
                maa_koodi VARCHAR,
                maa_selite VARCHAR,
                kotimaa_koodi VARCHAR,
                kotimaa_selite VARCHAR,
                paivityshetki TIMESTAMP,
                CONSTRAINT potilas_tieto_pk PRIMARY KEY (id)
);
COMMENT ON TABLE main.potilas_tieto IS 'Potilaan äidinkieli ja mahdolliset muutokset';
COMMENT ON COLUMN main.potilas_tieto.potilas_id IS 'Asiakannan sisäinen id
Esim. 1';
COMMENT ON COLUMN main.potilas_tieto.ammatti_koodi_id IS 'Ammatti voidaan koodata analyysejä varten';
COMMENT ON COLUMN main.potilas_tieto.tyossakaynti_koodi_id IS 'Työssäkäynti voidaan koodata';
COMMENT ON COLUMN main.potilas_tieto.aidinkieli IS 'Esim. Suomi';
COMMENT ON COLUMN main.potilas_tieto.aidinkieli_koodi_id IS 'Äidinkielen koodaus. Voidaan toteuttaa myöhemmin (esim suomi, Suomi, FI, FIN yhdistetään tarkoittamaan suomea koodinarvon avulla)';
COMMENT ON COLUMN main.potilas_tieto.as_kieli IS 'Asioinitikieli';
COMMENT ON COLUMN main.potilas_tieto.postinumero IS 'Postinumero voi alkaa nollalla. Ulkomaiset postinumerot voivat sisältää kirjaimia.';
COMMENT ON COLUMN main.potilas_tieto.postitoimipaikka IS 'Kuten lähdejärjestelmässä';
COMMENT ON COLUMN main.potilas_tieto.pot_kotikunta_koodi IS 'Potilaan kotikuntakoodi (kuntakoodiston mukaan)';
COMMENT ON COLUMN main.potilas_tieto.pot_kotikunta_selite IS 'Selväkielinen kotikunta, esim "RAUMA"';
COMMENT ON COLUMN main.potilas_tieto.vrk_kotikunta_koodi IS 'Väestörekisterkin kotikuntakoodi (kuntakoodiston mukaan)';
COMMENT ON COLUMN main.potilas_tieto.vrk_kotikunta_selite IS 'Väestörekisterin selväkielinen kunta (esim "RAUMA")';
COMMENT ON COLUMN main.potilas_tieto.paivityshetki IS 'Milloin luotu/muutettu.
2015-06-25 08:51:56.0';


ALTER SEQUENCE main.potilas_tieto_id_seq OWNED BY main.potilas_tieto.id;

CREATE SEQUENCE main.henkilon_identiteetti_id_seq;

CREATE TABLE main.henkilon_identiteetti (
                id INTEGER NOT NULL DEFAULT nextval('main.henkilon_identiteetti_id_seq'),
                potilas_id INTEGER NOT NULL,
                lahde_koodi_id INTEGER NOT NULL,
                lahde_paivityshetki TIMESTAMP,
                etunimi VARCHAR,
                sukunimi VARCHAR,
                sukupuoli VARCHAR,
                sukupuoli_koodi_id INTEGER NOT NULL,
                hetu VARCHAR,
                hetu_alku_pvm DATE,
                hetu_loppu_pvm DATE,
                hetu_oikeellinen BOOLEAN,
                hetu_kommentit VARCHAR,
                paivityshetki TIMESTAMP,
                CONSTRAINT henkilon_identiteetti_pk PRIMARY KEY (id)
);
COMMENT ON TABLE main.henkilon_identiteetti IS 'Potilaan hetu, nimi, potilasnumero ja mahdolliset muutokset';
COMMENT ON COLUMN main.henkilon_identiteetti.potilas_id IS 'Asiakannan sisäinen id
Esim. 1';
COMMENT ON COLUMN main.henkilon_identiteetti.etunimi IS 'nimi liittyy tiettyyn hetuun, ja tällä parilla on lähdejärjestelmä ja aikaleima.';
COMMENT ON COLUMN main.henkilon_identiteetti.hetu IS 'Esim. 12341111-000x';
COMMENT ON COLUMN main.henkilon_identiteetti.paivityshetki IS 'Milloin luotu/muutettu
Esim. 
1980-01-01 00:00:00.0';


ALTER SEQUENCE main.henkilon_identiteetti_id_seq OWNED BY main.henkilon_identiteetti.id;

CREATE SEQUENCE main.potilas_asia_id_seq;

CREATE TABLE main.potilas_asia (
                id BIGINT NOT NULL DEFAULT nextval('main.potilas_asia_id_seq'),
                potilas_id INTEGER NOT NULL,
                lahde_koodi_id INTEGER NOT NULL,
                tiedon_omistaja_koodi_id INTEGER NOT NULL,
                asia_koodi_id INTEGER NOT NULL,
                asia VARCHAR,
                lahde_paivityshetki TIMESTAMP,
                paivityshetki TIMESTAMP,
                CONSTRAINT potilas_asia_pk PRIMARY KEY (id)
);
COMMENT ON COLUMN main.potilas_asia.id IS 'Potilaan asian id.
Esim jokainen potilaskäynti on asia. 
as1.';
COMMENT ON COLUMN main.potilas_asia.potilas_id IS 'Asiakannan  sisäinen potilas_id
Esim. 1';
COMMENT ON COLUMN main.potilas_asia.asia IS 'Aisakoodin selväkielinen selite, helpottaa sisällön ymmärtämistä.';
COMMENT ON COLUMN main.potilas_asia.lahde_paivityshetki IS 'uusi asia tuotu  asiakantaan.
Esim. Potiaan uusi käynti, diagnoosi, labra....
2009-09-16 10:33:52.0';
COMMENT ON COLUMN main.potilas_asia.paivityshetki IS 'Esim. 2010-07-19 23:49:55.0';


ALTER SEQUENCE main.potilas_asia_id_seq OWNED BY main.potilas_asia.id;

CREATE TABLE main.leikkaus (
                id BIGINT NOT NULL,
                potilas_asia_id BIGINT NOT NULL,
                dm_dmf_leikkaus_pk BIGINT NOT NULL,
                leikkaus_pvm DATE NOT NULL,
                alkuhetki TIMESTAMP NOT NULL,
                loppuhetki TIMESTAMP NOT NULL,
                paatoimenpide_koodi_id BIGINT,
                paatoimenpide_koodi VARCHAR,
                paatoimenpide_nimi VARCHAR,
                hoitava_osasto_id INTEGER NOT NULL,
                hoitava_osasto VARCHAR,
                sairaala_koodi_id VARCHAR,
                sairaala VARCHAR,
                potilaan_erikoisala_koodi_id BIGINT,
                potilaan_erikoisala VARCHAR,
                jonottamisen_syy_koodi_id BIGINT,
                jonottamisen_syy VARCHAR,
                toimenpideosasto_id INTEGER NOT NULL,
                toimenpideosasto VARCHAR NOT NULL,
                paatoimenpiteen_puolisuus_koodi_id BIGINT,
                paatoimenpiteen_puolisuus_koodi VARCHAR,
                paatoimenpiteen_puolisuus VARCHAR,
                potilaan_pituus DOUBLE PRECISION,
                potilaan_paino DOUBLE PRECISION,
                leikkaussali_koodi_id BIGINT,
                leikkaussali VARCHAR,
                asa_luokka_koodi_id BIGINT,
                asa_luokka VARCHAR,
                anestesiamuoto_koodi_id BIGINT,
                anestesiamuoto VARCHAR,
                lahettava_yksikko_koodi_id BIGINT,
                lahettava_yksikko VARCHAR,
                on_tehty_rontgen BOOLEAN,
                on_paivystys BOOLEAN,
                on_ajanvaraus BOOLEAN,
                CONSTRAINT leikkaus_pk PRIMARY KEY (id)
);
COMMENT ON TABLE main.leikkaus IS 'Perustuu DataMartin tauluun Toimintatilasto.dmf_leikkaus. Otetaan mukaan vain rivit, joilla lippu_tmpValid = 1. Potilaan hetu löytyy potilas-sarakkeen perusteella taulusta S_Henkilo_Uranus.';
COMMENT ON COLUMN main.leikkaus.leikkaus_pvm IS 'toteutunutPvm';
COMMENT ON COLUMN main.leikkaus.alkuhetki IS 'sarake leikkausAlkanut';
COMMENT ON COLUMN main.leikkaus.loppuhetki IS 'leikkausValmis';
COMMENT ON COLUMN main.leikkaus.paatoimenpide_koodi_id IS 'koodistoksi DataMartista Yhteinen.DMD_TOIMENPIDE-taulu.';
COMMENT ON COLUMN main.leikkaus.paatoimenpide_koodi IS 'selite (Yhteinen.dmd_toimenpide.toimenpidekoodi)';
COMMENT ON COLUMN main.leikkaus.paatoimenpide_nimi IS 'selite (Yhteinen.dmd_toimenpide.toimenpidenimi)';
COMMENT ON COLUMN main.leikkaus.hoitava_osasto_id IS 'viite osasto-tauluun. perustuu sarakkeeseen fm_dmd_osasto_hoitava';
COMMENT ON COLUMN main.leikkaus.hoitava_osasto IS 'nimi haettuna osasto-taulusta';
COMMENT ON COLUMN main.leikkaus.sairaala_koodi_id IS 'koodisto sarakkeesta sairaalaValue';
COMMENT ON COLUMN main.leikkaus.sairaala IS 'selite em. koodin  perusteella';
COMMENT ON COLUMN main.leikkaus.potilaan_erikoisala_koodi_id IS 'koodisto DataMartin taulusta Yhteinen.dmd_erikoisala.';
COMMENT ON COLUMN main.leikkaus.potilaan_erikoisala IS 'selite em. koodin perusteella kooditaulusta';
COMMENT ON COLUMN main.leikkaus.jonottamisen_syy_koodi_id IS 'koodisto DataMartin taulusta Yhteinen.dmd_jonottamisensyy';
COMMENT ON COLUMN main.leikkaus.jonottamisen_syy IS 'selite em. koodille';
COMMENT ON COLUMN main.leikkaus.toimenpideosasto_id IS 'viittaus osasto-tauluun. perustuu sarakkeeseen fk_dmd_osasto_toimenpide';
COMMENT ON COLUMN main.leikkaus.toimenpideosasto IS 'selite em. koodin  perusteella';
COMMENT ON COLUMN main.leikkaus.paatoimenpiteen_puolisuus_koodi_id IS 'koodistoksi DataMartin yhteinen.dmd_toimenpide. (Toimenpiteen puolisuus ilmaistaan samalla koodistolla kuin itse toimenpidekin.)';
COMMENT ON COLUMN main.leikkaus.paatoimenpiteen_puolisuus_koodi IS 'koodi kooditaulusta em. id:n perusteella';
COMMENT ON COLUMN main.leikkaus.paatoimenpiteen_puolisuus IS 'selite kooditaulusta em. koodi_id:n perusteella';
COMMENT ON COLUMN main.leikkaus.potilaan_pituus IS 'täytyy muuntaa sekavasta varchar-muodosta. Tulee null jos muunnos ei onnistu.';
COMMENT ON COLUMN main.leikkaus.potilaan_paino IS 'täytyy muuntaa sekavasta varchar-muodosta. Tulee null jos muunnos ei onnistu.';
COMMENT ON COLUMN main.leikkaus.leikkaussali_koodi_id IS 'koodisto sarakkeesta leikkaussaliValue.';
COMMENT ON COLUMN main.leikkaus.leikkaussali IS 'selite em. koodin perusteella';
COMMENT ON COLUMN main.leikkaus.asa_luokka_koodi_id IS 'koodisto sarakkeesta ASAValue';
COMMENT ON COLUMN main.leikkaus.anestesiamuoto_koodi_id IS 'koodisto sarakkeesta anestesiamuotoValue';
COMMENT ON COLUMN main.leikkaus.anestesiamuoto IS 'selite em. koodin perusteella';
COMMENT ON COLUMN main.leikkaus.lahettava_yksikko_koodi_id IS 'koodisto sarakkeesta lahettavaYksikkoValue';
COMMENT ON COLUMN main.leikkaus.lahettava_yksikko IS 'selite em. koodin perusteella';
COMMENT ON COLUMN main.leikkaus.on_tehty_rontgen IS 'sarake rtg_lippu';
COMMENT ON COLUMN main.leikkaus.on_paivystys IS 'paivystysLippu';
COMMENT ON COLUMN main.leikkaus.on_ajanvaraus IS 'ajanvarausLippu';


CREATE TABLE main.leikkaus_toimenpide (
                id BIGINT NOT NULL,
                dm_dmf_toimenpide_pk BIGINT NOT NULL,
                leikkaus_id BIGINT NOT NULL,
                toteutunut_toimenpide_koodi_id BIGINT,
                toteutunut_toimenpide_koodi VARCHAR,
                toteutunut_toimenpide_nimi VARCHAR,
                on_paatoimenpide BOOLEAN,
                on_anestesiatoimenpide BOOLEAN,
                toimenpiteen_puolisuus_koodi_id BIGINT,
                toimenpiteen_puolisuus_koodi VARCHAR,
                toimenpiteen_puolisuus VARCHAR,
                preop_diagnoosi_koodi_id BIGINT,
                preop_diagnoosi_koodi VARCHAR,
                preop_diagnoosi VARCHAR,
                postop_diagnoosi_koodi_id BIGINT,
                postop_diagnoosi_koodi VARCHAR NOT NULL,
                postop_diagnoosi VARCHAR,
                suunniteltu_toimenpide_koodi_id BIGINT NOT NULL,
                suunniteltu_toimenpide_koodi VARCHAR,
                suunniteltu_toimenpide VARCHAR,
                CONSTRAINT leikkaus_toimenpide_pk PRIMARY KEY (id)
);
COMMENT ON TABLE main.leikkaus_toimenpide IS 'perustuu DataMartin tauluun Toimintatilasto.DMF_TOIMENPIDE. Tähän tauluun lähteestä mukaan vain ne rivit, joilla lippu_tmpValid = 1 ja lippu_TOIMENPIDEValid = 1. (Nämä lähteessä int-tyyppisiä, arvot 0/1.)';
COMMENT ON COLUMN main.leikkaus_toimenpide.leikkaus_id IS 'viite leikkaus-tauluun';
COMMENT ON COLUMN main.leikkaus_toimenpide.toteutunut_toimenpide_koodi_id IS 'koodistoksi DataMartista Yhteinen.DMD_TOIMENPIDE-taulu.';
COMMENT ON COLUMN main.leikkaus_toimenpide.toteutunut_toimenpide_koodi IS 'selite (Yhteinen.dmd_toimenpide.toimenpidekoodi)';
COMMENT ON COLUMN main.leikkaus_toimenpide.toteutunut_toimenpide_nimi IS 'selite (Yhteinen.dmd_toimenpide.toimenpidenimi)';
COMMENT ON COLUMN main.leikkaus_toimenpide.on_paatoimenpide IS 'lähdetaulussa sarake paatoimenpideLippu';
COMMENT ON COLUMN main.leikkaus_toimenpide.on_anestesiatoimenpide IS 'lähdetaulussa sarake anestesiaToimenpideLippu';
COMMENT ON COLUMN main.leikkaus_toimenpide.toimenpiteen_puolisuus_koodi_id IS 'koodistoksi DataMartin yhteinen.dmd_toimenpide. (Toimenpiteen puolisuus ilmaistaan samalla koodistolla kuin itse toimenpidekin.)';
COMMENT ON COLUMN main.leikkaus_toimenpide.toimenpiteen_puolisuus_koodi IS 'koodi kooditaulusta em. id:n perusteella';
COMMENT ON COLUMN main.leikkaus_toimenpide.toimenpiteen_puolisuus IS 'selite kooditaulusta em. koodi_id:n perusteella';
COMMENT ON COLUMN main.leikkaus_toimenpide.preop_diagnoosi_koodi_id IS 'viittaus kooditauluun, koodisto ICD10';
COMMENT ON COLUMN main.leikkaus_toimenpide.preop_diagnoosi_koodi IS 'koodi kooditaulusta em. id:n perusteella';
COMMENT ON COLUMN main.leikkaus_toimenpide.preop_diagnoosi IS 'selite em. koodille';
COMMENT ON COLUMN main.leikkaus_toimenpide.postop_diagnoosi_koodi_id IS 'kooditaulu, koodisto ICD10';
COMMENT ON COLUMN main.leikkaus_toimenpide.postop_diagnoosi_koodi IS 'koodi kooditaulusta em. id:n perusteella';
COMMENT ON COLUMN main.leikkaus_toimenpide.postop_diagnoosi IS 'selite kooditaulusta em. id:n perusteella';
COMMENT ON COLUMN main.leikkaus_toimenpide.suunniteltu_toimenpide_koodi_id IS 'koodisto DataMartista Yhteinen.dmd_toimenpide';


CREATE TABLE main.palvelutapahtuma (
                id BIGINT NOT NULL,
                potilas_asia_id BIGINT NOT NULL,
                palvelu_numero VARCHAR,
                ilmoittautumis_aika TIME,
                alkuhetki TIMESTAMP,
                loppuhetki TIMESTAMP,
                potilaan_erikoisala_koodi_id BIGINT,
                potilaan_erikoisala VARCHAR,
                hoitokokonaisuus_numero VARCHAR,
                varaus_numero VARCHAR,
                tapaturma VARCHAR,
                paivakirurgia VARCHAR,
                tiede_opetuspotilas VARCHAR,
                osasto_id INTEGER NOT NULL,
                osasto VARCHAR,
                palvelun_tila VARCHAR,
                resurssi_koodi_id BIGINT,
                resurssi VARCHAR,
                resurssin_tyyppi VARCHAR,
                mista_lahete_koodi_id BIGINT,
                mista_lahete VARCHAR,
                mista_tuli_koodi_id BIGINT,
                mista_tuli VARCHAR,
                tulosyy_koodi_id BIGINT,
                tulosyy VARCHAR,
                tulotapa_koodi_id BIGINT,
                tulotapa VARCHAR,
                lahettava_laitos_koodi_id BIGINT,
                lahettava_laitos VARCHAR,
                taustaosasto_koodi_id BIGINT,
                taustaosasto VARCHAR,
                siirto_palveluilta VARCHAR,
                siirto_osastolle BOOLEAN,
                jatkohoito_laitos_koodi_id BIGINT,
                jatkohoito_laitos VARCHAR,
                luontihetki TIMESTAMP,
                paivityshetki TIMESTAMP,
                luontihetki_s TIMESTAMP,
                paivityshetki_s TIMESTAMP,
                paivityshetki_ods TIMESTAMP,
                CONSTRAINT palvelutapahtuma_pk PRIMARY KEY (id)
);
COMMENT ON TABLE main.palvelutapahtuma IS 'tähän vain sellaiset käynnit ja osastohoidot, joilla tila_selite = ''Toteutettu'', peruttu = 0 ja mitatoity = 0.';
COMMENT ON COLUMN main.palvelutapahtuma.ilmoittautumis_aika IS 'ILM_AIKA_PVM Ilmoittautumisaika pvm  (YYYYMMDD)

ILM_AIKA_MIN Ilmoittautumisaika min

Yhdistetään';
COMMENT ON COLUMN main.palvelutapahtuma.alkuhetki IS 'ALKUHETKI_PVM
ALKUHETKI_MIN
Hoidon alkamisaika pvm  (YYYYMMDD)
Hoidon alkamisaika min
Yhdistetään';
COMMENT ON COLUMN main.palvelutapahtuma.loppuhetki IS 'LOPPUHETKI_PVM
LOPPUHETKI_MIN
Hoidon päättymisaika pvm  (YYYYMMDD)
Hoidon päättymisaika min
Yhdistetään';
COMMENT ON COLUMN main.palvelutapahtuma.potilaan_erikoisala_koodi_id IS 'POT_EALA_KOODI
Potilaan erikoisalakoodi
Koodisto SPECL/STAKE';
COMMENT ON COLUMN main.palvelutapahtuma.potilaan_erikoisala IS 'POT_EALA_SELITE
Potilaan erikoisalan selite
Koodisto SPECL/STAKE
Esim. KARDIOLOGIA';
COMMENT ON COLUMN main.palvelutapahtuma.hoitokokonaisuus_numero IS 'HOIKO_NUMERO
Viittaus hoitokokonaisuuteen';
COMMENT ON COLUMN main.palvelutapahtuma.varaus_numero IS 'VARAUS_NUMERO
Viittaus varaukseen';
COMMENT ON COLUMN main.palvelutapahtuma.tapaturma IS 'TAPATURMA
on/ei koodi?';
COMMENT ON COLUMN main.palvelutapahtuma.paivakirurgia IS 'PAIVAKIRURGIA
Päiväkirurgia';
COMMENT ON COLUMN main.palvelutapahtuma.tiede_opetuspotilas IS 'TIEDE_OPETUSPOT
Tiede/opetuspotilas
on/ei koodi';
COMMENT ON COLUMN main.palvelutapahtuma.osasto_id IS 'VO_TOIMIPISTE_KOODI & VO_TOIMIPISTE_NIMI pitäisi mäpätä osasto-tauluun';
COMMENT ON COLUMN main.palvelutapahtuma.osasto IS 'nimi osasto-taulusta';
COMMENT ON COLUMN main.palvelutapahtuma.palvelun_tila IS 'TILA_SELITE
Ajoitettu, toteutuksessa, toteutettu
Koodisto?';
COMMENT ON COLUMN main.palvelutapahtuma.resurssi_koodi_id IS 'RES_KOODI
Resurssin koodi';
COMMENT ON COLUMN main.palvelutapahtuma.resurssi IS 'RES_SELITE
Resurssin selite';
COMMENT ON COLUMN main.palvelutapahtuma.resurssin_tyyppi IS 'RES_TYYPPI_SELITE
Resrussin tyyppikoodin selite';
COMMENT ON COLUMN main.palvelutapahtuma.mista_lahete_koodi_id IS 'MISTA_LAH_TULI_KOODI
Mistä lähete tuli -koodi (Kun tulotapa = ''Päivystys'')
Koodisto?';
COMMENT ON COLUMN main.palvelutapahtuma.mista_lahete IS 'MISTA_LAH_TULI_NIMI
Mistä lähete tuli -nimi (Kun tulotapa = ''Päivystys'')';
COMMENT ON COLUMN main.palvelutapahtuma.mista_tuli_koodi_id IS 'MISTA_TULI_KOODI
Mistä tuli (koodi)
CSTCF/STAKE

Esim. 2';
COMMENT ON COLUMN main.palvelutapahtuma.mista_tuli IS 'MISTA_TULI_SELITE
Mistä tuli (selite)
koodisto CSTCF/STAKE

esim. koti';
COMMENT ON COLUMN main.palvelutapahtuma.tulosyy_koodi_id IS 'TULOSYY_KOODI
Tulosyy (koodi)
CARSN/STAKE

Esim. 6';
COMMENT ON COLUMN main.palvelutapahtuma.tulosyy IS 'TULOSYY_SELITE
Tulosyy (selite)

Koodisto CARSN/STAKE

Esim. somaat.sair.tutk. ja hoit';
COMMENT ON COLUMN main.palvelutapahtuma.tulotapa_koodi_id IS 'TULOTAPA_KOODI
Tulotapa (koodi)
CUARW/STAKE';
COMMENT ON COLUMN main.palvelutapahtuma.tulotapa IS 'TULOTAPA_SELITE
Tulotapa (selite)
Koodisto CUARW/STAKE';
COMMENT ON COLUMN main.palvelutapahtuma.lahettava_laitos_koodi_id IS 'LAH_LAITOS_KOODI
Lähettävän laitoksen/toimipisteen koodi
Koodisto?';
COMMENT ON COLUMN main.palvelutapahtuma.lahettava_laitos IS 'LAH_LAITOS_NIMI
Lähettävän laitoksen/toimipisteen nimi

Koodisto?';
COMMENT ON COLUMN main.palvelutapahtuma.taustaosasto_koodi_id IS 'TAUSTAOS_KOODI
Taustaosaston koodi
Koodisto?
Esim. 011';
COMMENT ON COLUMN main.palvelutapahtuma.taustaosasto IS 'TAUSTAOS_NIMI
Taustaosaston nimi
Koodisto?';
COMMENT ON COLUMN main.palvelutapahtuma.siirto_palveluilta IS 'SIIRTO_PALVELULTA
tieto palvelunumerosta josta siirryttiin';
COMMENT ON COLUMN main.palvelutapahtuma.siirto_osastolle IS 'SIIRTO_OSASTOLLE
Onko hoitojaksosta tehty osastosiirto 
Kyllä/ei koodisto';
COMMENT ON COLUMN main.palvelutapahtuma.jatkohoito_laitos_koodi_id IS 'JATKOH_LAITOS_KOODI
Jatkohoitolaitoksen koodi
koodisto?';
COMMENT ON COLUMN main.palvelutapahtuma.jatkohoito_laitos IS 'JATKOH_LAITOS_NIMI
Jatkohoitolaitoksen nimi
Koodisto?';
COMMENT ON COLUMN main.palvelutapahtuma.luontihetki IS 'LUONTIHETKI_S
Rivin luontihetki (YYYYMMDDHHMISS)';
COMMENT ON COLUMN main.palvelutapahtuma.paivityshetki IS 'PAIVITYSHETKI_S
Rivin viimeisin päivityshetki (YYYYMMDDHHMISS)';
COMMENT ON COLUMN main.palvelutapahtuma.luontihetki_s IS 'luontihetki lähdejärjestelmässä (Oberon)';
COMMENT ON COLUMN main.palvelutapahtuma.paivityshetki_s IS 'päivityshetki lähdejärjestelmässä (Oberon)';
COMMENT ON COLUMN main.palvelutapahtuma.paivityshetki_ods IS 'PAIVITYSHETKI_ODS
Rivin päivittymisjankohta ODS tauluun (YYYYMMDDHHMISS)';


CREATE TABLE main.toimenpide (
                id BIGINT NOT NULL,
                toimenpide_numero VARCHAR,
                palvelutapahtuma_id BIGINT NOT NULL,
                palvelu_numero VARCHAR,
                toimenpide_koodi_id BIGINT,
                toimenpide VARCHAR,
                on_paatoimenpide BOOLEAN,
                potilaan_erikoisala_koodi_id BIGINT,
                potilaan_erikoisala VARCHAR,
                toimenpidekokonaisuus_numero VARCHAR,
                rivinumero_toimenpidekokonaisuudessa INTEGER,
                kayntityyppi_koodi_id BIGINT,
                kayntityyppi VARCHAR,
                tulotapa_koodi_id BIGINT,
                tulotapa VARCHAR,
                eniten_voimavaroja BOOLEAN,
                uusinta_toimenpide BOOLEAN,
                salitoimenpide BOOLEAN,
                kiireellinen BOOLEAN,
                toimenpide_hetki TIMESTAMP,
                paivystys BOOLEAN,
                suorittava_laitos_koodi_id BIGINT,
                suorittava_laitos VARCHAR,
                suorittava_toimipiste_koodi_id BIGINT,
                suorittava_toimipiste VARCHAR,
                vastaanottava_toimipiste_koodi_id BIGINT,
                vastaanottava_toimipiste VARCHAR,
                lahettava_yksikko_koodi_id BIGINT,
                lahettava_yksikko VARCHAR,
                resurssi_koodi_id BIGINT,
                resurssi VARCHAR,
                luontihetki TIMESTAMP,
                paivityshetki TIMESTAMP,
                luontihetki_s TIMESTAMP,
                paivityshetki_s TIMESTAMP,
                paivityshetki_ods TIMESTAMP,
                CONSTRAINT toimenpide_pk PRIMARY KEY (id)
);
COMMENT ON TABLE main.toimenpide IS 'Oberonin toimenpiteet.
Toimenpide voi olla päätoimenpide tai sivutoimenpide (eli peräisin taulusta toimenpide tai alatoimenpide). Tähän tauluun vain rivit, joilla tila_selite = ''Toteutettu'' ja peruttu = 0.';
COMMENT ON COLUMN main.toimenpide.toimenpide_numero IS 'business key. Tähän sisältö kentistä toimenpide.toimenpide_numero ja alatoimenpide.alatoimenpide_numero.';
COMMENT ON COLUMN main.toimenpide.palvelutapahtuma_id IS 'PALVELU_NUMERO
Viittaus käyntiin/hoitojaksoon, johon toimenpide liittyy

Esim. 
579382000032997132';
COMMENT ON COLUMN main.toimenpide.palvelu_numero IS 'sen palvelutapahtuman palvelu_numero, johon tämä toimenpide liittyy (ja johon palvelutapahtuma_id viittaa)';
COMMENT ON COLUMN main.toimenpide.toimenpide_koodi_id IS 'toimenpide.TOIMENPIDE_KOODI tai alatoimenpide.alatoimenpide_koodi.
Toimenpiteen koodi
NCSP/STAKE tai OPCOD/OWN

esim. XF400';
COMMENT ON COLUMN main.toimenpide.toimenpide IS 'toimenpide.TOIMENPIDE_SELITE tai alatoimenpide.alatoimenpide_selite.
Toimenpiteen selite
NCSP/STAKE tai OPCOD/OWN
Esim. 12-KYTKENTÄINEN EKG';
COMMENT ON COLUMN main.toimenpide.on_paatoimenpide IS 'tähän true, jos rivi on taulusta toimenpide, ja false, jos rivi on taulusta alatoimenpide';
COMMENT ON COLUMN main.toimenpide.potilaan_erikoisala_koodi_id IS 'POT_EALA_KOODI
SPECL/STAKE

Esim. 10';
COMMENT ON COLUMN main.toimenpide.potilaan_erikoisala IS 'SPECL/STAKE

Esim. SISÄTAUDIT';
COMMENT ON COLUMN main.toimenpide.toimenpidekokonaisuus_numero IS 'TOIMENPIDEKOK_NUMERO
Toimenpidekokonaisuuden numero
NCSP/STAKE';
COMMENT ON COLUMN main.toimenpide.rivinumero_toimenpidekokonaisuudessa IS 'RIVI_NUMERO
Toimenpidekokonaisuuden rivinumero';
COMMENT ON COLUMN main.toimenpide.kayntityyppi_koodi_id IS 'KAYNTITYYPPI_KOODI
Käyntityyppikoodi
koodisto VISTY/OWN

Esim. 06';
COMMENT ON COLUMN main.toimenpide.kayntityyppi IS 'KAYNTITYYPPI_SELITE
Käyntityyppikoodin selite
VISTY/OWN

Esim. PÄIVYSTYS';
COMMENT ON COLUMN main.toimenpide.tulotapa_koodi_id IS 'TULOTAPA_KOODI
Tulotapa
koodisto CUARW/STAKE';
COMMENT ON COLUMN main.toimenpide.tulotapa IS 'TULOTAPA_SELITE
Tulotapakoodin selite
CUARW/STAKE';
COMMENT ON COLUMN main.toimenpide.eniten_voimavaroja IS 'ENITEN_VOIMAVAROJA
Onko kyseessä eniten voimavaroja vaatinut toimenpide
koodisto on/ei';
COMMENT ON COLUMN main.toimenpide.uusinta_toimenpide IS 'UUSINTA_TMP

Onko kyseessä uusintatoimenpide
on/i koodi';
COMMENT ON COLUMN main.toimenpide.salitoimenpide IS 'SALI_TMP
Onko kyseessä salitoimenpide
on/ei-koodi';
COMMENT ON COLUMN main.toimenpide.kiireellinen IS 'KIIREELLINEN
Kiireellinen tai hätätoimenpide
on/ei -koodi
Esim. 0';
COMMENT ON COLUMN main.toimenpide.toimenpide_hetki IS 'TOIMENPIDE_HETKI_PVM
TOIMENPIDE_HETKI_MIN
Toimenpiteen pvm  (YYYYMMDD)
Toimenpiteen kellonaika';
COMMENT ON COLUMN main.toimenpide.paivystys IS 'PAIVYSTYS
Onko kyseessä päivystys Y/N 

On/ei koodi
Esim. 0';
COMMENT ON COLUMN main.toimenpide.suorittava_laitos_koodi_id IS 'SUOR_LAITOS_KOODI
Toimenpiteen suorittajan laitoskoodi
Koodisto?';
COMMENT ON COLUMN main.toimenpide.suorittava_laitos IS 'SUOR_LAITOS_NIMI
Toimenpiteen suorittajan laitos nimi
Koodisto?';
COMMENT ON COLUMN main.toimenpide.suorittava_toimipiste_koodi_id IS 'SUOR_TOIMIPISTE_KOODI
Toimenpiteen suorittajan toimipistekoodi
Koodisto?';
COMMENT ON COLUMN main.toimenpide.suorittava_toimipiste IS 'SUOR_TOIMIPISTE_NIMI
Toimenpiteen suorittajan toimipiste nimi
Koodisto?';
COMMENT ON COLUMN main.toimenpide.vastaanottava_toimipiste_koodi_id IS 'VO_TOIMIPISTE_KOODI
Vastaanottavan toimipisteen koodi
Koodisto?';
COMMENT ON COLUMN main.toimenpide.vastaanottava_toimipiste IS 'VO_TOIMIPISTE_NIMI
Vastaanottavan toimipisteen selite
Koodisto?';
COMMENT ON COLUMN main.toimenpide.lahettava_yksikko_koodi_id IS 'LAH_LAITOS_KOODI
Lähettävän laitoksen/toimipisteen koodi
Koodistot?';
COMMENT ON COLUMN main.toimenpide.lahettava_yksikko IS 'LAH_LAITOS_NIMI
Lähettävän laitoksen/toimipisteen nimi
Koodistot?';
COMMENT ON COLUMN main.toimenpide.resurssi_koodi_id IS 'käynnistä/osastohoidosta';
COMMENT ON COLUMN main.toimenpide.resurssi IS 'käynnistä/osastohoidosta';
COMMENT ON COLUMN main.toimenpide.luontihetki IS 'LUONTIHETKI
Rivin luontihetki (YYYYMMDDHHMISS)';
COMMENT ON COLUMN main.toimenpide.paivityshetki IS 'PAIVITYSHETKI
Rivin viimeisin päivityshetki (YYYYMMDDHHMISS)';
COMMENT ON COLUMN main.toimenpide.luontihetki_s IS 'rivin luontihetki lähdejärjestelmässä (Oberon)';
COMMENT ON COLUMN main.toimenpide.paivityshetki_s IS 'rivin päivityshetki lähdejärjestelmässä (Oberon)';
COMMENT ON COLUMN main.toimenpide.paivityshetki_ods IS 'PAIVITYSHETKI_ODS
Rivin päivitysajankohta ODS tauluun (YYYYMMDDHHMISS)';


CREATE TABLE main.lisatoimenpide (
                id BIGINT NOT NULL,
                lisatoimenpide_numero VARCHAR,
                paatoimenpide_johon_liittyy_id BIGINT NOT NULL,
                paatoimenpide_numero VARCHAR,
                toimenpidekokonaisuus_numero VARCHAR,
                rivi_numero INTEGER,
                lisatoimenpide_koodi_id BIGINT,
                lisatoimenpide_selite VARCHAR,
                luontihetki VARCHAR,
                paivityshetki VARCHAR,
                luontihetki_s TIMESTAMP,
                paivityshetki_s TIMESTAMP,
                paivityshetki_ods TIMESTAMP,
                CONSTRAINT lisatoimenpide_pk PRIMARY KEY (id)
);
COMMENT ON TABLE main.lisatoimenpide IS 'lisätoimenpide liittyy aina johonkin toimenpiteeseen';
COMMENT ON COLUMN main.lisatoimenpide.lisatoimenpide_numero IS 'taulun pääavain Uraodsissa';
COMMENT ON COLUMN main.lisatoimenpide.paatoimenpide_numero IS 'sen päätoimenpiteen toimenpide_numero, johon tämä rivi liittyy';
COMMENT ON COLUMN main.lisatoimenpide.luontihetki IS 'luontihetki asiakannassa';
COMMENT ON COLUMN main.lisatoimenpide.paivityshetki IS 'päivityshetki asiakannassa';
COMMENT ON COLUMN main.lisatoimenpide.luontihetki_s IS 'luontihetki lähdejärjestelmässä (Oberon)';
COMMENT ON COLUMN main.lisatoimenpide.paivityshetki_s IS 'päivityshetki lähdejärjestelmässä (Oberon)';
COMMENT ON COLUMN main.lisatoimenpide.paivityshetki_ods IS 'päivityshetki ODS-kannassa (uraods)';


CREATE TABLE main.diagnoosi (
                id BIGINT NOT NULL,
                palvelutapahtuma_id BIGINT NOT NULL,
                diagnoosi_numero VARCHAR,
                paadiagnoosi BOOLEAN,
                diagnoosi_jarjestysnumero INTEGER,
                diagnoosi_alkupvm DATE,
                diagnoosi_loppupvm DATE,
                oire_koodi_id BIGINT,
                oire VARCHAR,
                syy_koodi_id BIGINT,
                syy VARCHAR,
                ei_haittavaikutus VARCHAR,
                hoidon_haittavaikutus_koodi_id BIGINT,
                hoidon_haittavaikutus VARCHAR,
                haittavaikutus_koodi_id BIGINT,
                haittavaikutus VARCHAR,
                ulkoinen_syy_koodi_id BIGINT,
                ulkoinen_syy VARCHAR,
                tapaturmatyyppi_koodi_id BIGINT,
                tapaturmatyyppi VARCHAR,
                vastaanottava_toimipiste_koodi_id BIGINT,
                vastaanottava_toimipiste VARCHAR,
                resurssi_koodi_id BIGINT,
                resurssi VARCHAR,
                luontihetki TIMESTAMP,
                paivityshetki TIMESTAMP,
                luontihetki_s TIMESTAMP,
                paivityshetki_s TIMESTAMP,
                paivityshetki_ods TIMESTAMP,
                CONSTRAINT diagnoosi_pk PRIMARY KEY (id)
);
COMMENT ON TABLE main.diagnoosi IS 'tähän tauluun vain rivit, joilla dgn_vaihe = ''TOTEUTUS'' ja joiden viittaama palvelu_numero on sellainen, että sen rivillä (käynnissä tai osastohoidossa) on mitatoity=0 ja peruttu=0 ja tila_selite=''Toteutettu''.';
COMMENT ON COLUMN main.diagnoosi.id IS 'Potilaan asian id';
COMMENT ON COLUMN main.diagnoosi.diagnoosi_numero IS 'DGN_NUMERO
Diagnoosirivin yksilöivä numero

Esim-. 974014729614045708';
COMMENT ON COLUMN main.diagnoosi.paadiagnoosi IS 'PAADGN
Onko kyseessä päädiagnoosi
on/ei -koodi';
COMMENT ON COLUMN main.diagnoosi.diagnoosi_jarjestysnumero IS 'JARJ_NRO
Diagnoosin järjestysnumero. Päädiagnoosilla  = 1, sivudiagnooseilla > 1
Koodisto?';
COMMENT ON COLUMN main.diagnoosi.diagnoosi_alkupvm IS 'ALKUHETKI_PVM
Diagnoosin alkuhetki (YYYYMMDD)';
COMMENT ON COLUMN main.diagnoosi.diagnoosi_loppupvm IS 'LOPPUHETKI_PVM
Diagnoosin loppuhetki (YYYYMMDD)';
COMMENT ON COLUMN main.diagnoosi.oire_koodi_id IS 'DG_OIRE_KOODI
Oirekoodi
DISCL/ICD10';
COMMENT ON COLUMN main.diagnoosi.oire IS 'DG_OIRE_SELITE
Diagnoosin/oireen selite
DISCL/ICD10

Esim. Rinnan keskiosan syöpä';
COMMENT ON COLUMN main.diagnoosi.syy_koodi_id IS 'DG_SYY_KOODI
Esim. C50.01&
Syykoodi
DISCL/ICD10 tai ATCCO/FIMEA';
COMMENT ON COLUMN main.diagnoosi.syy IS 'DG_SYY_SELITE
Syyn selite
DISCL/ICD10 tai ATCCO/FIMEA

Esim. nännin tai nännipihan syöpä; duktaalinen kasvain';
COMMENT ON COLUMN main.diagnoosi.ei_haittavaikutus IS 'EI_HAITTAVAIKUTUS
onko diagnoosi haittavaikutus
on/ei koodi
DISCL/ICD10';
COMMENT ON COLUMN main.diagnoosi.hoidon_haittavaikutus_koodi_id IS 'HOIDON_HAITTAVAIKUTUS_KOODI
Hoidon haittavakutuskoodi
CCOMP/STAKE';
COMMENT ON COLUMN main.diagnoosi.hoidon_haittavaikutus IS 'HOIDON_HAITTAVAIKUTUS_SELITE
Hoidon haittavakutusselite
CCOMP/STAKE';
COMMENT ON COLUMN main.diagnoosi.haittavaikutus_koodi_id IS 'HAITTAVAIKUTUS_KOODI
Haittavaikutuskoodi
DISCL/ICD10';
COMMENT ON COLUMN main.diagnoosi.haittavaikutus IS 'HAITTAVAIKUTUS_SELITE
Haittavaikutusselite
DISCL/ICD10';
COMMENT ON COLUMN main.diagnoosi.ulkoinen_syy_koodi_id IS 'ULK_SYY_KOODI
Ulkoisen syyn koodi';
COMMENT ON COLUMN main.diagnoosi.ulkoinen_syy IS 'ULK_SYY_SELITE
Ulkoisen syyn koodin selite
Koodisto?';
COMMENT ON COLUMN main.diagnoosi.tapaturmatyyppi_koodi_id IS 'TAPATURMA_TYYPPI_KOODI
Tapaturma tyypin koodi
ACCTY/ZMD';
COMMENT ON COLUMN main.diagnoosi.tapaturmatyyppi IS 'TAPATURMA_TYYPPI_SELITE
Tapaturma tyypin koodin selite
ACCTY/ZMD';
COMMENT ON COLUMN main.diagnoosi.vastaanottava_toimipiste_koodi_id IS 'käynnistä/osastohoidosta';
COMMENT ON COLUMN main.diagnoosi.resurssi_koodi_id IS 'käynnistä/osastohoidosta';
COMMENT ON COLUMN main.diagnoosi.luontihetki IS 'LUONTIHETKI_S
Rivin luontiajankohta (YYYYMMDDHHMISS)';
COMMENT ON COLUMN main.diagnoosi.paivityshetki IS 'PAIVITYSHETKI_S
Rivin viimeisin päivityshetki (YYYYMMDDHHMISS)';
COMMENT ON COLUMN main.diagnoosi.luontihetki_s IS 'luontihetki lähdejärjestelmässä (Oberon)';
COMMENT ON COLUMN main.diagnoosi.paivityshetki_s IS 'päivityshetki lähdejärjestelmässä (Oberon)';
COMMENT ON COLUMN main.diagnoosi.paivityshetki_ods IS 'PAIVITYSHETKI_ODS
Rivin päivittymisjankohta ODS tauluun (YYYYMMDDHHMISS)';


CREATE TABLE main.osastohoito (
                id BIGINT NOT NULL,
                palvelutapahtuma_id BIGINT NOT NULL,
                palvelu_numero VARCHAR,
                tulotapa_koodi_id BIGINT,
                tulotapa VARCHAR,
                taustaosasto_koodi_id BIGINT,
                taustaosasto VARCHAR,
                siirto_osastolle VARCHAR,
                siirto_palveluilta_ VARCHAR,
                CONSTRAINT osastohoito_pk PRIMARY KEY (id)
);
COMMENT ON TABLE main.osastohoito IS 'Taulun tiedot eri potilaasta';
COMMENT ON COLUMN main.osastohoito.id IS 'asia-kannan potilaan yksittäisen osastohoidon id';
COMMENT ON COLUMN main.osastohoito.tulotapa_koodi_id IS 'TULOTAPA_KOODI
Tulotapa (koodi)
CUARW/STAKE';
COMMENT ON COLUMN main.osastohoito.tulotapa IS 'TULOTAPA_SELITE
Tulotapa (selite)
Koodisto CUARW/STAKE';
COMMENT ON COLUMN main.osastohoito.taustaosasto_koodi_id IS 'TAUSTAOS_KOODI
Taustaosaston koodi
Koodisto?
Esim. 011';
COMMENT ON COLUMN main.osastohoito.taustaosasto IS 'TAUSTAOS_NIMI
Taustaosaston nimi
Koodisto?';
COMMENT ON COLUMN main.osastohoito.siirto_osastolle IS 'SIIRTO_OSASTOLLE
Onko hoitojaksosta tehty osastosiirto 
Kyllä/ei koodisto';
COMMENT ON COLUMN main.osastohoito.siirto_palveluilta_ IS 'SIIRTO_PALVELULTA
tieto palvelunumerosta josta siirryttiin';


CREATE TABLE main.kaynti (
                id BIGINT NOT NULL,
                palvelutapahtuma_id BIGINT NOT NULL,
                palvelun_tila_koodi_id BIGINT,
                palvelu_numero VARCHAR,
                kayntityyppi_koodi_id BIGINT,
                kayntityyppi VARCHAR,
                kayntityyppi_tarkenne_koodi_id BIGINT,
                kayntityyppi_tarkenne VARCHAR,
                jatkohoito_toimipiste_koodi_id BIGINT,
                jatkohoito_toimipiste VARCHAR,
                CONSTRAINT kaynti_pk PRIMARY KEY (id)
);
COMMENT ON COLUMN main.kaynti.id IS 'Tämä on turha, mutta olkoon.';
COMMENT ON COLUMN main.kaynti.palvelun_tila_koodi_id IS 'TILA_KOODI
Ajoitettu, toteutuksessa, toteutettu
koodisto?';
COMMENT ON COLUMN main.kaynti.kayntityyppi_koodi_id IS 'KAYNTITYYPPI_KOODI
KAYNTITYYPPI_KOODI
Käyntityyppikoodi

URANUS_Koodisto VISTQ/OWN

Esim. 04';
COMMENT ON COLUMN main.kaynti.kayntityyppi IS 'KAYNTITYYPPI_SELITE
Käyntityyppikoodin selite

URANUS koodisto VISTY/OWN
Esim. SARJAHOITO';
COMMENT ON COLUMN main.kaynti.jatkohoito_toimipiste_koodi_id IS 'jatkoh_toimipiste_koodi
Jatkohoitotoimipisteen koodi
Koodisto?';
COMMENT ON COLUMN main.kaynti.jatkohoito_toimipiste IS 'jatkoh_toimipiste_nimi
Jatkohoitotoimipisteen nimi
Koodi?';


CREATE SEQUENCE main.labra_id_seq;

CREATE TABLE main.labra (
                id BIGINT NOT NULL DEFAULT nextval('main.labra_id_seq'),
                potilas_asia_id BIGINT NOT NULL,
                lahde_koodi_id INTEGER NOT NULL,
                tiedon_omistaja_koodi_id INTEGER NOT NULL,
                tutkimusriviavain VARCHAR NOT NULL,
                naytteenotto_hetki TIMESTAMP NOT NULL,
                paatutkimuspaketti_koodi VARCHAR NOT NULL,
                paatutkimuspaketti VARCHAR,
                tutkimus_koodi VARCHAR,
                tutkimus VARCHAR,
                tulos_teksti VARCHAR,
                tulos_numeerinen DOUBLE PRECISION,
                mittayksikko VARCHAR,
                mittayksikko_koodi_id INTEGER NOT NULL,
                pyynto_hetki TIMESTAMP,
                analyysi_valmis_hetki TIMESTAMP,
                tulos_hyvaksytty_hetki TIMESTAMP,
                viitearvo_maksimi DOUBLE PRECISION,
                viitearvo_minimi DOUBLE PRECISION,
                viitearvojen_ulkopuolella_koodi VARCHAR,
                viitearvojen_ulkopuolella VARCHAR,
                tarkein_mikrobi_koodi VARCHAR,
                tarkein_mikrobi VARCHAR,
                ulkopuolella_teetetty_koodi VARCHAR,
                ulkopuolella_teetetty VARCHAR,
                projektin_tunnus_koodi VARCHAR,
                projektin_tunnus VARCHAR,
                putkien_lkm INTEGER,
                naytetunnus VARCHAR,
                tutkimuksen_tyyppi_koodi VARCHAR,
                tutkimuksen_tyyppi VARCHAR,
                kiireellinen_tutkimus_koodi VARCHAR,
                kiireellinen_tutkimus VARCHAR,
                tilaaja_taso_0_koodi VARCHAR,
                tilaaja_taso_1_koodi VARCHAR,
                tilaaja_taso_2_koodi VARCHAR,
                tilaaja_taso_3_koodi VARCHAR,
                tilaavan_yksikon_eala_koodi VARCHAR,
                tilaavan_yksikon_eala VARCHAR,
                laskutettu_hinta DOUBLE PRECISION,
                dt DATE NOT NULL,
                paivityshetki TIMESTAMP NOT NULL,
                CONSTRAINT labra_pk PRIMARY KEY (id)
);
COMMENT ON COLUMN main.labra.potilas_asia_id IS 'potilasasia = yksikäsitteinen potilas_id,  näytteenotto (datetime3) ja custorg0, custorg1, custorg2, custorg3, -kombinaatio';
COMMENT ON COLUMN main.labra.lahde_koodi_id IS 'Mistä järjestelmästä tieto on saatu';
COMMENT ON COLUMN main.labra.tutkimusriviavain IS 'testid
Tutkimusriviavain
Business key';
COMMENT ON COLUMN main.labra.naytteenotto_hetki IS 'datetime3
Näytteenotto

esim. 2009-09-09 14:21:00.0';
COMMENT ON COLUMN main.labra.paatutkimuspaketti_koodi IS 'testp
Codetable: ldwtx1_test
Päätutkimus(paketti)
Esim. 304';
COMMENT ON COLUMN main.labra.tutkimus_koodi IS 'Tutkimus (test)
Codetable ldwtx1_test1

Esim. 273';
COMMENT ON COLUMN main.labra.tulos_teksti IS 'outcomet
Tulos(teksti)
Täytetään vain kun tulos on teksti';
COMMENT ON COLUMN main.labra.tulos_numeerinen IS 'outcomen
Tulos (numeerinen)
esim. 4.7
Täytetään vain kun tulos numeerinen';
COMMENT ON COLUMN main.labra.mittayksikko IS 'unit
Tuloksen mittayksikkö
Esim. E9/l';
COMMENT ON COLUMN main.labra.pyynto_hetki IS 'datetime1
Pyyntö';
COMMENT ON COLUMN main.labra.analyysi_valmis_hetki IS 'datetime5
Analyysin valmistuminen';
COMMENT ON COLUMN main.labra.tulos_hyvaksytty_hetki IS 'datetime6
Tuloksen hyväksyminen';
COMMENT ON COLUMN main.labra.viitearvo_maksimi IS 'refmax
VIitearvo max
esim. 8.2';
COMMENT ON COLUMN main.labra.viitearvo_minimi IS 'refmin
viitearvo mimimi 
esim. 3.4';
COMMENT ON COLUMN main.labra.viitearvojen_ulkopuolella_koodi IS 'refval
VIitearvojen ulkopuolella
Codetable refval
esim. 0';
COMMENT ON COLUMN main.labra.tarkein_mikrobi_koodi IS 'microbe
Tärkein mikrobi
codetable ldwtx1_md';
COMMENT ON COLUMN main.labra.ulkopuolella_teetetty_koodi IS 'outsour
Ulkopuolella teetetty
Codetable ldwtx1_yesno';
COMMENT ON COLUMN main.labra.ulkopuolella_teetetty IS 'selite em. koodin perusteella';
COMMENT ON COLUMN main.labra.projektin_tunnus_koodi IS 'projid
Projektin tunnus
Codetable ldwtx1_projid';
COMMENT ON COLUMN main.labra.projektin_tunnus IS 'selite em. koodin perusteella';
COMMENT ON COLUMN main.labra.putkien_lkm IS 'mergeid
Yhdistelykoodi/putkien lkm';
COMMENT ON COLUMN main.labra.naytetunnus IS 'sampleid
Naytetunnus
EI YKSIKÄSITTEINEN: 
näytetunnus on kiertävä, eli kun näyte on kokonaan käsitelty, joku muu näyte voi saada saman näytetunnuksen. Kannattaa käyttää vain yhdistettynä hetuun, näytteenottohetkeen ja näyte_yhdistelykoodiin.';
COMMENT ON COLUMN main.labra.tutkimuksen_tyyppi_koodi IS 'testt
Tutkimuksen tyyppi
Codetable ldwtx1_ttype
Esim. 2';
COMMENT ON COLUMN main.labra.tutkimuksen_tyyppi IS 'selite em. koodin perusteella';
COMMENT ON COLUMN main.labra.kiireellinen_tutkimus_koodi IS 'urgency
Kiireellinen tutkimus 
Cotedables ldwtx1_yesno';
COMMENT ON COLUMN main.labra.kiireellinen_tutkimus IS 'selite em. koodin perusteella';
COMMENT ON COLUMN main.labra.tilaavan_yksikon_eala_koodi IS 'labspecd
Tilaavan yksilön eri. ala
codetable ownspec';
COMMENT ON COLUMN main.labra.tilaavan_yksikon_eala IS 'labspecd';
COMMENT ON COLUMN main.labra.laskutettu_hinta IS 'fee
Laskutettu hinta';
COMMENT ON COLUMN main.labra.dt IS 'Datan dt-partitio Hadoopissa';


ALTER SEQUENCE main.labra_id_seq OWNED BY main.labra.id;

CREATE TABLE main.sytostaattikuuri (
                id BIGINT NOT NULL,
                potilas_asia_id BIGINT NOT NULL,
                CONSTRAINT sytostaattikuuri_pk PRIMARY KEY (id)
);


CREATE TABLE main.sytostaattiannos (
                id BIGINT NOT NULL,
                potilas_asia_id BIGINT NOT NULL,
                CONSTRAINT sytostaattiannos_pk PRIMARY KEY (id)
);


CREATE TABLE main.sadehoito (
                id BIGINT NOT NULL,
                potilas_asia_id BIGINT NOT NULL,
                CONSTRAINT sadehoito_pk PRIMARY KEY (id)
);


CREATE TABLE main.patologia (
                id BIGINT NOT NULL,
                potilas_asia_id BIGINT NOT NULL,
                naytetyyppi VARCHAR,
                nayte_otettu TIMESTAMP,
                kliiniset_esitiedot VARCHAR,
                elin VARCHAR,
                tutkimus VARCHAR,
                diagnoosi VARCHAR,
                lausuntoteksti VARCHAR,
                kuitattu TIMESTAMP,
                tiedostolinkki VARCHAR,
                tiedosto_saatelinkki VARCHAR,
                tiedon_lahde_id VARCHAR,
                CONSTRAINT patologia_pk PRIMARY KEY (id)
);


CREATE TABLE main.kuvantaminen (
                id BIGINT NOT NULL,
                potilas_asia_id BIGINT NOT NULL,
                CONSTRAINT kuvantaminen_pk PRIMARY KEY (id)
);


ALTER TABLE main.osasto ADD CONSTRAINT laitos_osasto_fk
FOREIGN KEY (laitos_id)
REFERENCES main.laitos (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE main.leikkaus ADD CONSTRAINT osasto_leikkaus_fk
FOREIGN KEY (hoitava_osasto_id)
REFERENCES main.osasto (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE main.palvelutapahtuma ADD CONSTRAINT osasto_palvelutapahtuma_fk
FOREIGN KEY (osasto_id)
REFERENCES main.osasto (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE main.leikkaus ADD CONSTRAINT osasto_leikkaus_fk1
FOREIGN KEY (toimenpideosasto_id)
REFERENCES main.osasto (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE main.koodi ADD CONSTRAINT koodisto_koodinarvo_fk
FOREIGN KEY (koodisto_id)
REFERENCES main.koodisto (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE main.henkilon_identiteetti ADD CONSTRAINT koodinarvo_henkilon_identiteetti_fk
FOREIGN KEY (lahde_koodi_id)
REFERENCES main.koodi (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE main.potilas_tieto ADD CONSTRAINT koodinarvo_aidinkieli_fk
FOREIGN KEY (lahde_koodi_id)
REFERENCES main.koodi (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE main.henkilon_identiteetti ADD CONSTRAINT koodi_henkilon_identiteetti_fk
FOREIGN KEY (sukupuoli_koodi_id)
REFERENCES main.koodi (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE main.potilasnumero ADD CONSTRAINT koodi_potilasnumero_fk
FOREIGN KEY (lahde_koodi_id)
REFERENCES main.koodi (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE main.potilas ADD CONSTRAINT koodi_potilas_fk
FOREIGN KEY (lahde_koodi_id)
REFERENCES main.koodi (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE main.labra ADD CONSTRAINT koodi_labra_fk
FOREIGN KEY (lahde_koodi_id)
REFERENCES main.koodi (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE main.potilas_asia ADD CONSTRAINT koodi_potilas_asia_fk
FOREIGN KEY (lahde_koodi_id)
REFERENCES main.koodi (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE main.potilas_asia ADD CONSTRAINT koodi_potilas_asia_fk1
FOREIGN KEY (asia_koodi_id)
REFERENCES main.koodi (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE main.potilas_asia ADD CONSTRAINT koodi_potilas_asia_fk2
FOREIGN KEY (tiedon_omistaja_koodi_id)
REFERENCES main.koodi (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE main.labra ADD CONSTRAINT koodi_labra_fk2
FOREIGN KEY (mittayksikko_koodi_id)
REFERENCES main.koodi (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE main.labra ADD CONSTRAINT koodi_labra_fk1
FOREIGN KEY (tiedon_omistaja_koodi_id)
REFERENCES main.koodi (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE main.potilas_asia ADD CONSTRAINT potilas_potilas_asia_fk
FOREIGN KEY (potilas_id)
REFERENCES main.potilas (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE main.henkilon_identiteetti ADD CONSTRAINT potilas_hetu_fk
FOREIGN KEY (potilas_id)
REFERENCES main.potilas (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE main.potilas_tieto ADD CONSTRAINT potilas_aidinkieli_fk
FOREIGN KEY (potilas_id)
REFERENCES main.potilas (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE main.potilasnumero ADD CONSTRAINT potilas_potilasnumero_fk
FOREIGN KEY (potilas_id)
REFERENCES main.potilas (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE main.kuvantaminen ADD CONSTRAINT potilas_asia_kuvantaminen_fk
FOREIGN KEY (potilas_asia_id)
REFERENCES main.potilas_asia (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE main.patologia ADD CONSTRAINT potilas_asia_patologia_fk
FOREIGN KEY (potilas_asia_id)
REFERENCES main.potilas_asia (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE main.sadehoito ADD CONSTRAINT potilas_asia_sadehoito_fk
FOREIGN KEY (potilas_asia_id)
REFERENCES main.potilas_asia (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE main.sytostaattiannos ADD CONSTRAINT potilas_asia_sytostaattiannos_fk
FOREIGN KEY (potilas_asia_id)
REFERENCES main.potilas_asia (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE main.sytostaattikuuri ADD CONSTRAINT potilas_asia_sytostaattikuuri_fk
FOREIGN KEY (potilas_asia_id)
REFERENCES main.potilas_asia (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE main.labra ADD CONSTRAINT potilas_asia_labra_fk
FOREIGN KEY (potilas_asia_id)
REFERENCES main.potilas_asia (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE main.palvelutapahtuma ADD CONSTRAINT potilas_asia_palvelutapahtuma_fk
FOREIGN KEY (potilas_asia_id)
REFERENCES main.potilas_asia (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE main.leikkaus ADD CONSTRAINT potilas_asia_leikkaus_fk
FOREIGN KEY (potilas_asia_id)
REFERENCES main.potilas_asia (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE main.leikkaus_toimenpide ADD CONSTRAINT leikkaus_leikkaus_toimenpide_fk
FOREIGN KEY (leikkaus_id)
REFERENCES main.leikkaus (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE main.kaynti ADD CONSTRAINT palvelutapahtuma_kaynti_fk
FOREIGN KEY (palvelutapahtuma_id)
REFERENCES main.palvelutapahtuma (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE main.osastohoito ADD CONSTRAINT palvelutapahtuma_osastohoito_fk
FOREIGN KEY (palvelutapahtuma_id)
REFERENCES main.palvelutapahtuma (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE main.diagnoosi ADD CONSTRAINT palvelutapahtuma_diagnoosi_fk
FOREIGN KEY (palvelutapahtuma_id)
REFERENCES main.palvelutapahtuma (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE main.toimenpide ADD CONSTRAINT palvelutapahtuma_toimenpide_fk
FOREIGN KEY (palvelutapahtuma_id)
REFERENCES main.palvelutapahtuma (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE main.lisatoimenpide ADD CONSTRAINT toimenpide_lisatoimenpide_fk
FOREIGN KEY (paatoimenpide_johon_liittyy_id)
REFERENCES main.toimenpide (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
