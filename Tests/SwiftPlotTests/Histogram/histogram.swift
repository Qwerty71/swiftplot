import SwiftPlot
import SVGRenderer
#if canImport(AGGRenderer)
import AGGRenderer
#endif
#if canImport(QuartzRenderer)
import QuartzRenderer
#endif

@available(tvOS 13, watchOS 13, *)
extension HistogramTests {
  
  func testHistogram() throws {    
    let fileName = "_21_histogram"
    
    var histogram = Histogram<Float>(isNormalized: false, enableGrid: true)
    histogram.addSeries(data: histogram_values, bins: 50, label: "Plot 1", color: .blue)
    histogram.plotTitle = PlotTitle("HISTOGRAM")
    histogram.plotLabel = PlotLabel(xLabel: "X", yLabel: "Frequency")
    
    let svg_renderer = SVGRenderer()
    try histogram.drawGraphAndOutput(fileName: svgOutputDirectory+fileName,
                                     renderer: svg_renderer)
    verifyImage(name: fileName, renderer: .svg)
    #if canImport(AGGRenderer)
    let agg_renderer = AGGRenderer()
    try histogram.drawGraphAndOutput(fileName: aggOutputDirectory+fileName,
                                     renderer: agg_renderer)
    verifyImage(name: fileName, renderer: .agg)
    #endif
    #if canImport(QuartzRenderer)
    let quartz_renderer = QuartzRenderer()
    try histogram.drawGraphAndOutput(fileName: coreGraphicsOutputDirectory+fileName,
                                     renderer: quartz_renderer)
    verifyImage(name: fileName, renderer: .coreGraphics)
    #endif
  }
}
