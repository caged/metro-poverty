(function() {

  function render(metros) {
    // Basic set up of dimensions and sizes
    var el = d3.select('.js-canvas'),
       margin = { top: 20, right: 20, bottom: 0, left: 20 },
       width  = parseFloat(el.style('width')) - margin.left - margin.right,
       height = 1200 //parseFloat(el.style('height')) - margin.top - margin.bottom

    // Initialize a grid layout that will allow us to easily implement a
    // small-multiples-style visualization
    var grid = d3.layout.grid()
      .bands()
      .cols(6)
      .size([width, height])
      .padding([0.1, 0.1])

    metros = grid(metros)

    var plotSize   = grid.nodeSize(),
        plotWidth  = plotSize[0],
        plotHeight = plotSize[1]

        populationMin   = d3.min(metros, function(d) { return d.values.populationExtent[0] }),
        populationMax   = d3.max(metros, function(d) { return d.values.populationExtent[1] }),
        povertyCountMin = d3.min(metros, function(d) { return d.values.povcountExtent[0] }),
        povertyCountMax = d3.max(metros, function(d) { return d.values.povcountExtent[1] })

    console.log(populationMin, populationMax, povertyCountMin, povertyCountMax);
    // Create the main SVG container element with the proper size
    var vis = el.append('svg')
      .attr('width', width + margin.left + margin.right)
      .attr('height', height + margin.bottom + margin.top)
    .append('g')
      .attr('transform', 'translate(' + margin.left + ',' + margin.top + ')')

    // Create and position a plot for each metro area
    var plot = vis.selectAll('.plot')
      .data(grid(metros))
    .enter().append('g')
      .attr('transform', function(d) { return "translate(" + d.x + "," + d.y + ")" })
      .attr('class', 'plot')

    // Add the metro title to each plot
    plot.append('text')
      .attr('class', 'title')
      .text(formatMetroName)
  }

  // Private - Simplify metro name to the first metro and state
  function formatMetroName(tract) {
    var parts = tract.key.split(',')
    return parts[0].split('-')[0].split('/')[0] + ', ' + parts[1].split('-')[0]
  }

  d3.json('/metros.json', render)
})()
