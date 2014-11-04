SELECT CONCAT_WS(' ', CONCAT(':', REPLACE(LOWER(site),' ','_')), 'rdf:Type :Site ; rdfs:label', CONCAT('\"', site, '\"^^xsd:string '), '.')
FROM voc_anatomic_site 
WHERE 1
