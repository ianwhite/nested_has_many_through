module NestedThrough
  # mixin for ActiveRecord::Reflection::AssociationReflection & ActiveRecord::Reflection::ThroughReflection
  module Reflection
    def self.included(reflection_class)
      reflection_class.alias_method_chain :check_validity!, :nested_through
    end
    
    # NestedThrough allows through source reflections
    def check_validity_with_nested_through!
      check_validity_without_nested_through!
    rescue ActiveRecord::HasManyThroughSourceAssociationMacroError => e
      raise e unless source_through?
    end
    
    # is this association a nested_through association?
    def nested_through?
      through_reflection && through_reflection.through_reflection
    end
    
    # does this association have a through source?
    def source_through?
      source_reflection && source_reflection.through_reflection
    end
  end
end