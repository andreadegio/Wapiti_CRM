CREATE DEFINER=`dbabyway_staging`@`%` PROCEDURE `GetContattiByStep`(IN step_value INT)
BEGIN
    SELECT
        a.id_anagrafica AS id,
        a.pf_pg AS tipologia,
        a.nome,
        a.cognome,
        a.rag_soc,
        a.referente,
        t.desc AS RUI,
        p.desc AS origine,
        a.provincia,
        a.regione,
        a.mail,
        a.telefono,
        a.cell,
        a.cf,
        a.piva,
        a.agenzia,
        a.rui as numRui,
        a.via,
        a.civico,
        a.cap,
        a.comune
    FROM
        crm_anagrafica a
    INNER JOIN
        crm_provenienza p ON a.id_origin = p.id_origin
    INNER JOIN
        crm_tipologia t ON a.id_tipologia = t.id_tipologia
    WHERE
        a.id_step = step_value
    ORDER BY
        a.id_anagrafica;
END