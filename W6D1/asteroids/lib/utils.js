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
