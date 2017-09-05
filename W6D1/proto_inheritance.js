Function.prototype.inherits = function inherits(parent) {
  // const Surrogate = function Surrogate() {};
  // Surrogate.prototype = parent.prototype;
  // this.prototype = new Surrogate();
  // this.prototype.constructor = this;
  this.prototype = Object.create(parent.prototype);
  this.prototype.constructor = this;
};

function MovingObject () {}

MovingObject.prototype.test = function test() {
  console.log("test");
};

const movObject = new MovingObject();
movObject.test();


function Ship () {}
Ship.inherits(MovingObject);

Ship.prototype.test2 = function test2() {
  console.log("test2");
};

const ship = new Ship();
ship.test();
ship.test2();

function Asteroid () {}
Asteroid.inherits(MovingObject);

const asteroid = new Asteroid();
asteroid.test();
