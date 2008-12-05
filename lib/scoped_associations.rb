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

      def create_has_many_reflection(association_id, options, &extension)
        association_id, scopes = extract_scope_from_association_id(association_id)
        options[:scope] = [options[:scope], scopes].flatten.compact
        options.assert_valid_keys(valid_keys_for_has_many_association)
        options[:extend] = create_extension_modules(association_id, extension, options[:extend])

        create_reflection(:has_many, association_id, options, self)
      end

      def extract_scope_from_association_id(association_id)
        if association_id.to_s.include?('.')
          association_id, *scopes = association_id.to_s.split('.')
          [association_id, scopes]
        else
          association_id
        end
      end
    
    end
  end
end

# FIXME: better place? :)
require File.join(File.dirname(__FILE__), 'scoped_reflection')
ActiveRecord::Associations::HasManyAssociation.send(:include, ScopedReflection)
ActiveRecord::Associations::HasManyThroughAssociation.send(:include, ScopedReflection)
