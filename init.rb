#require 'nested_through'

require 'nested_through/reflection'
ActiveRecord::Reflection::AssociationReflection.send :include, NestedThrough::Reflection
ActiveRecord::Reflection::ThroughReflection.send :include, NestedThrough::Reflection

#
#ActiveRecord::Associations::HasManyThroughAssociation.send :include, NestedHasManyThrough::Association
