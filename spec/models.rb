class GrandChild < ActiveRecord::Base
  belongs_to :child

  named_scope :alive, :conditions => { :alive => true }
end

class Child < ActiveRecord::Base
  belongs_to :parent
  has_many :grand_children

  named_scope :alive, :conditions => { :alive => true }  
end

class Parent < ActiveRecord::Base
  # Standard
  has_many :children
  has_many :grand_children, :through => :children

  # Scope on direct assocation
  has_many :children_direct, :scope => 'alive', :class_name => 'Child'
  has_many :grand_children_direct, :through => :children_direct, :source => :grand_children

  # Scope on inderect assocation
  has_many :children_indirect, :class_name => 'Child'
  has_many :grand_children_indirect, :through => :children_indirect, :scope => 'alive', :source => :grand_children

  # Scope on direct and indirect assocation
  has_many :children_direct_and_indirect, :scope => 'alive', :class_name => 'Child'
  has_many :grand_children_direct_and_indirect, :through => :children_direct_and_indirect, :scope => 'alive', :source => :grand_children
end
