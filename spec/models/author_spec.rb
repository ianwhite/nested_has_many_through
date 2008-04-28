require File.expand_path(File.join(File.dirname(__FILE__), '../spec_helper'))
require File.expand_path(File.join(File.dirname(__FILE__), '../app'))

describe Author do
  describe "create" do
    before { @author = Author.create }
  
    it "should be cool" do
      @author.should be_instance_of(ActiveRecord::Base)
    end
  end
end