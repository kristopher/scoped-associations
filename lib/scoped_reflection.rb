module ScopedReflection
  def initialize(owner, reflection)
    scope_reflection(reflection)
    super
  end

  def scope_reflection(reflection)

      source_reflection_class = 
        if reflection.is_a? ActiveRecord::Reflection::ThroughReflection 
          reflection.source_reflection.klass 
        else 
          reflection.klass
        end
      
      scope_names = [reflection.options[:scope]].flatten
      final_scope = scope_names.inject(source_reflection_class) do |accumulated_scope, scope|
        if accumulated_scope.respond_to?(scope)
          accumulated_scope.send(scope)
        else
          raise ActiveRecord::UndefinedScopeReflectionError.new(self, scope)
        end
      end

      current_scoped_methods = final_scope.send(:current_scoped_methods) || {}
      reflection.options.merge!(current_scoped_methods[:find] || {}) 
    end
  end
end
