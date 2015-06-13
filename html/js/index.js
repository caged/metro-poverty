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
      .padding([0.1, 0.1])
      .size([width, height])

    metros = grid(metros)

    var plotSize   = grid.nodeSize(),
        plotWidth  = plotSize[0],
        plotHeight = plotSize[1]

    var plotMargin = { top: 20, right: 0, bottom: 0, left: 0 },
        plotWidth = plotWidth - plotMargin.left - plotMargin.right
        plotHeight = plotHeight - plotMargin.top - plotMargin.bottom

    // Establishes some extents so we can create global scales for relative
    // sizing
    var povertyRateMin  = 0,
        povertyRateMax  = 100,
        populationMin   = d3.min(metros, function(d) { return d.values.populationExtent[0] }),
        populationMax   = d3.max(metros, function(d) { return d.values.populationExtent[1] }),
        povertyCountMin = d3.min(metros, function(d) { return d.values.povcountExtent[0] }),
        povertyCountMax = d3.max(metros, function(d) { return d.values.povcountExtent[1] }),
        years           = ['70', '80', '90', '00', '10']

    // Create an ordinal x-axis scale to position each year of data along the x axis
    var x = d3.scale.ordinal()
      .domain(d3.range(years.length))
      .rangePoints([0, plotWidth])

    // Create a linear y-axis scale to position each year node based on the rate
    // of poverty for each tract
    var y = d3.scale.linear()
      .domain([povertyRateMin, povertyRateMax])
      .range([plotHeight, 0])

    // Initialize an axis for x so we can display year numbers and ticks
    var xax = d3.svg.axis()
      .scale(x)
      .tickSize(plotHeight)
      .tickFormat(function(d, i) { return years[i] })

    // Initialize a path generator so we can create a path for each tract
    // in a metro area.
    var path = d3.svg.line()
      .interpolate('monotone')
      .x(function(d, i) { return x(i) })
      .y(y)

    // Create the main SVG container element with the proper size
    var vis = el.append('svg')
      .attr('width', width + margin.left + margin.right)
      .attr('height', height + margin.bottom + margin.top)
    .append('g')
      .attr('transform', 'translate(' + margin.left + ',' + margin.top + ')')

    // Create and position a plot for each metro area
    var plot = vis.selectAll('.plot')
      .data(metros)
    .enter().append('g')
      .attr('transform', function(d) { return 'translate(' + d.x + ',' + d.y + ')' })
      .attr('class', 'plot')
    .append('g')
      .attr('transform', function(d) { return 'translate(' + plotMargin.left + ',' + plotMargin.top + ')' })

    // Add the metro title to each plot
    plot.append('text')
      .attr('class', 'title')
      .text(formatMetroName)

    var rates = plot.append('g')
      .attr('class', 'poverty-rate')

    var tracts = rates.selectAll('.tract')
      .data(function(d) { return d.values.tracts.sort(function(a, b) { return a.fallenStar - b.fallenStar }) })
    .enter().append('g')
      .attr('class', 'tract')

    tracts.append('path')
      .attr('class', 'rate-line')
      .classed('newly-poor', function(d) { return d.newlyPoor })
      .classed('fallen-star', function(d) { return d.fallenStar })
      .attr('d', function(d) { return  path(d.povrate) })

    plot.append('g')
      .attr('class', 'axis x')
      .call(xax)

    // tracts.selectAll('.rate')
    //   .data(function(d) { return d.povrate })
    // .enter().append('circle')
    //   .attr('class', 'rate')
    //   .attr('cx', function(d, i) { return x(i) })
    //   .attr('cy', y)
    //   .attr('r', 1)

  }

  // Private - Simplify metro name to the first metro and state
  function formatMetroName(tract) {
    var parts = tract.key.split(',')
    return parts[0].split('-')[0].split('/')[0] + ', ' + parts[1].split('-')[0]
  }

  d3.json('/metros.json', render)
})()
