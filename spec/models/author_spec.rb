require File.expand_path(File.join(File.dirname(__FILE__), '../spec_helper'))
require File.expand_path(File.join(File.dirname(__FILE__), '../app'))

describe Author do
  describe "newly created" do
    before { @author = Author.create }
  
    it ".posts should == []" do
      @author.posts.should == []
    end
     
    it ".categories should == []" do
      @author.categories.should == []
    end
    
    it ".recommended_posts should == []" do
      @author.recommended_posts.should == []
    end
    
    it ".recommended_authors should == []" do
      @author.recommended_authors.should == []
    end
    
    it ".commenters should == []" do
      @author.commenters.should == []
    end
  end
end