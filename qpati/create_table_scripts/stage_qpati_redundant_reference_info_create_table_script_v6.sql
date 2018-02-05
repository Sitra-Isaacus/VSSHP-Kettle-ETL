


CREATE TABLE stage_qpati.QPatiSample (
                QPatiSample_id BIGSERIAL,
                ExportTime VARCHAR,
                PatientID VARCHAR,
                PatientName VARCHAR,
                PatientNumber VARCHAR,
                PatientNumberUranus VARCHAR,
                RecordNumber VARCHAR,
                SampleNumberExternal VARCHAR,
                SampleNumberInternal VARCHAR,
                patientRoleId VARCHAR,
                recordType VARCHAR,
                patientNameFamily VARCHAR,
                patientNameGiven VARCHAR,
                xml_filename VARCHAR NOT NULL,
                IO BIGINT NOT NULL,
                downloaded_from_allas TIMESTAMP NOT NULL,
                CONSTRAINT qpatisample_pk PRIMARY KEY (QPatiSample_id)
);
COMMENT ON COLUMN stage_qpati.QPatiSample.PatientID IS 'hetu QPatiSample-lohkosta (QPatista tuleva tieto)';
COMMENT ON COLUMN stage_qpati.QPatiSample.patientRoleId IS 'hetu';



CREATE TABLE stage_qpati.QPatiOrder (
                QPatiOrder_id BIGSERIAL,
                QPatiSample_id BIGINT NOT NULL,
                OrderNumber INTEGER NOT NULL,
                SampleNumberInternal VARCHAR,
                SampleNumberExternal VARCHAR,
                PatientID VARCHAR,
                patientRoleId VARCHAR,
                xml_filename VARCHAR NOT NULL,
                CONSTRAINT qpatiorder_pk PRIMARY KEY (QPatiOrder_id)
);
COMMENT ON COLUMN stage_qpati.QPatiOrder.QPatiOrder_id IS 'generated key';
COMMENT ON COLUMN stage_qpati.QPatiOrder.QPatiSample_id IS 'ref to QPatiSample table';



CREATE TABLE stage_qpati.QPatiAnswer (
                QPatiAnswer_id BIGSERIAL,
                QPatiOrder_id BIGINT NOT NULL,
                Acked VARCHAR,
                AckingSaved VARCHAR,
                Age VARCHAR,
                Anamnesis TEXT,
                AnamnesisTableName VARCHAR,
                AnswerCopy VARCHAR,
                AnswerDelayDays VARCHAR,
                AnswerDelayMinutes VARCHAR,
                AnswerNumber INTEGER NOT NULL,
                Arrived VARCHAR,
                ArrivedIn VARCHAR,
                ArrivingSaved VARCHAR,
                BiobankProtocol VARCHAR,
                ClinicalExtraInfo VARCHAR,
                Concerned VARCHAR,
                ControlCodes VARCHAR,
                DeathDate VARCHAR,
                Dictated VARCHAR,
                DictationWriter VARCHAR,
                DisposingAllowed VARCHAR,
                DisposingDate VARCHAR,
                DoneByUnit VARCHAR,
                DoneByUnitHL7Id VARCHAR,
                DoneByUnitSampleNumber VARCHAR,
                ExtraWageIncluded VARCHAR,
                HL7Id VARCHAR,
                Hurry VARCHAR,
                InternalId VARCHAR,
                Isolation VARCHAR,
                Laboratory VARCHAR,
                Language VARCHAR,
                MainType VARCHAR,
                MassAcked VARCHAR,
                NewAnswerBefore VARCHAR,
                NewAnswerBeforeDate VARCHAR,
                NextSampleToSameExaminer VARCHAR,
                NoHL7Sending VARCHAR,
                NumberOfBlocks VARCHAR,
                NumberOfBottles VARCHAR,
                NumberOfSlides VARCHAR,
                OnStartAssistant VARCHAR,
                OnStartDate VARCHAR,
                OnStartPerson VARCHAR,
                OrderId VARCHAR,
                OtherComments VARCHAR,
                PapaClass VARCHAR,
                PatientAdministrationId VARCHAR,
                PatientNumber VARCHAR,
                PayablesAccountNumber VARCHAR,
                PayClass VARCHAR,
                Payer VARCHAR,
                PhonedAnswer VARCHAR,
                Price VARCHAR,
                PrintMacroscopyStatement VARCHAR,
                PrintMacroscopyTable VARCHAR,
                Project VARCHAR,
                Protected VARCHAR,
                QuickAck VARCHAR,
                ReadyBefore VARCHAR,
                ReadyForAck VARCHAR,
                Receiver VARCHAR,
                Returned VARCHAR,
                Reviewer VARCHAR,
                ReviewingAssigned VARCHAR,
                ReviewingDirected VARCHAR,
                ReviewingReady VARCHAR,
                ReviewingTableName VARCHAR,
                SampleTaken VARCHAR,
                SampleType VARCHAR,
                SavingTime VARCHAR,
                Sender VARCHAR,
                SendingDoctor VARCHAR,
                Sent VARCHAR,
                SerialSample VARCHAR,
                SplitDate VARCHAR,
                SplitExaminer VARCHAR,
                SplitTeam VARCHAR,
                SplitTeamDate VARCHAR,
                Statement TEXT,
                StatementNote VARCHAR,
                SytologyAssistantsNote VARCHAR,
                SytologyAssistantsPapaClass VARCHAR,
                SytologyPrevCheckDate VARCHAR,
                SytologyPrevCheckTableName VARCHAR,
                SytologyPrevCheckTableName_BPID VARCHAR,
                Transcribed VARCHAR,
                UnderRepair VARCHAR,
                QPatiAnswerUser VARCHAR,
                VersionNumber INTEGER NOT NULL,
                WhatAndWhere VARCHAR,
                SampleNumberInternal VARCHAR,
                SampleNumberExternal VARCHAR,
                PatientID VARCHAR,
                patientRoleId VARCHAR,
                OrderNumber INTEGER NOT NULL,
                xml_filename VARCHAR NOT NULL,
                CONSTRAINT qpatianswer_pk PRIMARY KEY (QPatiAnswer_id)
);
COMMENT ON COLUMN stage_qpati.QPatiAnswer.QPatiOrder_id IS 'ref to QpatiOrder table';
COMMENT ON COLUMN stage_qpati.QPatiAnswer.Acked IS 'Kuitattu(?)';



