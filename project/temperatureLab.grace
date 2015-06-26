import "graphix" as g

var drawing

factory method setup(obj) {
  drawing := self
  var graphics := g.create(200,400)
  def rect = graphics.addRect.at(35@20).setWidth(30).setHeight(285).draw
  def circle = graphics.addArc.setRadius(30).setStartAngle(0).setEndAngle(180).at(50@300)
  circle.colored("red").filled(true).draw
  var target := obj
  
  graphics.addText.setContent("Fahrenheit").at(150@80).draw
  def fahrInput = graphics.addInputBox.at(150@100).draw
  
  graphics.addText.setContent("Celsius:").at(150@170).draw
  def celsiusLabel = graphics.addText.setContent("???").colored("red").at(150@190)
  celsiusLabel.setFont("14px Arial").draw
  
  def block = {
    def val = g.convertStrToNum(fahrInput.value)
    target.convertToCelsius(val)
  }
  
  fahrInput.onSubmit(block)
  
  method setCelsius(value) {
    def rounded = g.roundTo(value, 2)
    celsiusLabel.setContent(rounded).draw
  }
}

method setCelsius(value) {
  drawing.setCelsius(value)
}
