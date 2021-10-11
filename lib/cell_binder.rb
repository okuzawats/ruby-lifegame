require_relative './cell'
require_relative './dimens'
require_relative './envs'

class CellBinder
  def initialize
    @width, @height = Dimens.new.size
    living_cells = Envs.new.initial_cells
    dead_cells = @width * @height - living_cells

    seeds = []
    seeds += Array.new(living_cells, true)
    seeds += Array.new(dead_cells, false)
    @cells = seeds
             .shuffle
             .map { |alive| Cell.new(alive) }
  end

  def bind_cells
    (0...@height).each do |i|
      (0...@width).each do |j|
        index = i * @width + j
        @cells[index].tap do |cell|
          cell.add_neighbor @cells[index - @width - 1] if i - 1 >= 0 && j - 1 >= 0
          cell.add_neighbor @cells[index - @width] if i - 1 >= 0
          cell.add_neighbor @cells[index - @width + 1] if i - 1 >= 0 && j + 1 < @width
          cell.add_neighbor @cells[index - 1] if j - 1 >= 0
          cell.add_neighbor @cells[index + 1] if j + 1 < @width
          cell.add_neighbor @cells[index + @width - 1] if i + 1 < @height && j - 1 >= 0
          cell.add_neighbor @cells[index + @width] if i + 1 < @height
          cell.add_neighbor @cells[index + @width + 1] if i + 1 < @height && j + 1 < @width
        end
      end
    end
    @cells
  end
end
