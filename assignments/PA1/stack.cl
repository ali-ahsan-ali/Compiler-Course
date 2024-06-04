(*
 *  CS164 Fall 94
 *
 *  Programming Assignment 1
 *    Implementation of a simple stack machine.
 *
 *  Skeleton file
 *)

class Stack inherits IO {
  top: String;
  next: Stack;
  
  init(i : String) : Stack {
    {
      top <- i;
      self;
    }
  };

  add_top(item: String): Object {
    if (isvoid next) then 
      {
        next <- (new Stack).init(top);
        top <- item;
      }
    else
      {
        next.add_top(top);
        top <- item;
      }
    fi
  };

  swap(): Object {
    let this_top: String <- top
    in 
    {
      top <- next.get_top();
      next.set_top(this_top);
    }
  };

  pop(): String {
    let popped: String <- top in
      {
        if (isvoid next) then 
          {
            top <- (new String);
            next <- (new Stack);
          }
        else 
          {
            top <- next.get_top();
            next <- next.get_next();
          }
        fi; 

        popped;
      }
  };

  get_top(): String {
    top
  };

  get_next(): Stack {
    next
  };

  set_top(item: String): Object {
    top <- item
  };

  set_next(stack: Stack): Object {
    next <- stack
  };


  display(): Stack {
    if (isvoid next) then 
      display_top()
    else
      display_all()  
    fi
  };

  display_top(): Stack {
    {
      out_string(top);
      out_string("\n");
    }
  };

   display_all(): Stack {
    {
      out_string(top);
      out_string("\n");
      next.display();
    }
  };

};


class Main inherits IO {
  input: String;
  stack: Stack;

  main() : Object {
    prompt()
  };

  prompt() : Object {
    {
      out_string(">");
      let input: String <- in_string() in {
        while (not (input = "x")) loop {
          act(input);
          out_string(">");
          input <- in_string();
        }
        pool;
        input;
      };
    }
  };

  act(input: Object) : Object {
      case input of 
      i: Int => append_or_initialise((new A2I).i2a(i));
      s: String => act_string(s); 
      o: Object => { abort(); "";};
      esac    
  };

  act_string(s: String) : Object {
    if (s = "e") then  
      case stack.pop() of 
      s: String => evaluate(s); 
      o: Object => { abort(); "";};
      esac 
    else
      if (s = "d") then 
        display()
      else
        append_or_initialise(s)
      fi
    fi
  };

  evaluate(item: String): Object {
    if (item = "+") then 
      let val_one: String <- stack.pop(),
          val_two: String <- stack.pop(),
          converter: A2I <- (new A2I),
          val_three:Int <- converter.a2i(val_one) + converter.a2i(val_two)
      in 
        append_or_initialise(converter.i2a(val_three))
    else 
      if (item = "s") then 
        stack.swap() 
      else 
        (new Stack)
      fi 
    fi  
  };

  append_or_initialise(input: String): Object {
    if (isvoid stack) then 
      stack <- (new Stack).init(input)
    else 
      stack.add_top(input)
    fi
  };

  display(): Object {
    if (isvoid stack) then
      out_string("\n")
    else 
      stack.display()
    fi
  };
};
