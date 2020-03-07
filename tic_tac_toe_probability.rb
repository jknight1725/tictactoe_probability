# frozen_string_literal: true

# a tic-tac-toe board, which comes with nine pieces that you and your opponent
# can place: five Xs and four Os.
# randomly place all nine pieces in the nine slots on the tic-tac-toe board
# (with one piece in each slot), what’s the probability that X wins?
# That is, what’s the probability that there will be at least one occurrence of
# three Xs in a row at the same time there are no occurrences of three Os in a row?
require 'set'
require 'colorize'

#this method attributed to "cyberfox" #https://gist.github.com/cyberfox/1574251
def permutations(sequence)
  return sequence if sequence.empty?

  ch = sequence.delete_at(0)
  underlying = Set.new([ch])
  sequence.each do |ch|
    new_set = Set.new
    underlying.each do |permutation|
      (0..permutation.length).each do |idx|
        new_set.add(permutation.dup.insert(idx, ch))
      end
    end
    underlying = new_set
  end
  underlying.each
end

def print_board(arr)
  tmp = arr.each_char.to_a
  tmp.map! { |c| c == 'x' ? c.green : c.red }
  until tmp.empty?
    puts tmp.first(3).join
    tmp.shift(3)
  end
  puts "\n"
end

def horizontal_win(board, p)
  (board[0] == p && board[1] == p && board[2] == p) ||
    (board[3] == p && board[4] == p && board[5] == p) ||
    (board[6] == p && board[7] == p && board[8] == p)
end

def vertical_win(board, p)
  (board[0] == p && board[3] == p && board[6] == p) ||
    (board[1] == p && board[4] == p && board[7] == p) ||
    (board[2] == p && board[5] == p && board[8] == p)
end

def diagonal_win(board, p)
  (board[0] == p && board[4] == p && board[8] == p) ||
    (board[2] == p && board[4] == p && board[6] == p)
end

def filter_wins(arr, p)
  tmp = arr.dup
  puts "Possibilities total = #{arr.size}"
  tmp.delete_if { |game| horizontal_win(game, p) }
  puts "After removing horizontal #{p} wins, total = #{tmp.size}"
  tmp.delete_if { |game| vertical_win(game, p) }
  puts "After removing vertical #{p} wins, total = #{tmp.size}"
  tmp.delete_if { |game| diagonal_win(game, p) }
  puts "After removing diagonal #{p} wins, total = #{tmp.size}"
  tmp
end

def filter_no_wins(arr, p)
  tmp = arr.dup
  tmp.delete_if do |game|
    !horizontal_win(game, p) &&
      !vertical_win(game, p) &&
      !diagonal_win(game, p)
  end
  puts "After removing non winning '#{p}' games, total = #{tmp.size}"
  tmp
end

def print_summary(arr, p)
  puts "#{arr.size} possible wins for #{p}"
  arr.each(&method(:print_board))
end

# show any possible way a piece can win, including arrangements in which the other piece wins
%w[vertical horizontal diagonal].each do |method|
  define_method "#{method}_wins" do |arr, p|
    tmp = arr.dup
    tmp.delete_if { |game| !send("#{method}_win", game.to_s, p.to_s) }
    puts "#{tmp.size}/#{arr.size} possible #{method} wins for #{p}"
    puts("---------------------------------")
    tmp.each(&method(:print_board))
    puts("---------------------------------")
  end
end

pieces = %w[x x x x x o o o o]
possible_games = permutations(pieces).to_a

# 62/126 .4921 
puts "x wins and o never wins"
removed_o_wins = filter_wins(possible_games, 'o')
removed_ties = filter_no_wins(removed_o_wins, 'x')
print_summary(removed_ties, 'x')

# 12/126 .0962
# puts "o wins and x never wins"
# removed_x_wins = filter_wins(possible_games, 'x')
# removed_ties = filter_no_wins(removed_x_wins, 'o')
# print_summary(removed_ties, 'o')

# 36/126 .2857
# puts "both x and o win"
# x = filter_no_wins(possible_games, 'o')
# y = filter_no_wins(x, 'x')
# puts("--------------------------------------")

# 16/126 .1270
# puts "no winners"
# x = filter_wins(possible_games, 'o')
# y = filter_wins(x, 'x')

# show a random game possibility
#print_board(possible_games.sample)
