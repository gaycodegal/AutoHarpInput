-- 0 = C0, 1 = C#0, ..., 10 = A#1, 11 = B1
-- technically if you're lucky, sometimes floating points will work here too
-- via detuning. should work in the javascript environment at least
full_scale = {0,1,2,3,4,5,6,7,8,9,10,11}
note_names = {["C"]=1,["C#"]=2,["D"]=3,["D#"]=4,["E"]=5,["F"]=6,["F#"]=7,["G"]=8,["G#"]=9,["A"]=10,["A#"]=11,["B"]=12}
octave_size = #full_scale

--[[
keymap assumes javascript en_us chrome mapping, which is
'roughly translatable' to most other locals. unfortunately,
the mapping between keycode and keyname is not always stable.

in reconfiguring, it is always possible to get the correct
name to number association, but working from saved data
some things may be incorrect for some locals.

thus, initial display of the values used will be with the
en_us map, but in the end product, users will be able to
make it do the right behavior and/or naming scheme
at runtime.
]]
key_to_code = {["0"]=48,["1"]=49,["2"]=50,["3"]=51,["4"]=52,["5"]=53,["6"]=54,["7"]=55,["8"]=56,["9"]=57,["a"]=65,["q"]=81,["w"]=87,["e"]=69,["r"]=82,["y"]=89,["t"]=84,["u"]=85,["i"]=73,["o"]=79,["p"]=80,[";"]=186,["l"]=76,["k"]=75,["j"]=74,["h"]=72,["g"]=71,["f"]=70,["d"]=68,["s"]=83,["/"]=191,["."]=190,[","]=188,["m"]=77,["n"]=78,["z"]=90,["b"]=66,["x"]=88,["c"]=67,["v"]=86,["Tab"]=9,["Escape"]=27,["Shift"]=16,["Control"]=17,["Alt"]=18,["ArrowLeft"]=37,["ArrowDown"]=40,["ArrowUp"]=38,["ArrowRight"]=39,["Enter"]=13,["'"]=222,["Backspace"]=8,[" "]=32,["!"]=49,["@"]=50,["#"]=51,["$"]=52,["%"]=53,["^"]=54,["&"]=55,["*"]=56,["("]=57,[")"]=48,["F1"]=112,["F2"]=113,["-"]=189,["="]=187,["["]=219,["]"]=221,["_"]=189,["+"]=187,["{"]=219,["}"]=221,["\\"]=220,["<"]=188,["Home"]=36,["End"]=35,[">"]=190,[":"]=186,["\""]=222,["?"]=191}

code_to_key = {}

for k, v in pairs(key_to_code) do
   code_to_key[v] = k
end

function load_maps()
   key_map_base = {
      q = base_note("A"),
      w = base_note("B"),
      e = base_note("C"),
      r = base_note("D"),
      t = base_note("E"),
      y = base_note("F"),
      u = base_note("G"),
   }
   key_map_chords = {
      a = set_chord("Major Chord", { 1, 5, 8}),
      s = set_chord("Minor Chord", { 1, 5, 8}),
      z = set_chord("Major Scale", { 1, 3, 5, 6, 8,10,12}),
      x = set_chord("Minor Scale", { 1, 3, 4, 6, 8, 9,11}),
   }
   notes_in_order = {
      "a","s","d","f","g",
      "h","j","k","l",";",
      "z","x","c","v","b",
      "n","m",",",".","/",
   }
end

