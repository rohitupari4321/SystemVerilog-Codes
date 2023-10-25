class scoreboard;
  //int count;

 mailbox mon2scb;

  event sco_next;
  
  bit [23:0] CRC;
  bit inv;
  
  function new(mailbox mon2scb);
   this.mon2scb = mon2scb;
  endfunction

task main;
 transaction trans;
  
 forever
  begin
    #5;   // do not give more delay here
    mon2scb.get(trans);
    if(trans.enb)
      begin
        inv = CRC[23] ^ trans.data_in;
       CRC[23] = CRC[22] ^ inv;
         CRC[22] = CRC[21];
         CRC[21] = CRC[20];
         CRC[20] = CRC[19];
         CRC[19] = CRC[18];
         CRC[18] = CRC[17] ^ inv;
         CRC[17] = CRC[16] ^ inv;
         CRC[16] = CRC[15];
         CRC[15] = CRC[14];
         CRC[14] = CRC[13] ^ inv;
         CRC[13] = CRC[12];
         CRC[12] = CRC[11];
         CRC[11] = CRC[10] ^ inv;
         CRC[10] = CRC[9] ^ inv;
         CRC[9] = CRC[8];
         CRC[8] = CRC[7];
         CRC[7] = CRC[6] ^ inv;
         CRC[6] = CRC[5] ^ inv;
         CRC[5] = CRC[4] ^ inv;
         CRC[4] = CRC[3] ^ inv;
         CRC[3] = CRC[2] ^ inv;
         CRC[2] = CRC[1];
         CRC[1] = CRC[0] ^ inv;
         CRC[0] = inv;
        
      end
    
    trans.display("Scoreboard");
    
    if(CRC == trans.crc)
      begin 
        $display("Result expected trans.crc : %0x crc_reg : %0x",trans.crc,CRC);
        $display("-------------------------------------------");
      end
     else
       $display("Result unexpected trans.crc : %0x crc_reg : %0x",trans.crc,CRC);
	    $display("------------------------------------------");
    ->sco_next;
  end
endtask

endclass
