`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/02/2019 12:49:59 AM
// Design Name: 
// Module Name: cpu_dp_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module cpu_dp_tb();

        //Data lines
        reg   [15:0]data_mem_in;
        wire  [15:0]data_mem_out;
        reg   [15:0]instr_mem_in;
        
        //Address Lines
        wire  [15:0]data_mem_addr;
        wire  [15:0]instr_mem_addr;
        
        //Signals for the BIU
        reg give_instr_addr;
        reg get_instr_mem;
        reg give_data_addr;
        reg get_data_mem;
        reg give_data_mem;
        
        //Signals from Control System
        reg regfile_rd1_mux_sel;
        reg regfile_we0;
        reg [1:0]regfile_wd0_mux_sel;
        reg alu_a_mux_sel;
        reg alu_b_mux_sel;
        reg [1:0]pc_mux_sel;
        reg alu_opcode;
        reg ireg_wr;
        reg pc_wr;
        
        //Feedback to Control System
        wire not_eq;
        wire [2:0]opcode;
        
        //Basic Control Signals
        reg clk;
        reg rst;
        
        //Some instructions require bus reads/writes, and therefore, multiple ticks. Use this to keep track of that.
        reg [1:0]instr_state;
    
        cpu_dp DUT(
            .data_mem_in(data_mem_in),
            .data_mem_out(data_mem_out),
            .instr_mem_in(instr_mem_in),
            
            .data_mem_addr(data_mem_addr),
            .instr_mem_addr(instr_mem_addr),
            
            .regfile_rd1_mux_sel(regfile_rd1_mux_sel),
            .regfile_we0(regfile_we0),
            .regfile_wd0_mux_sel(regfile_wd0_mux_sel),
            .alu_a_mux_sel(alu_a_mux_sel),
            .alu_b_mux_sel(alu_b_mux_sel),
            .pc_mux_sel(pc_mux_sel),
            .alu_opcode(alu_opcode),
            .ireg_wr(ireg_wr),
            .pc_wr(pc_wr),
                       
            .not_eq(not_eq),
            .opcode(opcode),
            
            .clk(clk),
            .rst(rst)
        );
        
        //Perform a clock tick
        task tick;
            begin
                clk = 0;
                #5;
                clk = 1;
                #5;
            end
        endtask
        
        //Reset the CPU
        task reset;
            begin
                rst = 1;
                #5;
                rst = 0;
                #5;
            end
        endtask
        
        //Initialize the control signals to their idle state
        task init_ctrl_signals;
            begin
                //Initialize the BIU Signals
                give_instr_addr = 0;
                get_instr_mem = 0;
                give_data_addr = 0;
                get_data_mem = 0;
                give_data_mem = 0;
                //Initialize the Control System Signals
                regfile_rd1_mux_sel = 0;
                regfile_we0 = 0;
                regfile_wd0_mux_sel = 0;
                alu_a_mux_sel = 0;
                alu_b_mux_sel = 0;
                ireg_wr = 0;
                pc_wr = 0;
                pc_mux_sel = 0;
                alu_opcode = 0;
            end
        endtask
        
        task instr_fetch(input [15:0]instr);
            begin
                //Initialize the control signals
                init_ctrl_signals();
                
                //Ask the memory for some instruction data
                give_instr_addr = 1;
                tick();
                
                //Simulate the memory giving the CPU instruction data
                instr_mem_in = instr;
                ireg_wr = 1;
                //Write the instruction to the CPU instruction register
                tick();
                ireg_wr = 0;
                $display("Performed instruction fetch, got opcode %b", opcode);
            end
        endtask
        
        task instr_decode;
            begin
                $display("Current Instruction State: %d", instr_state);
                //Perform PC handling at the end of each of the instruction decoding states
                pc_wr = 0;
                
                //Decode ADD instruction
                if(opcode == 3'b000) begin
                    //Mux rc from instruction to rd1
                    regfile_rd1_mux_sel = 1'b1;
                    //Mux output of ALU back into the regfile
                    regfile_wd0_mux_sel = 2'b01;
                    //Mux rd1 output of regfile to ALU A
                    alu_a_mux_sel = 1'b1;
                    //Mux rd0 output of regfile to ALU B
                    alu_b_mux_sel = 1'b1;
                    //Set ALU to perform addition
                    alu_opcode = 1'b0;
                    //Enable write on the regfile
                    regfile_we0 = 1'b1;
                    //Mux output of incrementer to the program counter
                    pc_mux_sel = 2'b10;
                    //Enable write on the program counter
                    pc_wr = 1'b1;
                end
                
                //Decode ADDI instruction
                if(opcode == 3'b001) begin
                    //Mux output of ALU back into the regfile
                    regfile_wd0_mux_sel = 2'b01;
                    //Mux sign extended output from instruction to ALU B
                    alu_a_mux_sel = 1'b0;
                    //Mux rd1 output of regfile to ALU A
                    alu_b_mux_sel = 1'b1;
                    //Set ALU to perform addition
                    alu_opcode = 1'b0;
                    //Enable write on the regfile
                    regfile_we0 = 1'b1;
                    //Mux output of incrementer to the program counter
                    pc_mux_sel = 2'b10;
                    //Enable write on the program counter
                    pc_wr = 1'b1;
                end
                
                //Decode NAND instruction
                if(opcode == 3'b010) begin
                    //Mux rc from instruction to rd1
                    regfile_rd1_mux_sel = 1'b1;
                    //Mux output of ALU back into the regfile
                    regfile_wd0_mux_sel = 2'b01;
                    //Mux rd1 output of regfile to ALU A
                    alu_a_mux_sel = 1'b1;
                    //Mux rd0 output of regfile to ALU B
                    alu_b_mux_sel = 1'b1;
                    //Set ALU to perform NAND
                    alu_opcode = 1'b1;
                    //Enable write on the regfile
                    regfile_we0 = 1'b1;
                    //Mux output of incrementer to the program counter
                    pc_mux_sel = 2'b10;
                    //Enable write on the program counter
                    pc_wr = 1'b1;
                end
                
                //Decode LW instruction
                else if (opcode == 3'b101) begin
                    if(instr_state == 0) begin
                        //First, put address on the bus
                        //Mux sign-extended immediate to the ALU
                        alu_a_mux_sel = 0;
                        //Mux the data at rd0 to the ALU
                        alu_b_mux_sel = 1;
                        //Perform an addition in the ALU to get the offset data address
                        alu_opcode = 0;
                        //Ask the BIU to perform a read bus cycle on data memory
                        get_data_mem = 1;
                        //Increment the state
                        instr_state = 1;
                    end
                    
                    else if(instr_state == 1) begin
                        //Wait state, BIU is handling
                        instr_state = 2;
                    end
                    
                    else if(instr_state == 2) begin
                        //BIU is handling the bus right now
                        //Enable write to the regfile
                        regfile_we0 = 1;
                        //Mux the data from data memory to the register file
                        regfile_wd0_mux_sel = 2'b10;
                        instr_state = 3;
                    end
                    
                    else if(instr_state == 3) begin
                        //BIU is handling the bus right now
                        //Don't write to the regfile again
                        regfile_we0 = 0;
                        //Increase the program counter
                        pc_mux_sel = 2'b10;
                        pc_wr = 1;
                        instr_state = 0;
                    end
                end
                $display("Before tick...");
                //Perform a tick to do the instruction
                tick();
                $display("After tick...");
            end
        endtask
        
        initial begin
            //Init the instruction state
            instr_state = 0;
            //Init reset and clock
            init_ctrl_signals();
            reset();
            tick();
            
            //Put some data on the data bus
            data_mem_in = 16'h0008;
            
            //Fetch a load word instruction
            //Load the memory at location: (Contents of reg 0) + 0 to reg0
            instr_fetch({3'b101,3'b000,3'b000,7'b0000000});
            //Perform the store word, need 4 cycles
            instr_decode();
            instr_decode();
            instr_decode();
            instr_decode();
            
            //Put some data on the data bus
            data_mem_in = 16'h0001;
            
            //Fetch another load word instruction
            //Load the memory at location: (Contents of reg 0) + immediate value 1 to reg1
            instr_fetch({3'b101,3'b001,3'b000,7'b0000001});
            //Perform the store word, need 4 cycles
            instr_decode();
            instr_decode();
            instr_decode();
            instr_decode();
            
            //Fetch an add instruction
            //Add contents of reg0 and reg1, store in reg2
            instr_fetch({3'b000, 3'b010, 3'b000, 4'b0000, 3'b001});
            instr_decode();
            
            //Fetch an add immediate instruction
            //Add contents of reg2 and the immediate value -2, store in reg3
            instr_fetch({3'b001, 3'b011, 3'b010, 7'b1111110});
            instr_decode();
            
            //Fetch a NAND instruction
            //NAND contents of reg3 and reg2, store in reg4
            instr_fetch({3'b010, 3'b100, 3'b011, 4'b0000, 3'b010});
            instr_decode();
        end
endmodule
