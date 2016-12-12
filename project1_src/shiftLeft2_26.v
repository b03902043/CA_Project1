module shiftLeft2_26
(
    data_i, 
    data_o
);

// Interface
input   [25:0]      data_i;
output reg  [27:0]      data_o;


always@ (*) 
begin
	  data_o <= ({{2{data_i[25]}}, data_i} << 2);  
end
endmodule
