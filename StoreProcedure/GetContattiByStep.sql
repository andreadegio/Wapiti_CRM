CREATE DEFINER=`dbabyway_staging`@`%` PROCEDURE `GetContattiByStep`(IN step_value VARCHAR(30))
BEGIN
	SET @sql = CONCAT('
    SELECT
		a.*,
        a.id_anagrafica AS id,
        s.desc as stato,
        s.color as _classes,
        a.pf_pg AS tipologia,
        t.desc AS RUI,
        p.desc AS origine,
        a.rui as numRui
    FROM
        crm_anagrafica a
    INNER JOIN
        crm_provenienza p ON a.id_origin = p.id_origin
    INNER JOIN
        crm_tipologia t ON a.id_tipologia = t.id_tipologia
	 INNER JOIN
        crm_step s ON a.id_step = s.id_step
    WHERE
		a.active = 1
        and a.id_step IN (',step_value,')
    ORDER BY
        a.id_step;');
        PREPARE stmt FROM @sql;
  EXECUTE stmt;
  DEALLOCATE PREPARE stmt;
END