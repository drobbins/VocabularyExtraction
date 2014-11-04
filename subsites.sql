SELECT CONCAT_WS(' ', CONCAT(':', REPLACE(LOWER(subsite),' ','_')), 'rdf:Type :Subsite ; rdfs:label', CONCAT('\"', subsite, '\"^^xsd:string '), '.')
FROM voc_anatomic_subsite
WHERE 1
