if RAILS_ENV == 'test'
  require 'test/unit/testcase'
  require 'test/unit/testsuite'

  require 'active_record/fixtures'

  require File.join(File.dirname(__FILE__), 'lib', 'join')
  require File.join(File.dirname(__FILE__), 'lib', 'nested_scenarios')
  require File.join(File.dirname(__FILE__), 'lib', 'builder')
  require File.join(File.dirname(__FILE__), 'lib', 'fixtures')
end