require File.expand_path(File.join(File.dirname(__FILE__), '../spec_helper'))
require File.expand_path(File.join(File.dirname(__FILE__), '../app'))

# these specs use the Author model in spec/app

# for testing, we need to know what class the association proxy is
class ActiveRecord::Associations::AssociationProxy
  def nested_through?; false; end
  def nested_has_many_through?; false; end
  def nested_has_one_through?; false; end
end

class NestedThrough::Associations::NestedHasManyThroughAssociation
  def nested_through?; true; end
  def nested_has_many_through?; true; end
end

class NestedThrough::Associations::NestedHasOneThroughAssociation
  def nested_through?; true; end
  def nested_has_one_through?; true; end
end

describe NestedThrough::Associations do
  before do
    @category =Category.create!
    @author = Author.create!
    @post = Post.create! :category_id => @category.id, :author_id => @author.id
  end
  
  describe "has_many" do
    it "non-through should not be nested through" do
      @author.posts.nested_through?.should == false
    end
    
    it "normal through should not be nested through" do
      @author.categories.nested_through?.should == false
    end
    
    it "source through should be nested_has_many_through" do
      @author.commenters.nested_has_many_through?.should == true
    end
    
    it "nested through should be nested_has_many_through" do
      @author.similar_posts.nested_has_many_through?.should == true
    end
  end
  
  describe "has_one" do
    it "non-through should not be nested through" do
      @author.first_post.nested_through?.should == false
    end
    
    it "normal through should not be nested through" do
      @author.first_category.nested_through?.should == false
    end
    
    it "source through should be nested_has_many_through" do
      @author.first_commenter.nested_has_many_through?.should == true
    end
    
    it "nested through should be nested_has_many_through" do
      @author.first_similar_post.nested_has_one_through?.should == true
    end
  end
end