# Chess-in-ruby

Chess game in command line, started by typing game.rb.  Cursor is controlled by
Arrow keys and pieces are selected and unselected with enter.

![Demo](/docs/chess_demo4.gif)

## Features

- [x] Pieces inherit from SlidingPiece and SteppingPiece classes which inherit Piece class
- [x] Depth-first search or breadth-first-search move finding depending upon piece class
- [x] Move limits due to check
- [x] Pawns move double on their first turn
