module decoder_2to4_1hot(
	input[1:0] in,
	output[3:0] out);

	assign out[0] = ~in[1] & ~in[0]; 
	assign out[1] = ~in[1] & in[0]; 
	assign out[2] = in[1] & ~in[0]; 
	assign out[3] = in[1] & in[0]; 
	
endmodule
