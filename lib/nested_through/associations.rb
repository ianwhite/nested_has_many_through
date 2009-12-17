module NestedThrough
  # extension for ActiveRecord::Base which creates NestedThrough associations
  module Associations
    def has_many(association_id, options = {}, &extension)
      reflection = create_has_many_reflection(association_id, options, &extension)
      if reflection.nested_through? || reflection.source_through?
        configure_dependency_for_has_many(reflection)
        add_association_callbacks(reflection.name, reflection.options)
        collection_accessor_methods(reflection, NestedThrough::Associations::NestedHasManyThroughAssociation)
      else
        super
      end
    end
    
    def has_one(association_id, options = {})
      reflection = create_has_one_through_reflection(association_id, options)
      if reflection.nested_through? || reflection.source_through?
        association_accessor_methods(reflection, NestedThrough::Associations::NestedHasOneThroughAssociation)
      else
        super
      end
    end
  end
end