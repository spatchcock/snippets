### Data types ###

# Single value types

# GEOMETRY    - Store values of any type
# POINT
# LINESTRING
# POLYGON

# Collections 

# MULTIPOINT
# MULTILINESTRING
# MULTIPOLYGON
# GEOMETRYCOLLECTION

# Initialize objects using MySQL syntax
select Point(0,0);
select LineString(Point(0,0),Point(1,2),Point(2,2),Point(2,4));
select MultiLineString(LineString(Point(0,0),Point(1,2),Point(2,2),Point(2,4)),LineString(Point(0,0),Point(1,2),Point(2,2),Point(2,4)))  
select MultiPoint(Point(0,0),Point(1,2),Point(2,2),Point(2,4));
select GeometryCollection(Point(0,0), Point(0,1), LineString(Point(0,0),Point(1,2),Point(2,2),Point(2,4)));
# Must end with start point
select Polygon(LineString(Point(0,0),Point(1,2),Point(2,2),Point(2,4),Point(0,0)));
select MultiPolygon(Polygon(LineString(Point(0,0),Point(1,2),Point(2,2),Point(2,4),Point(0,0))),Polygon(LineString(Point(10,10),Point(11,12),Point(12,12),Point(12,14),Point(10,10))));

# Initialize objects using WKT syntax
select PointFromText('Point(0 0)');
select MPointFromText('MULTIPOINT(0 0,0 1,2 2)');
# or   MultiPointFromText('MULTIPOINT(0 0,0 1,2 2)');
select LineFromText('LINESTRING(0 0,0 1,1 1,1 2,5 10)');
# or   LineStringFromText('LINESTRING(0 0,0 1,1 1,1 2,5 10)');
select MLineFromText('LINESTRING(0 0,0 1,1 1,1 2,5 10)','LINESTRING(0 0,0 1,1 1,1 2,5 10)');
# or   MultiLineStringFromText('LINESTRING(0 0,0 1,1 1,1 2,5 10)','LINESTRING(0 0,0 1,1 1,1 2,5 10)');
select PolyFromText('POLYGON((90 0,110 0,110 20,90 20,90 0))');
# or   PolygonFromText('POLYGON((90 0,110 0,110 20,90 20,90 0))');
select MPolyFromText('MULTIPOLYGON(((90 0,110 0,110 20,90 20,90 0)),((90 0,110 0,110 20,90 20,90 0)))');
# or   MultiPolyFromText('MULTIPOLYGON(((90 0,110 0,110 20,90 20,90 0)),((90 0,110 0,110 20,90 20,90 0)))');
select GeomCollFromText('GEOMETRYCOLLECTION(POINT(4 6),LINESTRING(4 6,7 10))');
# or   GeometryCollectionFromText('GEOMETRYCOLLECTION(POINT(4 6),LINESTRING(4 6,7 10))');
select GeomFromText('<any WKT object>');
# or   GeometryFromText('<any WKT object>');


### EXAMPLES ###

# Initialize a point object using WKT syntax
set @p = GeomFromText('POINT(5 10)');

# Get x and y values
select x(@p), y(@p);
#->
# +-------+-------+
# | x(@p) | y(@p) |
# +-------+-------+
# |    11 |     0 |
# +-------+-------+

# Initialize a linestring using WKT syntax
set @ls = GeomFromText('LINESTRING(0 0,0 1,1 1,1 2,5 10)');

# Does the linestring contrain the point
select contains(@ls,@p)
# ->
# +------------------+
# | contains(@ls,@p) |
# +------------------+
# |                1 |
# +------------------+

# Initialize a polygon using WKT syntax
set @plyg = GeomFromText('POLYGON((0 0, 10 0, 0 10, 0 0))');

# Do these points lie within the polygon 
# (may use only a Minimum Bounding Rectangle)
set @p1 = GeomFromText('POINT(5 5)');
set @p2 = GeomFromText('POINT(5 11)');

select contains(@plyg,@p1);
# ->
# +--------------------+
# | contains(@plyg,@p) |
# +--------------------+
# |                  1 |
# +--------------------+

select contains(@plyg,@p2);
# ->
# +---------------------+
# | contains(@plyg,@p2) |
# +---------------------+
# |                   0 |
# +---------------------+

# Initialize a polygon with a hole using WKT syntax
set @plyg_hole = GeomFromText('POLYGON((0 0,10 0,10 10,0 10,0 0),(5 5,7 5,7 7,5 7, 5 5))');

### Find locations within bounding box ##

# Createand populate with points
create table locations (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	coords POINT
);

