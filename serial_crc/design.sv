// Code your design here
// polynomial D^24+D^23+D^18+D^17+D^14+D^10+D^7+D^6+D^5+D^4+D^3+D+1
//1100001100100010011111011  - 25 bit polynomial
module crc_transmitter(
input clk,
input rstn,
input enable,
input crc_in,
  output [23:0] crc_out
);

 // reg [23:0] crc_reg;
 reg [23:0]CRC;
  
  reg inv;

 //assign crc_out=crc_reg;
  assign crc_out=CRC;
  
always@(posedge clk) 
begin
if(rstn)
//begin
//crc_reg = 24'd0;
  CRC = 24'd0;
//end
else begin
  if(enable)
   begin
  /*
     crc_reg[0] <= crc_reg[23] ^ crc_in;
  
     crc_reg[1] <= crc_reg[0] ^ crc_reg[23] ^ crc_in;
                                   
     crc_reg[2] <= crc_reg[1];
                                   
     crc_reg[3] <= crc_reg[2] ^ crc_reg[23] ^ crc_in;
                                   
     crc_reg[4] <= crc_reg[3] ^ crc_reg[23] ^ crc_in;
                                   
     crc_reg[5] <= crc_reg[4] ^ crc_reg[23] ^ crc_in;
                                   
     crc_reg[6] <= crc_reg[5] ^ crc_reg[23] ^ crc_in;
                                   
     crc_reg[7] <= crc_reg[6] ^ crc_reg[23] ^ crc_in;
                                   
     crc_reg[9:8] <= crc_reg[8:7];
                                   
     crc_reg[10] <= crc_reg[9] ^ crc_reg[23] ^ crc_in;
                                   
     crc_reg[11] <= crc_reg[10] ^ crc_reg[23] ^ crc_in;
                                   
     crc_reg[13:12] <= crc_reg[12:11];
                                   
     crc_reg[14] <= crc_reg[13] ^ crc_reg[23] ^ crc_in;
                                   
     crc_reg[16:15] <= crc_reg[15:14];
                                   
     crc_reg[17] <= crc_reg[16] ^ crc_reg[23] ^ crc_in;
                                   
     crc_reg[18] <= crc_reg[17] ^ crc_reg[23] ^ crc_in;
                                   
     crc_reg[22:19] <= crc_reg[21:18];
                                   
     crc_reg[23] <= crc_reg[22] ^ crc_reg[23] ^ crc_in;
  */
  
     inv = CRC[23] ^ crc_in;
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
end   
end

endmodule