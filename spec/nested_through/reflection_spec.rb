require File.expand_path(File.join(File.dirname(__FILE__), '../spec_helper'))
require File.expand_path(File.join(File.dirname(__FILE__), '../schema'))

module NTRSpec
  class Category < ActiveRecord::Base
    has_many :posts, :class_name => 'NTRSpec::Post'
    has_many :users, :through => :posts, :class_name => 'NTRSpec::User'
  end
  
  class User < ActiveRecord::Base
    has_many :posts, :class_name => 'NTRSpec::Post'
    has_many :categories, :through => :posts, :class_name => 'NTRSpec::Category'
    has_many :similar_posts, :through => :categories, :source => :posts, :class_name => 'NTRSpec::Post'
  end
  
  class Post < ActiveRecord::Base
    belongs_to :user, :class_name => 'NTRSpec::User'
    belongs_to :category, :class_name => 'NTRSpec::Category'
    has_many :similar_categories, :through => :user, :source => :categories, :class_name => 'NTRSpec::Category'
    has_many :similar_post_authors, :through => :similar_categories, :source => :users, :class_name => 'NTRSpec::User'
  end
end

describe "NestedThrough::Reflection" do
  shared_examples_for "valid reflection" do
    it "check_validity! should not raise error" do
      lambda { @reflection.check_validity! }.should_not raise_error
    end
  end
  
  describe "has_many" do
    describe "(non through)" do
      before { @reflection = NTRSpec::User.reflect_on_association(:posts) }
      it { @reflection.should_not be_nested_through }
      it { @reflection.should_not be_source_through }
      it_should_behave_like "valid reflection"
    end
  
    describe "(non nested through)" do
      before { @reflection = NTRSpec::User.reflect_on_association(:categories) }
      it { @reflection.should_not be_nested_through }
      it { @reflection.should_not be_source_through }
      it_should_behave_like "valid reflection"
    end
  
    describe "(nested through)" do
      before { @reflection = NTRSpec::User.reflect_on_association(:similar_posts) }
      it { @reflection.should be_nested_through }
      it { @reflection.should_not be_source_through }
      it_should_behave_like "valid reflection"
    end
  
    describe "(source through)" do
      before { @reflection = NTRSpec::Post.reflect_on_association(:similar_categories) }
      it { @reflection.should_not be_nested_through }
      it { @reflection.should be_source_through }
      it_should_behave_like "valid reflection"
    end
  
    describe "(source & nested through)" do
      before { @reflection = NTRSpec::Post.reflect_on_association(:similar_post_authors) }
      it { @reflection.should be_nested_through }
      it { @reflection.should be_source_through }
      it_should_behave_like "valid reflection"
    end
  end
end