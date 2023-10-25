class scoreboard;
 
  transaction trans;
  mailbox mon2scb;

  event next;
  
  bit [23:0] CRC,c;
 
  function new(mailbox mon2scb);
   this.mon2scb = mon2scb;
  endfunction

task main;
 forever
  begin
    #10;   // do not give more delay here
    mon2scb.get(trans);
    trans.display("Scoreboard");
    
      begin
         c = CRC;
        
        CRC[0] = c[1] ^ c[4] ^ trans.data_in[0] ^ trans.data_in[3];
        CRC[1] = c[2] ^ trans.data_in[1];
        CRC[2] = c[3]^ c[1] ^ c[4] ^ trans.data_in[3] ^ trans.data_in[2] ^ trans.data_in[0];
        CRC[3] = c[4] ^ c[2] ^ trans.data_in[1] ^ trans.data_in[3];
        CRC[4] = c[0] ^ c[3] ^ trans.data_in[2];
        
      end
    
    if(CRC == trans.data_out)
      begin 
        $display("Result expected data_out : %0d crc_reg : %0d",trans.data_out,CRC);
        $display("-------------------------------------------");
      end
    
     else
       $display("Result unexpected data_out : %0d crc_reg : %0d",trans.data_out,CRC);
	    $display("-------------------------------------------");
    
    ->next;
    CRC = 0;
  end
endtask

endclass
