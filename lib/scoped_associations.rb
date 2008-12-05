module ActiveRecord
  class UndefinedScopeReflectionError < ActiveRecordError
    def initialize(reflection, scope)
      super("Undefined Scope '#{scope}' for #{reflection.class_name}.")
    end 
  end
end

module ActiveRecord
  module Associations
    module ClassMethods
     
      mattr_accessor :valid_keys_for_has_many_association
      @@valid_keys_for_has_many_association = [
        :class_name, :table_name, :foreign_key, :primary_key,
        :dependent,
        :select, :conditions, :include, :order, :group, :having, :limit, :offset, :scope,
        :as, :through, :source, :source_type,
        :uniq,
        :finder_sql, :counter_sql,
        :before_add, :after_add, :before_remove, :after_remove,
        :extend, :readonly,
        :validate
      ]
    
    end
  end
end

require File.join(File.dirname(__FILE__), 'scoped_reflection')

ActiveRecord::Associations::HasManyAssociation.send(:include, ScopedReflection)
ActiveRecord::Associations::HasManyThroughAssociation.send(:include, ScopedReflection)
