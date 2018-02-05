
-- KTP Hive database 
--
-- Log is using beeline:
-- beeline -u jdbc:hive2://ktphadoop.vsshp.net:10000

CREATE DATABASE IF NOT EXISTS ktp
LOCATION '/user/hive/warehouse/ktp';
USE ktp;


