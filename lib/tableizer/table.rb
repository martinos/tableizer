require 'csv'

class DataTable
  attr_reader :rows, :cols_info

  def initialize(cols_info, rows)
    @rows = rows
    @cols_info = cols_info
  end

  def self.create(enum)
    rows = []
    cols_info = [] 
    gen = nil
    enum.each do |elem|
      ret = yield elem
      rows << ret.map{|col| col[1]}
      unless cols_info.empty? 
        ret.zip(cols_info).each do |(row, col_info)|
          # Detect the type of the current column
          if col_info.col_type == NilClass && row[1].class != NilClass
            col_info.col_type = row[1].class
          end
          # Detect the max width the current column
          col_info.width = [ col_info.width, row[1].to_s.strip.length ].max
        end
      else
        cols_info = ret.map do |(header, val)|  
          ColInfo.new( header.to_s, val.class, [ header.to_s.strip.length, val.to_s.strip.length ].max )
        end
      end
    end
    self.new(cols_info,rows)
  end

  def to_csv
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
  
  def to_text
    text = ""
    text << cols_info.map{|a| "%#{a.width}s" % a.header.strip }.join("|") + "\n"
    text << rows.map do |row| 
      row.zip(cols_info).map{|(col, col_info)| "%#{col_info.width}s" % col.to_s.strip}.join("|")
    end.join( "\n" )
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
  
  # def to_pdf
  #   pdf = Prawn::Document.new(:top_margin => 50, :page_layout => :landscape)

  #   data = rows.map do |row|
  #     row.zip(cols_info).map do |(col, col_info)| 
  #       col 
  #     end
  #   end
  #   data
  #   pdf.table(  data, :border_style => :grid,
  #               :headers => cols_info.map{|col_info| col_info.header},
  #               :font_size => 7,
  #               :vertical_padding => 1
  #                ) 
  #   pdf.render
  # end
end

