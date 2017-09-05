const Game = require('./game.js');
const Util = require('./utils.js');

const MovingObject = function MovingObject(attr) {
  this.pos = attr.pos;
  this.radius = attr.radius;
  this.vel = attr.vel;
  this.color = attr.color;
  this.game = attr.game;
};

MovingObject.prototype.draw = function draw(ctx) {
  ctx.fillStyle = this.color;
  ctx.beginPath();
  ctx.arc(this.pos[0], this.pos[1], this.radius, 0, 2*Math.PI);
  ctx.fill();
};


MovingObject.prototype.move = function move() {
  this.pos = ([this.pos[0] + this.vel[0],
     this.pos[1] + this.vel[1]]);
  this.pos = this.game.wrap(this.pos);
};

MovingObject.prototype.isCollideWith = function isCollideWith(otherObject) {
  return Util.dist(this.pos, otherObject.pos) < (this.radius + otherObject.radius);
};

module.exports = MovingObject;