insert into locations (coords) VALUES(GeomFromText('POINT(10 10)'));
insert into locations (coords) VALUES(GeomFromText('POINT(10 100)'));
insert into locations (coords) VALUES(GeomFromText('POINT(100 10)'));
insert into locations (coords) VALUES(GeomFromText('POINT(150 10)'));
insert into locations (coords) VALUES(GeomFromText('POINT(150 100)'));
insert into locations (coords) VALUES(GeomFromText('POINT(10 200)'));

# Define a bounding box
set @plyg = GeomFromText('POLYGON((0 0, 10 0, 0 10, 0 0))');
select id from locations where contains(@plyg, coords);
# ->
# +----+
# | id |
# +----+
# |  1 |
# +----+
# 1 row in set (0.00 sec)

# Define a different bounding box
set @plyg = GeomFromText('POLYGON((-100 -100, 100 -100, 100 100, 100 -100, -100 -100))');
select id from locations where contains(@plyg, coords);
# ->
# +----+
# | id |
# +----+
# |  1 |
# |  2 |
# |  3 |
# +----+
#3 rows in set (0.00 sec)

# Define a different bounding box
select id from locations where contains(@plyg, coords);
# ->
# +----+
# | id |
# +----+
# |  3 |
# +----+
# 1 row in set (0.00 sec)

# Fetch data and coerce into standard formats
select AsText(coords) from locations;
# +----------------+
# | AsText(coords) |
# +----------------+
# | POINT(10 10)   |
# | POINT(10 100)  |
# | POINT(100 10)  |
# | POINT(150 10)  |
# | POINT(150 100) |
# | POINT(10 200)  |
# +----------------+
# 6 rows in set (0.00 sec)

select AsBinary(coords) from locations;
# +-----------------------+
# | AsBinary(coords)      |
# +-----------------------+
# |          $@      $@ |
# |          $@      Y@ |
# |          Y@      $@ |
# |         �b@      $@  |
# |         �b@      Y@  |
# |          $@      i@ |
# +-----------------------+
# 6 rows in set (0.00 sec)

### Properties ###

set @p = Point(34,6);
set @ls = LineString(Point(1,3),Point(5,5),Point(10,10));
set @plyg = GeomFromText('POLYGON((90 0,110 0,110 20,90 20,90 0))');

# Dimension

select Dimension(@p);
#+---------------+
# | Dimension(@p) |
# +---------------+
# |             0 |
# +---------------+

select Dimension(@ls);
# +----------------+
# | Dimension(@ls) |
# +----------------+
# |              1 |
# +----------------+

select Dimension(@plyg);
# +------------------+
# | Dimension(@plyg) |
# +------------------+
# |                2 |
# +------------------+

# Envelope

select AsText(Envelope(@p));
# +-------------------------------------+
# | AsText(Envelope(@p))                |
# +-------------------------------------+
# | POLYGON((34 6,34 6,34 6,34 6,34 6)) |
# +-------------------------------------+

select AsText(Envelope(@ls));
# +------------------------------------+
# | AsText(Envelope(@ls))              |
# +------------------------------------+
# | POLYGON((1 3,10 3,10 10,1 10,1 3)) |
# +------------------------------------+

select AsText(Envelope(@plyg));
#+-----------------------------------------+
# | AsText(Envelope(@plyg))                 |
# +-----------------------------------------+
# | POLYGON((90 0,110 0,110 20,90 20,90 0)) |
# +-----------------------------------------+

# GeometryType

select GeometryType(@p);
# +------------------+
# | GeometryType(@p) |
# +------------------+
# | POINT            |
# +------------------+

select GeometryType(@ls);
# +-------------------+
# | GeometryType(@ls) |
# +-------------------+
# | LINESTRING        |
# +-------------------+

select GeometryType(@plyg);
# +---------------------+
# | GeometryType(@plyg) |
# +---------------------+
# | POLYGON             |
# +---------------------+

# Spatial Reference System Identifier
select SRID(@ls);
# +-----------+
# | SRID(@ls) |
# +-----------+
# |      4326 |
# +-----------+


### FUNCTIONS ##

# POINT
set @p = PointFromText('POINT(23 78)')

# X
select x(@p);
# +-------+
# | x(@p) |
# +-------+
# |    23 |
# +-------+
 
# Y
select y(@p);
# +-------+
# | y(@p) |
# +-------+
# |    78 |
# +-------+


# LINESTRING

# Note SRID passed as second argument
set @ls = LineStringFromText('LINESTRING(55.8648227764835 -4.25162833364874,55.8648470479249 -4.25171484016741,55.8649198621581 -4.25249339883564,55.865065490215 -4.25383424987533,55.8654538290309 -4.25374774335666,55.8658421639643 -4.253790996616,55.8662790361237 -4.25400726291273,55.8663518476725 -4.25405051617206,55.8664489295253 -4.25405051617206,55.8661091419789 -4.25270966513237,55.8660363299751 -4.25227713253891,55.8659877885634 -4.25171484016741,55.8659877885634 -4.25158508038941,55.8659635178348 -4.25141206735201,55.865939247091 -4.25128230757398,55.8658664347687 -4.25076326846185,55.86576935146 -4.24994145653429,55.865623726042 -4.24847084571656,55.8659877885634 -4.24834108593853,55.8663033066551 -4.2482113261605,55.8671284957005 -4.24786530008573,55.8678565891229 -4.24643794252734,55.8680264756242 -4.24604866319325,53.4792644902733 -2.24792109449384)', 4326);

