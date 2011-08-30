# module ChessMoves
#   # Node in a graph
#   class Node
#     attr_accessor :parent, :children, :val
#     $nd_count = 0
#     def initialize(val=nil)
#       $nd_count += 1
#       @val = val
#       @children = []
#     end
# 
#     def <<(child)
#       unless @children.include?(child)
#         @children << child
#         child.parent = self
#       end
#     end
# 
#     def each(&block)
#       @children.each(&block)
#     end
# 
#     # gets path (aka "phone number")
#     def path
#       if @parent
#         @parent.path + @val.to_s
#       else
#         @val.to_s
#       end
#     end
#     
#     def phone
#       path.gsub(/[^\d]/, '')
#     end
#   end
# end