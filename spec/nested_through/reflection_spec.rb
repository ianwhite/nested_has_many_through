require File.expand_path(File.join(File.dirname(__FILE__), '../spec_helper'))
require File.expand_path(File.join(File.dirname(__FILE__), '../app'))

# these specs use the Author model in spec/app.rb

describe NestedThrough::Reflection do
  shared_examples_for "valid reflection" do
    it "check_validity! should not raise error" do
      lambda { @reflection.check_validity! }.should_not raise_error
    end
  end
  
  describe "has_many" do
    describe "(non through)" do
      before { @reflection = Author.reflect_on_association(:posts) }
      it { @reflection.should_not be_nested_through }
      it { @reflection.should_not be_source_through }
      it_should_behave_like "valid reflection"
    end
  
    describe "(non nested through)" do
      before { @reflection = Author.reflect_on_association(:categories) }
      it { @reflection.should_not be_nested_through }
      it { @reflection.should_not be_source_through }
      it_should_behave_like "valid reflection"
    end
  
    describe "(nested through)" do
      before { @reflection = Author.reflect_on_association(:similar_posts) }
      it { @reflection.should be_nested_through }
      it { @reflection.should_not be_source_through }
      it_should_behave_like "valid reflection"
    end
  
    describe "(source through)" do
      before { @reflection = Author.reflect_on_association(:commenters) }
      it { @reflection.should_not be_nested_through }
      it { @reflection.should be_source_through }
      it_should_behave_like "valid reflection"
    end
  
    describe "(source & nested through)" do
      before { @reflection = Author.reflect_on_association(:similar_commenters) }
      it { @reflection.should be_nested_through }
      it { @reflection.should be_source_through }
      it_should_behave_like "valid reflection"
    end
  end
  
  describe "has_one" do
    describe "(non through)" do
      before { @reflection = Author.reflect_on_association(:first_post) }
      it { @reflection.should_not be_nested_through }
      it { @reflection.should_not be_source_through }
      it_should_behave_like "valid reflection"
    end
  
    describe "(non nested through)" do
      before { @reflection = Author.reflect_on_association(:first_category) }
      it { @reflection.should_not be_nested_through }
      it { @reflection.should_not be_source_through }
      it_should_behave_like "valid reflection"
    end
  
    describe "(nested through)" do
      before { @reflection = Author.reflect_on_association(:first_similar_post) }
      it { @reflection.should be_nested_through }
      it { @reflection.should_not be_source_through }
      it_should_behave_like "valid reflection"
    end
  
    describe "(source through)" do
      before { @reflection = Author.reflect_on_association(:first_commenter) }
      it { @reflection.should_not be_nested_through }
      it { @reflection.should be_source_through }
      it_should_behave_like "valid reflection"
    end
  
    describe "(source & nested through)" do
      before { @reflection = Author.reflect_on_association(:first_similar_commenter) }
      it { @reflection.should be_nested_through }
      it { @reflection.should be_source_through }
      it_should_behave_like "valid reflection"
    end
  end
end