"use strict";
this.outer = do_import("StandardPrelude", gracecode_StandardPrelude);
function gracecode_animation () {
  setModuleName("animation");
  if (callStack.length == 0)
    callStack = ["execution environment"]
  this.definitionModule = "animation";
  this.definitionLine = 0;
  setLineNumber(32)    // compilenode method;
  var func0 = function(argcv) {    // method while(1)pausing(1)do(1)
    var curarg = 1;
    var var_condition = arguments[curarg];
    curarg++;
    if (argcv[0] != 1)
      callmethod(ProgrammingErrorObject, "raise", [1], new GraceString("wrong number of arguments for while (arg list 1) of while(1)pausing(1)do(1)"));
    var var_pauseTime = arguments[curarg];
    curarg++;
    if (argcv[1] != 1)
      callmethod(ProgrammingErrorObject, "raise", [1], new GraceString("wrong number of arguments for pausing (arg list 2) of while(1)pausing(1)do(1)"));
    var var_block = arguments[curarg];
    curarg++;
    if (argcv[2] != 1)
      callmethod(ProgrammingErrorObject, "raise", [1], new GraceString("wrong number of arguments for do (arg list 3) of while(1)pausing(1)do(1)"));
    setModuleName("animation");
    var returnTarget = invocationCount;
    invocationCount++;
    try {
      setLineNumber(33)    // compilenode block;
      var block1 = new GraceBlock(this, 33, 0);
      block1.real = function() {
        sourceObject = this;
        var if2 = GraceDone;
        setLineNumber(34)    // compilenode identifier;
        var call3 = callmethod(var_condition,"apply", [0]);
        if (Grace_isTrue(call3)) {
          setLineNumber(35)    // compilenode identifier;
          var call4 = callmethod(var_block,"apply", [0]);
          if2 = call4;
        } else {
          setLineNumber(37)    // compilenode identifier;
          var call5 = callmethod(var_timer,"stop", [1], var_id);
          if2 = call5;
        }
        return if2;
      };
      setLineNumber(33)    // compilenode identifier;
      var call6 = callmethod(var_timer,"every()do", [1, 1], var_pauseTime, block1);
      var var_id = call6;
      if (!Grace_isTrue(callmethod(var_Number, "match",
        [1], var_id)))
          throw new GraceExceptionPacket(TypeErrorObject,
                new GraceString("expected "
                + "initial value of def 'id' to be of type Number"))
      return call6;
    } catch(e) {
      if ((e.exctype == 'return') && (e.target == returnTarget)) {
        return e.returnvalue;
      } else {
        throw e;
      }
    }
  }
  func0.paramTypes = [];
  func0.paramTypes.push([]);
  func0.paramTypes.push([type_Number, "pauseTime"]);
  func0.paramTypes.push([type_Block, "block"]);
  func0.paramCounts = [
      1,
      1,
      1,
  ];
  func0.variableArities = [
      false,
      false,
      false,
  ];
  this.methods["while()pausing()do"] = func0;
  func0.definitionLine = 32;
  func0.definitionModule = "animation";
  setLineNumber(44)    // compilenode method;
  var func7 = function(argcv) {    // method while(1)pausing(1)do(1)finally(1)
    var curarg = 1;
    var var_condition = arguments[curarg];
    curarg++;
    if (argcv[0] != 1)
      callmethod(ProgrammingErrorObject, "raise", [1], new GraceString("wrong number of arguments for while (arg list 1) of while(1)pausing(1)do(1)finally(1)"));
    var var_pauseTime = arguments[curarg];
    curarg++;
    if (argcv[1] != 1)
      callmethod(ProgrammingErrorObject, "raise", [1], new GraceString("wrong number of arguments for pausing (arg list 2) of while(1)pausing(1)do(1)finally(1)"));
    var var_block = arguments[curarg];
    curarg++;
    if (argcv[2] != 1)
      callmethod(ProgrammingErrorObject, "raise", [1], new GraceString("wrong number of arguments for do (arg list 3) of while(1)pausing(1)do(1)finally(1)"));
    var var_endBlock = arguments[curarg];
    curarg++;
    if (argcv[3] != 1)
      callmethod(ProgrammingErrorObject, "raise", [1], new GraceString("wrong number of arguments for finally (arg list 4) of while(1)pausing(1)do(1)finally(1)"));
    setModuleName("animation");
    var returnTarget = invocationCount;
    invocationCount++;
    try {
      setLineNumber(46)    // compilenode block;
      var block8 = new GraceBlock(this, 46, 0);
      block8.real = function() {
        sourceObject = this;
        var if9 = GraceDone;
        setLineNumber(47)    // compilenode identifier;
        var call10 = callmethod(var_condition,"apply", [0]);
        if (Grace_isTrue(call10)) {
          setLineNumber(48)    // compilenode identifier;
          var call11 = callmethod(var_block,"apply", [0]);
          if9 = call11;
        } else {
          setLineNumber(50)    // compilenode identifier;
          var call12 = callmethod(var_timer,"stop", [1], var_id);
          setLineNumber(51)    // compilenode identifier;
          var call13 = callmethod(var_endBlock,"apply", [0]);
          if9 = call13;
        }
        return if9;
      };
      setLineNumber(46)    // compilenode identifier;
      var call14 = callmethod(var_timer,"every()do", [1, 1], var_pauseTime, block8);
      var var_id = call14;
      if (!Grace_isTrue(callmethod(var_Number, "match",
        [1], var_id)))
          throw new GraceExceptionPacket(TypeErrorObject,
                new GraceString("expected "
                + "initial value of def 'id' to be of type Number"))
      return call14;
    } catch(e) {
      if ((e.exctype == 'return') && (e.target == returnTarget)) {
        return e.returnvalue;
      } else {
        throw e;
      }
    }
  }
  func7.paramTypes = [];
  func7.paramTypes.push([]);
  func7.paramTypes.push([type_Number, "pauseTime"]);
  func7.paramTypes.push([type_Block, "block"]);
  func7.paramTypes.push([type_Block, "endBlock"]);
  func7.paramCounts = [
      1,
      1,
      1,
      1,
  ];
  func7.variableArities = [
      false,
      false,
      false,
      false,
  ];
  this.methods["while()pausing()do()finally"] = func7;
  func7.definitionLine = 44;
  func7.definitionModule = "animation";
  setLineNumber(58)    // compilenode method;
  var func15 = function(argcv) {    // method while(1)pauseVarying(1)do(1)
    var curarg = 1;
    var var_condition = arguments[curarg];
    curarg++;
    if (argcv[0] != 1)
      callmethod(ProgrammingErrorObject, "raise", [1], new GraceString("wrong number of arguments for while (arg list 1) of while(1)pauseVarying(1)do(1)"));
    var var_timeBlock = arguments[curarg];
    curarg++;
    if (argcv[1] != 1)
      callmethod(ProgrammingErrorObject, "raise", [1], new GraceString("wrong number of arguments for pauseVarying (arg list 2) of while(1)pauseVarying(1)do(1)"));
    var var_block = arguments[curarg];
    curarg++;
    if (argcv[2] != 1)
      callmethod(ProgrammingErrorObject, "raise", [1], new GraceString("wrong number of arguments for do (arg list 3) of while(1)pauseVarying(1)do(1)"));
    setModuleName("animation");
    var returnTarget = invocationCount;
    invocationCount++;
    try {
      var if16 = GraceDone;
      setLineNumber(59)    // compilenode identifier;
      var call17 = callmethod(var_condition,"apply", [0]);
      if (Grace_isTrue(call17)) {
        setLineNumber(60)    // compilenode identifier;
        var call18 = callmethod(var_block,"apply", [0]);
        setLineNumber(61)    // compilenode identifier;
        var call19 = callmethod(var_timeBlock,"apply", [0]);
        var block20 = new GraceBlock(this, 61, 0);
        block20.real = function() {
          sourceObject = this;
          setLineNumber(62)    // compilenode identifier;
          onSelf = true;
          var call21 = callmethod(this, "while()pauseVarying()do", [1, 1, 1], var_condition, var_timeBlock, var_block);
          return call21;
        };
        setLineNumber(61)    // compilenode identifier;
        var call22 = callmethod(var_timer,"after()do", [1, 1], call19, block20);
        if16 = call22;
      }
      return if16;
    } catch(e) {
      if ((e.exctype == 'return') && (e.target == returnTarget)) {
        return e.returnvalue;
      } else {
        throw e;
      }
    }
  }
  func15.paramTypes = [];
  func15.paramTypes.push([]);
  func15.paramTypes.push([]);
  func15.paramTypes.push([type_Block, "block"]);
  func15.paramCounts = [
      1,
      1,
      1,
  ];
  func15.variableArities = [
      false,
      false,
      false,
  ];
  this.methods["while()pauseVarying()do"] = func15;
  func15.definitionLine = 58;
  func15.definitionModule = "animation";
  setLineNumber(69)    // compilenode method;
  var func23 = function(argcv) {    // method for(1)pausing(1)do(1)
    var curarg = 1;
    var var_rangeList = arguments[curarg];
    curarg++;
    if (argcv[0] != 1)
      callmethod(ProgrammingErrorObject, "raise", [1], new GraceString("wrong number of arguments for for (arg list 1) of for(1)pausing(1)do(1)"));
    var var_pauseTime = arguments[curarg];
    curarg++;
    if (argcv[1] != 1)
      callmethod(ProgrammingErrorObject, "raise", [1], new GraceString("wrong number of arguments for pausing (arg list 2) of for(1)pausing(1)do(1)"));
    var var_block = arguments[curarg];
    curarg++;
    if (argcv[2] != 1)
      callmethod(ProgrammingErrorObject, "raise", [1], new GraceString("wrong number of arguments for do (arg list 3) of for(1)pausing(1)do(1)"));
    // Start generics
    if (argcv.length == 1 + 3) {
      if (argcv[argcv.length-1] < 1) {
        callmethod(ProgrammingErrorObject, "raise", [1], new GraceString("insufficient generic parameters"));
      }
      var var_T = arguments[curarg++];
    } else {
      var_T = var_Unknown;
    }
    // End generics
    var curarg2 = 1;
    curarg2++;
    curarg2++;
    curarg2++;
    // End checking generics
    setModuleName("animation");
    var returnTarget = invocationCount;
    invocationCount++;
    try {
      setLineNumber(70)    // compilenode identifier;
      var call24 = callmethod(var_rangeList,"iterator", [0]);
      var var_it = call24;
      setLineNumber(71)    // compilenode block;
      var block25 = new GraceBlock(this, 71, 0);
      block25.real = function() {
        sourceObject = this;
        var call26 = callmethod(var_it,"havemore", [0]);
        return call26;
      };
      var block27 = new GraceBlock(this, 71, 0);
      block27.real = function() {
        sourceObject = this;
        var call28 = callmethod(var_it,"next", [0]);
        var call29 = callmethod(var_block,"apply", [1], call28);
        return call29;
      };
      onSelf = true;
      var call30 = callmethod(this, "while()pausing()do", [1, 1, 1], block25, var_pauseTime, block27);
      return call30;
    } catch(e) {
      if ((e.exctype == 'return') && (e.target == returnTarget)) {
        return e.returnvalue;
      } else {
        throw e;
      }
    }
  }
  func23.paramTypes = [];
  func23.paramTypes.push([]);
  func23.paramTypes.push([type_Number, "pauseTime"]);
  func23.paramTypes.push([]);
  func23.paramCounts = [
      1,
      1,
      1,
  ];
  func23.variableArities = [
      false,
      false,
      false,
  ];
  this.methods["for()pausing()do"] = func23;
  func23.definitionLine = 69;
  func23.definitionModule = "animation";
  setLineNumber(77)    // compilenode method;
  var func31 = function(argcv) {    // method for(1)pausing(1)do(1)finally(1)
    var curarg = 1;
    var var_rangeList = arguments[curarg];
    curarg++;
    if (argcv[0] != 1)
      callmethod(ProgrammingErrorObject, "raise", [1], new GraceString("wrong number of arguments for for (arg list 1) of for(1)pausing(1)do(1)finally(1)"));
    var var_pauseTime = arguments[curarg];
    curarg++;
    if (argcv[1] != 1)
      callmethod(ProgrammingErrorObject, "raise", [1], new GraceString("wrong number of arguments for pausing (arg list 2) of for(1)pausing(1)do(1)finally(1)"));
    var var_block = arguments[curarg];
    curarg++;
    if (argcv[2] != 1)
      callmethod(ProgrammingErrorObject, "raise", [1], new GraceString("wrong number of arguments for do (arg list 3) of for(1)pausing(1)do(1)finally(1)"));
    var var_endBlock = arguments[curarg];
    curarg++;
    if (argcv[3] != 1)
      callmethod(ProgrammingErrorObject, "raise", [1], new GraceString("wrong number of arguments for finally (arg list 4) of for(1)pausing(1)do(1)finally(1)"));
    // Start generics
    if (argcv.length == 1 + 4) {
      if (argcv[argcv.length-1] < 1) {
        callmethod(ProgrammingErrorObject, "raise", [1], new GraceString("insufficient generic parameters"));
      }
      var var_T = arguments[curarg++];
    } else {
      var_T = var_Unknown;
    }
    // End generics
    var curarg2 = 1;
    curarg2++;
    curarg2++;
    curarg2++;
    curarg2++;
    // End checking generics
    setModuleName("animation");
    var returnTarget = invocationCount;
    invocationCount++;
    try {
      setLineNumber(79)    // compilenode identifier;
      var call32 = callmethod(var_rangeList,"iterator", [0]);
      var var_it = call32;
      var call33 = callmethod(Grace_prelude, "Iterator", [0]);
      if (!Grace_isTrue(callmethod(call33, "match",
        [1], var_it)))
          throw new GraceExceptionPacket(TypeErrorObject,
                new GraceString("expected "
                + "initial value of def 'it' to be of type Iterator<T>"))
      setLineNumber(80)    // compilenode block;
      var block34 = new GraceBlock(this, 80, 0);
      block34.real = function() {
        sourceObject = this;
        var call35 = callmethod(var_it,"havemore", [0]);
        return call35;
      };
      var block36 = new GraceBlock(this, 80, 0);
      block36.real = function() {
        sourceObject = this;
        var call37 = callmethod(var_it,"next", [0]);
        var call38 = callmethod(var_block,"apply", [1], call37);
        return call38;
      };
      setLineNumber(81)    // compilenode identifier;
      onSelf = true;
      var call39 = callmethod(this, "while()pausing()do()finally", [1, 1, 1, 1], block34, var_pauseTime, block36, var_endBlock);
      return call39;
    } catch(e) {
      if ((e.exctype == 'return') && (e.target == returnTarget)) {
        return e.returnvalue;
      } else {
        throw e;
      }
    }
  }
  func31.paramTypes = [];
  func31.paramTypes.push([]);
  func31.paramTypes.push([]);
  func31.paramTypes.push([]);
  func31.paramTypes.push([type_Block, "endBlock"]);
  func31.paramCounts = [
      1,
      1,
      1,
      1,
  ];
  func31.variableArities = [
      false,
      false,
      false,
      false,
  ];
  this.methods["for()pausing()do()finally"] = func31;
  func31.definitionLine = 77;
  func31.definitionModule = "animation";
  setLineNumber(1)    // compilenode import;
  // Import of timer as timer
  if (typeof gracecode_timer == 'undefined')
    throw new GraceExceptionPacket(EnvironmentExceptionObject, 
      new GraceString('could not find module timer'));
  var var_timer = do_import("timer", gracecode_timer);
  var func40 = function(argcv) {    // method timer
    var curarg = 1;
    if (argcv[0] != 0)
      callmethod(ProgrammingErrorObject, "raise", [1], new GraceString("wrong number of arguments for timer"));
    setModuleName("animation");
    // timer is a simple accessor - elide try ... catch
    return var_timer;
  }
  func40.paramCounts = [
      0,
  ];
  func40.variableArities = [
      false,
  ];
  this.methods["timer"] = func40;
  func40.definitionLine = 1;
  func40.definitionModule = "animation";
  func40.debug = "import";
  func40.confidential = true;
  setModuleName("animation");
  setLineNumber(5)    // compilenode typedec;
  // Type decl BoolBlock
  //   Type literal 
  var type42 = new GraceType("BoolBlock");
  type42.typeMethods.push("apply");
  var var_BoolBlock = type42;
  setLineNumber(80)    // compilenode method;
  var func43 = function(argcv) {    // method BoolBlock
    var curarg = 1;
    if (argcv[0] != 0)
      callmethod(ProgrammingErrorObject, "raise", [1], new GraceString("wrong number of arguments for BoolBlock"));
    setModuleName("animation");
    // BoolBlock is a simple accessor - elide try ... catch
    setLineNumber(4)    // compilenode identifier;
    return var_BoolBlock;
  }
  func43.paramCounts = [
      0,
  ];
  func43.variableArities = [
      false,
  ];
  this.methods["BoolBlock"] = func43;
  func43.definitionLine = 80;
  func43.definitionModule = "animation";
  setLineNumber(8)    // compilenode typedec;
  // Type decl NumberBlock
  //   Type literal 
  var type45 = new GraceType("NumberBlock");
  type45.typeMethods.push("apply");
  var var_NumberBlock = type45;
  setLineNumber(80)    // compilenode method;
  var func46 = function(argcv) {    // method NumberBlock
    var curarg = 1;
    if (argcv[0] != 0)
      callmethod(ProgrammingErrorObject, "raise", [1], new GraceString("wrong number of arguments for NumberBlock"));
    setModuleName("animation");
    // NumberBlock is a simple accessor - elide try ... catch
    setLineNumber(5)    // compilenode identifier;
    return var_NumberBlock;
  }
  func46.paramCounts = [
      0,
  ];
  func46.variableArities = [
      false,
  ];
  this.methods["NumberBlock"] = func46;
  func46.definitionLine = 80;
  func46.definitionModule = "animation";
  setLineNumber(32)    // compilenode typedec;
  // Type decl Animator
  //   Type literal 
  var type48 = new GraceType("Animator");
  type48.typeMethods.push("while()pausing()do");
  type48.typeMethods.push("while()pausing()do()finally");
  type48.typeMethods.push("while()pauseVarying()do");
  type48.typeMethods.push("for()pausing()do");
  type48.typeMethods.push("for()pausing()do()finally");
  var var_Animator = type48;
  setLineNumber(80)    // compilenode method;
  var func49 = function(argcv) {    // method Animator
    var curarg = 1;
    if (argcv[0] != 0)
      callmethod(ProgrammingErrorObject, "raise", [1], new GraceString("wrong number of arguments for Animator"));
    setModuleName("animation");
    // Animator is a simple accessor - elide try ... catch
    setLineNumber(8)    // compilenode identifier;
    return var_Animator;
  }
  func49.paramCounts = [
      0,
  ];
  func49.variableArities = [
      false,
  ];
  this.methods["Animator"] = func49;
  func49.definitionLine = 80;
  func49.definitionModule = "animation";
  setLineNumber(73)    // compilenode blank;
  return this;
}
gracecode_animation.imports = [
'timer',
];
if (typeof gctCache !== "undefined")
  gctCache['animation'] = "classes:\npublic:\n BoolBlock\n NumberBlock\n Animator\n while()pausing()do\n while()pausing()do()finally\n while()pauseVarying()do\n for()pausing()do\n for()pausing()do()finally\nconfidential:\nfresh-methods:\nmodules:\n timer\npath:\n animation\n";
