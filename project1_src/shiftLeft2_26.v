module shiftLeft2_26
(
    clk_i,
    data_i, 
    data_o
);

// Interface
input		    clk_i;
input   [25:0]      data_i;
output reg  [27:0]      data_o;


always@ (posedge clk_i) 
begin
	  data_o = data_i<<2;  
end
endmodule
