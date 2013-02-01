# $ sudo apt-get install python-setuptools
#
# Install gdal > osgeo library
# Go to System > Administration > Synaptic Package Manager
# - Search gdal in 'Quick Search' box. Select it and choose 'Mark for installation'
# - Search gdal-python. Mark it for installation as well.
# - Click Apply button on the toolbar.

import osgeo.ogr

shapefile = osgeo.ogr.Open("/home/spatchcock/Documents/geo_spatial/tl_2009_us_state/tl_2009_us_state.shp")
numLayers = shapefile.GetLayerCount()

print "Shapefile contains %d layers" % numLayers

print
for layerNum in range(numLayers):
  layer = shapefile.GetLayer (layerNum)
  spatialRef = layer.GetSpatialRef().ExportToProj4()
  numFeatures = layer.GetFeatureCount()
  print "Layer %d has spatial reference %s" % (layerNum, spatialRef)
  print "Layer %d has %d features:" % (layerNum, numFeatures)
  print

for featureNum in range(numFeatures):
  feature = layer.GetFeature(featureNum)
  featureName = feature.GetField("NAME")
  print "Feature %d has name %s" % (featureNum, featureName)


# shapefile = osgeo.ogr.Open("tl_2009_us_state.shp")
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



# 

from osgeo import ogr

shapefile = ogr.Open("/home/spatchcock/Documents/geo_spatial/TM_WORLD_BORDERS-0.3/TM_WORLD_BORDERS-0.3.shp")
layer = shapefile.GetLayer(0)

for i in range(layer.GetFeatureCount()):
  feature = layer.GetFeature(i)
  name = feature.GetField("NAME")
  geometry = feature.GetGeometryRef()
  print i, name, geometry.GetGeometryName()