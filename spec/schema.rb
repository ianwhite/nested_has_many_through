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
      t.column "inflamatory", :boolean
    end

    create_table :categories, :force => true do |t|
    end

    create_table :comments, :force => true do |t|
      t.column "user_id", :integer
      t.column "post_id", :integer
    end
    
    create_table :assistants, :force => true do |t|
      t.column "author_id", :integer
      t.column "name", :string
    end
  end
end
