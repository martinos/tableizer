class ColInfo
  attr_reader :header 
  attr_accessor :width, :col_type

  def initialize(header, col_type = nil, width = 0)
    @header = header
    @col_type = col_type
    @width = width
  end
end

