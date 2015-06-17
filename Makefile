.SECONDARY:

data/gz/nhgis_tract_2010.zip:
	mkdir -p $(dir $@)
	curl -L --remote-time 'https://data2.nhgis.org/extracts/86432/28/nhgis0028_shape.zip' -o $@.download
	mv $@.download $@

data/shp/nhgis_tract_2010.shp: data/gz/nhgis_tract_2010.zip
	mkdir -p $(dir $@)
	tar -xzm -C $(dir $@) -f $<
	find $(dir $@) -depth -name '*.zip' -exec tar -xzm -C $(dir $@) -f {} \; -exec rm {} \;
	touch $@