if (typeof originalSourceLines !== "undefined") {
  originalSourceLines["animation"] = [
    "import \"timer\" as timer",
    "",
    "// type of a block that takes no parameters and returns a boolean",
    "type BoolBlock = {apply -> Boolean}",
    "type NumberBlock = {apply -> Number}",
    "",
    "// type of object that can simulate parallel animations",
    "type Animator = {",
    "   // Repeatedly execute block while condition is true",
    "   while(condition:BoolBlock) pausing (pauseTime:Number) do (block:Block) -> Done",
    "",
    "   // Repeatedly execute block while condition is true, pausing pauseTime between iterations",
    "   // when condition fails, execute endBlock.",
    "   while (condition:BoolBlock) pausing (pauseTime:Number) do (block:Block) ",
    "                         finally(endBlock:Block) -> Done",
    "",
    "   // Repeatedly execute block while condition is true",
    "   // pausing variable amount of time (obtained by evaluating timeBlock) between iterations",
    "   // when condition fails, execute endBlock.",
    "   while(condition:BoolBlock) pauseVarying (timeBlock: NumberBlock) do (block:Block) -> Done",
    "",
    "   // Repeatedly execute block while condition is true",
    "   for<T> (rangeList:List<T>) pausing (pauseTime) do (block:Block<T,Done>) -> Done",
    " ",
    "   // Repeatedly execute block while condition is true",
    "   // when condition fails, execute endBlock.",
    "   for<T> (rangeList:List<T>) pausing (pauseTime) do (block:Block<T,Done>) finally (endBlock:Block) -> Done",
    "",
    "}",
    "",
    "// Repeatedly execute block while condition is true",
    "method while(condition:BoolBlock) pausing (pauseTime:Number) do (block:Block) -> Done {",
    "  def id:Number = timer.every(pauseTime)do{",
    "     if(condition.apply) then {",
    "        block.apply",
    "     } else {",
    "        timer.stop(id)",
    "     }",
    "  }",
    "}",
    "",
    "// Repeatedly execute block while condition is true, pausing by pauseTime",
    "// between iterations. When condition fails, execute endBlock.",
    "method while (condition:BoolBlock) pausing (pauseTime:Number) do (block:Block) ",
    "                  finally(endBlock:Block) -> Done {",
    "  def id:Number = timer.every(pauseTime)do{",
    "     if(condition.apply) then {",
    "        block.apply",
    "     } else {",
    "        timer.stop(id)",
    "        endBlock.apply",
    "     }",
    "  }",
    "}",
    "",
    "// Repeatedly execute block while condition is true, pausing by pauseTime",
    "// between iterations. ",
    "method while(condition:BoolBlock) pauseVarying (timeBlock) do (block:Block)  -> Done {",
    "  if(condition.apply)then {",
    "     block.apply",
    "     timer.after(timeBlock.apply) do {",
    "         while (condition) pauseVarying (timeBlock) do (block)",
    "     }",
    "  }",
    "}",
    "",
    "// Repeatedly execute block for each value in rangeList, pausing pauseTime between iterations.",
    "// block should take a numeric value as a parameter",
    "method for<T>(rangeList:List<T>) pausing (pauseTime: Number) do (block:Block<Number,Done>)-> Done {",
    "  def it = rangeList.iterator",
    "  while{it.havemore} pausing (pauseTime) do {block.apply(it.next)}",
    "}",
    "",
    "// Repeatedly execute block for each value in rangeList, pausing pauseTime between iterations.",
    "// block should take a numeric value as a parameter",
    "// when condition fails, execute endBlock.",
    "method for<T> (rangeList:List<T>) pausing (pauseTime) do(block:Block<Number,Done>)",
    "             finally(endBlock:Block) -> Done {",
    "  def it:Iterator<T> = rangeList.iterator",
    "  while{it.havemore} pausing (pauseTime) do {block.apply(it.next)}",
    "         finally(endBlock)",
    "}",
  ];
};
if (typeof global !== "undefined")
  global.gracecode_animation = gracecode_animation;
if (typeof window !== "undefined")
  window.gracecode_animation = gracecode_animation;
