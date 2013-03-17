// Constructor function
var Person = function(){};

// Wrap in executing anonyous function to control scope
(function(){

  // define locally-scoped function
  var findById = function(){ /* ... */ };

  // Add public function to constructor which wraps 'private' (locally-scoped) function
  Person.find = function(id){
    if (typeof id == "integer") {
      return findById(id);
    }
  };

})();
