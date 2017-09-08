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
