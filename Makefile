.SECONDARY:
	# http://www2.census.gov/geo/tiger/TIGER_DP/2013ACS/ACS_2013_5YR_COUNTY.gdb.zip

data/gz/tiger/nhgis_tract_2010.zip:
	mkdir -p $(dir $@)
	curl -L --remote-time 'https://data2.nhgis.org/extracts/86432/28/nhgis0028_shape.zip' -o $@.download
	mv $@.download $@
