# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard :minitest do
  watch(%r{^lib/(.+)\.rb$})     { |m| file = "test/#{m[1]}_test.rb"; puts file; file }
  watch(%r{^test/.+_test\.rb$})
  watch('test/test_helper.rb')  { "test" }
end
