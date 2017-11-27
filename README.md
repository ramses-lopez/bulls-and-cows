# bulls-and-cows
A ruby implementation of the bulls and cows game. :cow:

The user must enter a four letter word; the algorithm will try and guess that word,
using only the feedback from the Chooser. The Chooser must enter the number of
letters in correct places (bulls) and correct letters but in the wrong place (cows).

## Modes
- manual: User must enter the number of bulls & cows after each guess.
  - features CheatGuard:tm:
- automatic: just enter the word, and the script will feed the algorithm with
the number of bull & cows.  

## Guessing strategies
1. Brute force: try each letter for every position; move to another letter only
when a new bull is found.
2. Alphabet: Check groups of four letters, to cover every letter in the alphabet.
Store bulls & cows, order by number of bulls & cows, then guess based on that.
3. Test Words: Similar to alphabet, but using real words; may yield better results
than alphabet.
