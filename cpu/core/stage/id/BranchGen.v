`timescale 1ns / 1ps

`include "bus.v"
`include "opcode.v"
`include "funct.v"

module BranchGen(
  input       [`ADDR_BUS]     addr,
  input       [`INST_BUS]     inst,
  input       [`INST_OP_BUS]  op,
  input       [`FUNCT_BUS]    funct,
  input       [`DATA_BUS]     reg_data_1,
  input       [`DATA_BUS]     reg_data_2,
  output  reg                 branch_flag,
  output  reg [`ADDR_BUS]     branch_addr,
  output  reg                 next_inst_delayslot_flag              
);

  wire[`ADDR_BUS] addr_plus_4 = addr + 4;
  wire[25:0] jump_addr = inst[25:0];
  wire[`DATA_BUS] sign_ext_imm_sll2 = {{14{inst[15]}}, inst[15:0], 2'b00};

  always @(*) begin
    case (op)
      `OP_JAL, `OP_J: begin     // ��չJ
        branch_flag <= 1;
        branch_addr <= {addr_plus_4[31:28], jump_addr, 2'b00};
        next_inst_delayslot_flag <= 1;
      end
      `OP_SPECIAL: begin
        if (funct == `FUNCT_JALR || funct == `FUNCT_JR) begin   // jrҲ����������ת
          branch_flag <= 1;
          branch_addr <= reg_data_1;
          next_inst_delayslot_flag <= 1;
        end
        else begin
          branch_flag <= 0;
          branch_addr <= 0;
          next_inst_delayslot_flag <= 0;
        end
      end
      `OP_BEQ: begin
        if (reg_data_1 == reg_data_2) begin         // ���������ת
          branch_flag <= 1;                         // ��ת�ź�
          branch_addr <= addr_plus_4 + sign_ext_imm_sll2;   // ��ת��ַ
        end
        else begin
          branch_flag <= 0;
          branch_addr <= 0;
        end
        next_inst_delayslot_flag <= 1;              // �ӳٲ�
      end
      `OP_BNE: begin
        if (reg_data_1 != reg_data_2) begin
          branch_flag <= 1;
          branch_addr <= addr_plus_4 + sign_ext_imm_sll2;
        end
        else begin
          branch_flag <= 0;
          branch_addr <= 0;
        end
        next_inst_delayslot_flag <= 1;
      end
      `OP_REGIMM: begin   // ��չ
        case(inst[20:16])   // ����ָ��16-20λ��һ���ж�ָ������
            `INST_BGEZ, `INST_BGEZAL:begin      // bgez,bgezal
                if (reg_data_1[31] == 0) begin  // rs>=0������λ����λΪ0
                  branch_flag <= 1;
                  branch_addr <= addr_plus_4 + sign_ext_imm_sll2;
                end
                else begin
                  branch_flag <= 0;
                  branch_addr <= 0;
                end
            end
            `INST_BLTZ, `INST_BLTZAL:begin   // bltz,bltzal
                if (reg_data_1[31] == 1) begin  // rs < 0������λ����λΪ1
                  branch_flag <= 1;
                  branch_addr <= addr_plus_4 + sign_ext_imm_sll2;
                end
                else begin
                  branch_flag <= 0;
                  branch_addr <= 0;
                end
            end
        endcase
       next_inst_delayslot_flag <= 1;
      end
      `OP_BGTZ: begin   // ��չbgtz
        if (reg_data_1[31] == 0 && reg_data_1[30:0] > 31'b0) begin  // rs>0������λ����λΪ0
          branch_flag <= 1;
          branch_addr <= addr_plus_4 + sign_ext_imm_sll2;
        end
        else begin
          branch_flag <= 0;
          branch_addr <= 0;
        end
        next_inst_delayslot_flag <= 1;
      end
      `OP_BLEZ: begin   // ��չblez
        if (!(reg_data_1[31] == 0 && reg_data_1[30:0] > 31'b0)) begin  // !(rs>0)
          branch_flag <= 1;
          branch_addr <= addr_plus_4 + sign_ext_imm_sll2;
        end
        else begin
          branch_flag <= 0;
          branch_addr <= 0;
        end
        next_inst_delayslot_flag <= 1;
      end
      default: begin
        branch_flag <= 0;
        branch_addr <= 0;
        next_inst_delayslot_flag <= 0;
      end
    endcase
  end

endmodule // BranchGen
