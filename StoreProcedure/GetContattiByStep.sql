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
        a.rui as numRui,
        d.giorno as giorno_demo,
        d.orario as orario_demo,
        f.data_formazione as data_formazione,
        f.ora_formazione as ora_formazione,
        f.id_formatore as id_formatore,
        f.nome_formatore as formatore
    FROM
        crm_anagrafica a
    INNER JOIN
        crm_provenienza p ON a.id_origin = p.id_origin
    INNER JOIN
        crm_tipologia t ON a.id_tipologia = t.id_tipologia
	INNER JOIN
        crm_step s ON a.id_step = s.id_step
	LEFT JOIN
		crm_demo d ON a.id_anagrafica = d.id_anagrafica
	LEFT JOIN
		crm_formazione f ON a.id_anagrafica = f.id_anagrafica
    WHERE
        a.id_step IN (',step_value,')
    ORDER BY
        a.id_step;');
        PREPARE stmt FROM @sql;
  EXECUTE stmt;
  DEALLOCATE PREPARE stmt;
END