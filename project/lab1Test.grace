import "gUnit" as gU
import "lab1" as l

def converterTest = object {
    class forMethod(m) {
        inherits gU.testCaseNamed(m)
        
        def converter = l.converterLab
        
        method test32Degrees {
          def cel = converter.convertToCelsius(32)
          assert(cel == 0)
        }
        
        method test100Degrees {
          def cel = converter.convertToCelsius(100)
          assert((cel >  37.77) && (cel < 37.78))
        }
        
        method test50Degrees {
          def cel = converter.convertToCelsius(50)
          assert(cel == 10)
        }
        
        method test0Degrees {
          def cel = converter.convertToCelsius(0)
          assert((cel > -17.78) && (cel < -17.77))
        }
    }
}

def converterTests = gU.testSuite.fromTestMethodsIn(converterTest)
converterTests.runAndPrintResults