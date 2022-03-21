/*
Key notes:
	inputs are signed 8-bit numbers [-128,127]
	output is a 16-bit number [-32'768 to 32'767]
	op-codes are: 
		 00 = SUM A + B
		 01 = SUB A - B
		 10 = MUL A * B
		 11 = DEV A / B
*/

module calculator (
	input  logic clk,
	input  logic rst_n,
	input         logic [1:0]  function_in,
	input  signed logic [7:0]  dat_a_in,
	input  signed logic [7:0]  dat_b_in,
	output signed logic [15:0] out
);

reg        [1:0]	reg_function_in; 
reg signed [7:0]	reg_dat_a_in; 
reg signed [7:0]	reg_dat_b_in; 
reg signed [15:0]	reg_out; 

always @(posedge clk or negedge rst_n) begin
	if(~rst_n) begin
		out							<= 16'b0;
		reg_dat_a_in		<= 8'b0;
		reg_dat_b_in		<= 8'b0;
		reg_function_in <= 2'b0;
	end
	else begin
		out							<= reg_out;
		reg_dat_a_in		<= dat_a_in;
		reg_dat_b_in		<= dat_b_in;
		reg_function_in <= function_in;
	end
end

always@(*)
  case (reg_function_in)
      2'b00:	reg_out		<= reg_dat_a_in + reg_dat_b_in; 
      2'b01:	reg_out		<= reg_dat_a_in - reg_dat_b_in;
      2'b10:	reg_out		<= reg_dat_a_in * reg_dat_b_in;
      2'b11:	reg_out		<= reg_dat_a_in / reg_dat_b_in;
  endcase

endmodule
