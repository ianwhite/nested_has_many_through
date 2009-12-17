module NestedThrough
  module Associations
    # has_one, but where :source is through, or :through is through association
    class NestedHasOneThroughAssociation < ActiveRecord::Associations::HasOneThroughAssociation
      include NestedThroughAssociation
    end
  end
end