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
  end

  def test_if_node_keeps_positions_is_less_than_OG_node_move_left
    skip
  end

#if node_keeps_positions_is_more_than_OG_node_move_right

#

end
