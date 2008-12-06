module ActiveRecord
  class UndefinedScopeReflectionError < ActiveRecordError
    def initialize(reflection, scope)
      super("Undefined Scope '#{scope}' for #{reflection.class_name}.")
    end 
  end

  module Associations
    module ClassMethods      
      @@valid_keys_for_has_many_association << :scope
    end
  end
end

require File.join(File.dirname(__FILE__), 'scoped_reflection')

ActiveRecord::Associations::HasManyAssociation.send(:include, ScopedReflection)
ActiveRecord::Associations::HasManyThroughAssociation.send(:include, ScopedReflection)
