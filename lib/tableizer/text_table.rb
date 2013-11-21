module Tableizer
  class TextTable
    def to_s(cols_info, rows)
      text = ""
      text << cols_info.map{|a| "%#{a.width}s" % a.header.strip }.join("|") + "\n"
      text << rows.map do |row| 
        row.zip(cols_info).map{|(col, col_info)| "%#{col_info.width}s" % col.to_s.strip}.join("|")
      end.join( "\n" )
    end
  end
end
