# Testing app setup

##################
# Database schema
##################

ActiveRecord::Migration.suppress_messages do
  ActiveRecord::Schema.define(:version => 0) do
    create_table :authors, :force => true do |t|
    end
    
    create_table :post, :force => true do |t|
      t.column "author_id", :integer
      t.column "category_id", :integer
    end

    create_table :category, :force => true do |t|
    end

    create_table :comment, :force => true do |t|
      t.column "author_id", :integer
      t.column "post_id", :integer
    end
  end
end

#########
# Models
#########

class Author < ActiveRecord::Base
  has_many :posts
  has_many :categories, :through => :posts
  has_many :recommended_posts, :through => :categories, :source => :posts
  has_many :recommended_authors, :through => :recommended_posts, :source => :author
  has_many :posts_of_recommended_authors, :through => :recommended_authors, :source => :posts

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