module shiftLeft2_26
(
    data_i, 
    data_o
);

// Interface
input   [25:0]      data_i;
output  [25:0]      data_o;

assign  data_o = data_i>>2;  

endmodule
