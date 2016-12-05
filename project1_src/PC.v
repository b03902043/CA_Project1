module PC
(
    clk_i,
    start_i,
    PCWrite_i,
    pc_i,
    pc_o
);

// Ports
input               clk_i, PCWrite_i;
input               start_i;
input   [31:0]      pc_i;
output  [31:0]      pc_o;

// Wires & Registers
reg     [31:0]      pc_o;


always@(posedge clk_i) begin
    
    if(PCWrite_i == 0)  begin
        if(start_i)
            pc_o <= pc_i;
        else
            pc_o <= pc_o;
    end
    
end

endmodule