import "gUnit" as gU

def dictionaryTest = object {
    class forMethod(m) {
        inherits gU.testCaseNamed(m)
        def oneToFive = dictionary.with("one"::1, "two"::2, "three"::3, 
            "four"::4, "five"::5)
        def evens = dictionary.with("two"::2, "four"::4, "six"::6, "eight"::8)
        def empty = dictionary.empty

        method testDictionarySize {
            assert(oneToFive.size) shouldBe 5
            assert(empty.size) shouldBe 0
            assert(evens.size) shouldBe 4
        }
    }
}

def dictTests = gU.testSuite.fromTestMethodsIn(dictionaryTest)
print "dictionary"
dictTests.runAndPrintResults