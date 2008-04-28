# Testing app setup

##################
# Database schema
##################

ActiveRecord::Migration.suppress_messages do
  ActiveRecord::Schema.define(:version => 0) do
    create_table :users, :force => true do |t|
      t.column "type", :string
    end
    
    create_table :posts, :force => true do |t|
      t.column "author_id", :integer
      t.column "category_id", :integer
    end

    create_table :categories, :force => true do |t|
    end

    create_table :comments, :force => true do |t|
      t.column "user_id", :integer
      t.column "post_id", :integer
    end
  end
end

#########
# Models
#
# Domain model is this:
#
#   - authors (type of user) can create posts in categories
#   - users can comment on posts
#   - authors have recommended_posts: posts in the same categories as ther posts
#   - authors have recommended_authors: authors of the recommended_posts
#   - authors have commenters: users who have commented on their posts
#
class User < ActiveRecord::Base
  has_many :comments
end

class Author < User
  has_many :posts
  has_many :categories, :through => :posts
  has_many :recommended_posts, :through => :categories, :source => :posts
  has_many :recommended_authors, :through => :recommended_posts, :source => :author
  has_many :commenters, :through => :posts
end

class Post < ActiveRecord::Base
  belongs_to :author
  belongs_to :category
  has_many :comments
  has_many :commenters, :through => :comments, :source => :user
end

class Category < ActiveRecord::Base
  has_many :posts
end

class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
end