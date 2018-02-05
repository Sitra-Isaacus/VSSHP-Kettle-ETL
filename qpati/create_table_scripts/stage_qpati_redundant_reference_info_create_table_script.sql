

CREATE TABLE stage_qpati.QPatiSample (
                QPatiSample_id BIGSERIAL NOT NULL,
                ExportTime TIMESTAMP,
                PatientID VARCHAR(8000),
                PatientName VARCHAR(8000),
                PatientNumber VARCHAR(8000),
                PatientNumberUranus VARCHAR(8000),
                RecordNumber VARCHAR(8000),
                SampleNumberExternal VARCHAR(8000),
                SampleNumberInternal VARCHAR(8000),
                patientRoleId VARCHAR(8000),
                recordType VARCHAR(8000),
                patientNameFamily VARCHAR(8000),
                patientNameGiven VARCHAR(8000),
                xml_filename VARCHAR(8000) NOT NULL,
                IO BIGINT NOT NULL,
                downloaded_from_allas TIMESTAMP NOT NULL,
                CONSTRAINT qpatisample_pk PRIMARY KEY (QPatiSample_id)
);
COMMENT ON COLUMN stage_qpati.QPatiSample.PatientID IS 'hetu QPatiSample-lohkosta (QPatista tuleva tieto)';
COMMENT ON COLUMN stage_qpati.QPatiSample.patientRoleId IS 'hetu';



CREATE TABLE stage_qpati.QPatiOrder (
                QPatiOrder_id BIGSERIAL NOT NULL,
                QPatiSample_id BIGINT,
                OrderNumber VARCHAR(8000),
                SampleNumberInternal VARCHAR(8000),
                SampleNumberExternal VARCHAR(8000),
                PatientID VARCHAR(8000),
                patientRoleId VARCHAR(8000),
                xml_filename VARCHAR(8000) NOT NULL,
                CONSTRAINT qpatiorder_pk PRIMARY KEY (QPatiOrder_id)
);
COMMENT ON COLUMN stage_qpati.QPatiOrder.QPatiOrder_id IS 'generated key';
COMMENT ON COLUMN stage_qpati.QPatiOrder.QPatiSample_id IS 'ref to QPatiSample table';


CREATE TABLE stage_qpati.QPatiAnswer (
                QPatiAnswer_id BIGSERIAL NOT NULL,
                QPatiOrder_id BIGINT,
                Acked VARCHAR(8000),
                AckingSaved VARCHAR(8000),
                Age VARCHAR(8000),
                Anamnesis TEXT,
                AnamnesisTableName VARCHAR(8000),
                AnswerCopy VARCHAR(8000),
                AnswerDelayDays VARCHAR(8000),
                AnswerDelayMinutes VARCHAR(8000),
                AnswerNumber VARCHAR(8000),
                Arrived VARCHAR(8000),
                ArrivedIn VARCHAR(8000),
                ArrivingSaved VARCHAR(8000),
                BiobankProtocol VARCHAR(8000),
                ClinicalExtraInfo VARCHAR(8000),
                Concerned VARCHAR(8000),
                ControlCodes VARCHAR(8000),
                DeathDate VARCHAR(8000),
                Dictated VARCHAR(8000),
                DictationWriter VARCHAR(8000),
                DisposingAllowed VARCHAR(8000),
                DisposingDate VARCHAR(8000),
                DoneByUnit VARCHAR(8000),
                DoneByUnitHL7Id VARCHAR(8000),
                DoneByUnitSampleNumber VARCHAR(8000),
                ExtraWageIncluded VARCHAR(8000),
                HL7Id VARCHAR(8000),
                Hurry VARCHAR(8000),
                InternalId VARCHAR(8000),
                Isolation VARCHAR(8000),
                Laboratory VARCHAR(8000),
                Language VARCHAR(8000),
                MainType VARCHAR(8000),
                MassAcked VARCHAR(8000),
                NewAnswerBefore VARCHAR(8000),
                NewAnswerBeforeDate VARCHAR(8000),
                NextSampleToSameExaminer VARCHAR(8000),
                NoHL7Sending VARCHAR(8000),
                NumberOfBlocks VARCHAR(8000),
                NumberOfBottles VARCHAR(8000),
                NumberOfSlides VARCHAR(8000),
                OnStartAssistant VARCHAR(8000),
                OnStartDate VARCHAR(8000),
                OnStartPerson VARCHAR(8000),
                OrderId VARCHAR(8000),
                OtherComments VARCHAR(8000),
                PapaClass VARCHAR(8000),
                PatientAdministrationId VARCHAR(8000),
                PatientNumber VARCHAR(8000),
                PayablesAccountNumber VARCHAR(8000),
                PayClass VARCHAR(8000),
                Payer VARCHAR(8000),
                PhonedAnswer VARCHAR(8000),
                Price VARCHAR(8000),
                PrintMacroscopyStatement VARCHAR(8000),
                PrintMacroscopyTable VARCHAR(8000),
                Project VARCHAR(8000),
                Protected VARCHAR(8000),
                QuickAck VARCHAR(8000),
                ReadyBefore VARCHAR(8000),
                ReadyForAck VARCHAR(8000),
                Receiver VARCHAR(8000),
                Returned VARCHAR(8000),
                Reviewer VARCHAR(8000),
                ReviewingAssigned VARCHAR(8000),
                ReviewingDirected VARCHAR(8000),
                ReviewingReady VARCHAR(8000),
                ReviewingTableName VARCHAR(8000),
                SampleTaken VARCHAR(8000),
                SampleType VARCHAR(8000),
                SavingTime VARCHAR(8000),
                Sender VARCHAR(8000),
                SendingDoctor VARCHAR(8000),
                Sent VARCHAR(8000),
                SerialSample VARCHAR(8000),
                SplitDate VARCHAR(8000),
                SplitExaminer VARCHAR(8000),
                SplitTeam VARCHAR(8000),
                SplitTeamDate VARCHAR(8000),
                Statement TEXT,
                StatementNote VARCHAR(8000),
                SytologyAssistantsNote VARCHAR(8000),
                SytologyAssistantsPapaClass VARCHAR(8000),
                SytologyPrevCheckDate VARCHAR(8000),
                SytologyPrevCheckTableName VARCHAR(8000),
                SytologyPrevCheckTableName_BPID VARCHAR(8000),
                Transcribed VARCHAR(8000),
                UnderRepair VARCHAR(8000),
                QPatiAnswerUser VARCHAR(8000),
                VersionNumber VARCHAR(8000),
                WhatAndWhere VARCHAR(8000),
                SampleNumberInternal VARCHAR(8000),
                SampleNumberExternal VARCHAR(8000),
                PatientID VARCHAR(8000),
                patientRoleId VARCHAR(8000),
                OrderNumber VARCHAR(8000),
                xml_filename VARCHAR(8000) NOT NULL,
                CONSTRAINT qpatianswer_pk PRIMARY KEY (QPatiAnswer_id)
);
COMMENT ON COLUMN stage_qpati.QPatiAnswer.QPatiOrder_id IS 'ref to QpatiOrder table';
COMMENT ON COLUMN stage_qpati.QPatiAnswer.Acked IS 'Kuitattu(?)';


