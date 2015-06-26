import "temperature" as t

factory method converterLab {
  t.setup(self)
  
  method convertToCelsius(value) {
    def celsius = (value - 32) * 5 / 9
    t.setCelsius(celsius)
    celsius
  }
}

converterLab