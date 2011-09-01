module ChessMoves
  # A "map"
  class PhonePad
    def initialize(opts=nil)
      @pad = {}
      @width = opts[:width]
      @height = opts[:height]
      # parse block
      if block_given?
        yield.each_with_index do |row, j|
          row.each_with_index do |value, i|
            @pad[[i,j]] = PadCell.new value, :for => self
          end
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

    def width
      @width ||= @pad.keys.map{ |k| k.x }.max + 1
    end

    def height
      @height ||= @pad.keys.map{ |k| k.y }.max + 1
    end
  end
end