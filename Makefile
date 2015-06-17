.SECONDARY:

data/gz/nhgis_tract_2010.zip:
	mkdir -p $(dir $@)
	curl -L --remote-time 'https://data2.nhgis.org/extracts/86432/28/nhgis0028_shape.zip' -o $@.download
	mv $@.download $@

# NOTE: The shapefile from NHGIS is in some kind of unknown albers-style user projection.
# The conversion to 4326 appears to work fine, but multiple warnings appear about
# not writing some points that are considered out of bounds.  I have yet to discover
# what points are not being written.
data/shp/nhgis_tract_2010.shp: data/gz/nhgis_tract_2010.zip
	mkdir -p $(dir $@)
	tar -xzm -C $(dir $@) -f $<
	find $(dir $@) -depth -name '*.zip' -exec tar -xzm -C $(dir $@) -f {} \; -exec rm {} \;
	find $(dir $@) -depth -name '*.shp' \
		-exec ogr2ogr -t_srs 'EPSG:4326' $(dir $@)/nhgis_tract_2010.shp {} \;
	rm $(dir $@)US_*
