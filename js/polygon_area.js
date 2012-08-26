
/*

  This algorithm is based on calculating the area underneath each line segment, bound by the x-axis. These under-segment areas for one 
  'side' of the polygon are substracted from those on the other, producing the area enclosed between. 

  The areas beneath each segment are are 'trapezoids' since there are two parellel sides. The area of a trapezoid is calculated as:

    area = (a + b)/2 x h

  where a and b are the lengths of the two parallel sides, and h is the distance between them. In the case of the polygon area
  algorithm, a and b are the respective y-axis distances for two successive points and h is the difference between x-axis differences.

  Polygon area equation can be formulated like this:

    A = 1/2 * (y1 + y0)(x1 - x0) + 1/2 * (y2 + y1)(x2 - x1) + 1/2 * (y3 + y2)(x3 - x2) + ... + 1/2 * (yn + yn-1)(xn - xn-1)

  This can be expanded thus:

    A = 1/2 * [(x1*y1 - x0*y1 + x1*y0 - x0*y0) + (x2*y2 - x1*y2 + x2*y1 - x1*y1) + (x3*y3 - x2*y3 + x3*y2 - x2*y2) ... ]

  and simplified:

    A = 1/2 * [ (x1 * y0 - x0 * y1) + (x2 * y1 - x1 * y2) + (x3 * y2 - x2 * y3) + ... (xn * yn-1 - xn-1 * yn) ]

  which is the formulation in the algorithm.

  The definition of what constitutes opposites sides is dealt with automatically on the assumption that points are listed in a clockwise 
  direction. This means that the 'widths' of trapezoids - calculated as a difference in x-coordinates - can be positive or negative. 
  Negative values occur when the x direction is reserved.  

 */
function polygonArea(points) {

  // count points list now so that additional point added by the subsequent call to completePolygon() is not counted. 
  // This enables the i + 1 index in the for loop to be valid for all iterations.
  var pointsCount = points.length;
  var area = 0;
  var i;

  points[points.length] = points[0];

  for (i = 0; i < pointsCount; i++) {
    area += points[i + 1].x * points[i].y
    area -= points[i].x     * points[i + 1].y
  }

  return area * 0.5;
}

var triangle = [
  { x: 0,  y: 0  },
  { x: 0,  y: 10 },
  { x: 10, y: 10 },
]

var square = [
  { x: 0,  y: 0  },
  { x: 0,  y: 10 },
  { x: 10, y: 10 },
  { x: 10, y: 0  },
]

var irregular = [
  { x: 0,   y: 0  },
  { x: 0,   y: 10 },
  { x: 1,   y: 10 },
  { x: 1,   y: 5  },
  { x: 5,   y: 5  },
  { x: 5,   y: 1  },
  { x: 10,  y: 1  },
  { x: 10,  y: 0  }
]

polygonArea(triangle)   == 50;
polygonArea(square)     == 100;
polygonArea(irregular)  == 35;