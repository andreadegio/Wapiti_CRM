-- ----------------------------------------------------------------------------
-- MySQL Workbench Migration
-- Migrated Schemata: abyway
-- Source Schemata: abyway
-- Created: Fri Jun 28 16:40:34 2024
-- Workbench Version: 8.0.26
-- ----------------------------------------------------------------------------

SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------------------------------------------------------
-- Schema abyway
-- ----------------------------------------------------------------------------
DROP SCHEMA IF EXISTS `abyway` ;
CREATE SCHEMA IF NOT EXISTS `abyway` ;

-- ----------------------------------------------------------------------------
-- Table abyway.academy_corsi
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `abyway`.`academy_corsi` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `corso` VARCHAR(100) NULL DEFAULT NULL,
  `descrizione` LONGTEXT NULL DEFAULT NULL,
  `cover` VARCHAR(45) NULL DEFAULT NULL,
  `attivo` INT(11) NOT NULL DEFAULT '1',
  `quiz` INT(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = latin1;

-- ----------------------------------------------------------------------------
-- Table abyway.academy_credenziali
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `abyway`.`academy_credenziali` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `id_anagrafica` INT(11) NULL DEFAULT NULL,
  `nome_utente` VARCHAR(100) NULL DEFAULT NULL,
  `pin` INT(8) NULL DEFAULT NULL,
  `link` VARCHAR(300) NULL DEFAULT NULL,
  `data_ins` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 23
DEFAULT CHARACTER SET = latin1;

-- ----------------------------------------------------------------------------
-- Table abyway.academy_log
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `abyway`.`academy_log` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `id_video` INT(11) NOT NULL,
  `id_utente` INT(11) NOT NULL,
  `log` LONGTEXT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

-- ----------------------------------------------------------------------------
-- Table abyway.academy_quiz
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `abyway`.`academy_quiz` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(255) NOT NULL,
  `course_id` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = latin1;

-- ----------------------------------------------------------------------------
-- Table abyway.academy_quiz_answers
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `abyway`.`academy_quiz_answers` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `quiz_id` INT(11) NULL DEFAULT NULL,
  `question_id` INT(11) NULL DEFAULT NULL,
  `answer_text` TEXT CHARACTER SET 'latin1' NULL DEFAULT NULL,
  `is_correct` TINYINT(1) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 64
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;

-- ----------------------------------------------------------------------------
-- Table abyway.academy_quiz_questions
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `abyway`.`academy_quiz_questions` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `quiz_id` INT(11) NULL DEFAULT NULL,
  `question_text` TEXT CHARACTER SET 'latin1' NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 22
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;

-- ----------------------------------------------------------------------------
-- Table abyway.academy_quiz_results
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `abyway`.`academy_quiz_results` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `user_id` INT(11) NULL DEFAULT NULL,
  `quiz_id` INT(11) NULL DEFAULT NULL,
  `course_id` INT(11) NULL DEFAULT NULL,
  `score` INT(11) NULL DEFAULT NULL,
  `passed` TINYINT(4) NOT NULL,
  `data` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 60
DEFAULT CHARACTER SET = latin1;

-- ----------------------------------------------------------------------------
-- Table abyway.academy_quiz_results_useraby
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `abyway`.`academy_quiz_results_useraby` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `user_id` INT(11) NULL DEFAULT NULL,
  `quiz_id` INT(11) NULL DEFAULT NULL,
  `course_id` INT(11) NULL DEFAULT NULL,
  `score` INT(11) NULL DEFAULT NULL,
  `passed` TINYINT(4) NOT NULL,
  `data` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 10
DEFAULT CHARACTER SET = latin1;

-- ----------------------------------------------------------------------------
-- Table abyway.academy_stato_corso
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `abyway`.`academy_stato_corso` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `id_utente` INT(11) NULL DEFAULT NULL,
  `id_corso` INT(11) NULL DEFAULT NULL,
  `id_video` INT(11) NULL DEFAULT NULL,
  `timestampinizio` VARCHAR(20) NULL DEFAULT NULL,
  `completo` TINYINT(1) NULL DEFAULT '0',
  `last_update` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `unique_user_course_video` (`id_utente` ASC, `id_corso` ASC, `id_video` ASC),
  INDEX `id_utente` (`id_utente` ASC),
  INDEX `id_corso` (`id_corso` ASC),
  INDEX `id_video` (`id_video` ASC),
  CONSTRAINT `academy_stato_corso_ibfk_1`
    FOREIGN KEY (`id_utente`)
    REFERENCES `abyway`.`crm_anagrafica` (`id_anagrafica`),
  CONSTRAINT `academy_stato_corso_ibfk_2`
    FOREIGN KEY (`id_corso`)
    REFERENCES `abyway`.`academy_corsi` (`id`),
  CONSTRAINT `academy_stato_corso_ibfk_3`
    FOREIGN KEY (`id_video`)
    REFERENCES `abyway`.`academy_video` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 784
DEFAULT CHARACTER SET = latin1;

-- ----------------------------------------------------------------------------
-- Table abyway.academy_stato_corso_useraby
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `abyway`.`academy_stato_corso_useraby` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `id_utente` INT(11) NULL DEFAULT NULL,
  `id_corso` INT(11) NULL DEFAULT NULL,
  `id_video` INT(11) NULL DEFAULT NULL,
  `timestampinizio` VARCHAR(20) NULL DEFAULT NULL,
  `completo` TINYINT(1) NULL DEFAULT '0',
  `last_update` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `unique_user_course_video` (`id_utente` ASC, `id_corso` ASC, `id_video` ASC),
  INDEX `id_utente` (`id_utente` ASC),
  INDEX `id_corso` (`id_corso` ASC),
  INDEX `id_video` (`id_video` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 626
DEFAULT CHARACTER SET = latin1;

-- ----------------------------------------------------------------------------
-- Table abyway.academy_video
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `abyway`.`academy_video` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `id_corso` INT(11) NULL DEFAULT NULL,
  `titolo` VARCHAR(100) NULL DEFAULT NULL,
  `descrizione` LONGTEXT NULL DEFAULT NULL,
  `file` VARCHAR(100) NULL DEFAULT NULL,
  `durata` VARCHAR(45) NULL DEFAULT NULL,
  `ordine` INT(11) NULL DEFAULT NULL,
  `attivo` INT(11) NULL DEFAULT NULL,
  `permessi` INT(11) NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = latin1;

-- ----------------------------------------------------------------------------
-- Table abyway.area
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `abyway`.`area` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `area` VARCHAR(45) NOT NULL,
  `area_color` VARCHAR(45) NULL DEFAULT NULL,
  `active` TINYINT(4) NOT NULL DEFAULT '1',
  `id_settore_padre` INT(11) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 8
DEFAULT CHARACTER SET = latin1
COMMENT = 'Area operativa: veicoli, flotte e trasporti, retail e professionisti, aziende e fidejussioni';

-- ----------------------------------------------------------------------------
-- Table abyway.autorized_file
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `abyway`.`autorized_file` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `id_fileUpload` INT(11) NOT NULL,
  `id_unita_operativa_tipo` INT(11) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 376
DEFAULT CHARACTER SET = latin1;

-- ----------------------------------------------------------------------------
-- Table abyway.avvisitoast
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `abyway`.`avvisitoast` (
  `idAvvisiToast` INT(11) NOT NULL AUTO_INCREMENT,
  `titolo` VARCHAR(100) NULL DEFAULT NULL,
  `contenuto` LONGTEXT NULL DEFAULT NULL,
  `attivo` TINYINT(4) NULL DEFAULT '1',
  PRIMARY KEY (`idAvvisiToast`),
  UNIQUE INDEX `idAvvisiToast_UNIQUE` (`idAvvisiToast` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = latin1;

-- ----------------------------------------------------------------------------
-- Table abyway.corsi
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `abyway`.`corsi` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `id_categoria` INT(11) NULL DEFAULT '2',
  `titolo` VARCHAR(200) NULL DEFAULT NULL,
  `sottotitolo` VARCHAR(200) NULL DEFAULT NULL,
  `contenuto` TEXT NULL DEFAULT NULL,
  `obiettivi` TEXT NULL DEFAULT NULL,
  `durata` INT(10) NULL DEFAULT NULL,
  `copertina` VARCHAR(100) NULL DEFAULT NULL,
  `allegati` TINYINT(4) NULL DEFAULT NULL,
  `id_utente_insert` INT(11) NULL DEFAULT NULL,
  `utente_insert` VARCHAR(100) NULL DEFAULT NULL,
  `date_insert` DATETIME NULL DEFAULT NULL,
  `id_utente_edit` INT(11) NULL DEFAULT NULL,
  `utente_edit` VARCHAR(100) NULL DEFAULT NULL,
  `date_edit` DATETIME NULL DEFAULT NULL,
  `id_utente_del` INT(11) NULL DEFAULT NULL,
  `utente_del` VARCHAR(100) NULL DEFAULT NULL,
  `date_del` DATETIME NULL DEFAULT NULL,
  `deleted` TINYINT(4) NULL DEFAULT '0',
  `priority` INT(11) NULL DEFAULT '0',
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 75
DEFAULT CHARACTER SET = latin1
COMMENT = 'Tabella contenente i corsi di formazione	';

-- ----------------------------------------------------------------------------
-- Table abyway.corsi_attachments
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `abyway`.`corsi_attachments` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `id_corso` INT(11) NOT NULL,
  `id_upload` INT(11) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 49
DEFAULT CHARACTER SET = latin1
COMMENT = 'Tabella di link per gli allegati ai corsi';

-- ----------------------------------------------------------------------------
-- Table abyway.corsi_authorizations
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `abyway`.`corsi_authorizations` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `id_corso` INT(11) NOT NULL,
  `id_unita_operativa_tipo` INT(11) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 255
DEFAULT CHARACTER SET = latin1
COMMENT = 'Tabella di link per i permessi di visualizzazione dei corsi';

-- ----------------------------------------------------------------------------
-- Table abyway.corsi_category
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `abyway`.`corsi_category` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `descrizione` VARCHAR(100) NOT NULL,
  `label_color` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 8
DEFAULT CHARACTER SET = latin1
COMMENT = 'Tabella con le categorie per i corsi';

-- ----------------------------------------------------------------------------
-- Table abyway.crm_anagrafica
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `abyway`.`crm_anagrafica` (
  `id_anagrafica` INT(11) NOT NULL AUTO_INCREMENT,
  `id_step` INT(11) NULL DEFAULT NULL,
  `id_tipologia` INT(11) NULL DEFAULT NULL,
  `pf_pg` VARCHAR(2) CHARACTER SET 'latin1' NOT NULL,
  `nome` VARCHAR(45) CHARACTER SET 'latin1' NULL DEFAULT NULL,
  `cognome` VARCHAR(45) CHARACTER SET 'latin1' NULL DEFAULT NULL,
  `agenzia` VARCHAR(45) CHARACTER SET 'latin1' NULL DEFAULT NULL,
  `rag_soc` VARCHAR(45) CHARACTER SET 'latin1' NULL DEFAULT NULL,
  `referente` VARCHAR(45) CHARACTER SET 'latin1' NULL DEFAULT NULL,
  `cf` VARCHAR(45) CHARACTER SET 'latin1' NULL DEFAULT NULL,
  `piva` VARCHAR(45) CHARACTER SET 'latin1' NULL DEFAULT NULL,
  `id_origin` INT(11) NULL DEFAULT NULL,
  `priorita` VARCHAR(10) NULL DEFAULT NULL,
  `rui` VARCHAR(45) CHARACTER SET 'latin1' NULL DEFAULT NULL,
  `dataRui` DATE NULL DEFAULT NULL,
  `cell` VARCHAR(45) CHARACTER SET 'latin1' NULL DEFAULT NULL,
  `telefono` VARCHAR(45) CHARACTER SET 'latin1' NULL DEFAULT NULL,
  `mail` VARCHAR(45) CHARACTER SET 'latin1' NULL DEFAULT NULL,
  `linkedin` VARCHAR(200) NULL DEFAULT NULL,
  `facebook` VARCHAR(200) NULL DEFAULT NULL,
  `via` VARCHAR(45) CHARACTER SET 'latin1' NULL DEFAULT NULL,
  `civico` VARCHAR(45) CHARACTER SET 'latin1' NULL DEFAULT NULL,
  `cap` VARCHAR(10) NULL DEFAULT NULL,
  `comune` VARCHAR(45) CHARACTER SET 'latin1' NULL DEFAULT NULL,
  `provincia` VARCHAR(45) CHARACTER SET 'latin1' NULL DEFAULT NULL,
  `regione` VARCHAR(45) CHARACTER SET 'latin1' NULL DEFAULT NULL,
  `modo_primo_contatto` VARCHAR(45) NULL DEFAULT NULL,
  `data_primo_contatto` DATETIME NULL DEFAULT NULL,
  `user_primo_contatto` VARCHAR(45) NULL DEFAULT NULL,
  `data_accettazione` DATETIME NULL DEFAULT NULL,
  `data_ins` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `user_ins` VARCHAR(45) CHARACTER SET 'latin1' NOT NULL,
  `user_ins_id` INT(11) NOT NULL,
  `data_del` DATETIME NULL DEFAULT NULL,
  `data_restore` DATETIME NULL DEFAULT NULL,
  `user_del` VARCHAR(45) CHARACTER SET 'latin1' NULL DEFAULT NULL,
  `user_del_id` INT(11) NULL DEFAULT NULL,
  `data_edit` DATETIME NULL DEFAULT NULL,
  `user_edit` VARCHAR(45) CHARACTER SET 'latin1' NULL DEFAULT NULL,
  `user_edit_id` INT(11) NULL DEFAULT NULL,
  `active` TINYINT(4) NULL DEFAULT '1',
  `user_abyway` VARCHAR(45) NULL DEFAULT NULL,
  `pwd_abyway` VARCHAR(45) NULL DEFAULT NULL,
  `last_step` INT(11) NULL DEFAULT NULL,
  `id_segnalatore` INT(11) NULL DEFAULT NULL,
  `nome_segnalatore` VARCHAR(50) NULL DEFAULT NULL,
  `mail_segnalatore` VARCHAR(45) NULL DEFAULT NULL,
  `id_referente` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id_anagrafica`),
  UNIQUE INDEX `id_anagrafica_UNIQUE` (`id_anagrafica` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 235
DEFAULT CHARACTER SET = latin2
COMMENT = 'Anagrafiche candidature';

-- ----------------------------------------------------------------------------
-- Table abyway.crm_credenziali_tmp
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `abyway`.`crm_credenziali_tmp` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `id_anagrafica` INT(11) NULL DEFAULT NULL,
  `pin` INT(8) NULL DEFAULT NULL,
  `link` VARCHAR(300) NULL DEFAULT NULL,
  `data_ins` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 170
DEFAULT CHARACTER SET = latin1;

-- ----------------------------------------------------------------------------
-- Table abyway.crm_demo
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `abyway`.`crm_demo` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `id_anagrafica` INT(11) NOT NULL,
  `giorno` DATE NULL DEFAULT NULL,
  `orario` TIME NULL DEFAULT NULL,
  `tipo_meeting` VARCHAR(45) NULL DEFAULT NULL,
  `data_ins` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `user_ins_id` INT(11) NOT NULL,
  `user_ins_nome` VARCHAR(45) NOT NULL,
  `data_exec` DATETIME NULL DEFAULT NULL,
  `user_exec` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 15
DEFAULT CHARACTER SET = latin1
COMMENT = 'Tabella degli appuntamenti	';

-- ----------------------------------------------------------------------------
-- Table abyway.crm_email
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `abyway`.`crm_email` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `oggetto` VARCHAR(200) NULL DEFAULT NULL,
  `messaggio` LONGTEXT NULL DEFAULT NULL,
  `tipo` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 15
DEFAULT CHARACTER SET = latin1;

-- ----------------------------------------------------------------------------
-- Table abyway.crm_fileupload
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `abyway`.`crm_fileupload` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `id_anagrafica` INT(11) NULL DEFAULT NULL,
  `tipo_documento` VARCHAR(100) NULL DEFAULT NULL,
  `nome_file` VARCHAR(100) NULL DEFAULT NULL,
  `data_ins` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `validato` TINYINT(4) NULL DEFAULT '0',
  `id_utente_validazione` INT(11) NULL DEFAULT NULL,
  `nome_utente_validazione` VARCHAR(100) NULL DEFAULT NULL,
  `data_validazione` DATETIME NULL DEFAULT NULL,
  `id_utente_del` INT(11) NULL DEFAULT NULL,
  `nome_utente_del` VARCHAR(100) NULL DEFAULT NULL,
  `data_del` DATETIME NULL DEFAULT NULL,
  `eliminato` TINYINT(4) NULL DEFAULT '0',
  `motivazione` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 794
DEFAULT CHARACTER SET = latin1;

-- ----------------------------------------------------------------------------
-- Table abyway.crm_formazione
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `abyway`.`crm_formazione` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `id_anagrafica` INT(11) NULL DEFAULT NULL,
  `data_formazione` DATE NULL DEFAULT NULL,
  `ora_formazione` TIME NULL DEFAULT NULL,
  `id_formatore` INT(11) NULL DEFAULT NULL,
  `nome_formatore` VARCHAR(45) NULL DEFAULT NULL,
  `data_ins` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `data_exec` DATETIME NULL DEFAULT NULL,
  `user_exec` VARCHAR(45) NULL DEFAULT NULL,
  `incontri` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 114
DEFAULT CHARACTER SET = latin1;

-- ----------------------------------------------------------------------------
-- Table abyway.crm_log
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `abyway`.`crm_log` (
  `id_log` INT(11) NOT NULL AUTO_INCREMENT,
  `id_anagrafica` INT(11) NULL DEFAULT NULL,
  `id_user` INT(11) NULL DEFAULT NULL,
  `nome_user` VARCHAR(45) NULL DEFAULT NULL,
  `data` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `action` VARCHAR(100) NULL DEFAULT NULL,
  `desc` VARCHAR(300) NULL DEFAULT NULL,
  PRIMARY KEY (`id_log`),
  UNIQUE INDEX `id_log_UNIQUE` (`id_log` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 1433
DEFAULT CHARACTER SET = latin1;

-- ----------------------------------------------------------------------------
-- Table abyway.crm_note
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `abyway`.`crm_note` (
  `id_note` INT(11) NOT NULL AUTO_INCREMENT,
  `id_anagrafica` INT(11) NOT NULL,
  `fase` VARCHAR(45) NULL DEFAULT NULL,
  `testo` LONGTEXT NULL DEFAULT NULL,
  `data_ins` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `id_user_ins` INT(11) NOT NULL,
  `id_user_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_note`),
  UNIQUE INDEX `id_note_UNIQUE` (`id_note` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 805
DEFAULT CHARACTER SET = latin1;

-- ----------------------------------------------------------------------------
-- Table abyway.crm_notifiche
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `abyway`.`crm_notifiche` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `id_anagrafica` INT(11) NULL DEFAULT NULL,
  `desc` LONGTEXT NULL DEFAULT NULL,
  `lettura` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_notice_UNIQUE` (`id` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

-- ----------------------------------------------------------------------------
-- Table abyway.crm_privacy
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `abyway`.`crm_privacy` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `id_anagrafica` INT(11) NULL DEFAULT NULL,
  `consenso` INT(11) NULL DEFAULT NULL,
  `data` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 162
DEFAULT CHARACTER SET = latin1;

-- ----------------------------------------------------------------------------
-- Table abyway.crm_provenienza
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `abyway`.`crm_provenienza` (
  `id_origin` INT(11) NOT NULL AUTO_INCREMENT,
  `desc` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id_origin`),
  UNIQUE INDEX `id_origini_UNIQUE` (`id_origin` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 12
DEFAULT CHARACTER SET = latin1;

-- ----------------------------------------------------------------------------
-- Table abyway.crm_richiama
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `abyway`.`crm_richiama` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `id_anagrafica` INT(11) NOT NULL,
  `giorno` DATE NOT NULL,
  `orario` TIME NOT NULL,
  `motivo` VARCHAR(500) NOT NULL,
  `data_ins` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `user_ins_id` INT(11) NOT NULL,
  `user_ins_nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 36
DEFAULT CHARACTER SET = latin1
COMMENT = 'Tabella elenco chiamate programmate';

-- ----------------------------------------------------------------------------
-- Table abyway.crm_ruoli
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `abyway`.`crm_ruoli` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `descrizione` VARCHAR(45) NULL DEFAULT NULL,
  `attivo` INT(11) NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 8
DEFAULT CHARACTER SET = latin1;

-- ----------------------------------------------------------------------------
-- Table abyway.crm_step
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `abyway`.`crm_step` (
  `id_step` INT(11) NOT NULL AUTO_INCREMENT,
  `desc` VARCHAR(45) NULL DEFAULT NULL,
  `color` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`id_step`),
  UNIQUE INDEX `id_step_UNIQUE` (`id_step` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 21
DEFAULT CHARACTER SET = latin1;

-- ----------------------------------------------------------------------------
-- Table abyway.crm_tipologia
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `abyway`.`crm_tipologia` (
  `id_tipologia` INT(11) NOT NULL AUTO_INCREMENT,
  `desc` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id_tipologia`),
  UNIQUE INDEX `id_tipologia_UNIQUE` (`id_tipologia` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = latin1
COMMENT = 'Tipologia del contatto (sezione a, b, e)';

-- ----------------------------------------------------------------------------
-- Table abyway.crm_users
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `abyway`.`crm_users` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `idbroker` INT(11) NOT NULL,
  `idRuolo` INT(11) NULL DEFAULT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `cognome` VARCHAR(45) NOT NULL,
  `id_referente` INT(11) NULL DEFAULT NULL,
  `mail` VARCHAR(50) NOT NULL,
  `telefono` VARCHAR(45) NULL DEFAULT NULL,
  `firma_mail` LONGTEXT NULL DEFAULT NULL,
  `attivo` INT(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `idcrm_ruoli_UNIQUE` (`id` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 17
DEFAULT CHARACTER SET = latin1;

-- ----------------------------------------------------------------------------
-- Table abyway.fileupload
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `abyway`.`fileupload` (
  `id_upload` INT(11) NOT NULL AUTO_INCREMENT,
  `id_utente_insert` INT(11) NOT NULL,
  `utente_insert` VARCHAR(45) NOT NULL,
  `data_insert` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `settore` VARCHAR(45) NOT NULL,
  `filePath` VARCHAR(100) NOT NULL,
  `fileName` VARCHAR(100) NOT NULL,
  `fileExtension` VARCHAR(45) NOT NULL,
  `deleted` TINYINT(4) NOT NULL DEFAULT '0',
  `id_utente_del` INT(11) NULL DEFAULT NULL,
  `utente_del` VARCHAR(45) NULL DEFAULT NULL,
  `data_del` DATETIME NULL DEFAULT NULL,
  `id_utente_update` INT(11) NULL DEFAULT NULL,
  `utente_update` VARCHAR(45) NULL DEFAULT NULL,
  `data_update` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id_upload`))
ENGINE = InnoDB
AUTO_INCREMENT = 115
DEFAULT CHARACTER SET = latin1;

-- ----------------------------------------------------------------------------
-- Table abyway.log_accessi_piattaforme
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `abyway`.`log_accessi_piattaforme` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `piattaforma` VARCHAR(45) NOT NULL,
  `utente` INT(11) NOT NULL,
  `data_accesso` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 1721605
DEFAULT CHARACTER SET = latin1;

-- ----------------------------------------------------------------------------
-- Table abyway.log_richieste_contatto
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `abyway`.`log_richieste_contatto` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `data` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `utente` VARCHAR(100) NULL DEFAULT NULL,
  `ufficio` VARCHAR(100) NULL DEFAULT NULL,
  `settore` VARCHAR(100) NULL DEFAULT NULL,
  `destinatario` LONGTEXT NULL DEFAULT NULL,
  `numeroContatto` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 3200
DEFAULT CHARACTER SET = latin1
COMMENT = 'Contiene il riepilogo delle richieste di contatto inviate dal portale';

-- ----------------------------------------------------------------------------
-- Table abyway.news_mondo
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `abyway`.`news_mondo` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `titolo` VARCHAR(200) NOT NULL,
  `contenuto` TEXT NOT NULL,
  `data` DATE NOT NULL,
  `stato` TINYINT(4) NOT NULL DEFAULT '1',
  `img_path` VARCHAR(45) NOT NULL DEFAULT 'no_img.jpg',
  `utente_add` VARCHAR(150) NULL DEFAULT NULL,
  `id_utente` VARCHAR(10) NULL DEFAULT NULL,
  `utente_edit` VARCHAR(150) NULL DEFAULT NULL,
  `data_edit` DATE NULL DEFAULT NULL,
  `utente_del` VARCHAR(150) NULL DEFAULT NULL,
  `data_del` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 476
DEFAULT CHARACTER SET = latin1;

-- ----------------------------------------------------------------------------
-- Table abyway.notifiche
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `abyway`.`notifiche` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `tipo` VARCHAR(45) CHARACTER SET 'latin1' NOT NULL,
  `id_elemento` INT(11) NOT NULL,
  `data_ins` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `titolo` VARCHAR(100) CHARACTER SET 'latin1' NOT NULL,
  `deleted` TINYINT(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 145
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci
COMMENT = 'Tabella notifiche popolata dal trigger della tabela corsi e da quello della tabella post';

-- ----------------------------------------------------------------------------
-- Table abyway.notifiche_destinatari
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `abyway`.`notifiche_destinatari` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `id_notifica` INT(11) NOT NULL,
  `destinatario` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 268
DEFAULT CHARACTER SET = latin1
COMMENT = 'Tabella di riferimento per i destinatari (tipologia di unita operativa) a cui è rivolta la news';

-- ----------------------------------------------------------------------------
-- Table abyway.notifiche_lette
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `abyway`.`notifiche_lette` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `id_notifica` INT(11) NOT NULL,
  `utente` INT(11) NOT NULL,
  `data_lettura` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 14061
DEFAULT CHARACTER SET = latin1
COMMENT = 'Tabella di registro delle letture delle notifiche';

-- ----------------------------------------------------------------------------
-- Table abyway.post
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `abyway`.`post` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `id_categoria` INT(11) NULL DEFAULT '2',
  `id_area` INT(11) NULL DEFAULT '0',
  `id_settore` INT(11) NULL DEFAULT NULL,
  `titolo` VARCHAR(200) NULL DEFAULT NULL,
  `sottotitolo` VARCHAR(200) NULL DEFAULT NULL,
  `contenuto` TEXT NULL DEFAULT NULL,
  `copertina` VARCHAR(100) NULL DEFAULT NULL,
  `allegati` TINYINT(4) NULL DEFAULT NULL,
  `id_utente_insert` INT(11) NULL DEFAULT NULL,
  `utente_insert` VARCHAR(100) NULL DEFAULT NULL,
  `date_insert` DATETIME NULL DEFAULT NULL,
  `id_utente_edit` INT(11) NULL DEFAULT NULL,
  `utente_edit` VARCHAR(100) NULL DEFAULT NULL,
  `date_edit` DATETIME NULL DEFAULT NULL,
  `id_utente_del` INT(11) NULL DEFAULT NULL,
  `utente_del` VARCHAR(100) NULL DEFAULT NULL,
  `date_del` DATETIME NULL DEFAULT NULL,
  `deleted` TINYINT(4) NULL DEFAULT '0',
  `priority` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 72
DEFAULT CHARACTER SET = latin1
COMMENT = 'Tabella contenente i post/comunicazioni/news	';

-- ----------------------------------------------------------------------------
-- Table abyway.post_attachments
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `abyway`.`post_attachments` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `id_post` INT(11) NOT NULL,
  `id_upload` INT(11) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 71
DEFAULT CHARACTER SET = latin1
COMMENT = 'Tabella di link per gli allegati ai post';

-- ----------------------------------------------------------------------------
-- Table abyway.post_authorizations
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `abyway`.`post_authorizations` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `id_post` INT(11) NOT NULL,
  `id_unita_operativa_tipo` INT(11) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 213
DEFAULT CHARACTER SET = latin1
COMMENT = 'Tabella di link per i permessi di visualizzazione dei post';

-- ----------------------------------------------------------------------------
-- Table abyway.post_category
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `abyway`.`post_category` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `descrizione` VARCHAR(100) NOT NULL,
  `label_color` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = latin1
COMMENT = 'Tabella con le categorie per i post';

-- ----------------------------------------------------------------------------
-- Table abyway.settori
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `abyway`.`settori` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `descrizione` VARCHAR(100) NOT NULL,
  `label_color` VARCHAR(45) NULL DEFAULT NULL,
  `label_text` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = latin1
COMMENT = 'Tabella dizionario dei settori, es. Assicurazioni, Rami, Energy';

-- ----------------------------------------------------------------------------
-- Table abyway.tipologiaunitaoperativa
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `abyway`.`tipologiaunitaoperativa` (
  `id_unita_operativa_tipo` INT(11) NOT NULL AUTO_INCREMENT,
  `tipo_unita_operativa` VARCHAR(45) NOT NULL,
  `Active` TINYINT(4) NOT NULL,
  PRIMARY KEY (`id_unita_operativa_tipo`))
ENGINE = InnoDB
AUTO_INCREMENT = 12
DEFAULT CHARACTER SET = latin1;

-- ----------------------------------------------------------------------------
-- Table abyway.utility
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `abyway`.`utility` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `version` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = latin1;

-- ----------------------------------------------------------------------------
-- Routine abyway.GetContattiByStep
-- ----------------------------------------------------------------------------
DELIMITER $$

DELIMITER $$
USE `abyway`$$
CREATE DEFINER=`abylamp`@`172.16.2.6` PROCEDURE `GetContattiByStep`(IN step_value VARCHAR(30))
BEGIN
    IF step_value = '99' THEN
        SET @sql = '
            SELECT
                a.*,
                a.id_anagrafica AS id,
                a.pf_pg AS tipologia,
                a.rui as numRui,
                s.desc as stato,
                s.color as _classes,
                t.desc AS RUI,
                p.desc AS origine,
                d.giorno as giorno_demo,
                d.orario as orario_demo,
                f.data_formazione as data_formazione,
                f.ora_formazione as ora_formazione,
                f.id_formatore as id_formatore,
                f.nome_formatore as formatore,
                u.nome as referente_nome,
                u.cognome as referente_cognome,
                u.mail as referente_mail
            FROM
                crm_anagrafica a
            LEFT JOIN
                crm_provenienza p ON a.id_origin = p.id_origin
            LEFT JOIN
                crm_tipologia t ON a.id_tipologia = t.id_tipologia
            LEFT JOIN
                crm_step s ON a.id_step = s.id_step
            LEFT JOIN
                crm_demo d ON a.id_anagrafica = d.id_anagrafica
            LEFT JOIN
                crm_formazione f ON a.id_anagrafica = f.id_anagrafica
			LEFT JOIN
				crm_users u ON a.id_referente = u.idbroker
            ORDER BY
                a.id_step;';
    ELSE
        SET @sql = CONCAT('
            SELECT
                a.*,
                a.id_anagrafica AS id,
                a.pf_pg AS tipologia,
                a.rui as numRui,
                s.desc as stato,
                s.color as _classes,
                t.desc AS RUI,
                p.desc AS origine,
                d.giorno as giorno_demo,
                d.orario as orario_demo,
                f.data_formazione as data_formazione,
                f.ora_formazione as ora_formazione,
                f.id_formatore as id_formatore,
                f.nome_formatore as formatore,
                u.nome as referente_nome,
                u.cognome as referente_cognome,
                u.mail as referente_mail
            FROM
                crm_anagrafica a
            LEFT JOIN
                crm_provenienza p ON a.id_origin = p.id_origin
            LEFT JOIN
                crm_tipologia t ON a.id_tipologia = t.id_tipologia
            LEFT JOIN
                crm_step s ON a.id_step = s.id_step
            LEFT JOIN
                crm_demo d ON a.id_anagrafica = d.id_anagrafica
            LEFT JOIN
                crm_formazione f ON a.id_anagrafica = f.id_anagrafica
			LEFT JOIN
				crm_users u ON a.id_referente = u.idbroker
            WHERE
                a.id_step IN (', step_value, ')
            ORDER BY
                a.id_step;');
    END IF;

    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END$$

DELIMITER ;

-- ----------------------------------------------------------------------------
-- Routine abyway.tatale_today
-- ----------------------------------------------------------------------------
DELIMITER $$

DELIMITER $$
USE `abyway`$$
CREATE DEFINER=`abylamp`@`172.16.2.6` PROCEDURE `tatale_today`(
	out broker_tot int,
	out rami_tot int,
	out energy_tot int,
	out broker_uni int,
	out rami_uni int,
	out energy_uni int)
BEGIN
	select count(distinct(utente)) into broker_uni from abyway.log_accessi_piattaforme where piattaforma = "broker" and date(data_accesso) = CURRENT_DATE();
	select count(distinct(utente)) into rami_uni from abyway.log_accessi_piattaforme where piattaforma = "rami" and date(data_accesso) = CURRENT_DATE();
    select count(distinct(utente)) into energy_uni from abyway.log_accessi_piattaforme where piattaforma = "energy" and date(data_accesso) = CURRENT_DATE();
    select count(utente) into broker_tot from abyway.log_accessi_piattaforme where piattaforma = "broker" and date(data_accesso) = CURRENT_DATE();
	select count(utente) into rami_tot from abyway.log_accessi_piattaforme where piattaforma = "rami" and date(data_accesso) = CURRENT_DATE();
    select count(utente) into energy_tot from abyway.log_accessi_piattaforme where piattaforma = "energy" and date(data_accesso) = CURRENT_DATE();
END$$

DELIMITER ;

-- ----------------------------------------------------------------------------
-- Routine abyway.totale
-- ----------------------------------------------------------------------------
DELIMITER $$

DELIMITER $$
USE `abyway`$$
CREATE DEFINER=`abylamp`@`172.16.2.6` PROCEDURE `totale`(
out broker int,
out rami int,
out energy int)
BEGIN
	select count(utente) into broker from abyway.log_accessi_piattaforme where piattaforma = "broker";
    select count(utente) into rami from abyway.log_accessi_piattaforme where piattaforma = "rami";
    select count(utente) into energy from abyway.log_accessi_piattaforme where piattaforma = "energy";
END$$

DELIMITER ;

-- ----------------------------------------------------------------------------
-- Routine abyway.totale_accessi
-- ----------------------------------------------------------------------------
DELIMITER $$

DELIMITER $$
USE `abyway`$$
CREATE DEFINER=`abylamp`@`172.16.2.6` PROCEDURE `totale_accessi`(
out broker_tot int,
out rami_tot int,
out energy_tot int)
BEGIN
	select count(utente) into broker_tot from abyway.log_accessi_piattaforme where piattaforma = "broker";
    select count(utente) into rami_tot from abyway.log_accessi_piattaforme where piattaforma = "rami";
    select count(utente) into energy_tot from abyway.log_accessi_piattaforme where piattaforma = "energy";
END$$

DELIMITER ;

-- ----------------------------------------------------------------------------
-- Routine abyway.totale_accessi_univoci
-- ----------------------------------------------------------------------------
DELIMITER $$

DELIMITER $$
USE `abyway`$$
CREATE DEFINER=`abylamp`@`172.16.2.6` PROCEDURE `totale_accessi_univoci`(
out broker_uni int,
out rami_uni int,
out energy_uni int)
BEGIN
	select count(distinct(utente)) into broker_uni from abyway.log_accessi_piattaforme where piattaforma = "broker";
    select count(distinct(utente)) into rami_uni from abyway.log_accessi_piattaforme where piattaforma = "rami";
    select count(distinct(utente)) into energy_uni from abyway.log_accessi_piattaforme where piattaforma = "energy";
END$$

DELIMITER ;

-- ----------------------------------------------------------------------------
-- Routine abyway.totale_mese_in
-- ----------------------------------------------------------------------------
DELIMITER $$

DELIMITER $$
USE `abyway`$$
CREATE DEFINER=`abylamp`@`172.16.2.6` PROCEDURE `totale_mese_in`(
	in mese int,
    out broker_tot int,
	out rami_tot int,
	out energy_tot int,
	out broker_uni int,
	out rami_uni int,
	out energy_uni int)
BEGIN
	select count(distinct(utente)) into broker_uni from abyway.log_accessi_piattaforme where piattaforma = "broker" and month(data_accesso) = mese;
	select count(distinct(utente)) into rami_uni from abyway.log_accessi_piattaforme where piattaforma = "rami" and month(data_accesso) = mese;
    select count(distinct(utente)) into energy_uni from abyway.log_accessi_piattaforme where piattaforma = "energy" and month(data_accesso) = mese;
    select count(utente) into broker_tot from abyway.log_accessi_piattaforme where piattaforma = "broker" and month(data_accesso) = mese;
	select count(utente) into rami_tot from abyway.log_accessi_piattaforme where piattaforma = "rami" and month(data_accesso) = mese;
    select count(utente) into energy_tot from abyway.log_accessi_piattaforme where piattaforma = "energy" and month(data_accesso) = mese;
END$$

DELIMITER ;
SET FOREIGN_KEY_CHECKS = 1;
