DROP IF EXISTS TABLE stage_hadoop.lab;

CREATE TABLE stage_hadoop.lab (
  id BIGSERIAL PRIMARY KEY
, testid VARCHAR
, testp VARCHAR
, test VARCHAR
, testt INTEGER
, urgency INTEGER
, sampleid VARCHAR
, cost DOUBLE PRECISION
, fee DOUBLE PRECISION
, outcomet VARCHAR
, outcomen DOUBLE PRECISION
, unit VARCHAR
, microbe VARCHAR
, refmin DOUBLE PRECISION
, refmax DOUBLE PRECISION
, refval DOUBLE PRECISION
, outsour VARCHAR
, weekday VARCHAR
, custorg0 VARCHAR
, custorg1 VARCHAR
, custorg2 VARCHAR
, custorg3 VARCHAR
, custorgt VARCHAR
, projid VARCHAR
, payer1 VARCHAR
, payer2 VARCHAR
, provorg1 VARCHAR
, labspecd VARCHAR
, labspec VARCHAR
, provorg2 VARCHAR
, testorg VARCHAR
, datetime1  TIMESTAMP
, datetime2  TIMESTAMP
, datetime3  TIMESTAMP
, datetime4  TIMESTAMP
, datetime5  TIMESTAMP
, datetime6  TIMESTAMP
, datetime7  TIMESTAMP
, delay1 VARCHAR
, delay2 VARCHAR
, delay3 VARCHAR
, delay4 VARCHAR
, delay5 VARCHAR
, delay6 VARCHAR
, macid VARCHAR
, batchid VARCHAR
, patidcode VARCHAR
, agedays VARCHAR
, ageyear VARCHAR
, sex VARCHAR
, patarea1 VARCHAR
, spec VARCHAR
, agecat1 VARCHAR
, autoack VARCHAR
, dayt1 VARCHAR
, dayt2 VARCHAR
, dayt3 VARCHAR
, dayt4 VARCHAR
, dayt5 VARCHAR
, dayt6 VARCHAR
, dayt7 VARCHAR
, dayt8 VARCHAR
, macgrp VARCHAR
, testgrp VARCHAR
, agecat2 VARCHAR
, agecat3 VARCHAR
, hetu VARCHAR
, mergeid VARCHAR
, datetime8  TIMESTAMP
, dt DATE 
);

-- CREATE INDEX lab_dt_index ON lab (dt);
