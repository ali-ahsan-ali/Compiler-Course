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
  null: Bool;  

  init(i : String) : Stack {
    {
      top <- i;
      self;
    }
  };

  add_top(item: String): Object {
    if (null = true) then 
      {
        null <- false; 
        top <- item;
        next <- (new Stack);
        if (isvoid next) then
          new Object
        else 
          next.set_null(true)
        fi; 
      }
    else 
      if (isvoid next) then 
          {
            next <- (new Stack).init(top);
            top <- item;
          }
      else 
        if (next.get_null() = true) then 
          {
            next.set_top(top);
            next.set_null(false);
            top <- item;
          }
        else
          {
            next.add_top(top);
            top <- item;
          }
        fi
      fi
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
            null <- true;
          }
        else
          if (next.get_null() = true) then
            {
              top <- (new String);
              next <- (new Stack);
              null <- true;
            }
          else 
            {
              top <- next.get_top();
              next <- next.get_next();
            }
          fi
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

  get_null(): Bool {
    null
  };

  set_null(truth: Bool): Bool {
    null <- truth
  };


  display(): Stack {
    if (null = true) then 
      out_string("")
    else 
      if (isvoid next) then 
        display_top()
      else
        display_all()  
      fi
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
      if (isvoid stack) then 
        new Object
      else 
        if (stack.get_null() = true) then 
          new Object
        else
          case stack.pop() of 
          s: String => evaluate(s); 
          o: Object => { abort(); "";};
          esac
        fi
      fi
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
        if (isvoid stack) then 
          (new Object)
        else 
          stack.pop()
        fi
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
      out_string("")
    else 
      stack.display()
    fi
  };
};
