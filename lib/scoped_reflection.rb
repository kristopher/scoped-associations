module ScopedReflection
  def initialize(owner, reflection)
    scope_reflection(reflection)
    super
  end

  def scope_reflection(reflection)
    if reflection.options && reflection.options[:scope]
      
      source_reflection_class = 
        if reflection.options[:through] && reflection.respond_to?(:source_reflection) 
          reflection.source_reflection.klass 
        else 
          reflection.klass
        end
      
      final_scope = [reflection.options[:scope]].flatten.inject(source_reflection_class) do |accumulated_scope, scope|
        if accumulated_scope.respond_to?(scope)
          accumulated_scope.send(scope)
        else
          raise ActiveRecord::UndefinedScopeReflectionError.new(self, scope)
        end
      end
      reflection.options.merge!((final_scope.send(:current_scoped_methods) || {})[:find] || {}) 
    end
  end
end