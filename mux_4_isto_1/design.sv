
module mux41(i,s,y);
  
  input [3:0]i;
  input [1:0]s;
  output y;  
  
  assign y=i[s];
  
endmodule