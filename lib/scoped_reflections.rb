module ActiveRecord
  module Reflection # :nodoc:
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def create_reflection(macro, name, options, active_record)
        case macro
          when :has_many, :belongs_to, :has_one, :has_and_belongs_to_many
            klass = options[:through] ? ThroughReflection : AssociationReflection
            reflection = klass.new(macro, name, options, active_record)
          when :composed_of
            reflection = AggregateReflection.new(macro, name, options, active_record)
        end
        write_inheritable_hash :reflections, name => reflection
        reflection
      end

      def reflections
        (read_inheritable_attribute(:reflections) && read_inheritable_attribute(:reflections).symbolize_keys) || write_inheritable_attribute(:reflections, {})
      end

    end
  end
end

module ActiveRecord
  module Reflection
    class MacroReflection
      def initialize(macro, name, options, active_record)
        @macro, @name, @options, @active_record = macro, name, options, active_record
        if is_has_many? && @options && @options[:scope]
          final_scope = [options[:scope]].flatten.inject(source_reflection_class) do |accumulated_scope, scope|
            if accumulated_scope.respond_to?(scope)
              accumulated_scope.send(scope)
            else
              raise UndefinedScopeReflectionError.new(self, scope)
            end
          end
          @options.merge!((final_scope.send(:current_scoped_methods) || {})[:find] || {}) 
        end
      end
      
      def is_has_many?
        macro == :has_many
      end
      
      private 
      
        def source_reflection_class
          klass
        end
        
    end
  end
end

module ActiveRecord
  module Reflection
    class ThroughReflection < AssociationReflection #:nodoc:

      def source_reflection
        @source_reflection ||= through_reflection && source_reflection_names.collect { |name| through_reflection.klass.reflect_on_association(name) }.compact.first
      end

      def through_reflection
        @through_reflection ||= active_record.reflect_on_association(options[:through].to_sym)
      end

      private
        def source_reflection_class
          source_reflection && source_reflection.class_name.constantize || get_class_from_source_reflection_names || (raise HasManyThroughSourceAssociationNotFoundError.new(self))
        end
        
        def get_class_from_source_reflection_names
          source_reflection_names.collect do |name| 
            begin 
              name.to_s.camelize.constantize
            rescue
            end
          end.compact.first          
        end
    end
  end
end

