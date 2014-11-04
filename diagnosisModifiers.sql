SELECT CONCAT_WS(' ', CONCAT(':', REPLACE(LOWER(modifier),' ','_')), ':compatible', CONCAT(':', REPLACE(LOWER(diagnosis),' ','_')))
FROM (
	SELECT `voc_dx_list`.`dx` AS `diagnosis`, `voc_subdx_list`.`subDx` AS `modifier`
	FROM voc_dx_list, voc_subdx_list, vrel_dx_sdx
	WHERE vrel_dx_sdx.sdx = voc_subdx_list.subDxId AND vrel_dx_sdx.dx = voc_dx_list.dxId
) AS dm1 WHERE 1