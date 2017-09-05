const MovingObject = require('./moving_object.js');
const Util = require('./utils.js');

const Asteroid = function Asteroid(attr) {
  this.color = "brown";
  this.radius = 10;
  this.vel = Util.randomVec(4);
  this.pos = attr.pos;
  this.game = attr.game;
};

Asteroid.prototype.collideWith = function collideWith(otherObj) {
  if (typeof otherObj === 'Ship') {
    otherObj.relocate;
  } else {
    this.game.remove(this);
    // this.game.remove(otherObj);
  }
};

Util.inherits(Asteroid, MovingObject);

module.exports = Asteroid;
