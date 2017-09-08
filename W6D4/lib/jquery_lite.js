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
/******/ 	return __webpack_require__(__webpack_require__.s = 0);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ (function(module, exports, __webpack_require__) {

const DOMNodeCollection = __webpack_require__(1);

window.$l = function $l(selector) {
  const functions = [];
  document.addEventListener("DOMContentLoaded", () => {
    functions.forEach((fn)=>{fn();});
  });
  if (selector.constructor === String) {
    const nodeList = document.querySelectorAll(selector);
    return new DOMNodeCollection(Array.from(nodeList));
  } else if (selector instanceof HTMLElement ) {
    return new DOMNodeCollection([selector]);
  } else if (selector instanceof Function) {
    if(document.readyState ==="complete" && functions.length === 0) {
      selector();
    } else {
      functions.push(selector);
    }
  }
};

console.log(window.$l('div'));
window.$l(()=>{console.log(window.$l('div'));});

Window.DOMNodeCollection = DOMNodeCollection;


/***/ }),
/* 1 */
/***/ (function(module, exports) {

class DOMNodeCollection {
  constructor(arrHTML) {
    this.arrHTML = arrHTML;
  }

  html(str) {
    if(str === undefined) {
      return this.arrHTML[0].innerHTML;
    } else {
      this.arrHTML.forEach( (el) => {el.innerHTML = str;} );
    }
  }

  empty (){
    this.arrHTML.forEach( (el) => {el.innerHTML = "";} );
  }

  append (html){
    if (html.constructor === DOMNodeCollection) {
      html.arrHTML.forEach( (node) => {
        this.arrHTML.forEach( (el) => {
          // alert(node);
          el.appendChild(node);
        });
      });
    } else {
      this.arrHTML.forEach( (el) => {
        el.innerHTML += html;
      });
    }
  }

  attr (attrName, value) {
    if(value === undefined) {
      return this.arrHTML[0].getAttribute(attrName);
    } else {
      this.arrHTML.forEach((el) => {
        return el.setAttribute(attrName, value);
      });
    }
  }

  addClass (elClass) {
    this.arrHTML.forEach( (el) => {
      if (!(el.className)) {
        el.className = elClass;
      } else {
        el.className += ' ' + elClass;
      }
    });
  }

  removeClass (elClass) {
    this.arrHTML.forEach( (el) => {
      el.classList.remove(elClass);
    });
  }

  children () {
    let allChildren = [];
    this.arrHTML.forEach((el)=> {
      allChildren = allChildren.concat(Array.from(el.children));
    });
    return new DOMNodeCollection(allChildren);
  }

  parent () {
    let allParents = [];
    this.arrHTML.forEach((el)=>{
      allParents.push(el.parentNode);
    });
    return new DOMNodeCollection(allParents);
  }

  find (selector) {
    let found = [];
    this.arrHTML.forEach( (el) => {
      let subFound = Array.from(el.querySelectorAll(selector));
      found = found.concat(subFound);
    });
    return new DOMNodeCollection(found);
  }

  remove () {
    this.arrHTML.forEach((el)=>{
      el.parentNode.removeChild(el);
    });
    this.arrHTML = [];
  }

  on (type, e) {
    this.arrHTML.forEach((el)=>{
      el.addEventListener(type, e);
      if (el[type].length > 0) {
        el[type].push(e);
      } else {
        el[type] = [e];
      }
    });
  }

  off (type) {
    this.arrHTML.forEach((el)=>{
      el[type].forEach((fn) => {
        el.removeEventListener(type, fn);
      });
      el[type] = undefined;
    });
  }
}

module.exports = DOMNodeCollection;


/***/ })
/******/ ]);