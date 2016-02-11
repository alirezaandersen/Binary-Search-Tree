require 'pry'
require 'csv'
require_relative 'node'

class BinarySearchTree

  attr_reader :root, :depth_hash
  attr_accessor :count, :leaf_count

  def initialize
    @root = nil
    @array_of_hashes = []
    @count = 0
    @depth_hash = Hash.new { |h,k| h[k] = [] }
    @leaf_count = 0
  end

  def load(path)
    count = 0
    data = CSV.foreach(path) do |row|
      score = row[0].dup.to_i
      title = row[1].dup
      unless include?(score)
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
    result = []
    @count = 0

    @depth_hash = hash_of_depths
    nodes = @depth_hash.fetch(depth,nil)
    return nil if nodes.nil?

    total_nodes = count_children(@root).to_f
    nodes.each{|node|
      @count = 0
      child_count = count_children(node)
      result << [node.score, child_count, child_count/total_nodes*100]
    }
    result
  end

  def get_nodes_at_depth(depth)
    @depth_hash = hash_of_depths
    get_depth =  @depth_hash.fetch(depth,nil?)
    get_depth.count
  end

  def hash_of_depths(current_node = @root)
    @depth_hash.clear if current_node == @root
    return if current_node.nil?
    hash_of_depths(current_node.left_node)
    @depth_hash[current_node.depth] << current_node
    hash_of_depths(current_node.right_node)
    @depth_hash
  end

  def height
    hash_of_depths.keys.max
  end

  def count_children(current_node = @root)
    return if current_node.nil?
    count_children(current_node.left_node)
    count_children(current_node.right_node)
    @count +=1
  end

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
    # p node.depth unless node.nil?
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

  def leaves(current_node = @root)
    return if current_node.nil?

    leaves(current_node.left_node)
    leaves(current_node.right_node)
    if current_node.left_node.nil? && current_node.right_node.nil?
      @leaf_count += 1
    end
    @leaf_count
  end

end

bst = BinarySearchTree.new
bst.insert(50,"Boss Ni")
bst.insert(41,"25th Hour")
bst.insert(90,"Boss Nice")
bst.insert(25,"101th Hour")
bst.insert(37,"Mission Impossible")
bst.insert(65,"Kung Fury")
bst.insert(20,"Boss Night_time")
bst.insert(85,"30th Hour")
bst.insert(97,"Mission Impossible")
bst.insert(1,"Kung Funky")