CREATE TABLE stage_qpati.StatementTableCellData (
                StatementTableCellData_id BIGSERIAL,
                QPatiAnswer_id BIGINT NOT NULL,
                BPID VARCHAR,
                CellType VARCHAR,
                Col INTEGER NOT NULL,
                InternalValue VARCHAR,
                Row INTEGER NOT NULL,
                Value VARCHAR,
                TableNumber INTEGER,
                TableName VARCHAR,
                TableName_BPID VARCHAR,
                SampleNumberExternal VARCHAR,
                SampleNumberInternal VARCHAR,
                patientRoleId VARCHAR,
                PatientID VARCHAR,
                OrderNumber INTEGER NOT NULL,
                AnswerNumber INTEGER NOT NULL,
                VersionNumber INTEGER NOT NULL,
                xml_filename VARCHAR NOT NULL,
                CONSTRAINT statementtablecelldata_pk PRIMARY KEY (StatementTableCellData_id)
);
COMMENT ON COLUMN stage_qpati.StatementTableCellData.StatementTableCellData_id IS 'generated key';
COMMENT ON COLUMN stage_qpati.StatementTableCellData.TableNumber IS 'extracted from tag name
StatementTable[ 2345]';



CREATE TABLE stage_qpati.DiagnoseRow (
                DiagnoseRow_id BIGSERIAL,
                QPatiAnswer_id BIGINT NOT NULL,
                Diagnose VARCHAR,
                DiagnoseSuffix VARCHAR,
                M_Snomed VARCHAR,
                Organ VARCHAR,
                OrganPrefix VARCHAR,
                OrganSuffix VARCHAR,
                RowNumber VARCHAR,
                T_Snomed VARCHAR,
                AlertDiagnose VARCHAR,
                CancerSample VARCHAR,
                NoteDiagnose VARCHAR,
                SampleNumberInternal VARCHAR,
                SampleNumberExternal VARCHAR,
                patientRoleId VARCHAR,
                PatientID VARCHAR,
                OrderNumber INTEGER NOT NULL,
                AnswerNumber INTEGER NOT NULL,
                VersionNumber INTEGER NOT NULL,
                xml_filename VARCHAR NOT NULL,
                CONSTRAINT diagnoserow_pk PRIMARY KEY (DiagnoseRow_id)
);



CREATE TABLE stage_qpati.ExaminationRow (
                ExaminationRow_id BIGSERIAL,
                QPatiAnswer_id BIGINT NOT NULL,
                Count VARCHAR,
                Examination VARCHAR,
                HL7 VARCHAR,
                Price VARCHAR,
                RowNumber VARCHAR,
                SampleNumberExternal VARCHAR,
                SampleNumberInternal VARCHAR,
                patientRoleId VARCHAR,
                PatientID VARCHAR,
                OrderNumber INTEGER NOT NULL,
                AnswerNumber INTEGER NOT NULL,
                VersionNumber INTEGER NOT NULL,
                xml_filename VARCHAR NOT NULL,
                CONSTRAINT examinationrow_pk PRIMARY KEY (ExaminationRow_id)
);
COMMENT ON COLUMN stage_qpati.ExaminationRow.ExaminationRow_id IS 'generated key';



ALTER TABLE stage_qpati.QPatiOrder ADD CONSTRAINT qpatisample_qpatiorder_fk
FOREIGN KEY (QPatiSample_id)
REFERENCES stage_qpati.QPatiSample (QPatiSample_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE stage_qpati.QPatiAnswer ADD CONSTRAINT qpatiorder_qpatianswer_fk
FOREIGN KEY (QPatiOrder_id)
REFERENCES stage_qpati.QPatiOrder (QPatiOrder_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE stage_qpati.ExaminationRow ADD CONSTRAINT qpatianswer_examinations_fk
FOREIGN KEY (QPatiAnswer_id)
REFERENCES stage_qpati.QPatiAnswer (QPatiAnswer_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE stage_qpati.DiagnoseRow ADD CONSTRAINT qpatianswer_diagnosis_fk
FOREIGN KEY (QPatiAnswer_id)
REFERENCES stage_qpati.QPatiAnswer (QPatiAnswer_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE stage_qpati.StatementTableCellData ADD CONSTRAINT qpatianswer_celldata_fk
FOREIGN KEY (QPatiAnswer_id)
REFERENCES stage_qpati.QPatiAnswer (QPatiAnswer_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
