require 'rubygems'
require 'active_support'
require 'active_support/test_case'

require 'active_record'
require File.join(File.dirname(__FILE__), '..', 'lib', 'scoped_associations')

require File.join(File.dirname(__FILE__), 'models')

TEST_DATABASE_FILE = File.join(File.dirname(__FILE__), 'test.sqlite3')

def setup_database
  File.unlink(TEST_DATABASE_FILE) if File.exist?(TEST_DATABASE_FILE)
  ActiveRecord::Base.establish_connection(
    "adapter" => "sqlite3", "timeout" => 5000, "database" => TEST_DATABASE_FILE
  )
  create_tables
  load_fixtures
end

def create_tables
  c = ActiveRecord::Base.connection
  
  c.create_table :parents, :force => true do |t|
    t.string :name
    t.boolean :alive, :default => false
    t.timestamps
  end

  c.create_table :children, :force => true do |t|
    t.string :name
    t.references :parent
    t.boolean :alive, :default => false
    t.timestamps
  end
  
  c.create_table :grand_children, :force => true do |t|
    t.string :name
    t.references :child
    t.boolean :alive, :default => false
    t.timestamps
  end
end

def load_fixtures
  a = Parent.create(:name => 'a', :alive => true)
  
  a_a = a.children.create(:name => 'aa', :alive => true)
  a_a_a = a_a.grand_children.create(:name => 'aaa', :alive => true)
  a_a_b = a_a.grand_children.create(:name => 'aab', :alive => false)
  
  a_b = a.children.create(:name => 'ab', :alive => false)
  a_b_a = a_b.grand_children.create(:name => 'aba', :alive => true)
  a_b_b = a_b.grand_children.create(:name => 'abb', :alive => false)
end

setup_database