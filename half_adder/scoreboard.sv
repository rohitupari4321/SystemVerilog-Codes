
class scoreboard;
  
  transaction trans;   // handle of transaction class	
  mailbox mon2scb;     // mailbox declaration
  
  event next;
  
  function new(mailbox mon2scb);
    this.mon2scb = mon2scb;
  endfunction
  
  task main;
    
    forever
      begin
        mon2scb.get(trans);         // getting info from mailbox
        trans.display("Scoreboard");
        
        if(((trans.a ^ trans.b) == trans.sum) && ((trans.a & trans.b) == trans.carry))
          begin
          $display("Result is as Expected");
        $display("a:%0b b:%0b sum:%0b carry:%0b",trans.a,trans.b,trans.sum,trans.carry);
          end
        
        else
          begin
          $error("Wrong result");
          $display("a:%0b b:%0b sum:%0b carry:%0b",trans.a,trans.b,trans.sum,trans.carry);
          end
        
        ->next;
      end
  endtask
endclass