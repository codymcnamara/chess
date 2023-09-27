# Chess

The game of Chess written for the command line.

<br>

### Interesting features:
Chess pieces inherit from parent classes where piece movements are similar (ex: bishops and rooks both inherit from [Slidable](https://github.com/codymcnamara/chess/blob/master/pieces/sliding.rb) class).

Custom method [“deep_dup”](https://github.com/codymcnamara/chess/blob/master/board.rb#L5) copies the game board, which is used to check if move is valid and/or puts other player in check

<br>

## To play the game:
1. Clone this repository
2. Navigate to the cloned repository in your terminal
3. Type "ruby game.rb" and press enter!
