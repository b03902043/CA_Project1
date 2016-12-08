module ALU_Control(
    funct_i,
    ALUOp_i,
    ALUCtrl_o
);

input	[5:0]	funct_i;
input	[1:0]	ALUOp_i;
output	[2:0]	ALUCtrl_o;

reg	[2:0]	aluCtrl_temp;

assign	ALUCtrl_o = aluCtrl_temp;

always@ (*)	begin
	case(ALUOp_i)
		2'b00:	// 	R-type
			begin
				case(funct_i)
					6'b100000:	aluCtrl_temp = 3'b010;	// +
					6'b100010:	aluCtrl_temp = 3'b110;	// -
					6'b011000:	aluCtrl_temp = 3'b111;	// *
					6'b100100:	aluCtrl_temp = 3'b000;	// &
					6'b100101:	aluCtrl_temp = 3'b001;	// |
					default:	aluCtrl_temp = 3'b100;  // nop
				endcase
			end
		2'b01:	// Or
			aluCtrl_temp = 3'b001;
		2'b11:	// Subtract
			aluCtrl_temp = 3'b110;
		2'b10:	// Add
			aluCtrl_temp = 3'b010;
	endcase
end

endmodule
