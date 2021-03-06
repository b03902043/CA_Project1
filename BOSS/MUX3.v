module MUX3 
(
   data1_i,
   data2_i,
   data3_i,
   select_i,
   data_o
);

input	[31:0]		data1_i;
input	[31:0]		data2_i;
input	[31:0]		data3_i;
input	[1:0]			select_i;
output 	[31:0]		data_o;

reg 	[31:0]		data_o;

always@(*) begin
    if(select_i[1]) begin
        data_o = data3_i;
    end
    else if(select_i[0]) begin
        data_o = data2_i;
    end
    else begin
		data_o = data1_i; 
    end
end

endmodule
