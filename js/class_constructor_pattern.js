// Class constructor function - returns a new constructor function 
var Class = function(){
  var klass = function(){
    this.init.apply(this, arguments);
  };
  
  // Change klass' prototype
  if (parent) {
    var subclass = function() { };
    subclass.prototype = parent.prototype;
    klass.prototype = new subclass;
  };

  klass.prototype.init = function(){};
  
  // Shortcut to access class
  klass.fn = klass.prototype;
  // Shortcut to access class
  klass.fn.parent = klass;

  klass._super = klass.__proto__;

  // Add class properties to the new class as defined in obj
  klass.extend = function(obj){
    var extended = obj.extended;

    for(var i in obj){
      klass[i] = obj[i];
    }

    // Invoke callback function for extension id defined
    if (extended) extended(klass);
  };

  // Add instance properties to the new class as defined in obj
  klass.include = function(obj){
    var included = obj.included;

    for(var i in obj){
      klass.fn[i] = obj[i];
    }
    
    // Invoke callback function for inclusion id defined
    if (included) included(klass);
  };

  // Adding a proxy function to enable the control of scope
  klass.proxy = function(func){
    var self = this;
    return(function(){
      return func.apply(self, arguments);
    });
  }

  // Add the function on instances too
  klass.fn.proxy = klass.proxy;

  create: function() {
    
  }
  
  return klass;
};
