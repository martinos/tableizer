$LOAD_PATH << (File.join(File.expand_path(File.dirname(__FILE__)),'..', 'lib'))

require_relative '../test_helper'

require 'tableizer/data_table'

module Tableizer
  class TestDataTable < MiniTest::Should::TestCase

    context "A enumerable" do
      should "return a DataTable" do
        assert_kind_of(Table, [ 1,2,3 ].table{|a| [[ "Col1", a ],["Col2", a + 1] ]})
      end
    end

    context "A valid DataTable" do
      setup do
        @table = [ 1,2,3 ].table{|elem| [ ["col1",elem * 2], ["col2", elem == 3 ? "60000" : (elem * 2 + 1).to_s] ] }
      end

      should "return the collected rows" do
        assert_equal( [[2,"3"],[4,"5"],[6,"60000"]], @table.rows )
      end

      should "return the headers" do
        assert_equal( ["col1","col2"], @table.cols_info.map{|col| col.header} )
      end

      should "detect the column types" do
        assert_equal( [Fixnum, String], @table.cols_info.map{|col| col.col_type} )
      end

      should "detect the columns width" do
        assert_equal([4,5], @table.cols_info.map{|col|  col.width}  )
      end
    end 

    context "A Valid table with containing nil value" do
      setup do
        @table = [1, 2, 3].table do |elem| 
          [ [ "col1", elem ], 
            [ "col2", elem == 2 ? nil : (elem + 1).to_s ] ]
        end
      end

      should "detect the column type" do
        assert_equal( [Fixnum, String], @table.cols_info.map{|col_info| col_info.col_type })
      end

      should "be convertable to csv" do
        expected = <<EOF
col1,col2
1,2
2,
3,4
EOF
        assert_equal( expected, @table.to_csv )
      end
    end

    context "A Valid table containing Time value should be convert to ISO 8601 string" do 
      setup  do
        @table = [Time.local(2009,12,1, 13,44,23)].table do |elem| 
          [ [ "col1", elem ]] 
        end
      end

      should "Convert time to UTC" do 
        expected = <<EOF
col1
2009-12-01 13:44:23
EOF
        assert_equal expected, @table.to_csv
      end
    end
  end
end
