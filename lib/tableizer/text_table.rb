module Tableizer
  class TextTable
    def to_s(cols_info, rows)
      headers = cols_info.map(&:header)
      widths = col_widths(headers, rows)
      text = ""
      text << row_str(headers, widths) + "\n"
      text << rows.map do |cols| 
        row_str(cols, widths)
      end.join( "\n" )
    end

    def row_str(row, col_widths)
      row.each_with_index.map do |val, index|
        value_to_str(val, col_widths.fetch(index))
      end.join('|')
    end

    def value_to_str(value, width)
      "%#{width}s" % value.to_s.strip
    end

    def col_widths(headers, rows)
      rows = [headers] + rows
      widths = Array.new(headers.length, 0)
      rows.each do |row|
        row.each_with_index do |col, index|
          width = col.to_s.length || 0
          widths[index] = width if width > widths.fetch(index) 
        end
      end
      widths
    end
  end
end
