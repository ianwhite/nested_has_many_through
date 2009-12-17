module NestedThrough
  module Associations
    # has_one, but where :source is through, or :through is through association
    class NestedHasOneThroughAssociation < ActiveRecord::Associations::HasOneThroughAssociation
    end
  end
end