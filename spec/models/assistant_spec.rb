require File.expand_path(File.join(File.dirname(__FILE__), '../spec_helper'))
require File.expand_path(File.join(File.dirname(__FILE__), '../app'))

describe Assistant do
  describe "belongs_to > has_many => through (#posts)" do
    before(:each) do
      # Create an extra dummy to make sure the index of assistent is not the same as that from the author
      Assistant.create!(:name => "Maran")

      @author = Author.create!
      @assistant = @author.assistants.create!(:name => "Jeroen")
      
      @p1, @p2, @p3 = (1..3).map { @author.posts.create! }
    end
    
    it "should return the correct author" do
      @assistant.author.should == @author
    end
    
    it "should belong to the correct author" do
      @author.assistants.should == [@assistant]
    end

    it "should return correct number of posts" do
      @assistant.posts.size.should == 3
    end

    it "should return the same posts as its author" do
      @assistant.posts.should == @author.posts
    end

    it "should return the posts in the same order " do
      @assistant.posts.should == [@p1, @p2, @p3]
    end
  end
  
  describe "belongs_to > has_many => :through > has_many => :through (#categories)" do
    
    before(:each) do
      # Create an extra dummy to make sure the index of assistent is not the same as that from the author
      Assistant.create!(:name => "Maran")
      @author = Author.create!
      @assistant = @author.assistants.create!(:name => "Jeroen")

      @category = Category.create!
      @other_post = Post.create!(:category_id => @category.id)
      @p1, @p2, @p3 = @posts = (1..3).map { @author.posts.create!(:category_id => @category.id) }
    end
    
    it "should return the correct number of categories" do
      @assistant.categories.count.should == 1
    end
    
    it "should return the correct categories" do
      @assistant.categories.should == [@category]
    end
    
    describe "> has_many => :through (#similar_posts)" do
      it "should return the correct number of posts" do
        @assistant.similar_posts.should == [@other_post] + @posts
      end
      
      describe "> has_many => :through (#similar_authors)" do
        before(:each) do
          # Some dummies
          4.times { Author.create! }
          
          @other_author = Author.create!
          @other_assistant = @other_author.assistants.create!(:name => "Jeffrey")
          @other_posts = (1..3).map { @other_author.posts.create(:category_id => @category.id) }
        end

        it "should return the correct number of authors" do
          @assistant.similar_authors.count == 2
        end

        it "should return the correct authors" do
          @assistant.similar_authors.should == [@author, @other_author]
        end
        
        describe "> has_many => :through (#posts_of_similar_authors)" do
          before(:each) do
            # Some spam
            12.times { Post.create! }
          end
          
          it "should return the correct number of posts" do
            @assistant.posts_of_similar_authors.count.should == 6
          end
          
          it "should return the correct posts" do
            @assistant.posts_of_similar_authors.should == @posts + @other_posts
          end
        end
        
      end
      
      
    end
    
    
  end

end