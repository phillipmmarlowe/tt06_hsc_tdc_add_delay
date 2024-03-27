/*
   Filename: tdc_delay_line.sv
    Version: 1.0
   Standard: SystemVerilog 2012
Description: Create a delay line using vmacros
     Author: Tyler Sheaves (@tsheaves)
*/
`timescale 1ns/1ps
module delay_line #(
    parameter N=64,
    parameter DL_TYPE="RCA"
) ( 
	input 
        in,
	output [N-1:0]
        dl_out
);
	
    generate
	    case(DL_TYPE)
		    "RCA": begin : dl_genblk
                (* keep *) logic 
                    keep_co;
			    rca #(.WIDTH(N)) dl (
				    .a({N{1'b1}}),
				    .b({N{1'b0}}),
				    .ci(in),
				    .s(dl_out),
				    .co(keep_co)
			    );
            	end
	    case(DL_TYPE)
		   "DAND": begin dland_genblk
		(* keep *) logic
                    keep_co2;
                             dand #(.WIDTH(N)) dl2 (
			               .in_i(in),
                                       .ffout_o(dl_out)
			    );
                end
	    endcase
    endgenerate

endmodule
