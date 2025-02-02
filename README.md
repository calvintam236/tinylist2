# tinylist2

> `tinylist2` is a small library that simplifies working with meta-arrangements commonly encountered in combinatorics, such as arrangements of combinations and permutations.

A frok of [trotter](https://github.com/ram6ler/dart-trotter) by [Richard Ambler](https://github.com/ram6ler)

`tinylist2` gives the developer access to pseudo-lists that 'contain' all selections (combinations, permutations, etc.) of objects taken from a specified list of items.

The order of arrangements is based on the the order produced by the  [Steinhaus–Johnson–Trotter algorithm](https://en.wikipedia.org/wiki/Steinhaus%E2%80%93Johnson%E2%80%93Trotter_algorithm) for ordering permutations, which I have generalized to combinations and arrangements that allow for replacement after item selection.

The following pseudo-list classes are available:
* Combinations
* Permutations
* Compositions (combinations with replacement)
* Amalgams (permutations with replacement)
* Subsets (combinations of unspecified size)
* Compounds (permutations of unspecified size)

## Getting Started

```dart
import 'package:tinylist2/tinylist2.dart';
```

## Constructors

### Combinations

A *combination* is a selection of items for which order is *not* important and items are *not* replaced after being selected.

`TinyList<T>.combination()` 'contains' all combinations of a set of items.

```dart
final List<String> bagOfItems = <String>["a", "b", "c", "d", "e"];
final TinyList<String> combos = TinyList.combination(bagOfItems, 3);
for (final combo in combos.getRange(BigInt.zero, combos.length)) {
  print('$combo (${combos.indexOf(combo)})');
}
```

```
[a, b, c]
[a, b, d]
[a, b, e]
[a, c, d]
[a, c, e]
[a, d, e]
[b, c, d]
[b, c, e]
[b, d, e]
[c, d, e]
...
```

### Permutations

A *permutation* is a selection of items for which order *is* important and items are *not* replaced after being selected.

`TinyList<T>.permutation()` 'contains' all permutations of a set of items.

```dart
final List<String> bagOfItems = <String>["a", "b", "c", "d", "e"];
final TinyList<String> perms = TinyList.permutation(bagOfItems, 3);
for (final perm in perms.getRange(BigInt.zero, perms.length)) {
  print('$perm (${perms.indexOf(perm)})');
}
```

```
[a, b, c]
[a, c, b]
[c, a, b]
[c, b, a]
[b, c, a]
[b, a, c]
[a, b, d]
[a, d, b]
[d, a, b]
[d, b, a]
[b, d, a]
[b, a, d]
[a, b, e]
[a, e, b]
[e, a, b]
[e, b, a]
[b, e, a]
[b, a, e]
[a, c, d]
[a, d, c]
[d, a, c]
[d, c, a]
[c, d, a]
[c, a, d]
[a, c, e]
[a, e, c]
[e, a, c]
[e, c, a]
[c, e, a]
[c, a, e]
[a, d, e]
[a, e, d]
[e, a, d]
[e, d, a]
[d, e, a]
[d, a, e]
[b, c, d]
[b, d, c]
[d, b, c]
[d, c, b]
[c, d, b]
[c, b, d]
[b, c, e]
[b, e, c]
[e, b, c]
[e, c, b]
[c, e, b]
[c, b, e]
[b, d, e]
[b, e, d]
[e, b, d]
[e, d, b]
[d, e, b]
[d, b, e]
[c, d, e]
[c, e, d]
[e, c, d]
[e, d, c]
[d, e, c]
[d, c, e]
...
```

Note: that this library arranges permutations similarly to the way [Steinhaus-Johnson-Trotter](https://en.wikipedia.org/wiki/Steinhaus%E2%80%93Johnson%E2%80%93Trotter_algorithm) algorithm arranges permutations. In fact, if we get the permutations of *all* the specified items, e.g. `var perms = Permutations(bagOfItems.length, bagOfItems);` in the above code, the arrangement of permutations is exactly what would have resulted from applying the S-J-T algorithm. The algorithms in this library have an advantage in that they do not iterate through all k - 1 permutations in order to determint the kth permutation, however.

### Compositions

A *composition* (or combination with replacement) is a selection of items for which order is *not* important and items *are* replaced after being selected.

`TinyList<T>.composition` 'contains' all compositions of a set of items.

```dart
final List<String> bagOfItems = <String>["a", "b", "c", "d", "e"];
final TinyList<String> compos = TinyList.composition(bagOfItems, 3);
for (final compo in compos.getRange(BigInt.zero, compos.length)) {
  print('$compo (${compos.indexOf(compo)})');
}
```

```
[a, a, a]
[a, a, b]
[a, a, c]
[a, a, d]
[a, a, e]
[a, b, b]
[a, b, c]
[a, b, d]
[a, b, e]
[a, c, c]
[a, c, d]
[a, c, e]
[a, d, d]
[a, d, e]
[a, e, e]
[b, b, b]
[b, b, c]
[b, b, d]
[b, b, e]
[b, c, c]
[b, c, d]
[b, c, e]
[b, d, d]
[b, d, e]
[b, e, e]
[c, c, c]
[c, c, d]
[c, c, e]
[c, d, d]
[c, d, e]
[c, e, e]
[d, d, d]
[d, d, e]
[d, e, e]
[e, e, e]
...
```

### Amalgams

An *amalgam* (or permutation with replacement) is a selection of items for which order *is* important and items *are* replaced after being selected.

`TinyList<T>.amalgam()` 'contains' all amalgams of a set of items.

```dart
final List<String> bagOfItems = <String>["a", "b", "c", "d", "e"];
final TinyList<String> amals = TinyList.amalgam(bagOfItems, 3);
for (final amal in amals.getRange(BigInt.zero, amals.length)) {
  print('$amal (${amals.indexOf(amal)})');
}
```

```
[a, a, a]
[a, a, b]
[a, a, c]
[a, a, d]
[a, a, e]
[a, b, a]
[a, b, b]
[a, b, c]
[a, b, d]
[a, b, e]
[a, c, a]
[a, c, b]
[a, c, c]
[a, c, d]
[a, c, e]
[a, d, a]
[a, d, b]
[a, d, c]
[a, d, d]
[a, d, e]
[a, e, a]
[a, e, b]
[a, e, c]
[a, e, d]
[a, e, e]
[b, a, a]
[b, a, b]
[b, a, c]
[b, a, d]
[b, a, e]
[b, b, a]
[b, b, b]
[b, b, c]
[b, b, d]
[b, b, e]
[b, c, a]
[b, c, b]
[b, c, c]
[b, c, d]
[b, c, e]
[b, d, a]
[b, d, b]
[b, d, c]
[b, d, d]
[b, d, e]
[b, e, a]
[b, e, b]
[b, e, c]
[b, e, d]
[b, e, e]
[c, a, a]
[c, a, b]
[c, a, c]
[c, a, d]
[c, a, e]
[c, b, a]
[c, b, b]
[c, b, c]
[c, b, d]
[c, b, e]
[c, c, a]
[c, c, b]
[c, c, c]
[c, c, d]
[c, c, e]
[c, d, a]
[c, d, b]
[c, d, c]
[c, d, d]
[c, d, e]
[c, e, a]
[c, e, b]
[c, e, c]
[c, e, d]
[c, e, e]
[d, a, a]
[d, a, b]
[d, a, c]
[d, a, d]
[d, a, e]
[d, b, a]
[d, b, b]
[d, b, c]
[d, b, d]
[d, b, e]
[d, c, a]
[d, c, b]
[d, c, c]
[d, c, d]
[d, c, e]
[d, d, a]
[d, d, b]
[d, d, c]
[d, d, d]
[d, d, e]
[d, e, a]
[d, e, b]
[d, e, c]
[d, e, d]
[d, e, e]
[e, a, a]
[e, a, b]
[e, a, c]
[e, a, d]
[e, a, e]
[e, b, a]
[e, b, b]
[e, b, c]
[e, b, d]
[e, b, e]
[e, c, a]
[e, c, b]
[e, c, c]
[e, c, d]
[e, c, e]
[e, d, a]
[e, d, b]
[e, d, c]
[e, d, d]
[e, d, e]
[e, e, a]
[e, e, b]
[e, e, c]
[e, e, d]
[e, e, e]
...
```

### Subsets

A *subset* (or combination of unspecified length) is a selection of items for which order is *not* important, items are *not* replaced and the number of items is not specified.

`TinyList<T>.subset()` 'contains' all subsets of a set of items.

```dart
final List<String> bagOfItems = <String>["a", "b", "c", "d", "e"];
final TinyList<String> subs = TinyList.subset(bagOfItems);
for (final sub in subs.getRange(BigInt.zero, subs.length)) {
  print('$sub (${subs.indexOf(sub)})');
}
```

```
[]
[a]
[b]
[a, b]
[c]
[a, c]
[b, c]
[a, b, c]
[d]
[a, d]
[b, d]
[a, b, d]
[c, d]
[a, c, d]
[b, c, d]
[a, b, c, d]
[e]
[a, e]
[b, e]
[a, b, e]
[c, e]
[a, c, e]
[b, c, e]
[a, b, c, e]
[d, e]
[a, d, e]
[b, d, e]
[a, b, d, e]
[c, d, e]
[a, c, d, e]
[b, c, d, e]
[a, b, c, d, e]
...
```

### Compounds

A *compound* (or permutation of unspecified length) is a selection of items for which order *is* important, items are *not* replaced and the number of items is not specified.

`TinyList<T>.compound()` 'contains' all compounds of a set of items.

```dart
final List<String> bagOfItems = <String>["a", "b", "c", "d", "e"];
final TinyList<String> comps = TinyList.compound(bagOfItems);
for (final comp in comps.getRange(BigInt.zero, comps.length)) {
  print('$comp (${comps.indexOf(comp)})');
}
```

```
[]
[a]
[b]
[c]
[d]
[e]
[a, b]
[b, a]
[a, c]
[c, a]
[a, d]
[d, a]
[a, e]
[e, a]
[b, c]
[c, b]
[b, d]
[d, b]
[b, e]
[e, b]
[c, d]
[d, c]
[c, e]
[e, c]
[d, e]
[e, d]
[a, b, c]
[a, c, b]
[c, a, b]
[c, b, a]
[b, c, a]
[b, a, c]
[a, b, d]
[a, d, b]
[d, a, b]
[d, b, a]
[b, d, a]
[b, a, d]
[a, b, e]
[a, e, b]
[e, a, b]
[e, b, a]
[b, e, a]
[b, a, e]
[a, c, d]
[a, d, c]
[d, a, c]
[d, c, a]
[c, d, a]
[c, a, d]
[a, c, e]
[a, e, c]
[e, a, c]
[e, c, a]
[c, e, a]
[c, a, e]
[a, d, e]
[a, e, d]
[e, a, d]
[e, d, a]
[d, e, a]
[d, a, e]
[b, c, d]
[b, d, c]
[d, b, c]
[d, c, b]
[c, d, b]
[c, b, d]
[b, c, e]
[b, e, c]
[e, b, c]
[e, c, b]
[c, e, b]
[c, b, e]
[b, d, e]
[b, e, d]
[e, b, d]
[e, d, b]
[d, e, b]
[d, b, e]
[c, d, e]
[c, e, d]
[e, c, d]
[e, d, c]
[d, e, c]
[d, c, e]
[a, b, c, d]
[a, b, d, c]
[a, d, b, c]
[d, a, b, c]
[d, a, c, b]
[a, d, c, b]
[a, c, d, b]
[a, c, b, d]
[c, a, b, d]
[c, a, d, b]
[c, d, a, b]
[d, c, a, b]
[d, c, b, a]
[c, d, b, a]
[c, b, d, a]
[c, b, a, d]
[b, c, a, d]
[b, c, d, a]
[b, d, c, a]
[d, b, c, a]
[d, b, a, c]
[b, d, a, c]
[b, a, d, c]
[b, a, c, d]
[a, b, c, e]
[a, b, e, c]
[a, e, b, c]
[e, a, b, c]
[e, a, c, b]
[a, e, c, b]
[a, c, e, b]
[a, c, b, e]
[c, a, b, e]
[c, a, e, b]
[c, e, a, b]
[e, c, a, b]
[e, c, b, a]
[c, e, b, a]
[c, b, e, a]
[c, b, a, e]
[b, c, a, e]
[b, c, e, a]
[b, e, c, a]
[e, b, c, a]
[e, b, a, c]
[b, e, a, c]
[b, a, e, c]
[b, a, c, e]
[a, b, d, e]
[a, b, e, d]
[a, e, b, d]
[e, a, b, d]
[e, a, d, b]
[a, e, d, b]
[a, d, e, b]
[a, d, b, e]
[d, a, b, e]
[d, a, e, b]
[d, e, a, b]
[e, d, a, b]
[e, d, b, a]
[d, e, b, a]
[d, b, e, a]
[d, b, a, e]
[b, d, a, e]
[b, d, e, a]
[b, e, d, a]
[e, b, d, a]
[e, b, a, d]
[b, e, a, d]
[b, a, e, d]
[b, a, d, e]
[a, c, d, e]
[a, c, e, d]
[a, e, c, d]
[e, a, c, d]
[e, a, d, c]
[a, e, d, c]
[a, d, e, c]
[a, d, c, e]
[d, a, c, e]
[d, a, e, c]
[d, e, a, c]
[e, d, a, c]
[e, d, c, a]
[d, e, c, a]
[d, c, e, a]
[d, c, a, e]
[c, d, a, e]
[c, d, e, a]
[c, e, d, a]
[e, c, d, a]
[e, c, a, d]
[c, e, a, d]
[c, a, e, d]
[c, a, d, e]
[b, c, d, e]
[b, c, e, d]
[b, e, c, d]
[e, b, c, d]
[e, b, d, c]
[b, e, d, c]
[b, d, e, c]
[b, d, c, e]
[d, b, c, e]
[d, b, e, c]
[d, e, b, c]
[e, d, b, c]
[e, d, c, b]
[d, e, c, b]
[d, c, e, b]
[d, c, b, e]
[c, d, b, e]
[c, d, e, b]
[c, e, d, b]
[e, c, d, b]
[e, c, b, d]
[c, e, b, d]
[c, b, e, d]
[c, b, d, e]
[a, b, c, d, e]
[a, b, c, e, d]
[a, b, e, c, d]
[a, e, b, c, d]
[e, a, b, c, d]
[e, a, b, d, c]
[a, e, b, d, c]
[a, b, e, d, c]
[a, b, d, e, c]
[a, b, d, c, e]
[a, d, b, c, e]
[a, d, b, e, c]
[a, d, e, b, c]
[a, e, d, b, c]
[e, a, d, b, c]
[e, d, a, b, c]
[d, e, a, b, c]
[d, a, e, b, c]
[d, a, b, e, c]
[d, a, b, c, e]
[d, a, c, b, e]
[d, a, c, e, b]
[d, a, e, c, b]
[d, e, a, c, b]
[e, d, a, c, b]
[e, a, d, c, b]
[a, e, d, c, b]
[a, d, e, c, b]
[a, d, c, e, b]
[a, d, c, b, e]
[a, c, d, b, e]
[a, c, d, e, b]
[a, c, e, d, b]
[a, e, c, d, b]
[e, a, c, d, b]
[e, a, c, b, d]
[a, e, c, b, d]
[a, c, e, b, d]
[a, c, b, e, d]
[a, c, b, d, e]
[c, a, b, d, e]
[c, a, b, e, d]
[c, a, e, b, d]
[c, e, a, b, d]
[e, c, a, b, d]
[e, c, a, d, b]
[c, e, a, d, b]
[c, a, e, d, b]
[c, a, d, e, b]
[c, a, d, b, e]
[c, d, a, b, e]
[c, d, a, e, b]
[c, d, e, a, b]
[c, e, d, a, b]
[e, c, d, a, b]
[e, d, c, a, b]
[d, e, c, a, b]
[d, c, e, a, b]
[d, c, a, e, b]
[d, c, a, b, e]
[d, c, b, a, e]
[d, c, b, e, a]
[d, c, e, b, a]
[d, e, c, b, a]
[e, d, c, b, a]
[e, c, d, b, a]
[c, e, d, b, a]
[c, d, e, b, a]
[c, d, b, e, a]
[c, d, b, a, e]
[c, b, d, a, e]
[c, b, d, e, a]
[c, b, e, d, a]
[c, e, b, d, a]
[e, c, b, d, a]
[e, c, b, a, d]
[c, e, b, a, d]
[c, b, e, a, d]
[c, b, a, e, d]
[c, b, a, d, e]
[b, c, a, d, e]
[b, c, a, e, d]
[b, c, e, a, d]
[b, e, c, a, d]
[e, b, c, a, d]
[e, b, c, d, a]
[b, e, c, d, a]
[b, c, e, d, a]
[b, c, d, e, a]
[b, c, d, a, e]
[b, d, c, a, e]
[b, d, c, e, a]
[b, d, e, c, a]
[b, e, d, c, a]
[e, b, d, c, a]
[e, d, b, c, a]
[d, e, b, c, a]
[d, b, e, c, a]
[d, b, c, e, a]
[d, b, c, a, e]
[d, b, a, c, e]
[d, b, a, e, c]
[d, b, e, a, c]
[d, e, b, a, c]
[e, d, b, a, c]
[e, b, d, a, c]
[b, e, d, a, c]
[b, d, e, a, c]
[b, d, a, e, c]
[b, d, a, c, e]
[b, a, d, c, e]
[b, a, d, e, c]
[b, a, e, d, c]
[b, e, a, d, c]
[e, b, a, d, c]
[e, b, a, c, d]
[b, e, a, c, d]
[b, a, e, c, d]
[b, a, c, e, d]
[b, a, c, d, e]
...
```

## Large indices

Arrangement numbers often grow very quickly. Due to large numbers in index and length, they cannot be represented using a 64 bit `int`, `BigInt` was implemeneted instead.

For example, consider the number of 10-permutations of the letters of the alphabet:

```dart
final List<String> largeBagOfItems = <String>["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"];
final TinyList<String> perms = TinyList.permutation(largeBagOfItems, 10);
print(perms);
final List<String> permutationOfInterest = <String>["a", "l", "g", "o", "r", "i", "t", "h", "m", "s"];
final BigInt index = perms.indexOf(permutationOfInterest);
print('The index of $permutationOfInterest is $index.');
print('perms[$index]: ${perms[index]}');
```

```
Pseudo-list containing all 19275223968000 10-permutations of items from [a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, w, x, y, z].
The index of [a, l, g, o, r, i, t, h, m, s] is 6831894769563.
perms[6831894769563]: [a, l, g, o, r, i, t, h, m, s]
```

Wow! That's a lot of permutations! Don't iterate over them all! That's almost seven trillion!

Luckily we didn't need to perform that search using brute force! (Take that, Mathematica!)

```dart
final TinyList<String> comps = TinyList.compound(largeBagOfItems);
print('There are ${comps.length} compounds of these letters!');
final BigInt lastCompoundIndex = comps.length - BigInt.one;
print('The last compound is ${comps[lastCompoundIndex]}.');
```

```
There are 1096259850353149530222034277 compounds of these letters!
The last compound is [b, a, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, w, x, y, z].
```

## Methods

### Properties

#### `.r`

Return the number of items taken from `items` in `int?`.

#### `.length`

Return the number of arrangements 'contained' in this pseudo-list in `BigInt`.

### Utilities

#### `[]`

Return `List<T>` at index given.

#### `.contains()`

Return `bool` on whether the structure contains `arrangement`.

#### `.indexOf()`

Return index of `arrangement` in `BigInt`.

#### `.sublist()`

Return `List<List<T>>` based on `start` (and `end`) given.

```dart
final BigInt start = BigInt.zero;
final BigInt? end = BigInt.two;
final List<List<T>> newList = list.sublist(start, end);
```

#### `.getRange()`

Return `Iterable<List<T>>` based on `start` and `end` given.

```dart
final BigInt start = BigInt.zero;
final BigInt end = BigInt.two;
final Iterable<List<T>> newList = list.getRange(start, end);
```

## Extensions

`tinylist2` provides extensions that allow us to generate combinatoric arrangements directly from lists...

### `List<T>`

```dart
final TinyList<int> subs = <int>[1, 2, 3, 4, 5].subset();
for (final sub in subs.getRange(BigInt.zero, subs.length)) {
  print('$sub (${subs.indexOf(sub)})');
}
```

```
[]
[1]
[2]
[1, 2]
[3]
[1, 3]
[2, 3]
[1, 2, 3]
[4]
[1, 4]
[2, 4]
[1, 2, 4]
[3, 4]
[1, 3, 4]
[2, 3, 4]
[1, 2, 3, 4]
[5]
[1, 5]
[2, 5]
[1, 2, 5]
[3, 5]
[1, 3, 5]
[2, 3, 5]
[1, 2, 3, 5]
[4, 5]
[1, 4, 5]
[2, 4, 5]
[1, 2, 4, 5]
[3, 4, 5]
[1, 3, 4, 5]
[2, 3, 4, 5]
[1, 2, 3, 4, 5]
```
