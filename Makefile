all: data/png/atlanta.png data/png/austin.png data/png/baltimore.png data/png/birmingham.png data/png/boston.png data/png/buffalo.png data/png/charlotte.png data/png/chicago.png data/png/cincinnati.png data/png/cleveland.png data/png/columbus.png data/png/dallas.png data/png/denver.png data/png/detroit.png data/png/hartford.png data/png/houston.png data/png/indianapolis.png data/png/jacksonville.png data/png/kansas_city.png data/png/las_vegas.png data/png/los_angeles.png data/png/louisville.png data/png/memphis.png data/png/miami.png data/png/milwaukee.png data/png/minneapolis.png data/png/nashville.png data/png/new_orleans.png data/png/new_york.png data/png/oklahoma_city.png data/png/orlando.png data/png/philadelphia.png data/png/phoenix.png data/png/pittsburgh.png data/png/portland.png data/png/providence.png data/png/raleigh.png data/png/richmond.png data/png/riverside.png data/png/rochester.png data/png/sacramento.png data/png/salt_lake_city.png data/png/san_antonio.png data/png/san_diego.png data/png/san_francisco.png data/png/san_jose.png data/png/seattle.png data/png/st_louis.png data/png/tampa.png data/png/virginia_beach.png data/png/washington.png

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

data/png/atlanta.png:
	mkdir -p $(dir $@)
	script/rasterize-metro-shapefile-two --in `script/export-metro-shapefile -d metro_poverty -m 12060` --out $@

data/png/austin.png:
	mkdir -p $(dir $@)
	script/rasterize-metro-shapefile-two --in `script/export-metro-shapefile -d metro_poverty -m 12420` --out $@

data/png/baltimore.png:
	mkdir -p $(dir $@)
	script/rasterize-metro-shapefile-two --in `script/export-metro-shapefile -d metro_poverty -m 12580` --out $@

data/png/birmingham.png:
	mkdir -p $(dir $@)
	script/rasterize-metro-shapefile-two --in `script/export-metro-shapefile -d metro_poverty -m 13820` --out $@

data/png/boston.png:
	mkdir -p $(dir $@)
	script/rasterize-metro-shapefile-two --in `script/export-metro-shapefile -d metro_poverty -m 14460` --out $@

data/png/buffalo.png:
	mkdir -p $(dir $@)
	script/rasterize-metro-shapefile-two --in `script/export-metro-shapefile -d metro_poverty -m 15380` --out $@

data/png/charlotte.png:
	mkdir -p $(dir $@)
	script/rasterize-metro-shapefile-two --in `script/export-metro-shapefile -d metro_poverty -m 16740` --out $@

data/png/chicago.png:
	mkdir -p $(dir $@)
	script/rasterize-metro-shapefile-two --in `script/export-metro-shapefile -d metro_poverty -m 16980` --out $@

data/png/cincinnati.png:
	mkdir -p $(dir $@)
	script/rasterize-metro-shapefile-two --in `script/export-metro-shapefile -d metro_poverty -m 17140` --out $@

data/png/cleveland.png:
	mkdir -p $(dir $@)
	script/rasterize-metro-shapefile-two --in `script/export-metro-shapefile -d metro_poverty -m 17460` --out $@

data/png/columbus.png:
	mkdir -p $(dir $@)
	script/rasterize-metro-shapefile-two --in `script/export-metro-shapefile -d metro_poverty -m 18140` --out $@

data/png/dallas.png:
	mkdir -p $(dir $@)
	script/rasterize-metro-shapefile-two --in `script/export-metro-shapefile -d metro_poverty -m 19100` --out $@

data/png/denver.png:
	mkdir -p $(dir $@)
	script/rasterize-metro-shapefile-two --in `script/export-metro-shapefile -d metro_poverty -m 19740` --out $@

data/png/detroit.png:
	mkdir -p $(dir $@)
	script/rasterize-metro-shapefile-two --in `script/export-metro-shapefile -d metro_poverty -m 19820` --out $@

data/png/hartford.png:
	mkdir -p $(dir $@)
	script/rasterize-metro-shapefile-two --in `script/export-metro-shapefile -d metro_poverty -m 25540` --out $@

data/png/houston.png:
	mkdir -p $(dir $@)
	script/rasterize-metro-shapefile-two --in `script/export-metro-shapefile -d metro_poverty -m 26420` --out $@

data/png/indianapolis.png:
	mkdir -p $(dir $@)
	script/rasterize-metro-shapefile-two --in `script/export-metro-shapefile -d metro_poverty -m 26900` --out $@

data/png/jacksonville.png:
	mkdir -p $(dir $@)
	script/rasterize-metro-shapefile-two --in `script/export-metro-shapefile -d metro_poverty -m 27260` --out $@

data/png/kansas_city.png:
	mkdir -p $(dir $@)
	script/rasterize-metro-shapefile-two --in `script/export-metro-shapefile -d metro_poverty -m 28140` --out $@

data/png/las_vegas.png:
	mkdir -p $(dir $@)
	script/rasterize-metro-shapefile-two --in `script/export-metro-shapefile -d metro_poverty -m 29820` --out $@

data/png/los_angeles.png:
	mkdir -p $(dir $@)
	script/rasterize-metro-shapefile-two --in `script/export-metro-shapefile -d metro_poverty -m 31100` --out $@

data/png/louisville.png:
	mkdir -p $(dir $@)
	script/rasterize-metro-shapefile-two --in `script/export-metro-shapefile -d metro_poverty -m 31140` --out $@

