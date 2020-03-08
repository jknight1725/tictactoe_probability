# tictactoe_probability
Prints colorized visualization of all answers to challenge from https://fivethirtyeight.com/features/how-good-are-you-at-guess-who/

Explanation:
There are 9 choose 5 = 126 ways to place the x's and o's on the board. 
To find the amount of 'x' wins without any 'o' wins we must filter possibilities which do not result in a win for x
and any results that result in a win for o.

It's possible to solve this on paper using combinatorics and set theory. I plan on tidy-ing my paper solution then adding it to this repo.
This program calculates every possible game and then applies filters to get to a desired result.
It can print every desired solution in a colored format

The last bit of code utilizes metaprogramming to show any possible way a piece can win,
including arrangements in which the other piece wins
It defines methods to find vertical/horizontal/diagonal wins for 'x' or 'o'
e.g. 
diagonal_wins possible_games, 'o' 
Would display the number of ways 'o' can win diagonally
