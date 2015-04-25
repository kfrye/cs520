import "gUnit" as gU
dialect "dictionary" 

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
        
        method testDictionaryKeysAndValuesDo {
            def accum = dictionary.empty
            var n := 1
            oneToFive.keysAndValuesDo { k, v ->
                accum.at(k)put(v)
                assert (accum.size) shouldBe (n)
                n := n + 1
            }
            assert(accum) shouldBe (oneToFive)
        }
        
        method testDictionaryEmptyBindingsIterator {
            deny (empty.bindings.havemore) description "the empty iterator has elements"
        }
        
        method testDictionaryEvensBindingsIterator {
            def ei = evens.bindings
            assert (evens.size == 4) description "evens doesn't contain 4 elements!"
            assert (ei.havemore) description "the evens iterator has no elements"
            def copyDict = dictionary.with(ei.next, ei.next, ei.next, ei.next)
            deny (ei.havemore) description "the evens iterator has more than 4 elements"
            assert (copyDict) shouldBe (evens)
        }
        
        //method testDictionarySizeAfterRemove {
        //    oneToFive.removeKey "one"
        //    deny(oneToFive.containsKey "one") description "\"one\" still present"
        //    oneToFive.removeKey "two"
        //    oneToFive.removeKey "three"
        //    assert(oneToFive.size) shouldBe 2
        //}
    }
}

def dictTests = gU.testSuite.fromTestMethodsIn(dictionaryTest)
dictTests.runAndPrintResults