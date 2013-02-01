import osgeo.ogr

def findPoints(geometry, results):
  for i in range(geometry.GetPointCount()):
    x,y,z = geometry.GetPoint(i)

    if results['west'] == None or results['west'][0] < x:
      results['west'] = (x,y)

    if results['east'] == None or results['east'][0] > y:
      results['east'] = (x,y)

  for i in range(geometry.GetGeometryCount()):
    findPoints(geometry.GetGeometryRef(i), results)

shapefile = osgeo.ogr.Open("/home/spatchcock/Documents/geo_spatial/tl_2009_us_state/tl_2009_us_state.shp")
layer     = shapefile.GetLayer(0)
feature   = layer.GetFeature(53)
geometry  = feature.GetGeometryRef()

results = { 'east' : None,
            'west' : None }

findPoints(geometry, results)

print "Westernmost point is (%0.4f, %0.4f)" % results['west']
print "Easternmost point is (%0.4f, %0.4f)" % results['east']

import math

lat1  = 42.0095
long1 = -122.3782
lat2  = 32.5288
long2 = -117.2049

rLat1  = math.radians(results['west'][0])
rLong1 = math.radians(results['west'][1])
rLat2  = math.radians(results['east'][0])
rLong2 = math.radians(results['east'][1])

dLat  = rLat2 - rLat1
dLong = rLong2 - rLong1

a = math.sin(dLat/2)**2 + math.cos(rLat1) * math.cos(rLat2) * math.sin(dLong/2)**2
c = 2 * math.atan2(math.sqrt(a), math.sqrt(1-a))

distance = 6371 * c

print "Great circle distance is %0.0f kilometers" % distance
