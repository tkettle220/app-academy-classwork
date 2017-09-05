const Util = require('./utils.js');
const MovingObject = require('./moving_object.js');

const Bullet = function Bullet(attr) {
  const BASE_VEL = 10;
  this.color = "black";
  this.radius = 3;
  this.vel = attr.shipVel + BASE_VEL;
  this.pos = attr.pos;
  this.game = attr.game;
};

Util.inherits(Bullet, MovingObject);


module.exports = Bullet;
