require File.expand_path(File.join(File.dirname(__FILE__), '../spec_helper'))
require File.expand_path(File.join(File.dirname(__FILE__), '../schema'))

# for testing, we need to know what class the association proxy is
class ActiveRecord::Associations::AssociationProxy
  def nested_through?; false; end
  def nested_has_many_through?; false; end
  def nested_has_one_through?; false; end
end

class NestedThrough::Associations::NestedHasManyThroughAssociation
  def nested_through?; true; end
  def nested_has_many_through?; false; end
end

class NestedThrough::Associations::NestedHasOneThroughAssociation
  def nested_through?; true; end
  def nested_has_one_through?; true; end
end

module NTASpec
  class Category < ActiveRecord::Base
    has_many :posts, :class_name => 'NTASpec::Post'
    has_many :users, :through => :posts, :class_name => 'NTASpec::User'
    has_one :first_post, :class_name => 'NTASpec::Post'
    has_one :first_user, :through => :posts, :source => :user, :class_name => 'NTASpec::User'
  end
  
  class User < ActiveRecord::Base
  end
  
  class Post < ActiveRecord::Base
    belongs_to :user, :class_name => 'NTASpec::User', :foreign_key => :author_id
    belongs_to :category, :class_name => 'NTASpec::Category'
  end
end

describe NestedThrough::Associations do
  before do
    @category = NTASpec::Category.create!
    @user = NTASpec::User.create!
    @post = NTASpec::Post.create! :category_id => @category.id, :author_id => @user.id
  end
  
  describe "has_many" do
    it "non-through should not be nested through" do
      @category.posts.nested_through?.should == false
    end
    
    it "normal through should not be nested through" do
      @category.users.nested_through?.should == false
    end
  end
  
  describe "has_one" do
    it "non-through should not be nested through" do
      @category.first_post.nested_through?.should == false
    end
    
    it "normal through should not be nested through" do
      @category.first_user.nested_through?.should == false
    end
  end
end