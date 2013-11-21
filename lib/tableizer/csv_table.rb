require 'csv'

module Tableizer
  class CsvTable
    def to_s(cols_info, rows)
      CSV.generate do |csv|
        csv << cols_info.map{|col_info| col_info.header}
        rows.each do |row|
          csv << row.map { |col| convert(col) }
        end
      end
    end

    def convert(data)
      case data
      when Time
        data.strftime("%Y-%m-%d %H:%M:%S")
      else
        data
      end
    end
  end
end
