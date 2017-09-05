/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId]) {
/******/ 			return installedModules[moduleId].exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			i: moduleId,
/******/ 			l: false,
/******/ 			exports: {}
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.l = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// define getter function for harmony exports
/******/ 	__webpack_require__.d = function(exports, name, getter) {
/******/ 		if(!__webpack_require__.o(exports, name)) {
/******/ 			Object.defineProperty(exports, name, {
/******/ 				configurable: false,
/******/ 				enumerable: true,
/******/ 				get: getter
/******/ 			});
/******/ 		}
/******/ 	};
/******/
/******/ 	// getDefaultExport function for compatibility with non-harmony modules
/******/ 	__webpack_require__.n = function(module) {
/******/ 		var getter = module && module.__esModule ?
/******/ 			function getDefault() { return module['default']; } :
/******/ 			function getModuleExports() { return module; };
/******/ 		__webpack_require__.d(getter, 'a', getter);
/******/ 		return getter;
/******/ 	};
/******/
/******/ 	// Object.prototype.hasOwnProperty.call
/******/ 	__webpack_require__.o = function(object, property) { return Object.prototype.hasOwnProperty.call(object, property); };
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = 2);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ (function(module, exports, __webpack_require__) {

const Asteroid = __webpack_require__(4);
const Util = __webpack_require__(1);
const Ship = __webpack_require__(6);

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


/***/ }),
/* 1 */
/***/ (function(module, exports) {

const Util = {
  inherits (childClass, parentClass) {
    const Surrogate = function Surrogate() {};
    Surrogate.prototype = parentClass.prototype;
    childClass.prototype = new Surrogate();
    childClass.constructor = childClass;
  },

  scale(vec, m) {
    return [vec[0] * m, vec[1] * m];
  },

  normVec(vel) {
    let m = Math.sqrt([vel[0]**2 + vel[1]**2]);
    return [vel[0]/m, vel[1]/m];
  },

  randomVec(length) {
    const deg = 2 * Math.PI * Math.random();
    return Util.scale([Math.sin(deg), Math.cos(deg)], length);
  },

  randomPos(maxX,maxY) {
    return [maxX * Math.random(), maxY * Math.random()];
  },

  wrap(pos, boundary) {
    return pos.map(el => Util.mod(el, boundary));
  },

  mod(num, modVal) {
    if (num >= 0) {
      return num % modVal;
    } else {
      return modVal + num % modVal;
    }
  },

  dist(p1, p2) {
    return Math.sqrt((p1[0] - p2[0])**2
                        + (p1[1] - p2[1])**2);
  }
};

module.exports = Util;


/***/ }),
/* 2 */
/***/ (function(module, exports, __webpack_require__) {


const GameView = __webpack_require__(3);

function startGame() {
  const canvasEl = document.getElementsByTagName("canvas")[0];
  canvasEl.height = 500;
  canvasEl.width = 500;
  new GameView(
    canvasEl.getContext("2d")
  ).start();
}

document.addEventListener('DOMContentLoaded', startGame);


/***/ }),
/* 3 */
/***/ (function(module, exports, __webpack_require__) {

const Game = __webpack_require__(0);

const GameView = function GameView(ctx) {
  this.ctx = ctx;
  this.game = new Game();
};

GameView.prototype.start = function start() {
  this.game.draw(this.ctx);

  setInterval( () => {
    this.game.step();
    this.game.draw(this.ctx);
  }, 20);
};

GameView.prototype.bindKeyHandlers = function bindKeyHandlers(){
  
};

module.exports = GameView;


/***/ }),
/* 4 */
/***/ (function(module, exports, __webpack_require__) {

const MovingObject = __webpack_require__(5);
const Util = __webpack_require__(1);

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


/***/ }),
/* 5 */
/***/ (function(module, exports, __webpack_require__) {

const Game = __webpack_require__(0);
const Util = __webpack_require__(1);

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


/***/ }),
/* 6 */
/***/ (function(module, exports, __webpack_require__) {

const Game = __webpack_require__(0);
const Util = __webpack_require__(1);
const Key = __webpack_require__(7);
const MovingObject = __webpack_require__(5);
const Bullet = __webpack_require__(8);

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


/***/ }),
/* 7 */
/***/ (function(module, exports, __webpack_require__) {

//     keymaster.js
//     (c) 2011-2013 Thomas Fuchs
//     keymaster.js may be freely distributed under the MIT license.

;(function(global){
  var k,
    _handlers = {},
    _mods = { 16: false, 18: false, 17: false, 91: false },
    _scope = 'all',
    // modifier keys
    _MODIFIERS = {
      '⇧': 16, shift: 16,
      '⌥': 18, alt: 18, option: 18,
      '⌃': 17, ctrl: 17, control: 17,
      '⌘': 91, command: 91
    },
    // special keys
    _MAP = {
      backspace: 8, tab: 9, clear: 12,
      enter: 13, 'return': 13,
      esc: 27, escape: 27, space: 32,
      left: 37, up: 38,
      right: 39, down: 40,
      del: 46, 'delete': 46,
      home: 36, end: 35,
      pageup: 33, pagedown: 34,
      ',': 188, '.': 190, '/': 191,
      '`': 192, '-': 189, '=': 187,
      ';': 186, '\'': 222,
      '[': 219, ']': 221, '\\': 220
    },
    code = function(x){
      return _MAP[x] || x.toUpperCase().charCodeAt(0);
    },
    _downKeys = [];

  for(k=1;k<20;k++) _MAP['f'+k] = 111+k;

  // IE doesn't support Array#indexOf, so have a simple replacement
  function index(array, item){
    var i = array.length;
    while(i--) if(array[i]===item) return i;
    return -1;
  }

  // for comparing mods before unassignment
  function compareArray(a1, a2) {
    if (a1.length != a2.length) return false;
    for (var i = 0; i < a1.length; i++) {
        if (a1[i] !== a2[i]) return false;
    }
    return true;
  }

  var modifierMap = {
      16:'shiftKey',
      18:'altKey',
      17:'ctrlKey',
      91:'metaKey'
  };
  function updateModifierKey(event) {
      for(k in _mods) _mods[k] = event[modifierMap[k]];
  };

  // handle keydown event
  function dispatch(event) {
    var key, handler, k, i, modifiersMatch, scope;
    key = event.keyCode;

    if (index(_downKeys, key) == -1) {
        _downKeys.push(key);
    }

    // if a modifier key, set the key.<modifierkeyname> property to true and return
    if(key == 93 || key == 224) key = 91; // right command on webkit, command on Gecko
    if(key in _mods) {
      _mods[key] = true;
      // 'assignKey' from inside this closure is exported to window.key
      for(k in _MODIFIERS) if(_MODIFIERS[k] == key) assignKey[k] = true;
      return;
    }
    updateModifierKey(event);

    // see if we need to ignore the keypress (filter() can can be overridden)
    // by default ignore key presses if a select, textarea, or input is focused
    if(!assignKey.filter.call(this, event)) return;

    // abort if no potentially matching shortcuts found
    if (!(key in _handlers)) return;

    scope = getScope();

    // for each potential shortcut
    for (i = 0; i < _handlers[key].length; i++) {
      handler = _handlers[key][i];

      // see if it's in the current scope
      if(handler.scope == scope || handler.scope == 'all'){
        // check if modifiers match if any
        modifiersMatch = handler.mods.length > 0;
        for(k in _mods)
          if((!_mods[k] && index(handler.mods, +k) > -1) ||
            (_mods[k] && index(handler.mods, +k) == -1)) modifiersMatch = false;
        // call the handler and stop the event if neccessary
        if((handler.mods.length == 0 && !_mods[16] && !_mods[18] && !_mods[17] && !_mods[91]) || modifiersMatch){
          if(handler.method(event, handler)===false){
            if(event.preventDefault) event.preventDefault();
              else event.returnValue = false;
            if(event.stopPropagation) event.stopPropagation();
            if(event.cancelBubble) event.cancelBubble = true;
          }
        }
      }
    }
  };

  // unset modifier keys on keyup
  function clearModifier(event){
    var key = event.keyCode, k,
        i = index(_downKeys, key);

    // remove key from _downKeys
    if (i >= 0) {
        _downKeys.splice(i, 1);
    }

    if(key == 93 || key == 224) key = 91;
    if(key in _mods) {
      _mods[key] = false;
      for(k in _MODIFIERS) if(_MODIFIERS[k] == key) assignKey[k] = false;
    }
  };

  function resetModifiers() {
    for(k in _mods) _mods[k] = false;
    for(k in _MODIFIERS) assignKey[k] = false;
  };

  // parse and assign shortcut
  function assignKey(key, scope, method){
    var keys, mods;
    keys = getKeys(key);
    if (method === undefined) {
      method = scope;
      scope = 'all';
    }

    // for each shortcut
    for (var i = 0; i < keys.length; i++) {
      // set modifier keys if any
      mods = [];
      key = keys[i].split('+');
      if (key.length > 1){
        mods = getMods(key);
        key = [key[key.length-1]];
      }
      // convert to keycode and...
      key = key[0]
      key = code(key);
      // ...store handler
      if (!(key in _handlers)) _handlers[key] = [];
      _handlers[key].push({ shortcut: keys[i], scope: scope, method: method, key: keys[i], mods: mods });
    }
  };

  // unbind all handlers for given key in current scope
  function unbindKey(key, scope) {
    var multipleKeys, keys,
      mods = [],
      i, j, obj;

    multipleKeys = getKeys(key);

    for (j = 0; j < multipleKeys.length; j++) {
      keys = multipleKeys[j].split('+');

      if (keys.length > 1) {
        mods = getMods(keys);
      }

      key = keys[keys.length - 1];
      key = code(key);

      if (scope === undefined) {
        scope = getScope();
      }
      if (!_handlers[key]) {
        return;
      }
      for (i = 0; i < _handlers[key].length; i++) {
        obj = _handlers[key][i];
        // only clear handlers if correct scope and mods match
        if (obj.scope === scope && compareArray(obj.mods, mods)) {
          _handlers[key][i] = {};
        }
      }
    }
  };

  // Returns true if the key with code 'keyCode' is currently down
  // Converts strings into key codes.
  function isPressed(keyCode) {
      if (typeof(keyCode)=='string') {
        keyCode = code(keyCode);
      }
      return index(_downKeys, keyCode) != -1;
  }

  function getPressedKeyCodes() {
      return _downKeys.slice(0);
  }

  function filter(event){
    var tagName = (event.target || event.srcElement).tagName;
    // ignore keypressed in any elements that support keyboard data input
    return !(tagName == 'INPUT' || tagName == 'SELECT' || tagName == 'TEXTAREA');
  }

  // initialize key.<modifier> to false
  for(k in _MODIFIERS) assignKey[k] = false;

  // set current scope (default 'all')
  function setScope(scope){ _scope = scope || 'all' };
  function getScope(){ return _scope || 'all' };

  // delete all handlers for a given scope
  function deleteScope(scope){
    var key, handlers, i;

    for (key in _handlers) {
      handlers = _handlers[key];
      for (i = 0; i < handlers.length; ) {
        if (handlers[i].scope === scope) handlers.splice(i, 1);
        else i++;
      }
    }
  };

  // abstract key logic for assign and unassign
  function getKeys(key) {
    var keys;
    key = key.replace(/\s/g, '');
    keys = key.split(',');
    if ((keys[keys.length - 1]) == '') {
      keys[keys.length - 2] += ',';
    }
    return keys;
  }

  // abstract mods logic for assign and unassign
  function getMods(key) {
    var mods = key.slice(0, key.length - 1);
    for (var mi = 0; mi < mods.length; mi++)
    mods[mi] = _MODIFIERS[mods[mi]];
    return mods;
  }

  // cross-browser events
  function addEvent(object, event, method) {
    if (object.addEventListener)
      object.addEventListener(event, method, false);
    else if(object.attachEvent)
      object.attachEvent('on'+event, function(){ method(window.event) });
  };

  // set the handlers globally on document
  addEvent(document, 'keydown', function(event) { dispatch(event) }); // Passing _scope to a callback to ensure it remains the same by execution. Fixes #48
  addEvent(document, 'keyup', clearModifier);

  // reset modifiers to false whenever the window is (re)focused.
  addEvent(window, 'focus', resetModifiers);

  // store previously defined key
  var previousKey = global.key;

  // restore previously defined key and return reference to our key object
  function noConflict() {
    var k = global.key;
    global.key = previousKey;
    return k;
  }

  // set window.key and window.key.set/get/deleteScope, and the default filter
  global.key = assignKey;
  global.key.setScope = setScope;
  global.key.getScope = getScope;
  global.key.deleteScope = deleteScope;
  global.key.filter = filter;
  global.key.isPressed = isPressed;
  global.key.getPressedKeyCodes = getPressedKeyCodes;
  global.key.noConflict = noConflict;
  global.key.unbind = unbindKey;

  if(true) module.exports = assignKey;

})(this);


/***/ }),
/* 8 */
/***/ (function(module, exports, __webpack_require__) {

const Util = __webpack_require__(1);
const MovingObject = __webpack_require__(5);

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


/***/ })
/******/ ]);