module ALU(
    data1_i,
    data2_i,
    ALUCtrl_i,
    data_o
);

input	[31:0]	data1_i, data2_i;
input	[2:0]	ALUCtrl_i;
output	[31:0]	data_o;

reg		[31:0]	result_temp;

assign	data_o = result_temp;

always@	(*)	begin
	case(ALUCtrl_i)
		3'b000:		// AND
			result_temp = data1_i & data2_i;
		3'b001:		// OR
			result_temp = data1_i | data2_i;
		3'b010:		// ADD
			result_temp = data1_i + data2_i;
		3'b110:		// SUBTRACT
			result_temp = data1_i - data2_i;
		3'b111:		// mul
			result_temp = data1_i * data2_i;
		3'b100:	        // nop
			result_temp = 32'b0;
	endcase
end

endmodule
