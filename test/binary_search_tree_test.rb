require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/binary_search_tree'


class BinarySearchTreeTest < Minitest::Test


  def test_creates_a_node
    bst = BinarySearchTree.new
    bst.insert(4, "25th Hour")
    refute_equal nil, bst.root
  end

  def test_node_is_nil_when_bst_is_created
      bst = BinarySearchTree.new
      assert_equal nil, bst.root
  end

  def test_node_will_not_insert_invalid_score
    bst = BinarySearchTree.new
    assert_equal nil, bst.insert("A","25th Hour")
  end

  def test_insert_node_to_tree
    bst = BinarySearchTree.new
    bst.insert(50, "25th Hour")
    assert_equal 50, bst.root.score

    bst.insert(40, "I love phlipp Morris")
    assert_equal 40, bst.root.left_node.score

    bst.insert(60, "Goonies")
    assert_equal 60, bst.root.right_node.score

    bst.insert(45, "Kung Fury")
    assert_equal 45, bst.root.left_node.right_node.score

    bst.insert(90, "JACE")
    assert_equal 90, bst.root.right_node.right_node.score
  end

  def test_node_commits_to_specific_branch
    bst = BinarySearchTree.new
    bst.insert(40, "25th Hour")
    assert_equal 40, bst.root.score

    bst.insert(30, "I love phlipp Morris")
    assert_equal 30, bst.root.left_node.score

    bst.insert(50, "Goonies")
    assert_equal 50, bst.root.right_node.score

    bst.insert(45, "Kung Fury")
    assert_equal 45, bst.root.right_node.left_node.score

    bst.insert(90, "JACE")
    assert_equal 90, bst.root.right_node.right_node.score
  end

  def test_node_depth_when_inserting_to_tree
    bst = BinarySearchTree.new
    assert_equal 0, bst.insert(50, "25th Hour")

    assert_equal 1, bst.insert(40, "I love phlipp Morris")

    assert_equal 1, bst.insert(60, "Goonies")

    assert_equal 2, bst.insert(45, "Kung Fury")
  end

  def test_returns_depth_of_score #two test
    bst = BinarySearchTree.new
    bst.insert(25,"Boss Ni")
    bst.insert(5,"25th Hour")
    bst.insert(75,"JACE")
    bst.insert(80,"Kung Fury")

    assert_equal 2, bst.depth_of(80)
    assert_equal 1, bst.depth_of(75)
  end

  def test_returns_depth_of_valid_score_only

    bst = BinarySearchTree.new
    bst.insert(25,"Boss Ni")
    bst.insert(5,"25th Hour")
    bst.insert(75,"JACE")
    bst.insert(80,"Kung Fury")

    assert_equal nil, bst.depth_of(79)
  end

  def test_if_node_exist_in_tree

    bst = BinarySearchTree.new
    bst.insert(25,"Boss Ni")
    bst.insert(5,"25th Hour")
    bst.insert(75,"JACE")
    bst.insert(80,"Kung Fury")

    assert bst.include?(75)
    refute bst.include?(60)
  end

  def test_if_invalid_node_exist_in_tree

    bst = BinarySearchTree.new
    bst.insert(25,"Boss Ni")
    bst.insert(5,"25th Hour")
    bst.insert(75,"Mission Impossible")
    bst.insert(80,"Kung Fury")

    refute bst.include?(100)
    assert bst.include?(75)
  end

  def test_maximum_scoring_node_returned

    bst = BinarySearchTree.new
    bst.insert(30,"Boss Ni")
    bst.insert(25,"25th Hour")
    bst.insert(65,"Mission Impossible")
    bst.insert(67,"Kung Fury")

    assert "Kung Fury => 67", bst.max
  end

  def test_minimum_scoring_node_returned

    bst = BinarySearchTree.new
    bst.insert(50,"Boss Ni")
    bst.insert(25,"25th Hour")
    bst.insert(15,"Mission Impossible")
    bst.insert(30,"Kung Fury")
    bst.insert(67,"King Kong")

    assert "Mission Impossible => 67", bst.min
  end

def test_bst_will_sort_in_numeric_order_by_score
  bst = BinarySearchTree.new
  bst.insert(90,"Boss Ni")
  bst.insert(25,"25th Hour")
  bst.insert(37,"Mission Impossible")
  bst.insert(65,"Kung Fury")
  bst.insert(20,"Boss Ni")
  bst.insert(85,"25th Hour")
  bst.insert(97,"Mission Impossible")
  bst.insert(1,"Kung Fury")

  assert_equal [{"Kung Fury"=>1}, {"Boss Ni"=>20}, {"25th Hour"=>25}, {"Mission Impossible"=>37}, {"Kung Fury"=>65}, {"25th Hour"=>85}, {"Boss Ni"=>90}, {"Mission Impossible"=>97}], bst.sort
