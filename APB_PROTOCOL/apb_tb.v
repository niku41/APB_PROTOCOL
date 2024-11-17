module apb_tb;
				reg pclk ,prstn,trf_valid ;
                reg[1:0]trf_enc;
                reg [7:0]trf_addr,trf_wdata;
                wire [7:0]trf_rdata;
                wire trf_rdata_valid;
				 apb_top DUT(
						 .trf_addr(trf_addr),
						 .trf_wdata(trf_wdata),
						 .prstn(prstn) ,
						 .pclk(pclk),
						 .trf_valid(trf_valid),
						 .trf_enc(trf_enc),// trf_enc:transfer_encod 2'b10 -read ,2'b01wr
						 .trf_rdata(trf_rdata),
						 .trf_rdata_valid(trf_rdata_valid)
						);
	always #5 pclk = ~pclk ;
	initial 
		begin 
      	$dumpfile ("APB_top_tb.vcd");
			$dumpvars (0);
		end
   initial 
		begin 
			pclk = 0 ;
			prstn = 0;
			trf_valid = 0 ;
			trf_wdata= 8'b00000001;
			trf_addr= 8'b0;
#10
			prstn = 1 ;
			trf_valid = 1 ;
			trf_enc = 2'b01 ;
			
#10
			trf_wdata= 8'b00000010 ;
			trf_addr = 8'b00000001;
#15
			trf_valid = 0;
#5
            trf_valid = 1;
            trf_enc = 2'b01;
#2
        	trf_wdata = 8'b00000011;
			trf_addr  = 8'b00000010;
#20
		   trf_wdata = 8'b00000100;
			trf_addr  = 8'b00000100;
#7 		
			trf_valid = 1'b1 ;
			trf_wdata = 8'b00000101;
			trf_addr =  8'b00000101;
#25
            trf_addr = 8'b00000000;
            trf_enc = 2'b10;
            #30
	 $finish ;
		end 
endmodule