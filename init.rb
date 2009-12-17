require 'nested_through'

ActiveRecord::Base.extend NestedThrough::Associations
ActiveRecord::Reflection::AssociationReflection.send :include, NestedThrough::Reflection
ActiveRecord::Reflection::ThroughReflection.send :include, NestedThrough::Reflection