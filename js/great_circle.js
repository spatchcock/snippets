function greatCircle(latLong) {
   degreesToRadians = 0.01745329252;
   earthRadius      = 6371.009;

   for (i in latLong) {
      latLong[i] *= degreesToRadians;
   }

   latitudeDifference = 0.5 * (latLong.lat2 - latLong.lat1);
   latitudeDifference = Math.sin(latitudeDifference);
   latitudeDifference = latitudeDifference * latitudeDifference;

   longitudeDifference = 0.5 * (latLong.long2 - latLong.long1);
   longitudeDifference = Math.sin(longitudeDifference);
   longitudeDifference = longitudeDifference * longitudeDifference;

   result = latitudeDifference;
   result += Math.cos(latLong.lat1) * Math.cos(latLong.lat2) * longitudeDifference;
   result = Math.sqrt(result);

   return earthRadius * 2 * Math.asin(result);
}

greatCircle({
   lat1:   20.0,
   long1:   0.0,
   lat2:   30.0,
   long2: 150.0
});