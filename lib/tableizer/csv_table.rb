require 'csv'

module Tableizer
  class CsvTable
    def to_s(cols_info, rows)
      CSV.generate do |csv|
        csv << cols_info.map{|col_info| col_info.header}
        rows.each do |row|
          conv_row = row.map do |a| 
            a.class == Time ? a.strftime("%Y-%m-%d %H:%M:%S") : a
          end
          csv << conv_row
        end
      end
    end
  end
end
