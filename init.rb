require 'nested_has_many_through'

ActiveRecord::Associations::HasManyThroughAssociation.send :include, NestedHasManyThrough::Association
ActiveRecord::Reflection::ThroughReflection.send :include, NestedHasManyThrough::Reflection