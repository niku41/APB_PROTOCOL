module apb_master ( 
    input [7:0] trf_addr,
    input [7:0] trf_wdata, prdata,
    input prstn, pclk, trf_valid, pready,
    input [1:0] trf_enc, // trf_enc:tracsfer_encod 2'b10 -read ,2'b01wr
    output  penable,
    output reg [7:0] paddr,
    output reg pwrite,
    output reg [7:0] pwdata, 
	 output [7:0]trf_rdata,
    output  trf_rdata_valid,
    output  psel
);

parameter IDLE = 2'b01,
          SETUP = 2'b10,
          ACCESS = 2'b11;
reg [1:0] cs, ns;
wire valid ;
assign valid = trf_valid &&(trf_enc==2'b01||trf_enc==2'b10);
always @(posedge pclk)
	begin
   	if (!prstn) 
   	    begin 
            cs <= IDLE;
		    paddr <= 8'b0;
            pwdata <= 8'b0;
            pwrite <= 1'b0;
         end    
	else 
        cs <= ns;
   end
always @(posedge pclk)
begin
    if((cs == IDLE || cs == ACCESS) && valid && pready )
           begin
               paddr <= trf_addr;
               pwdata <= trf_wdata;
               if(trf_enc == 2'b01  )               
                   pwrite <= 1'b1;
               else if(trf_enc == 2'b10 )    
                   pwrite <= 1'b0;
           end 
	end 
always @(*) 
begin
    case (cs)
        IDLE:  begin
                ns = IDLE;
                if(valid)
                    ns = SETUP;
              	end 
        SETUP:	begin
            		ns = ACCESS;
              	end
        ACCESS:begin
               	 if (pready && valid) 
               	    ns = SETUP;
			     else if (pready && !trf_valid) 
               	    ns = IDLE;
			     else 
               	    ns = ACCESS;
                end
    endcase
end
assign psel = (cs != IDLE);
assign penable =(cs == ACCESS);
assign trf_rdata_valid  =(penable && (cs== ACCESS) && ~pwrite );
assign trf_rdata = trf_rdata_valid ? prdata : 8'b0; 
endmodule