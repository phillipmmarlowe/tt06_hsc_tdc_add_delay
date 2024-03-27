/*
   Filename: dand.v
    Version: 1.0
   Standard: Verilog
Description: Guaranteed to be an and chain independent of inputs
     Author: Phillip Marlowe (@phillipmmarlowe)
*/
`define AND_CELL sky130_fd_sc_hd__and2_1  
`timescale 1ns/1ps
module dand #(parameter WIDTH=32) ( 
	input 			    in_i,
	output [WIDTH-1:0]	ffout_o,
	output			    out_o
);

	wire [n-1:0] ffout_w;
	assign ffout_o = ffout_w;
	
	`AND_CELL DA ( 
                .X(ffout_w[0]), 
                .A(1'b1), 
                .B(in_i)
                `ifdef USE_POWER_PINS
                    , .VGND(VGND)
                    , .VPWR(VPWR)
                    , .VPB(VPB)
                    , .VNB(VNB)
                `endif  // USE_POWER_PINS
            );
	
	generate 
		genvar i;
		for(i=0; i<WIDTH; i=i+1) begin : dand_genblk
            	(* keep *)
			`AND_CELL DA ( 
                .X(ffout_w[i]), 
                .A(1'b1), 
                .B(ffout_w[i-1])
                `ifdef USE_POWER_PINS
                    , .VGND(VGND)
                    , .VPWR(VPWR)
                    , .VPB(VPB)
                    , .VNB(VNB)
                `endif  // USE_POWER_PINS
            );
        	end
   	endgenerate

endmodule
