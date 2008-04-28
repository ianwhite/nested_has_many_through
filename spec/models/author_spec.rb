require File.expand_path(File.join(File.dirname(__FILE__), '../spec_helper'))
require File.expand_path(File.join(File.dirname(__FILE__), '../app'))

describe Author do
  describe "(newly created)" do
    before do
      @category = Category.create!
      @other_category = Category.create!
      @author = Author.create!
    end
  
    it "#posts should == []" do
      @author.posts.should == []
    end
   
    it "#categories should == []" do
      @author.categories.should == []
    end
  
    it "#similar_posts should == []" do
      @author.similar_posts.should == []
    end
  
    it "#similar_authors should == []" do
      @author.similar_authors.should == []
    end
  
    it "#commenters should == []" do
      @author.commenters.should == []
    end
  
    describe "who creates @post with @category" do
      before do
        @post = Post.create! :author => @author, :category => @category
        @author.reload
      end
  
      it "#posts should == [@post]" do
        @author.posts.should == [@post]
      end
    
      it "#categories should == [@category]" do
        @author.categories.should == [@category]
      end
    
      describe "and @other_author creates @other_post with @category" do
      
        before do
          @other_author = Author.create!
          @other_post = Post.create! :author => @other_author, :category => @category
        end
    
        it "#posts should == [@post]" do
          @author.posts.should == [@post]
        end

        it "#categories should == [@category]" do
          @author.categories.should == [@category]
        end

        it "#similar_posts.should == [@post, @other_post]" do
          @author.similar_posts.should == [@post, @other_post]
        end
      
        it "#similar_authors.should == [@author, @other_author]" do
          @author.similar_authors.should == [@author, @other_author]
        end
      end
    end
  end
end