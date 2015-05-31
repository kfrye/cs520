import "math" as math
import "mirrors" as mi
def mm = mi.reflect(math)
print "math's methods are: "
for (mm.methods) do { each ->
    print "    {each.name}"
}

print "asString = {math.asString}"
print "asDebugString = {math.asDebugString}"
print "sin(90°) = {math.sin(math.π/2)}"
print "cos(0°) = {math.cos(0)}"
print "tan(45°) = {math.tan(math.π/4)}"
print "asin(-1/2) = {math.asin(-1/2) * 180 / math.π}°"
print "acos(1/2) = {math.acos(1/2) * 180 / math.π}°"
print "atan(1) = {math.atan(1) * 180 / math.π}°"
print "pi = {math.pi}"
print "π = {math.π}"
print "sqrt(16) = {math.sqrt(16)}"
print "abs(-21.34) = {math.abs(-21.34)}"