data/png/memphis.png:
	mkdir -p $(dir $@)
	script/rasterize-metro-shapefile-two --in `script/export-metro-shapefile -d metro_poverty -m 32820` --out $@

data/png/miami.png:
	mkdir -p $(dir $@)
	script/rasterize-metro-shapefile-two --in `script/export-metro-shapefile -d metro_poverty -m 33100` --out $@

data/png/milwaukee.png:
	mkdir -p $(dir $@)
	script/rasterize-metro-shapefile-two --in `script/export-metro-shapefile -d metro_poverty -m 33340` --out $@

data/png/minneapolis.png:
	mkdir -p $(dir $@)
	script/rasterize-metro-shapefile-two --in `script/export-metro-shapefile -d metro_poverty -m 33460` --out $@

data/png/nashville.png:
	mkdir -p $(dir $@)
	script/rasterize-metro-shapefile-two --in `script/export-metro-shapefile -d metro_poverty -m 34980` --out $@

data/png/new_orleans.png:
	mkdir -p $(dir $@)
	script/rasterize-metro-shapefile-two --in `script/export-metro-shapefile -d metro_poverty -m 35380` --out $@

data/png/new_york.png:
	mkdir -p $(dir $@)
	script/rasterize-metro-shapefile-two --in `script/export-metro-shapefile -d metro_poverty -m 35620` --out $@

data/png/oklahoma_city.png:
	mkdir -p $(dir $@)
	script/rasterize-metro-shapefile-two --in `script/export-metro-shapefile -d metro_poverty -m 36420` --out $@

data/png/orlando.png:
	mkdir -p $(dir $@)
	script/rasterize-metro-shapefile-two --in `script/export-metro-shapefile -d metro_poverty -m 36740` --out $@

data/png/philadelphia.png:
	mkdir -p $(dir $@)
	script/rasterize-metro-shapefile-two --in `script/export-metro-shapefile -d metro_poverty -m 37980` --out $@

data/png/phoenix.png:
	mkdir -p $(dir $@)
	script/rasterize-metro-shapefile-two --in `script/export-metro-shapefile -d metro_poverty -m 38060` --out $@

data/png/pittsburgh.png:
	mkdir -p $(dir $@)
	script/rasterize-metro-shapefile-two --in `script/export-metro-shapefile -d metro_poverty -m 38300` --out $@

data/png/portland.png:
	mkdir -p $(dir $@)
	script/rasterize-metro-shapefile-two --in `script/export-metro-shapefile -d metro_poverty -m 38900` --out $@

data/png/providence.png:
	mkdir -p $(dir $@)
	script/rasterize-metro-shapefile-two --in `script/export-metro-shapefile -d metro_poverty -m 39300` --out $@

data/png/raleigh.png:
	mkdir -p $(dir $@)
	script/rasterize-metro-shapefile-two --in `script/export-metro-shapefile -d metro_poverty -m 39580` --out $@

data/png/richmond.png:
	mkdir -p $(dir $@)
	script/rasterize-metro-shapefile-two --in `script/export-metro-shapefile -d metro_poverty -m 40060` --out $@

data/png/riverside.png:
	mkdir -p $(dir $@)
	script/rasterize-metro-shapefile-two --in `script/export-metro-shapefile -d metro_poverty -m 40140` --out $@

data/png/rochester.png:
	mkdir -p $(dir $@)
	script/rasterize-metro-shapefile-two --in `script/export-metro-shapefile -d metro_poverty -m 40380` --out $@

data/png/sacramento.png:
	mkdir -p $(dir $@)
	script/rasterize-metro-shapefile-two --in `script/export-metro-shapefile -d metro_poverty -m 40900` --out $@

data/png/salt_lake_city.png:
	mkdir -p $(dir $@)
	script/rasterize-metro-shapefile-two --in `script/export-metro-shapefile -d metro_poverty -m 41620` --out $@

data/png/san_antonio.png:
	mkdir -p $(dir $@)
	script/rasterize-metro-shapefile-two --in `script/export-metro-shapefile -d metro_poverty -m 41700` --out $@

data/png/san_diego.png:
	mkdir -p $(dir $@)
	script/rasterize-metro-shapefile-two --in `script/export-metro-shapefile -d metro_poverty -m 41740` --out $@

data/png/san_francisco.png:
	mkdir -p $(dir $@)
	script/rasterize-metro-shapefile-two --in `script/export-metro-shapefile -d metro_poverty -m 41860` --out $@

data/png/san_jose.png:
	mkdir -p $(dir $@)
	script/rasterize-metro-shapefile-two --in `script/export-metro-shapefile -d metro_poverty -m 41940` --out $@

data/png/seattle.png:
	mkdir -p $(dir $@)
	script/rasterize-metro-shapefile-two --in `script/export-metro-shapefile -d metro_poverty -m 42660` --out $@

data/png/st_louis.png:
	mkdir -p $(dir $@)
	script/rasterize-metro-shapefile-two --in `script/export-metro-shapefile -d metro_poverty -m 41180` --out $@

data/png/tampa.png:
	mkdir -p $(dir $@)
	script/rasterize-metro-shapefile-two --in `script/export-metro-shapefile -d metro_poverty -m 45300` --out $@

data/png/virginia_beach.png:
	mkdir -p $(dir $@)
	script/rasterize-metro-shapefile-two --in `script/export-metro-shapefile -d metro_poverty -m 47260` --out $@

data/png/washington.png:
	mkdir -p $(dir $@)
	script/rasterize-metro-shapefile-two --in `script/export-metro-shapefile -d metro_poverty -m 47900` --out $@
