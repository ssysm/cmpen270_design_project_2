module DE0_Nano(
	CLOCK_50,
	LED,
	KEY,
	SW,
);

input 		          		CLOCK_50;
output		     [7:0]		LED;
input 		     [1:0]		KEY;
input 		     [3:0]		SW;

wire [1:0] counter_to_decoder;
wire [3:0] decoder_output;
wire [1:0] state_output;

wire charge_state = !(decoder_output[0] | decoder_output[2]);
wire charge_enable = !(state_output[0] | state_output[1]);

reg [31:0] counter;
reg qnext = 0;

counter_2bit counter_inst(
	.clk(qnext),
	.rst(KEY[1]),
	.count(counter_to_decoder)
);
	
decoder_2to4_1hot decoder_inst(
	.in(counter_to_decoder),
	.out(decoder_output)
);


initial begin
	counter <= 32'b0;
	qnext = 0;
end

always @ (posedge CLOCK_50) 
	begin
	counter <= counter + 1'b1;
	
	if (counter > 50000000)
	begin
		qnext = !qnext;
		counter <= 32'b0;
	end
end

assign state_output[0] = decoder_output[1] ^ charge_state;
assign state_output[1] = decoder_output[3] ^ charge_state;

assign LED[0] = state_output[0];
assign LED[1] = state_output[1];
assign LED[2] = state_output[0];
assign LED[3] = state_output[1];
assign LED[4] = charge_enable;
assign LED[6] = counter_to_decoder[0];
assign LED[7] = counter_to_decoder[1];
	
endmodule
