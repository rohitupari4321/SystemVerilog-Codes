class scoreboard;
  
  transaction trans;
  mailbox mon2scb;
  event next;
  
  bit [31:0]mem[32];
  bit [31:0]out;
  
  function new(mailbox mon2scb);
    this.mon2scb = mon2scb;
    trans = new();
  endfunction
  
  task main;
    forever begin
      #10;
      mon2scb.get(trans);
    trans.display("Scoreboard");
      
      if(trans.psel && trans.penable)
        begin
          if(trans.pwrite)
            begin
              mem[trans.paddr] = trans.pwdata;
              $display("[Scoreboard] data written into memory mem[%0d] : %0d ",trans.paddr,trans.pwdata);
            end
          
          else
            begin
              out = mem[trans.paddr];
              $display("[Scoreboard] data read from memory %0d : mem[%0d] ",out,trans.paddr);
              
              if(trans.prdata == out)
              begin
                $display("[Scoreboard] data match trans.prdata : %0d out : %0d",trans.prdata,out);
              end
              
              else begin
                $display("[Scoreboard] data mismatch trans.prdata : %0d out : %0d",trans.prdata,out);
              end
              
            end
        end
      ->next;
    end
    
  endtask
endclass