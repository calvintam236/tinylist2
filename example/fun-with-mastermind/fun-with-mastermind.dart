import 'dart:math' as math;
import 'package:tinylist2/tinylist2.dart';

class Clue {
  Clue(this.blacks, this.whites);
  int blacks, whites;
}

void main() {
  final games = 500, gamesToDisplay = 5;

  print('''

(An example of output generated by `fun-with-mastermind.dart`.)

# Fun with Mastermind

In this demonstration we investigate the average number of guesses it
takes to win a game of Mastermind using a simple algorithm:

1. We choose a (fairly) random code from among the remaining eligible codes, and guess it.

2. We use the clues we receive to determine whether we have won, in which case we stop and record the number of moves it took, or not, in which case we use the clues to reduce the number of eligible codes and go back to step 1.

We are investigating the version of the game that has six colors (which we arbitrarily refer to as A, B, C, D, E and F) and four positions.

Clues are represented by the characters `*` (for black, which means that a color is in the correct position) and `o` (for white, which means a color not already accounted for is in an incorrect position).

We will let the computer play $games games; we will only display the first and last $gamesToDisplay games.
  
Here goes:

## The games...
  
  ''');

  final scores = List.generate(games, (gameIndex) {
    bool display =
        gameIndex < gamesToDisplay || games - gameIndex <= gamesToDisplay;
    if (display) {
      print('\n### Game ${gameIndex + 1}\n');
    }
    return playGame(display);
  });

  print('## Summary\n');
  final mean = scores.fold<num>(0, (a, b) => a + b) / games,
      min = scores.reduce(math.min),
      max = scores.reduce(math.max);
  print('''
In $games games, the computer found the code in at least $min guesses, at most $max guesses, and on average ${mean.toStringAsFixed(3)} guesses.

Thanks for your interest! Please let me know if you find any interesting use cases for this library!

Richard Ambler rambler@ibwya.net

''');
}

String showClues(Clue clue) => '` ${'*' * clue.blacks} ${'o' * clue.whites} `';

int playGame(bool display) {
  final rand = math.Random(),
      //potentials = Amalgams(4, characters('ABCDEF'))().toList(),
      amalgams = Amalgams(4, characters('ABCDEF')),
      length = amalgams.length.toInt(),
      storage = Storage(amalgams),
      secretCode = amalgams[rand.nextInt(length)];

  if (display) {
    print('The secret code: ${secretCode.join()}\n');
  }

  Clue clue;
  int guesses = 0;

  if (display) {
    print('|Guess number|Guess|Clues|\n|:--:|:--|:--|');
  }

  List<String> makeGuess() {
    List<String> guess;
    // Try three random guesses.
    for (int i = 0; i < 3; i++) {
      guess = amalgams[rand.nextInt(length)];
      if (storage.contains(guess)) {
        return guess;
      }
    }
    // Otherwise return the first available guess.
    return storage.firstRemaining();
  }

  do {
    guesses++;
    final guess = makeGuess();
    clue = getClues(secretCode, guess);
    if (display) print('|$guesses|${string(guess)}|${showClues(clue)}|');

    storage.removeWhere((potentialGuess) {
      final potentialClues = getClues(guess, potentialGuess);
      if (potentialClues.blacks != clue.blacks ||
          potentialClues.whites != clue.whites) {
        return true;
      } else
        return false;
    });
  } while (clue.blacks != 4);

  if (display) {
    print('\nSolved in $guesses guesses.');
  }
  return guesses;
}

Clue getClues(List<String> code, List<String> guess) {
  var codeCopy = List<String>.from(code), guessCopy = List<String>.from(guess);
  final blacks = List.generate(4, (i) {
        if (codeCopy[i] == guessCopy[i]) {
          codeCopy[i] = 'x';
          guessCopy[i] = 'x';
          return 1;
        }
        return 0;
      }).fold<int>(0, (a, b) => a + b),
      whites = List.generate(4, (i) {
        if (guessCopy[i] == 'x') return 0;
        int index = codeCopy.indexOf(guess[i]);
        if (index == -1) return 0;
        codeCopy[index] = 'x';
        return 1;
      }).fold<int>(0, (a, b) => a + b);

  return Clue(blacks, whites);
}
