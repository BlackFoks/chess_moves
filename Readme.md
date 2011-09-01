Chess Moves
===========

It includes 2 things:

1.  A lib that provides an infrastructure to find valid phones for a phone pad and a chess
piece. Also the lib provides useful DSL in order to create rules and other stuff very
simple.
2.  An app that uses the lib and puts all found phones into console.

How to use the lib
------------------

The lib has a pretty DSL so all following examples will be use it.

In order to find phones you should do following things:

1. Define rules (how chess pieces go).
2. Define chess pieces (which rules they use, how they can transform into another pieces 
and so on).
3. Define a pad you want to use.
4. And define which buttons (or cell) you pieces can't use for.

All of this stages are very simple with DSL:

### Defining rules

Lets define some rules:

```ruby
rules do
  define :rook do |start, target|
    # rook can move on cells with the same 'x' or 'y'
    start.x == target.x || start.y == target.y
  end
  
  define :bishop do |start, target|
    # Array#% works like [(a1.x - a2.x).abs, (a1.y - a2.y).abs]
    i, j = start % target
    i == j
  end

  #...
end
```
You also can define a rule which can determine whether this step is first or don't:

    define :pawn do |start, target, is_first|
      i, j = start / target # it's just like Array#% but w/o #abs
      max_j = is_first && start.y >= 2 ? 2 : 1

      i == 0 && j >= 0 && j <= max_j
    end
    
Now you have a few rules so you can define some chess pieces:

    pieces do
      define :rook do
        moves_like :rook
      end
      
      #...
    end
    
As you can see we've defined a rook that moves like a rook (very unexpectedly, right? :).
That's why there is a simpler way to define pieces which move like themselves:

    # define single piece
    define :rook
    
    #define multiple pieces at once
    define :knight, :bishop, :king
    
Ok, that's good, but what `#moves_like` really does? It just links a piece with an appropriate 
rule so this piece can move on only those cells which satisfy the rule.

Moreover you can define a piece that moves like multiple pieces (or, in other words, use
multiple rules). That makes creating such pieces like queen very simple and fun (also it's
DRY):

    define :queen do
      moves_like :rook, :bishop, :king
    end
    
There is another thing with defining rules we did not discuss. It's transformations.
Let's look at code:

    define :pawn do
      moves_like :pawn
      transforms_to(:queen) { |pos| pos.y == 0 }
    end
    
First, note that now we should explicitly define how the chess piece moves.
Second, look how we use `#transforms_to`. We pass a name of a chess piece to it and use 
a block to define a condition for the transformation. In our case transformation will be 
happen when pawn stops at a cell from a first row.