(function() {

  function render(metros) {
    // Basic set up of dimensions and sizes
    var el = d3.select('.js-canvas'),
       margin = { top: 20, right: 10, bottom: 10, left: 10 },
       width  = parseFloat(el.style('width')) - margin.left - margin.right,
       height = parseFloat(el.style('height')) - margin.top - margin.bottom

    // Initialize a grid layout that will allow us to easily implement a
    // small-multiples-style visualization
    var grid = d3.layout.grid()
      .bands()
      .cols(9)
      .padding([0.02, 0.09])
      .size([width, height])

    metros = grid(metros)

    var plotSize   = grid.nodeSize(),
        plotWidth  = plotSize[0],
        plotHeight = plotSize[1]

    var plotMargin = { top: 20, right: 0, bottom: 1, left: 0 },
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
      .tickPadding(5)

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

    // Crate a linear gradient to use later in our paths
    vis.append('linearGradient')
      .attr('id', 'fallen-star-gradient')
      .attr('gradientUnits', 'userSpaceOnUse')
      .attr('x1', 0).attr('y1', y(povertyRateMin))
      .attr('x2', 0).attr('y2', y(povertyRateMax))
    .selectAll('stop')
      .data(generateColorStops(10, '#40C90A', '#F14C24'))
    .enter().append('stop')
        .attr('offset', function(d) { return d.offset })
        .attr('stop-color', function(d) { return d.color })

    // Create and position a plot for each metro area
    var plot = vis.selectAll('.plot')
      .data(metros)
    .enter().append('g')
      .attr('transform', function(d) { return 'translate(' + d.x + ',' + d.y + ')' })
      .attr('class', function(d, i) { return 'plot ' + 'plot-' + i })
    .append('g')
      .attr('transform', function(d) { return 'translate(' + plotMargin.left + ',' + plotMargin.top + ')' })

    // Create a horizontal divider line
    plot.append('line')
      .attr('class', 'divider')
      .attr('x1', 0)
      .attr('x2', plotWidth + plotMargin.left + plotMargin.right)
      .attr('y1', plotHeight + 1)
      .attr('y2', plotHeight + 1)

    // Draw the x axis ticks and labels
    plot.append('g')
      .attr('class', 'axis x')
      .call(xax)

    // Add the metro title to each plot
    plot.append('text')
      .attr('class', 'title')
      .attr('x', plotWidth / 2)
      .attr('y', -5)
      .text(formatMetroName)

    // Add a group to house all tract lines for poverty rates
    var rates = plot.append('g')
      .attr('class', 'poverty-rate')

    // Add a group for each tract.
    // TODO: We could potentially get rid of this extra nesting assuming we
    // don't put other objects in this group
    var tracts = rates.selectAll('.tract')
      .data(function(d) { return d.values.tracts.sort(function(a, b) { return a.fallenStar - b.fallenStar }) })
    .enter().append('g')
      .attr('class', 'tract')

    // Create a path for each tract based on the poverty since 1970
    tracts.append('path')
      .attr('class', 'rate-line')
      .classed('newly-poor', function(d) { return d.newlyPoor })
      .classed('fallen-star', function(d) { return d.fallenStar })
      .classed('chronically-poor', function(d) { return d.chronicallyPoor })
      .attr('d', function(d) { return  path(d.povrate) })
      .style('stroke', function(d) {
        if(d.fallenStar) return 'url(#fallen-star-gradient)'
      })

  }

  // Private - Simplify metro name to the first metro and state
  function formatMetroName(tract) {
    var parts = tract.key.split(',')
    return parts[0].split('-')[0].split('/')[0] + ', ' + parts[1].split('-')[0]
  }

  function generateColorStops(count, colorFrom, colorTo) {
    count -= 1
    var stops = [],
        cursor = 0,
        step  = 100 / count,
        scale = d3.scale.linear()
          .domain([0, count])
          .range([colorFrom, colorTo])
          .interpolate(d3.interpolateHcl)

    for(; cursor <= count; cursor++) {
      stops.push({
        offset: Math.ceil(cursor * step) + '%',
        color: scale(cursor)
      })
    }

    return stops
  }

  d3.json('/metros.json', render)
})()
