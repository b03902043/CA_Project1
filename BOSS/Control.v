module Control
(
	data_i,
	data_o,
	branch,
	jump,
);

input	[31:0]		data_i; 
output	[7:0]		data_o;
output			branch;
output			jump;

reg	[7:0]		data_o;
reg			branch;
reg			jump;

always@(*) begin
	branch <= 0;
	jump <= 0;
	case(data_i[31:26])
		6'b000000:	data_o <= 8'b10000001;	//R-type
		6'b001101:	data_o <= 8'b10001010;	//ori
		6'b100011:	data_o <= 8'b11101100;	//lw
		6'b101011:	data_o <= 8'b00011100; 	//sw
		6'b000100:	begin	
			data_o <= 8'b00001100; 	//beq
			branch <= 1;
		end
		6'b000010:	begin	
			data_o <= 8'b00000000;	//jump
			jump = 1;
		end
	endcase
end

endmodule
