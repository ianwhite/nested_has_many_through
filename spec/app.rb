require File.dirname(__FILE__) + '/schema.rb'

#########
# Models
#
# Domain model is this:
#
#   - authors (type of user) can create posts in categories
#   - users can comment on posts
#   - authors have similar_posts: posts in the same categories as ther posts
#   - authors have similar_authors: authors of the recommended_posts
#   - authors have posts_of_similar_authors: all posts by similar authors (not just the similar posts,
#                                            similar_posts is be a subset of this collection)
#   - authors have commenters: users who have commented on their posts
#
# Following model is added to verify the has_many/belongs_to :through relationship still works (as it is currently broken)
#   - authors have many assistants: they can access the posts of their author

class Category < ActiveRecord::Base
  has_many :posts
end

class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
end

class Post < ActiveRecord::Base
  # testing with_scope
  def self.find_inflamatory(*args)
    with_scope :find => {:conditions => {:inflamatory => true}} do
      find(*args)
    end
  end

  # only test named_scope if it's defined
  named_scope(:inflamatory, :conditions => {:inflamatory => true}) if respond_to?(:named_scope)
  
  belongs_to :author
  belongs_to :category
  has_many :comments
  has_many :commenters, :through => :comments, :source => :user, :uniq => true
end

class User < ActiveRecord::Base
  has_many :comments
  
  # Cases made possible by this plugin
  with_options :uniq => true do |w|
    w.has_many :commented_posts, :through => :comments, :source => :post
    w.has_many :commented_authors, :through => :commented_posts, :source => :author
    w.has_many :posts_of_interest, :through => :commented_authors, :source => :posts_of_similar_authors
    w.has_many :categories_of_interest, :through => :posts_of_interest, :source => :category
  end
end

class Author < User
  # Normal cases
  has_many :posts
  has_many :categories, :through => :posts
  has_many :assistants
  
  has_one :first_post, :class_name => 'Post'
  has_one :first_category, :through => :first_post, :source => :category
  
  # Cases made possible by this plugin
  with_options :uniq => true do |w|
    w.has_many :commenters, :through => :posts
    w.has_many :similar_posts, :through => :categories, :source => :posts
    w.has_many :similar_authors, :through => :similar_posts, :source => :author
    w.has_many :posts_of_similar_authors, :through => :similar_authors, :source => :posts
    w.has_many :similar_commenters, :through => :similar_posts, :source => :commenters
  end

  has_one :first_commenter, :through => :posts, :source => :commenters
  has_one :first_similar_post, :through => :first_category, :source => :posts
  has_one :first_similar_commenter, :through => :first_similar_post, :source => :commenters  
end

class Assistant < ActiveRecord::Base
  # Normal cases
  belongs_to :author
  has_many :posts, :through => :author
  
  # Cases made possible by this plugin
  with_options :uniq => true do |w|
    w.has_many :categories, :through => :posts
    w.has_many :similar_posts, :through => :categories, :source => :posts
    w.has_many :similar_authors, :through => :similar_posts, :source => :author
    w.has_many :posts_of_similar_authors, :through => :similar_authors, :source => :posts
  end
end