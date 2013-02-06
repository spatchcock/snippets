# $ sudo apt-get install python-setuptools
#
# Install gdal > osgeo library
# Go to System > Administration > Synaptic Package Manager
# - Search gdal in 'Quick Search' box. Select it and choose 'Mark for installation'
# - Search gdal-python. Mark it for installation as well.
# - Click Apply button on the toolbar.

import osgeo.ogr

shapefile = osgeo.ogr.Open("/home/spatchcock/Documents/geo_spatial/tl_2009_us_state/tl_2009_us_state.shp")
layer     = shapefile.GetLayer(0)
feature   = layer.GetFeature(2)

print "Feature 2 has the following attributes:"
print

attributes = feature.items()

for key,value in attributes.items():
  print " %s = %s" % (key, value)
  print

geometry     = feature.GetGeometryRef()
geometryName = geometry.GetGeometryName()
print "Feature's geometry data consists of a %s" % geometryName