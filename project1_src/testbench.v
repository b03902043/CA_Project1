`define CYCLE_TIME 50            

module TestBench;

reg                Clk;
reg                Start, Reset;
integer            i, outfile, counter;
integer            stall, flush;

always #(`CYCLE_TIME/2) Clk = ~Clk;    

CPU CPU(
    .clk_i  (Clk),
    .rst_i  (Reset),
    .start_i(Start)
);
  
initial begin
    counter = 0;
    stall = 0;
    flush = 0;
    
    // initialize instruction memory
    for(i=0; i<256; i=i+1) begin
        CPU.Instruction_Memory.memory[i] = 32'b0;
    end
    
    // initialize data memory
    for(i=0; i<32; i=i+1) begin
        CPU.DataMemory.memory[i] = 32'b0;
    end    
        
    // initialize Register File
    for(i=0; i<32; i=i+1) begin
        CPU.Registers.register[i] = 32'b0;
    end

    CPU.Control.jump = 0;
    CPU.Control.branch = 0;
    CPU.HazardDetection.IFIDWrite_o = 0;
    CPU.HazardDetection.PCWrite_o = 0;
    
    // Load instructions into instruction memory
    $readmemb("instruction.txt", CPU.Instruction_Memory.memory);
    
    // Open output file
    outfile = $fopen("output.txt") | 1;
    
    // Set Input n into data memory at 0x00
    CPU.DataMemory.memory[0] = 32'h5;       // n = 5 for example

    $dumpfile("result.vcd");
    $dumpvars;
    
    Clk = 1;
    Reset = 0;
    Start = 0;
    
    #(`CYCLE_TIME/4) 
    Reset = 1;
    Start = 1;
        
    
end
  
always@(posedge Clk) begin
    if(counter == 30)    // stop after 30 cycles
        $stop;

    // put in your own signal to count stall and flush
    // if(CPU.HazardDetection.MUX8_o == 1 && CPU.Control.jump == 0 && CPU.Control.branch == 0)stall = stall + 1;
    // if(CPU.HazardDetection.IFIDWrite_o == 1)flush = flush + 1;  

    // print PC
    $fdisplay(outfile, "cycle = %d, Start = %d, Stall = %d, Flush = %d\nPC = %d", counter, Start, stall, flush, CPU.PC.pc_o);
    
    // print Registers
    $fdisplay(outfile, "Registers");
    $fdisplay(outfile, "R0(r0) = %d, R8 (t0) = %d, R16(s0) = %d, R24(t8) = %d", CPU.Registers.register[0], CPU.Registers.register[8] , CPU.Registers.register[16], CPU.Registers.register[24]);
    $fdisplay(outfile, "R1(at) = %d, R9 (t1) = %d, R17(s1) = %d, R25(t9) = %d", CPU.Registers.register[1], CPU.Registers.register[9] , CPU.Registers.register[17], CPU.Registers.register[25]);
    $fdisplay(outfile, "R2(v0) = %d, R10(t2) = %d, R18(s2) = %d, R26(k0) = %d", CPU.Registers.register[2], CPU.Registers.register[10], CPU.Registers.register[18], CPU.Registers.register[26]);
    $fdisplay(outfile, "R3(v1) = %d, R11(t3) = %d, R19(s3) = %d, R27(k1) = %d", CPU.Registers.register[3], CPU.Registers.register[11], CPU.Registers.register[19], CPU.Registers.register[27]);
    $fdisplay(outfile, "R4(a0) = %d, R12(t4) = %d, R20(s4) = %d, R28(gp) = %d", CPU.Registers.register[4], CPU.Registers.register[12], CPU.Registers.register[20], CPU.Registers.register[28]);
    $fdisplay(outfile, "R5(a1) = %d, R13(t5) = %d, R21(s5) = %d, R29(sp) = %d", CPU.Registers.register[5], CPU.Registers.register[13], CPU.Registers.register[21], CPU.Registers.register[29]);
    $fdisplay(outfile, "R6(a2) = %d, R14(t6) = %d, R22(s6) = %d, R30(s8) = %d", CPU.Registers.register[6], CPU.Registers.register[14], CPU.Registers.register[22], CPU.Registers.register[30]);
    $fdisplay(outfile, "R7(a3) = %d, R15(t7) = %d, R23(s7) = %d, R31(ra) = %d", CPU.Registers.register[7], CPU.Registers.register[15], CPU.Registers.register[23], CPU.Registers.register[31]);

    // print Data Memory
    $fdisplay(outfile, "Data Memory: 0x00 = %d", {CPU.DataMemory.memory[3] , CPU.DataMemory.memory[2] , CPU.DataMemory.memory[1] , CPU.DataMemory.memory[0] });
    $fdisplay(outfile, "Data Memory: 0x04 = %d", {CPU.DataMemory.memory[7] , CPU.DataMemory.memory[6] , CPU.DataMemory.memory[5] , CPU.DataMemory.memory[4] });
    $fdisplay(outfile, "Data Memory: 0x08 = %d", {CPU.DataMemory.memory[11], CPU.DataMemory.memory[10], CPU.DataMemory.memory[9] , CPU.DataMemory.memory[8] });
    $fdisplay(outfile, "Data Memory: 0x0c = %d", {CPU.DataMemory.memory[15], CPU.DataMemory.memory[14], CPU.DataMemory.memory[13], CPU.DataMemory.memory[12]});
    $fdisplay(outfile, "Data Memory: 0x10 = %d", {CPU.DataMemory.memory[19], CPU.DataMemory.memory[18], CPU.DataMemory.memory[17], CPU.DataMemory.memory[16]});
    $fdisplay(outfile, "Data Memory: 0x14 = %d", {CPU.DataMemory.memory[23], CPU.DataMemory.memory[22], CPU.DataMemory.memory[21], CPU.DataMemory.memory[20]});
    $fdisplay(outfile, "Data Memory: 0x18 = %d", {CPU.DataMemory.memory[27], CPU.DataMemory.memory[26], CPU.DataMemory.memory[25], CPU.DataMemory.memory[24]});
    $fdisplay(outfile, "Data Memory: 0x1c = %d", {CPU.DataMemory.memory[31], CPU.DataMemory.memory[30], CPU.DataMemory.memory[29], CPU.DataMemory.memory[28]});
	
    $fdisplay(outfile, "\n");
    
    counter = counter + 1;
    
      
end

  
endmodule
