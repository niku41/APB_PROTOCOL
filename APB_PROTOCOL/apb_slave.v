module apb_slave (  
		   input pclk ,prstn,
		   input pwrite ,penable ,psel,
		   input [7:0]paddr,
		   input [7:0]pwdata ,
		   output  [7:0]prdata,
		   output pready
					);
reg [7:0]mem[8:0];
assign  prdata = mem[paddr];
assign pready = 1'b1;

always @(posedge pclk )
	begin 
	  if (psel && penable && pwrite )
 	      begin 
             mem[paddr] = pwdata ;
          end     
   end 
   endmodule