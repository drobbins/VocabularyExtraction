SELECT CONCAT_WS(' ', URLINATE(modifier) COLLATE utf8_general_ci, ':compatible', URLINATE(diagnosis) COLLATE utf8_general_ci, '.')
FROM (
	SELECT `voc_dx_list`.`dx` AS `diagnosis`, `voc_subdx_list`.`subDx` AS `modifier`
	FROM voc_dx_list, voc_subdx_list, vrel_dx_sdx
	WHERE vrel_dx_sdx.sdx = voc_subdx_list.subDxId AND vrel_dx_sdx.dx = voc_dx_list.dxId
) AS dm1 WHERE 1