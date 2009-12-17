module NestedThrough
  # extension for ActiveRecord::Base which created NestedThrough associations
  module Associations
    def has_many(association_id, options = {}, &extension)
      if through_association?(options[:through])
        reflection = create_has_many_reflection(association_id, options, &extension)
        configure_dependency_for_has_many(reflection)
        add_association_callbacks(reflection.name, reflection.options)
        collection_accessor_methods(reflection, NestedThrough::Associations::NestedHasManyThroughAssociation)
      else
        super
      end
    end
    
    def has_one(association_id, options = {})
      if through_association?(options[:through])
        reflection = create_has_one_through_reflection(association_id, options)
        association_accessor_methods(reflection, NestedThrough::Associations::NestedHasOneThroughAssociation)
      else
        super
      end
    end
    
  private
    def through_association?(assoc_name)
      reflection = reflect_on_association(assoc_name)
      reflection.respond_to?(:through_reflection) && reflection.through_reflection
    end
  end
end