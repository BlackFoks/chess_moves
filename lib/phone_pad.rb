module ChessMoves
  # A "map"
  class PhonePad
    def initialize
      @pad = {}
      # parse block
      yield.each_with_index do |row, j|
        row.each_with_index do |cell, i|
          @pad[[i,j]] = PadCell.new cell, :for => self 
        end
      end
    end

    # gets a cell
    def [](i, j)
      @pad[[i,j]]
    end

    # gets pos of a cell
    def pos_of(cell)
      @pad.key(cell)
    end

    # gets pos of a cell with specified value
    def pos_of_value(cell_value)
      pos_of(cells.select{ |c| c.value == cell_value }.first)
    end

    # gets all cells
    def cells
      @pad.values
    end
  end
end