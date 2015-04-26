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
        
        method testDictionarySizeAfterRemove {
            oneToFive.removeKey "one"
            deny(oneToFive.containsKey "one") description "\"one\" still present"
            oneToFive.removeKey "two"
            oneToFive.removeKey "three"
            assert(oneToFive.size) shouldBe 2
        }
        
        method testDictionaryContentsAfterMultipleRemove {
            oneToFive.removeKey("one", "two", "three")
            assert(oneToFive.size) shouldBe 2
            deny(oneToFive.containsKey "one") description "\"one\" still present"
            deny(oneToFive.containsKey "two") description "\"two\" still present"
            deny(oneToFive.containsKey "three") description "\"three\" still present"
            assert(oneToFive.containsKey "four")
            assert(oneToFive.containsKey "five")
        }
        
        method testAsString {
            def dict2 = dictionary.with("one"::1, "two"::2)
            def dStr = dict2.asString
            assert((dStr == "dict⟬one::1, two::2⟭").orElse{dStr == "dict⟬two::2, one::1⟭"})
                description "\"{dStr}\" should be \"dict⟬one::1, two::2⟭\""
        }
        
        method testAsStringEmpty {
            assert(empty.asString) shouldBe "dict⟬⟭"
        }
        
        method testDictionaryEmptyDo {
            empty.do {each -> failBecause "emptySet.do did with {each}"}
        }
        
        method testDictionaryEqualityEmpty {
            assert(empty == dictionary.empty)
            deny(empty != dictionary.empty)
        }
        
        method testDictionaryInequalityEmpty {
            deny(empty == dictionary.with("one"::1)) 
                description "empty dictionary equals non-empty dictionary with \"one\"::1"
            assert(empty != dictionary.with("two"::2))
                description "empty dictionary equals non-empty dictionary with \"two\"::2"
            deny(empty == 3)
            deny(empty == evens)
        }
        
        method testDictionaryInequalityFive {
            evens.at "ten" put 10
            assert(evens.size == oneToFive.size) description "evens.size should be 5"
            deny(oneToFive == evens)
            assert(oneToFive != evens)
        }
        
        method testDictionaryEqualityFive {
            assert(oneToFive == dictionary.with("one"::1, "two"::2, "three"::3,
                "four"::4, "five"::5))
        }
        
        
        method testDictionaryAdd {
            assert (empty.at "nine" put(9)) 
                shouldBe (dictionary.with("nine"::9))
            //assert (evens.at "ten" put(10).values.onto(set)) shouldBe (set.with(2, 4, 6, 8, 10))
        }
        
        method testDictionaryRemoveKeyTwo {
            //assert (evens.removeKey "two".values.onto(set)) shouldBe (set.with(4, 6, 8))
            //assert (evens.values.onto(set)) shouldBe (set.with(4, 6, 8))
        }
        
        method testDictionaryRemoveValue4 {
            assert (evens.size == 4) description "evens doesn't contain 4 elements"
            evens.removeValue(4)
            assert (evens.size == 3) 
                description "after removing 4, 3 elements should remain"
            assert (evens.containsKey "two") description "Can't find key \"two\""
            assert (evens.containsKey "six") description "Can't find key \"six\""
            assert (evens.containsKey "eight") description "Can't find key \"eight\""
            deny (evens.containsKey "four") description "Found key \"four\""
            //assert (evens.removeValue(4).values.onto(set)) shouldBe (set.with(2, 6, 8))
            //assert (evens.values.onto(set)) shouldBe (set.with(2, 6, 8))
            //assert (evens.keys.onto(set)) shouldBe (set.with("two", "six", "eight"))
        }
        
        method testDictionaryRemoveMultiple {
            evens.removeValue(4, 6, 8)
            assert (evens) shouldBe (dictionary.at"two"put(2))
        }
        
        method testDictionaryRemove5 {
            //assert {evens.removeKey(5)} shouldRaise (NoSuchObject)
        }
        
        method testDictionaryRemoveKeyFive {
            //assert {evens.removeKey("Five")} shouldRaise (NoSuchObject)
        }
        
        method testDictionaryChaining {        
            oneToFive.at "eleven" put(11).at "twelve" put(12).at "thirteen" put(13)
            //assert (oneToFive.values.onto(set)) shouldBe (set.with(1, 2, 3, 4, 5, 11, 12, 13))
        }
        
        method testDictionaryPushAndExpand {
            evens.removeKey "two"
            evens.removeKey "four"
            evens.removeKey "six"
            evens.at "ten" put(10)
            evens.at "twelve" put(12)
            evens.at "fourteen" put(14)
            evens.at "sixteen" put(16)
            evens.at "eighteen" put(18)
            evens.at "twenty" put(20)
            //assert (evens.values.onto(set)) 
            //    shouldBe (set.with(8, 10, 12, 14, 16, 18, 20))
        }
    }
}

def dictTests = gU.testSuite.fromTestMethodsIn(dictionaryTest)
dictTests.runAndPrintResults