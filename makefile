.PHONY: clean all temp urlinate

# Prefixes variable for insertion
define PREFIXES
@prefix : <http://chtn.org/vocabulary/v2#> .
@prefix owl: <http://www.w3.org/2002/07/owl#> .
@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .
@prefix xsd: <http://www.w3.org/2001/XMLSchema#> .

endef
export PREFIXES

# sqlFor generates sql for creating data triples (e.g :acanthoma a :Diagnosis)
# Call it as $(call sqlFor,field,type,table)
# e.g. $(call sqlFor,position,Position,voc_anatomic_site_position)
sqlFor = "SELECT CONCAT_WS(' ', URLINATE($(1)) COLLATE utf8_general_ci, 'rdf:type :$(2) ; rdfs:label', CONCAT('\"', $(1), '\"^^xsd:string '), '.') FROM $(3) WHERE 1"
#sqlFor = "SELECT CONCAT_WS(' ', $(1), 'rdf:Type :$(2) ; rdfs:label', CONCAT('\"', $(1), '\"^^xsd:string '), '.') FROM $(3) WHERE 1"

all: data.ttl

data.trig: sites.ttl subsites.ttl positions.ttl diagnoses.ttl categories.ttl modifiers.ttl diagnosisModifiers.ttl siteSubsites.ttl
	@echo "$$PREFIXES" > $@
	cat ":Data { " $? | sed 's/_-_/-/g' >> $@
	@echo " }" >> $@

data.ttl: sites.ttl subsites.ttl positions.ttl diagnoses.ttl categories.ttl modifiers.ttl diagnosisModifiers.ttl siteSubsites.ttl
	@echo "$$PREFIXES" > $@
	cat $? | sed 's/_-_/-/g' >> $@

sites.ttl: urlinate
	mysql -u root --password=password -D chtn --skip-column-names \
		-e $(call sqlFor,site,Site,voc_anatomic_site) \
		> $@

subsites.ttl: urlinate
	mysql -u root --password=password -D chtn --skip-column-names \
		-e $(call sqlFor,subsite,Subsite,voc_anatomic_subsite) \
		> $@

positions.ttl: urlinate
	mysql -u root --password=password -D chtn --skip-column-names \
		-e $(call sqlFor,position,Position,voc_anatomic_site_position) \
		> $@

diagnoses.ttl: urlinate
	mysql -u root --password=password -D chtn --skip-column-names \
		-e $(call sqlFor,dx,Diagnosis,voc_dx_list) \
		> $@

categories.ttl: urlinate
	mysql -u root --password=password -D chtn --skip-column-names \
		-e $(call sqlFor,specimenCategory,Category,voc_specimen_category) \
		> $@

modifiers.ttl: urlinate
	mysql -u root --password=password -D chtn --skip-column-names \
		-e $(call sqlFor,subDx,Modifier,voc_subdx_list) \
		> $@

diagnosisModifiers.ttl: urlinate
	mysql -u root --password=password -D chtn --skip-column-names \
		< diagnosisModifiers.sql \
		> $@

siteSubsites.ttl: urlinate
	mysql -u root --password=password -D chtn --skip-column-names \
		< siteSubsites.sql \
		> $@

urlinate:
	mysql -u root --password=password -D chtn --skip-column-names < urlinate.sql

temp:
	echo $(call sqlFor,position,Position,voc_anatomic_site_position)

clean:
	rm -rf *.ttl *.txt
