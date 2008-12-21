require File.join(File.dirname(__FILE__), 'spec_helper')

describe "ScopedAssociation" do
  before(:each) do
    @parent = Parent.first
  end
  
  describe "standard assocations" do
    describe "has_many :through" do
      it "should return all grand children" do
        @parent.grand_children.collect(&:name).should == ['aaa', 'aab', 'aba', 'abb']
      end
    end

    describe "has_many" do
      it "should return all children" do
        @parent.children.collect(&:name).should == ['aa', 'ab']
      end
    end
  end


  describe "scope on direct assocation" do
    describe "has_many :through" do
      it "should should return all grand children with a live parent" do
        @parent.grand_children_direct.collect(&:name).should == ['aaa', 'aab']
      end
    end

    describe "has_many" do
      it "should should return all live children" do
        @parent.children_direct.collect(&:name).should == ['aa']
      end
    end
  end


  describe "scope on indrect assocation" do
    describe "has_many :through" do
      it "should should return all live grand children" do
        @parent.grand_children_indirect.collect(&:name).should == ['aaa', 'aba']
      end
    end

    describe "has_many" do
      it "should return all children" do
        @parent.children_indirect.collect(&:name).should == ['aa', 'ab']
      end
    end
  end


  describe "scope on direct and indrect assocation" do
    describe "has_many :through" do
      it "should return all live grandchildren with a live parent" do
        @parent.grand_children_direct_and_indirect.collect(&:name).should == ['aaa']
      end
    end

    describe "has_many" do
      it "should return all live children" do
        @parent.children_direct_and_indirect.collect(&:name).should == ['aa']
      end
    end
  end

end
