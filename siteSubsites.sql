SELECT CONCAT_WS(' ', URLINATE(subsite) COLLATE utf8_general_ci, ':compatible', URLINATE(site) COLLATE utf8_general_ci, '.')
FROM (
	SELECT `voc_anatomic_site`.`site` AS `site`, `voc_anatomic_subsite`.`subSite` AS `subsite`
	FROM voc_anatomic_site, voc_anatomic_subsite, vrel_as_ss
	WHERE vrel_as_ss.ssID = voc_anatomic_subsite.subid AND vrel_as_ss.asID = voc_anatomic_site.aSiteID
) AS sss1 WHERE 1