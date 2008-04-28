require File.expand_path(File.join(File.dirname(__FILE__), '../spec_helper'))
require File.expand_path(File.join(File.dirname(__FILE__), '../app'))

describe 'Commenter use case (@a1 has @p1 in @c1, @p2 in @c2)' do
  before do
    @c1 = Category.create!
    @c2 = Category.create!
    @a1 = Author.create!
    @p1 = @a1.posts.create! :category => @c1
    @p2 = @a1.posts.create! :category => @c2
    @a1.reload
  end

  it "@a1.posts should == [@p1, @p2]" do
    @a1.posts.should == [@p1, @p2]
  end

  it "@a1.categories should == [@c1, @c2]" do
    @a1.categories.should == [@c1, @c2]
  end
  
  describe "@u1 comments on @p1, p2" do
    before do
      @u1 = User.create!
      @c1 = @p1.comments.create! :user => @u1
      @c2 = @p2.comments.create! :user => @u1
    end
    
    it "@u1.comments should == [@c1, @c2]" do
      @u1.comments.should == [@c1, @c2]
    end
    
    it "@a1.commenters.should == [@u1]" do
      @a1.commenters.should == [@u1]
    end
  end
end