CREATE TABLE stage_qpati.StatementTableCellData (
                StatementTableCellData_id BIGSERIAL NOT NULL,
                QPatiAnswer_id BIGINT,
                BPID VARCHAR(8000),
                CellType VARCHAR(8000),
                Col VARCHAR(8000),
                InternalValue VARCHAR(8000),
                Row VARCHAR(8000),
                Value VARCHAR(8000),
                TableNumber INTEGER,
                TableName VARCHAR(8000),
                TableName_BPID VARCHAR(8000),
                SampleNumberExternal VARCHAR(8000),
                SampleNumberInternal VARCHAR(8000),
                patientRoleId VARCHAR(8000),
                PatientID VARCHAR(8000),
                OrderNumber VARCHAR(8000),
                AnswerNumber VARCHAR(8000),
                VersionNumber VARCHAR(8000),
                xml_filename VARCHAR(8000) NOT NULL,
                CONSTRAINT statementtablecelldata_pk PRIMARY KEY (StatementTableCellData_id)
);
COMMENT ON COLUMN stage_qpati.StatementTableCellData.StatementTableCellData_id IS 'generated key';
COMMENT ON COLUMN stage_qpati.StatementTableCellData.TableNumber IS 'extracted from tag name
StatementTable[ 2345]';



CREATE TABLE stage_qpati.DiagnoseRow (
                DiagnoseRow_id BIGSERIAL NOT NULL,
                QPatiAnswer_id BIGINT,
                Diagnose VARCHAR(8000),
                DiagnoseSuffix VARCHAR(8000),
                M_Snomed VARCHAR(8000),
                Organ VARCHAR(8000),
                OrganPrefix VARCHAR(8000),
                OrganSuffix VARCHAR(8000),
                RowNumber VARCHAR(8000),
                T_Snomed VARCHAR(8000),
                AlertDiagnose VARCHAR(8000),
                CancerSample VARCHAR(8000),
                NoteDiagnose VARCHAR(8000),
                SampleNumberInternal VARCHAR(8000),
                SampleNumberExternal VARCHAR(8000),
                patientRoleId VARCHAR(8000),
                PatientID VARCHAR(8000),
                OrderNumber VARCHAR(8000),
                AnswerNumber VARCHAR(8000),
                VersionNumber VARCHAR(8000),
                xml_filename VARCHAR(8000) NOT NULL,
                CONSTRAINT diagnoserow_pk PRIMARY KEY (DiagnoseRow_id)
);



CREATE TABLE stage_qpati.ExaminationRow (
                ExaminationRow_id BIGSERIAL NOT NULL,
                QPatiAnswer_id BIGINT,
                Count VARCHAR(8000),
                Examination VARCHAR(8000),
                HL7 VARCHAR(8000),
                Price VARCHAR(8000),
                RowNumber VARCHAR(8000),
                SampleNumberExternal VARCHAR(8000),
                SampleNumberInternal VARCHAR(8000),
                patientRoleId VARCHAR(8000),
                PatientID VARCHAR(8000),
                OrderNumber VARCHAR(8000),
                AnswerNumber VARCHAR(8000),
                VersionNumber VARCHAR(8000),
                xml_filename VARCHAR(8000) NOT NULL,
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
