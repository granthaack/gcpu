`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/19/2019 02:24:10 AM
// Design Name: 
// Module Name: cpu_fsm
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


module cpu_fsm(

        //Data lines
        input [15:0]data_mem_in,
        output [15:0]data_mem_out,
        input [15:0]instr_mem_in,
        
        //Address Lines
        output [15:0]data_mem_addr,
        output [15:0]instr_mem_addr,
        
        //Signals for the BIU
        output reg give_instr_addr,
        output reg get_instr_mem,
        output reg give_data_addr,
        output reg get_data_mem,
        output reg give_data_mem,
        
        //Signals for data path
        output reg regfile_rd1_mux_sel,
        output reg regfile_we0,
        output reg [1:0]regfile_wd0_mux_sel,
        output reg alu_a_mux_sel,
        output reg alu_b_mux_sel,
        output reg pc_mux_sel,
        output beq_override,
        output reg [1:0]alu_opcode,
        output reg ireg_wr,
        output reg pc_wr,
        
        //Feedback from data path
        wire not_eq,
        wire [2:0]opcode,
        
        //Basic Control Signals
        input clk,
        input rst
    );
    
    reg [1:0]instr_state;
    reg fetch_instr;
    
    always @ (negedge clk, posedge rst) begin
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
            alu_opcode = 2'b00;
            //Enable write on the regfile
            regfile_we0 = 1'b1;
            //Mux output of incrementer to the program counter
            pc_mux_sel = 1'b1;
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
            alu_opcode = 2'b00;
            //Enable write on the regfile
            regfile_we0 = 1'b1;
            //Mux output of incrementer to the program counter
            pc_mux_sel = 1'b1;
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
            alu_opcode = 2'b01;
            //Enable write on the regfile
            regfile_we0 = 1'b1;
            //Mux output of incrementer to the program counter
            pc_mux_sel = 1'b1;
            //Enable write on the program counter
            pc_wr = 1'b1;
        end
        
        //Decode LUI instruction
        if(opcode == 3'b011) begin
            //Pass ALU input B through the ALU
            alu_opcode = 2'b11;
            //Mux output of the left shift into B on the ALU
            alu_b_mux_sel = 1'b0;
            //Mux the output of the ALU back into the regfile
            regfile_wd0_mux_sel = 2'b01;
            //Enable write on the regfile
            regfile_we0 = 1'b1;
            //Mux output of incrementer to the program counter
            pc_mux_sel = 1'b1;
            //Enable write on the program counter
            pc_wr = 1'b1;
        end
        
        //Decode LW instruction
        else if (opcode == 3'b100) begin
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
                 pc_mux_sel = 1'b1;
                 pc_wr = 1;
                 instr_state = 0;
                 //Tell BIU that the read bus cyle is done
                 get_data_mem = 0;
            end
        end
        
        //Perform SW instruction
        if(opcode == 3'b101) begin
            if(instr_state == 0) begin
                //Put address on the bus
                //Mux ra from instruction to rd1
                regfile_rd1_mux_sel = 1'b0;
                //Mux sign-extended immediate to the ALU
                alu_a_mux_sel = 0;
                //Mux the data at rd0 to the ALU
                alu_b_mux_sel = 1;
                //Perform an addition in the ALU to get the offset data address
                alu_opcode = 0;
                //Ask the BIU to perform a write bus cycle on data memory
                give_data_mem = 1;
                //Increment the state
                instr_state = 1;
            end
            
            else if(instr_state == 1) begin
                //Wait state, BIU is handling
                //Data is already on bus
                instr_state = 2;
            end
            
            else if(instr_state == 2) begin
                //BIU is handling the bus right now
                instr_state = 3;
            end
            
            else if(instr_state == 3) begin
                //BIU is handling the bus right now
                //Increase the program counter
                pc_mux_sel = 1'b1;
                pc_wr = 1;
                instr_state = 0;
                //Tell BIU that write cycle is done
                give_data_mem = 0;
            end
        end
        
        //Perform BEQ instruction
        if(opcode == 3'b110) begin
            //Mux RA into the regfile input
            regfile_rd1_mux_sel = 1'b0;
            //Mux rd1 output of regfile to ALU A
            alu_a_mux_sel = 1'b1;
            //Mux rd0 output of regfile to ALU B
            alu_b_mux_sel = 1'b1;
            //If the inputs to the ALU aren't equal, this will be overridden
            pc_mux_sel = 1'b1;
            //Enable write on the program counter
            pc_wr = 1'b1;
        end
        
        //Perform JALR instruction
        if(opcode == 3'b111) begin
            //Pass ALU input B through the ALU
            alu_opcode = 2'b11;
            //Mux output of the rd1 into B on the ALU
            alu_b_mux_sel = 1'b1;
            //Mux output of PC incrementer to register file
            regfile_wd0_mux_sel = 2'b00;
            //Mux output of ALU into the PC
            pc_mux_sel = 1'b0;
            //Enable writes on the regfile
            regfile_we0 = 1'b1;
            //Enable write on the PC
            pc_wr = 1'b1;
        end
    end
    
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
    
    //TODO: Write instruction fetch task and change the give/get regs cause they're terrible
    task instr_fetch(input [15:0]instr);
        begin
            //Initialize the control signals
            init_ctrl_signals();
            
            //Ask the memory for some instruction data
            give_instr_addr = 1;
            //tick();
            
            //Simulate the memory giving the CPU instruction data
            //instr_mem_in = instr;
            ireg_wr = 1;
            //Write the instruction to the CPU instruction register
            tick();
            ireg_wr = 0;
            $display("Performed instruction fetch, got opcode %b", opcode);
        end
    endtask
    
endmodule
