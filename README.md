# 🐂🐂🐂 Bulls and Cows 🐄🐄🐄
A ruby implementation of the bulls and cows game, 4-letter word version.

## :cow: How to play
1. get the code
```shell
git clone git@github.com:ramses-lopez/bulls-and-cows.git
```
1. Make sure you have ruby 2.0+ installed. If not, there are [many ways to do it](https://www.ruby-lang.org/en/documentation/installation/)

1. execute the file
```shell
ruby bull.rb
```

## :cow: Play Modes
1. **Auto Guess mode**:
  The user must enter a four letter word; the algorithm will try and guess that word,
using only the feedback from the Chooser.  
The Chooser evaluates every guess by checking the number of letters in correct places (bulls) and correct letters but in the wrong place (cows).

  The guessing strategy used in the CLI is `replacement`; details of the implementation
are described below.

1. **Manual mode**:
  This mode allows the user to try to guess a 4-letter word. After every guess from the
player, the computer will return the number of cows and bulls present in the current
guess.

The game ends when the player successfully guess the word chosen by the computer.

---

## :cow: Guessing strategies

### :cow: Replacement
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
3. When checking the initial guesses, a letter from a guess with score zero is extracted for later use. It is a letter that is absolutely not included on the chosen word.
4. Each letter of each candidate word is replaced with the unused letter, one at a time. Each new word gets a score and a cow & bull count.
  - If the score lowers, then the replaced letter *is* part of the chosen word.
  - If the score remains unchanged, the letter is replaced.
5. As a result of the previous step, now we have a list of words, which contains the letters for the chosen word, with the unused letters removed.
6. The unused letter extracted in *step 3* is removed.
7. All the permutations of the remaining 4 letters are tested against the chosen word until four bulls are found.


### :cow: Brute force

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

---

## :cow: Tests

The code comes with a set of tests. Install `bundler` then run `bundle install` to
install the required dependences.

Then, you can run `rspec` to run all the tests present in the `spec` folder.
