# AutoHarp Input

This is an input library for mapping keyboard input to midi notes. Technically the output does not have to be midi, it just is by default set up that way.

## The plan

1. top row of keys choose base note, enters into chord/scale select mode.
2. the next two rows of keys in chord select mode are mapped each to a
   different chord
3. selecting a chord remaps these bottom two rows of keys into that
   chord.
4. top row remains base note select keys to allow swap out of keys
5. possibly also do a floating point 0.0 to 1.0 scale also mapped 
   to midi.
   
## Technical specifications

- mapping hosted in lua, for use in any environment.
- lua packaged in minimal webassembly setup
- javascript controls input of lua, and loading of lua code
  via minimal api
- application specific javascript handles what to do with midi
