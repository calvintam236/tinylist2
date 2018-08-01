import 'dart:math' as math;
import 'package:trotter/trotter.dart';

void main() {
  final games = 1000, gamesToDisplay = 5;

  print("""

(An example of output generated by `example.dart`.)

# Fun with Mastermind

In this demonstration we investigate the average number of guesses it
takes to win a game of Mastermind using a simple algorithm:

1. We choose a random code from among the potential codes, and guess it.

2. We use the clues we receive to determine whether we have won, in which case we stop and record the number of moves it took, or not, in which case we use the clues to reduce the number of potential codes and go back to step 1.

We are investigating the version of the game that has six colors (which we arbitrarily refer to as A, B, C, D, E and F) and four positions.

Clues are represented by the characters `*` (for black, which means that a color is in the correct position) and `o` (for white, which means a color not already accounted for is in an incorrect position).

We will let the computer play $games games; we will only display the first and last $gamesToDisplay games.
  
Here goes:

## The games...
  
  """);

  var scores = List.generate(games, (i) {
    bool display = i < gamesToDisplay || games - i <= gamesToDisplay;
    if (display) print("\n### Game ${i + 1}\n");
    return playGame(display);
  });

  print("## Summary\n");
  num mean = scores.fold(0, (a, b) => a + b) / games,
      min = scores.reduce(math.min),
      max = scores.reduce(math.max);
  print(
      "In $games games, the computer found the code in at least $min guesses, at most $max guesses, and on average ${mean.toStringAsFixed(3)} guesses.");

  print("## trotter\n");
  print("""
This was just a little demonstration of a real-world application using the trotter library.

Notice that Mastermind codes are permutations with replacement (referred to as `Amalgams` in the trotter library). In this program a single line of code generates a list of all possible Mastermind codes:

```dart
var potentials = Amalgams(4, characters("ABCDEF"))().toList();
```

The game *Bulls & Cows* is played similarly to Mastermind but with non zero digits instead of colors and usually without replacement. Notice that this program would only need a few alterations to investigate that game, including something along the lines of:

```dart
var potentials = Permutations(4, characters("123456789"))().toList();
```

Thanks for your interest! Please let me know if you find any interesting use cases for this library!

Richard Ambler rambler@ibwya.net

  """);
}

String showClues(List clues) => "` ${"*" * clues.first} ${"o" * clues.last} `";

int playGame(bool display) {
  var rand = math.Random();

  var potentials = Amalgams(4, characters("ABCDEF"))().toList();
  var code = potentials[rand.nextInt(potentials.length)];
  if (display) print("The secret code: ${string(code)}\n");
  List<int> clues;
  int guesses = 0;
  if (display) print("|Guess number|Guess|Clues|\n|:--:|:--|:--|");
  do {
    guesses++;
    var guess = potentials[rand.nextInt(potentials.length)];
    clues = getClues(code, guess);
    if (display) print("|$guesses|${string(guess)}|${showClues(clues)}");

    potentials.removeWhere((potentialGuess) {
      var potentialClues = getClues(guess, potentialGuess);
      if (potentialClues.first != clues.first || potentialClues.last != clues.last) {
        return true;
      } else
        return false;
    });
  } while (clues.first != 4);

  if (display) print("\nSolved in $guesses guesses.");
  return guesses;
}

List<int> getClues(List code, List guess) {
  var codeCopy = List.from(code), guessCopy = List.from(guess);
  int blacks = List.generate(4, (i) {
    if (codeCopy[i] == guessCopy[i]) {
      codeCopy[i] = 'x';
      guessCopy[i] = 'x';
      return 1;
    }
    return 0;
  }).fold(0, (a, b) => a + b),
      whites = List.generate(4, (i) {
    if (guessCopy[i] == 'x') return 0;
    int index = codeCopy.indexOf(guess[i]);
    if (index == -1) return 0;
    codeCopy[index] = 'x';
    return 1;
  }).fold(0, (a, b) => a + b);

  return [blacks, whites];
}
