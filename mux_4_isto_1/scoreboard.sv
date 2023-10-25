
class scoreboard;
  
  transaction trans;   
  mailbox mon2scb;    
  
  event next;
  
  function new(mailbox mon2scb);
    this.mon2scb = mon2scb;
  endfunction
  
  task main;
    
    forever
      begin
        mon2scb.get(trans);     
        trans.display("Scoreboard");
        
        if(trans.y==trans.i[trans.s])
          begin
          $display("Result is as Expected");
            $display("i:%0b s:%0d y:%0b",trans.i,trans.s,trans.y);
          end
        
        else
          begin
          $error("Wrong result");
            $display("i:%0b s:%0d y:%0b",trans.i,trans.s,trans.y);
          end
        
        ->next;
      end
  endtask
endclass