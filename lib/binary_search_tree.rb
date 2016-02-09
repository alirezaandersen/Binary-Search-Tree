require 'pry'
require_relative 'node'

class BinarySearchTree

  attr_reader :root

  def initialize
    @root = nil
  end

  def insert(score,movie_title)
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
        elsif (score < current_node.score)
          current_node = current_node.left_node
        elsif (score > current_node.score)
          current_node = current_node.right_node
        else
          return current_node.depth
        end
      end
    end
    depth
  end

  # def left_child_node(score, movie_title, depth = nil)
  #   # current_node = @root
  #   # (score < current_node.score) && (current_node.left_node == nil)
  #   # current_node.left_node =
  #   # Node.new(title: movie_title, score: score, depth: depth)
  #   # #  left_node < parent_node
  #   # #  place left_node under parent to the left
  # end

  # def right_child_node(score, movie_title, depth = nil)
  #   # current_node = @root
  #   # (score > current_node.score) && (current_node.right_node == nil)
  #   # current_node.right_node = Node.new(title: movie_title, score: score, depth: depth)
  #   # # right_node > parent_node
  #   # # place right_node under parent to the right
  #   # # p @root
  # end

  def find_score(score,current_node= @root)
    return current_node if current_node && current_node.score == score
    return if (current_node == nil)
    find_score(score,current_node.left_node)
    find_score(score,current_node.right_node)
  end

  def depth_of(score = nil)
    node = find_score(score,@root)
    p node.depth unless node.nil?
    score = node.depth unless node.nil?
  end

  def create_node_from_movie_title_score(score, movie_title)
    current_node = Node.new(parent: nil, title: movie_title, score: score, depth: depth)
  end

  def include?(score)
    find_score(score,@root).nil? ? false : true
  end


end
