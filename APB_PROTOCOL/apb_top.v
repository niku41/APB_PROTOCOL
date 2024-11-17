`timescale 1ns/1ns
module apb_top (
input pclk ,prstn,trf_valid ,
input[1:0]trf_enc,
input [7:0]trf_addr,trf_wdata,
output [7:0]trf_rdata,
output trf_rdata_valid
                     );

wire [7:0]wire_paddr,wire_pwdata,wire_prdata;
wire wire_psel ,wire_pwrite,wire_peable,wire_pready;
apb_master master_inst(
.pclk(pclk),
.prstn(prstn),
.trf_valid(trf_valid),
.trf_enc(trf_enc),
.trf_addr(trf_addr),
.trf_wdata(trf_wdata),
.trf_rdata(trf_rdata),
.trf_rdata_valid(trf_rdata_valid),
.psel(wire_psel),
.paddr(wire_paddr),
.pwdata(wire_pwdata),
.prdata(wire_prdata),
.pwrite(wire_pwrite),
.penable(wire_penable),
.pready(wire_pready));

apb_slave slave_1_inst(
.pclk(pclk),
.prstn(prstn),
.penable(wire_penable),
.paddr(wire_paddr),
.pwdata(wire_pwdata),
.prdata(wire_prdata),
.pwrite(wire_pwrite),
.pready(wire_pready),
.psel(wire_psel));

endmodule