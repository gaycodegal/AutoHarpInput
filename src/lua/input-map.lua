--[[
input map from keyboard input into autoharp

choose ABCD EFG primary note:
qwer tyu

Choose chord:
asdfg hjkl; 
zxcvb nm,./

minor:
major:
dim triad
dom seventh
dim seventh
augmented triad
major seventh
minor seventh
extended?
augmented seventh (maj minor)
chromatic mediant

no standard lua lib available.
API:
print (javascript console.log)
midiOn
midiOff
]]
require("config")
midi_on_map = {}
keydown_map = {}
keyup_map = {}
selected_scale=full_scale

function get_from_map(map, key)
   for i, v in ipairs(map) do
      local val = v[key]
      if val then
	 return val
      end
   end
   return nil
end

function keydown(code)
   print("key down", code)
   local f = get_from_map(keydown_map, code)
   if f then
      f()
   end
end

function keyup(code)
   print("key up", code)
   local f = get_from_map(keyup_map, code)
   if f then
      f()
   end
end

function clone_rotated_array(arr, offset)
   local new_arr = {}
   local size = #arr
   for i = 1, offset do
      new_arr[i] = arr[size - offset + i]
   end
   for i = offset + 1, size do
      new_arr[i] = arr[i - offset]
   end
   return new_arr
end

function print_rot(arr, offset)
   print(table.concat(clone_rotated_array(arr,offset), ","))
end

function base_note(note_name)
   return function()
      local note_offset = note_names[note_name] - 1
      selected_scale = clone_rotated_array(full_scale, note_offset)
      keydown_map = {_key_map_base}
      keyup_map = {_key_map_chords}
   end
end

function chord_map(fn)
   local new_map = {}
   local j = 0
   
   for i, v in ipairs(_notes_in_order) do
      local note = selected_chord[(j % selected_chord_len) + 1] + octave_size * (j // selected_chord_len)
      new_map[v] = fn(note)
      print("i", i, "note", note, "key", v)
      j = j + 1
   end
   return new_map
end

function note_down(note)
   return function()
      print("down", note)
   end
end

function note_up(note)
   return function()
      print("up", note)
   end
end

function set_chord(name, notes)
   return function()
      selected_chord = notes
      selected_chord_len = #notes
      print("down")
      keydown_map = {_key_map_base,chord_map(note_down)}
      print("up")
      keyup_map = {chord_map(note_up)}
      print("-----")
   end
end

function convert_to_nums(map)
   local new_map = {}
   for k,v in pairs(map) do
      local code = key_to_code[k]
      if code ~= nil then
	 new_map[code] = v
      else
	 new_map[key] = v
      end
   end
   return new_map
end

function convert_to_nums_ipair(map)
   local new_map = {}
   for i,v in ipairs(map) do
      local code = key_to_code[v]
      if code ~= nil then
	 new_map[i] = code
      else
	 new_map[i] = v
      end
   end
   return new_map
end

function setup()
   load_maps()
   -- now we want the maps in terms of number -> fn
   -- instead of keyname -> fn
   _key_map_base = convert_to_nums(key_map_base)
   _key_map_chords = convert_to_nums(key_map_chords)
   _notes_in_order = convert_to_nums_ipair(notes_in_order)
   keydown_map = {_key_map_base}
   keyup_map = {_key_map_chords}
end

setup()
keydown(key_to_code["q"])
keyup(key_to_code["q"])
keydown(key_to_code["a"])
keyup(key_to_code["a"])

keydown(key_to_code["a"])
keyup(key_to_code["a"])
