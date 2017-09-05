const Asteroid = require('./asteroid.js');
const Util = require('./utils.js');
const Ship = require('./ship.js');

const Game = function Game () {
  this.asteroids = [];
  this.bullets = [];
  this.DIM_X = 500;
  this.DIM_Y = this.DIM_X;
  this.NUM_ASTEROIDS = 15;
  this.addAsteroids();
  this.ship = new Ship([this.DIM_X/2, this.DIM_Y/2], this);
};

Game.prototype.addAsteroids = function addAsteroids () {
  while (this.asteroids.length < this.NUM_ASTEROIDS) {
    this.asteroids.push(new Asteroid({pos: Util.randomPos(this.DIM_X, this.DIM_Y), game: this}));
  }
};

Game.prototype.draw = function draw(ctx) {
  ctx.clearRect(0,0,500,500);
  this.allObjects().forEach(movObj => movObj.draw(ctx) );

};

Game.prototype.move = function move() {
  this.ship.processInput();
  this.allObjects().forEach(obj => obj.move() );
};

Game.prototype.wrap = function wrap(pos) {
  return Util.wrap(pos, this.DIM_X);
};

Game.prototype.checkCollisions = function checkCollisions() {
  let collided = {};


  // for(let i = 0; i < this.asteroids.length; i ++) {
  //   if (collided[i]) {
  //     continue;
  //   }
  //   for (let j = 0; j < this.asteroids.length; j++) {
  //     if ((i === j) || (collided[j])) {
  //       continue;
  //     } else {
  //       if (this.asteroids[i].isCollideWith(this.asteroids[j])) {
  //         collided[i] = this.asteroids[i];
  //         collided[j] = this.asteroids[j];
  //         console.log("alert");
  //       }
  //     }
  //   }
  // }

  // for (let key in collided) {
  //   this.remove(collided[key]);
  // }
};

Game.prototype.step = function step() {
  this.move();
  this.checkCollisions();
};

Game.prototype.remove = function remove(obj) {
  if (typeof obj === 'Asteroid') {
    let index = this.asteroids.indexOf(obj);
    this.asteroids.splice(index, 1);
  } else {
    let index = this.bullets.indexOf(obj);
    this.bullets.splice(index, 1);
  }
};

Game.prototype.addBullet = function addBullet(bullet) {
  this.bullets.push(bullet);
};

Game.prototype.allObjects = function allObjects () {
  return this.asteroids.concat([this.ship]).concat(this.bullets);
};


module.exports = Game;
