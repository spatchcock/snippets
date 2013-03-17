// Inherit from parent to child
function extend(Child,Parent){
  var F = function(){};
  F.prototype = Parent.prototype;
  Child.prototype = new F();
  Child.prototype.constructor = Child;
  Child.uber = Parent.prototype;
}

// Create a new object inheriting from a specified parent
// Use Object.create or roll own if not defined
if (typeof Object.create !== "function"){
  Object.create = function(o) {
    function F() {}
    F.prototype = o;
    return new F();
  };
}
