require 'nested_through'
require 'nested_through/reflection'
require 'nested_through/associations'
require 'nested_through/associations/nested_has_many_through_association'
require 'nested_through/associations/nested_has_one_through_association'

ActiveRecord::Base.extend NestedThrough::Associations
ActiveRecord::Reflection::AssociationReflection.send :include, NestedThrough::Reflection
ActiveRecord::Reflection::ThroughReflection.send :include, NestedThrough::Reflection