end

  def test_bst_will_load_file_and_skip_existing_entries

    bst = BinarySearchTree.new
    bst.insert(91,"Boss Ni")
    bst.insert(41,"25th Hour")
    assert_equal 10, bst.load('./lib/movie.txt')
  end

  def test_bst_will_sort_loaded_file

    bst = BinarySearchTree.new
    bst.load('./lib/movie.txt')
    assert_equal [{" I Love You Phillip Morris"=>10}, {" Hannibal Buress: Comedy Camisado part 2"=>14}, {" Experimenter"=>22}, {" Meet My Valentine Is Killing Me"=>23}, {" Trolls Part 2: The return of module 1"=>30}, {" Hannibal Buress: Comedy Camisado"=>34}, {" Love"=>41}, {" Experimenter With My Emotions"=>42}, {" French Dirty Dancing"=>54}, {" Meet My Valentine"=>63}, {" French Dirty"=>84}, {" Love For Code: Led to the end of my relationship"=>91}], bst.sort
  end

  def test_bst_can_find_depth_by_score
    bst = BinarySearchTree.new
    bst.insert(25,"Boss Ni")
    bst.insert(5,"25th Hour")
    bst.insert(75,"JACE")
    bst.insert(80,"Kung Fury")

    assert_equal 2, bst.depth_of(80)
    assert_equal 1, bst.depth_of(75)
  end

  def test_bst_can_find_depth_of_loaded_file
    bst = BinarySearchTree.new
    bst.load('./lib/movie.txt')
    assert_equal 2, bst.depth_of(22)
  end

  def test_bst_will_return_nil_for_invalid_health
    bst = BinarySearchTree.new
    bst.insert(90,"Boss Ni")
    bst.insert(25,"25th Hour")
    bst.insert(37,"Mission Impossible")
    bst.insert(65,"Kung Fury")
    bst.insert(20,"Boss Ni")
    bst.insert(85,"25th Hour")
    bst.insert(97,"Mission Impossible")
    bst.insert(1,"Kung Fury")

    assert_equal nil, bst.health(7)
  end

  def test_bst_counts_number_of_depths
    bst = BinarySearchTree.new
    bst.insert(90,"Boss Ni")
    bst.insert(25,"25th Hour")
    bst.insert(37,"Mission Impossible")
    bst.insert(65,"Kung Fury")
    bst.insert(20,"Boss Ni")
    bst.insert(85,"25th Hour")
    bst.insert(97,"Mission Impossible")
    bst.insert(1,"Kung Fury")

    assert_equal 2, bst.get_nodes_at_depth(2)
    assert_equal 2, bst.get_nodes_at_depth(3)
    assert_equal 2, bst.get_nodes_at_depth(1)
  end

  def test_bst_returns_number_of_children_for_right_node
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

    assert_equal 4, bst.count_children(bst.root.right_node)
  end

  def test_bst_returns_number_of_children_for_left_node
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

    assert_equal 5, bst.count_children(bst.root.left_node)
  end

  def test_bst_returns_number_of_children_for_left_node
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

    assert_equal 5, bst.count_children(bst.root.left_node)
  end

  def test_return_number_of_childern_for_specific_node
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

    assert_equal 4, bst.count_children(bst.find_score(90))
  end

  def test_health_of_nodes
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

    assert_equal [[25, 4, 40.0], [65, 2, 20.0], [97, 1, 10.0]], bst.health(2)
  end

  def test_invalid_health_levels
      bst = BinarySearchTree.new
      bst.insert(90,"Boss Ni")
      bst.insert(25,"25th Hour")
      bst.insert(37,"Mission Impossible")
      bst.insert(65,"Kung Fury")
      bst.insert(20,"Boss Ni")
      bst.insert(85,"25th Hour")
      bst.insert(97,"Mission Impossible")
      bst.insert(1,"Kung Fury")

      assert_equal nil, bst.health(1000)
  end

  def test_number_depth_at_particular_depth
    bst = BinarySearchTree.new
    bst.insert(90,"Boss Ni")
    bst.insert(25,"25th Hour")
    bst.insert(37,"Mission Impossible")
    bst.insert(65,"Kung Fury")
    bst.insert(20,"Boss Ni")
    bst.insert(85,"25th Hour")
    bst.insert(97,"Mission Impossible")
    bst.insert(1,"Kung Fury")

    assert_equal 2, bst.get_nodes_at_depth(2)
  end

  def test_total_number_of_nodes_in_tree
    bst = BinarySearchTree.new
    bst.insert(90,"Boss Ni")
    bst.insert(25,"25th Hour")
    bst.insert(37,"Mission Impossible")
    bst.insert(65,"Kung Fury")
    bst.insert(20,"Boss Ni")
    bst.insert(85,"25th Hour")
    bst.insert(97,"Mission Impossible")
    bst.insert(1,"Kung Fury")

    assert_equal 8, bst.count_children(bst.root)
  end

  def test_tree_has_leaves
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

    assert_equal 4, bst.leaves
  end

  def test_particular_node_has_leaves
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

    assert_equal 2, bst.leaves(bst.find_score(25))
  end

  def test_tree_has_hight
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

    assert_equal 4, bst.height
  end

  def test_tree_has_right_node
    bst = BinarySearchTree.new
    bst.insert(50,"Boss Ni")
    bst.insert(41,"25th Hour")
    bst.insert(90,"Boss Nice")

    assert_equal 90, bst.root.right_node.score
  end

  def test_tree_has_left_node
    bst = BinarySearchTree.new
    bst.insert(50,"Boss Ni")
    bst.insert(41,"25th Hour")
    bst.insert(90,"Boss Nice")

    assert_equal 41, bst.root.left_node.score
  end

  def test_tree_has_been_created
      bst = BinarySearchTree.new
      bst.insert(50,"Boss Ni")
      bst.insert(41,"25th Hour")
      bst.insert(90,"Boss Nice")

      assert_equal 50, bst.root.score
  end


end
