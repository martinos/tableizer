require 'csv'

module Tableizer
  class NullObject
    def method_missing(*args, &block)
      self
    end

    def nil?
      true
    end
  end

  class Table
    attr_reader :rows, :cols_info

    def initialize(cols_info, rows)
      @rows = rows
      @cols_info = cols_info
    end

    def self.create(elems)
      rows = []
      cols_info = [] 
      gen = nil
      
      elems = [NullObject] if elems.first.nil?
      elems.each do |elem|
        yielded = yield elem
        rows << yielded.map{|col| col[1]}
        unless cols_info.empty? 
          yielded.zip(cols_info).each do |(row, col_info)|
            # Detect the type of the current column
            if col_info.col_type == NilClass && row[1].class != NilClass
              col_info.col_type = row[1].class
            end
          end
        else
          cols_info = yielded.map do |(header, val)|  
            ColInfo.new( header.to_s, val.class, [ header.to_s.strip.length, val.to_s.strip.length ].max )
          end
        end
      end
      self.new(cols_info,rows)
    end

    def to(table_type)
      mapper = {:csv => CsvTable,
                :text => TextTable}
      mapper.fetch(table_type).new.to_s(cols_info, rows)
    end

    def to_html
      text = "<table border=\"1\">\n"
      text += "<thead>\n"
      text += "<tr>\n"
      text << cols_info.map{|a| "<th>#{a.header.strip}</th>" }.join("\n")
      text += "</tr>\n"
      text += "</thead>"
      text += "<tbody>"
      text << rows.map do |row| 
        "<tr>" + row.map{|col| "<td>#{col}</td>"}.join("\n") + "</tr>"
      end.join( "\n" )
      text += "</tbody>"
      text += "</table>"
    end

    def to_google_table
      GoogleVisualization.render( rows, cols_info.map{|col| [col.col_type, col.header]} )
    end
  end
end
