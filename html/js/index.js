(function() {

  function render(data) {
    console.log(data);
  }

  d3.json('/metros.json', render)
})()
