# bulls-and-cows :cow:
A ruby implementation of the bulls and cows game, 4-letter word version.

The user must enter a four letter word; the algorithm will try and guess that word,
using only the feedback from the Chooser. The Chooser must enter the number of
letters in correct places (bulls) and correct letters but in the wrong place (cows).

## Guessing strategy
1. Given a user-entered word, the algorithm will try to discard all letters not present
in it by testing it against a pre-built list of 'words':
  - ETAO
  - INSH
  - RDLC
  - UMWF
  - GYPB
  - VKJX
  - QZJX
2. This list contains all the letters in the english alphabet, ordered by its [frecuency
in the english language](https://en.wikipedia.org/wiki/Letter_frequency#Relative_frequencies_of_letters_in_the_English_language), from the most frequent at top and the least frequent at the end of the list, and no repeating letters (except for the last word)
3. The initial guesses _probably_ won't include the chosen word, but it will yield 4 words with one cow each, in the worst case.
4. With these 16 letters at most, the algorithm will check the permutations against the chooser,
using a scoring system to compare guesses.
  - Each bull in the word adds 5 points to the score, for a maximum of 20
  - Each cow in the word adds 1 point to the score, for a maximum of 4
5. The algorithm ends when it finds a guess with a score of 20, or runs out of guesses.