# Start point
select AsText(StartPoint(@ls));
# +-------------------------------------------+
# | AsText(StartPoint(@ls))                   |
# +-------------------------------------------+
# | POINT(55.8648227764835 -4.25162833364874) |
# +-------------------------------------------+

# Endpoint
select AsText(EndPoint(@ls));
# +-------------------------------------------+
# | AsText(EndPoint(@ls))                     |
# +-------------------------------------------+
# | POINT(53.4792644902733 -2.24792109449384) |
# +-------------------------------------------+

# Length
select GLength(@ls);
# +--------------------+
# | GLength(@ls)       |
# +--------------------+
# | 3.1272532713024597 |
# +--------------------+

# Number of vertices
select NumPoints(@ls);
# +----------------+
# | NumPoints(@ls) |
# +----------------+
# |             24 |
# +----------------+

# Point at index (starting at 1)
select AsText(PointN(@ls,3));
# +-------------------------------------------+
# | AsText(PointN(@ls,3))                     |
# +-------------------------------------------+
# | POINT(55.8649198621581 -4.25249339883564) |
# +-------------------------------------------+

# Returns true if line start is same as end (and is 'simple' - does not pass through same point more than once)
select IsRing(@ls);


# POLYGON

# Area - appears to be NOT simply Minimum Bounding Rectangle

# SQUARE
set @plyg = PolyFromText('POLYGON((0 0,10 0,10 10,0 10,0 0))',4326);
select Area(@plyg);
# +-------------+
# | Area(@plyg) |
# +-------------+
# |         100 |
# +-------------+

# TRIANGLE
set @plyg = PolyFromText('POLYGON((0 0,10 0,10 10,0 0))',4326);
select Area(@plyg);
# +-------------+
# | Area(@plyg) |
# +-------------+
# |          50 |
# +-------------+

# L-shape
set @plyg = PolyFromText('POLYGON((0 0,10 0,10 10,5 10,5 5,0 5,0 0))',4326);
select Area(@plyg);
# +-------------+
# | Area(@plyg) |
# +-------------+
# |          75 |
# +-------------+

# Collections

# Get nth geometry
SET @gc = 'GeometryCollection(Point(1 1),LineString(2 2, 3 3))';
SELECT AsText(GeometryN(GeomFromText(@gc),1));

# Count geometries
SET @gc = 'GeometryCollection(Point(1 1),LineString(2 2, 3 3))';
SELECT NumGeometries(GeomFromText(@gc));

# Length of multi-line string
SET @mls = 'MultiLineString((1 1,2 2,3 3),(4 4,5 5))';
SELECT GLength(GeomFromText(@mls));

# Get outer, or intertior ring of polygon
SET @poly = 'Polygon((0 0,0 3,3 3,3 0,0 0),(1 1,1 2,2 2,2 1,1 1))';
SELECT AsText(ExteriorRing(GeomFromText(@poly)));
SELECT AsText(InteriorRingN(GeomFromText(@poly),1));
# Get number of interior rings
SELECT NumInteriorRings(GeomFromText(@poly));
# Misc

# Get centre of geometry
DELIMITER //
DROP FUNCTION IF EXISTS GetCenterPoint; //
CREATE FUNCTION GetCenterPoint(g GEOMETRY) RETURNS POINT NO SQL DETERMINISTIC
BEGIN
	DECLARE envelope POLYGON;
	DECLARE sw, ne POINT; #South-West and North-East points
	DECLARE lat, lng DOUBLE;

	SET envelope = ExteriorRing(Envelope(g));
	SET sw = PointN(envelope, 1);
	SET ne = PointN(envelope, 3);
	SET lat = X(sw) + (X(ne)-X(sw))/2;
	SET lng = Y(sw) + (Y(ne)-Y(sw))/2;

	RETURN POINT(lat, lng);
END; //

# Get nth line segment
DELIMITER //
DROP FUNCTION IF EXISTS LineN; //
CREATE FUNCTION LineN(ls LINESTRING, n INT) RETURNS LINESTRING NO SQL DETERMINISTIC
BEGIN
  IF n >= numPoints(ls) THEN
    RETURN NULL;
  END IF;

  RETURN LineString(PointN(ls, n), PointN(ls, n+1)); 
END; //