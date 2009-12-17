module NestedThrough
  module Associations
    # has_many, but where :source is through, or :through is through association
    class NestedHasManyThroughAssociation < ActiveRecord::Associations::HasManyThroughAssociation
      include NestedThroughAssociation
    end
  end
end