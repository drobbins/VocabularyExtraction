.PHONY: clean all

define PREFIXES
@prefix : <http://chtn.org/vocabulary/v2#> .
@prefix owl: <http://www.w3.org/2002/07/owl#> .
@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .
@prefix xsd: <http://www.w3.org/2001/XMLSchema#> .

endef
export PREFIXES

all: data.ttl

data.ttl: sites.ttl subsites.ttl positions.ttl diagnoses.ttl categories.ttl modifiers.ttl
	@echo "$$PREFIXES" > $@
	cat $? >> $@

sites.ttl:
	mysql -u root --password=password -D chtn --skip-column-names \
		-e "SELECT CONCAT_WS(' ', CONCAT(':', REPLACE(REPLACE(LOWER(site),' ','_'), '/', '-')), 'rdf:Type :Site ; rdfs:label', CONCAT('\"', site, '\"^^xsd:string '), '.') FROM voc_anatomic_site WHERE 1" \
		> $@

subsites.ttl:
	mysql -u root --password=password -D chtn --skip-column-names \
		-e "SELECT CONCAT_WS(' ', CONCAT(':', REPLACE(REPLACE(LOWER(subsite),' ','_'), '/', '-')), 'rdf:Type :Subsite ; rdfs:label', CONCAT('\"', subsite, '\"^^xsd:string '), '.') FROM voc_anatomic_subsite WHERE 1" \
		> $@

positions.ttl:
	mysql -u root --password=password -D chtn --skip-column-names \
		-e "SELECT CONCAT_WS(' ', CONCAT(':', REPLACE(REPLACE(LOWER(position),' ','_'), '/', '-')), 'rdf:Type :Position ; rdfs:label', CONCAT('\"', position, '\"^^xsd:string '), '.') FROM voc_anatomic_site_position WHERE 1" \
		> $@

diagnoses.ttl:
	mysql -u root --password=password -D chtn --skip-column-names \
		-e "SELECT CONCAT_WS(' ', CONCAT(':', REPLACE(REPLACE(LOWER(dx),' ','_'), '/', '-')), 'rdf:Type :Diagnosis ; rdfs:label', CONCAT('\"', dx, '\"^^xsd:string '), '.') FROM voc_dx_list WHERE 1" \
		> $@

categories.ttl:
	mysql -u root --password=password -D chtn --skip-column-names \
		-e "SELECT CONCAT_WS(' ', CONCAT(':', REPLACE(REPLACE(LOWER(specimenCategory),' ','_'), '/', '-')), 'rdf:Type :Category ; rdfs:label', CONCAT('\"', specimenCategory, '\"^^xsd:string '), '.') FROM voc_specimen_category WHERE 1" \
		> $@

modifiers.ttl:
	mysql -u root --password=password -D chtn --skip-column-names \
		-e "SELECT CONCAT_WS(' ', CONCAT(':', REPLACE(REPLACE(LOWER(subDx),' ','_'), '/', '-')), 'rdf:Type :Modifier ; rdfs:label', CONCAT('\"', subDx, '\"^^xsd:string '), '.') FROM voc_subdx_list WHERE 1" \
		> $@

temp.txt:
	 temp.txt

clean:
	rm -rf *.ttl *.txt
