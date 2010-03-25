#require "spec"
#
#describe Stack do
#
#  it "should have one or more pieces" do
#    stack1 = Stack.new(:black)
#    stack2 = Stack.new(:red, :white)
#
#    stack1.size.should == 1
#    stack2.size.should == 2
#
#    stack1.dvonn?.should == false
#    stack2.dvonn?.should == true
#
#  end
#
#  it "should allow stacks to be combined" do
#    stack1 = Stack.new(:black, white)
#    stack2 = Stack.new(:red)
#    stack1.takes(stack2)
#
#    stack1.dvonn?.should == true
#    stack
#  end
#end