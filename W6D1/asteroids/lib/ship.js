const Game = require('./game.js');
const Util = require('./utils.js');
const Key = require('../keymaster.js');
const MovingObject = require('./moving_object.js');
const Bullet = require('./bullet.js');

const Ship = function Ship (pos, game) {
  this.radius = 10;
  this.color = "red";
  this.vel = [0,0];
  this.pos = pos;
  this.origPos = pos;
  this.game = game;
};

Util.inherits(Ship, MovingObject);

Ship.prototype.relocate = function relocate() {
  this.pos = this.origPos;
  this.vel = [0, 0];
};

Ship.prototype.power = function power(impulse) {
  this.vel = [this.vel[0] + impulse[0], this.vel[1] + impulse[1]];
};

Ship.prototype.processInput = function processInput() {
  key("space",  () => { this.fireBullet(); });
  key("left", () => { this.power([-1/1000,0]); });
  key("right", () => { this.power([1/1000,0]); });
  key("up", () => { this.power([0,-1/1000]); });
  key("down", () => { this.power([0,1/1000]); });




  // if key.isPressed(left) {
  //   this.power([-1, 0]);

  // }
  // if key.isPressed(right) {
  //   this.power([1, 0]);
  // }
  // if key.isPressed(up) {
  //   this.power([0, 1]);
  // }
  // if key.isPressed(down) {
  //   this.power([0, -1]);
  // }
  // if key.isPressed(space) {
  //   this.fireBullet();
  // }
};

Ship.prototype.fireBullet = function fireBullet() {
  let offset = Util.scale(Util.normVec(this.vel), this.radius);
  let pos = [this.pos[0] + offset[0], this.pos[1] + offset[1]];
  let bullet = new Bullet({pos: pos, game: this.game, shipVel: this.vel});
  this.game.addBullet(bullet);
};


module.exports = Ship;
