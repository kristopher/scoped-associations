module ActiveRecord # :nodoc:
  class UndefinedScopeReflectionError < ActiveRecordError # :nodoc:
    def initialize(reflection, scope)
      super("Undefined Scope '#{scope}' for #{reflection.class_name}.")
    end 
  end

  module Associations # :nodoc:
    module ClassMethods # :nodoc:
      @@valid_keys_for_has_many_association << :scope
    end
  end
end

require File.join(File.dirname(__FILE__), 'scope_reflection')

ActiveRecord::Associations::HasManyAssociation.send(:include, ActiveRecord::Associations::ScopeReflection)
ActiveRecord::Associations::HasManyThroughAssociation.send(:include, ActiveRecord::Associations::ScopeReflection)
