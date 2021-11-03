module counter_2bit(
	input clk,
	input rst,
	output [1:0] count
);

	wire q0_to_t1clk;
	
	t_flipflop tff_inst0(
		.clk(!clk),
		.rst(rst),
		.t(1),
		.q(q0_to_t1clk)
	);
	
	t_flipflop tff_inst1(
		.clk(!q0_to_t1clk),
		.rst(rst),
		.t(1),
		.q(count[1])
	);
	
	assign count[0] = q0_to_t1clk;

endmodule
