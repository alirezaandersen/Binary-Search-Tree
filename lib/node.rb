

class Node

  attr_accessor :data, :left_node, :right_node, :parent_node, :depth, :score, :title

    def initialize(params)
      @title = params[:title]
      @score = params[:score]
      # @parent_node = params[:parent]
      @left_node = params[:move_left]
      @right_node = params[:move_right]
      @depth = params[:depth]

    end

    def get_value
      Hash[@title,@score]
    end

end
