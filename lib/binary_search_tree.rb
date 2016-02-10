require 'pry'
require 'csv'
require_relative 'node'

class BinarySearchTree

  attr_reader :root

  def initialize
    @root = nil
    #@match = nil
    @array_of_hashes = []
  end

  def load(path)
    count = 0
    data = CSV.foreach(path) do |row|
      score = row[0].dup.to_i
      title = row[1].dup
      #binding.pry
      unless include?(score)
        # binding.pry
        insert(score,title)
        count += 1
      end
    end
    count
  end


  def insert(score,movie_title)
    return nil unless numeric?(score)
    current_node = @root
    depth = 0
    # binding.pry
    if @root.nil?
      @root = Node.new(title: movie_title, score: score, depth: depth)
    else
      while nil != current_node
        depth += 1
        if #left_child_node(score, movie_title)
          (score < current_node.score) && (current_node.left_node == nil)
          current_node.left_node =
          Node.new(title: movie_title, score: score, depth: depth)
        elsif #right_child_node(score, movie_title)
          (score > current_node.score) && (current_node.right_node == nil)
          current_node.right_node = Node.new(title: movie_title, score: score, depth: depth)
        else
          return current_node.depth if score == current_node.score
          current_node = (score < current_node.score) ? current_node.left_node : current_node.right_node
        end
      end
    end
    depth
  end

  def find_score(score,current_node=@root)
    return if current_node.nil?
    return (current_node.score == score) ? current_node : find_score(score,current_node.left_node) || find_score(score,current_node.right_node)
  end


  def health(depth)

  end
=begin
  def find_score2(score,current_node= @root)
    @match = nil if current_node == @root
    # binding.pry
    return if current_node.nil?
    if current_node.score == score
      @match = current_node
      return @match
    end
    find_score(score,current_node.left_node)
    find_score(score,current_node.right_node)
    @match
  end
=end


  def sort(current_node = @root)
    @array_of_hashes.clear if current_node == @root

    return if current_node.nil?
    sort(current_node.left_node)
    @array_of_hashes << current_node.get_value
    sort(current_node.right_node)
    @array_of_hashes
  end

  def max
    current_node = @root
    return nil if current_node.nil?
    while current_node.right_node != nil
      current_node = current_node.right_node
    end
    current_node.get_value
  end

  def min
    current_node = @root
    return nil if current_node.nil?
    while current_node.left_node != nil
      current_node = current_node.left_node
    end
    current_node.get_value
  end

  def depth_of(score = nil)
    node = find_score(score,@root)
    p node.depth unless node.nil?
    node.depth unless node.nil?
  end

  def include?(score)
    find_score(score,@root).nil? ? false : true
    # binding.pry
  end

  def numeric?(score)
    return true if score =~ /\A\d+\Z/
    true if Float(score) rescue false
  end


end

bst = BinarySearchTree.new
bst.insert(50,"Boss Ni")
bst.insert(41,"25th Hour")
bst.insert(90,"Boss Ni")
bst.insert(25,"25th Hour")
bst.insert(37,"Mission Impossible")
bst.insert(65,"Kung Fury")
bst.insert(20,"Boss Ni")
bst.insert(85,"25th Hour")
bst.insert(97,"Mission Impossible")
bst.insert(1,"Kung Fury")

bst.health(2)

bst.load('./lib/movie.txt')
bst.sort
