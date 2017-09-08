const DOMNodeCollection = require("./dom_node_collection.js");

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
