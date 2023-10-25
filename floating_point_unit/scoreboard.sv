class scoreboard;

	mailbox mon2scb;
	
    event sco_nxt;
 
  bit [31:0] res;
  bit exp;
	
	function new(mailbox mon2scb);
	this.mon2scb = mon2scb;
	endfunction

	task main;
	transaction trans;	
	forever begin
	#10;
	mon2scb.get(trans);
       trans.display("scoreboard");
    
      if(trans.instruction[7:6]==2'b00)
        res = trans.instruction[15:0] + trans.instruction[31:16];
      else if(trans.instruction[7:6]==2'b01)
        res = trans.instruction[15:0] - trans.instruction[31:16];
      else if(trans.instruction[7:6]==2'b10)
        res = trans.instruction[15:0] * trans.instruction[31:16];
      else if(trans.instruction[7:6]==2'b11)
      begin
        if(trans.instruction[31:16]==0)
          begin
          res = 32'd0;
          exp = 1'b1;
          end
        else begin
          res = trans.instruction[15:0] / trans.instruction[31:16];
          exp = 1'b0;
        end
      end
      else
        begin
         res = 32'd0;
         exp = 1'b0;
        end
      
      if(res == trans.result && exp==trans.exp_flag)
      begin
        $display("Expected Result");
        $display("res : %0d, trans.result : %0d",res,trans.result);
        $display("exp : %0b trans.exception : %0b",exp,trans.exp_flag);
      end
      
      else
      begin
        $display("Unexpected Result");
        $display("res : %0d, trans.result : %0d",res,trans.result);
        $display("exp : %0b trans.exception : %0b",exp,trans.exp_flag);
      end
     
      $display("-----------------------------------");
    -> sco_nxt;
	end
	endtask
endclass

	
