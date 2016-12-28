module MUX5(
	data1_i, 
	data2_i, 
	select_i,
	data_o
);

input	[4:0]		data1_i;
input	[4:0]		data2_i;
input				select_i;
output	[4:0]		data_o;

reg	[4:0]		data_o;

always@ (*) begin
	if(select_i) begin
		data_o = data2_i;
	end
	else begin
		data_o = data1_i;
	end
end

endmodule
