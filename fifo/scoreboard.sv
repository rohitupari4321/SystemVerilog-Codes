class scoreboard;
  
  transaction trans;
  mailbox mon2scb;
  
  event next;
  
  bit [7:0]mem[$];
  bit [7:0]temp;
  int err = 0;
  
  function new(mailbox mon2scb);
    this.mon2scb = mon2scb;
  endfunction
  
  task main;
    forever begin
      #10;
      mon2scb.get(trans);
      trans.display("Scoreboard");
      
      if(trans.wr==1'b1)
        begin
          if(trans.full==1'b0)
            begin
              mem.push_front(trans.din);
              $display("[Sco] - Data scored in queue : %0d",trans.din);
            end
          else
            begin
              $display("FIFO is full");
            end
        end
      
      if(trans.rd==1'b1)
        begin
          if(trans.empty==1'b0)
            begin
              temp = mem.pop_back();
              $display("[Sco] - Data read from queue : %0d",temp);
              
              if(trans.dout == temp)
                $display("[Scoreboard] - data match temp:%0d 		trans.dout:%0d",temp,trans.dout);
              else
                $display("[Scoreboard] - data mismatch temp:%0d trans.dout:%0d",temp,trans.dout);
            end
          else
            begin
              $display("FIFO is empty");
            end
        end
      
      ->next;
    end
    
  endtask
  
endclass