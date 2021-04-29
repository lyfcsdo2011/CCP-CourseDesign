`timescale 1ns / 1ps

`include "bus.v"
`include "opcode.v"
`include "funct.v"

module FunctGen(
  input       [`INST_OP_BUS]  op,
  input       [`FUNCT_BUS]    funct_in,
  output  reg [`FUNCT_BUS]    funct
);

  // generating FUNCT signal in order for the ALU to perform operations
  always @(*) begin
    case (op)
      `OP_SPECIAL: funct <= funct_in;
      `OP_ORI, `OP_LUI, `OP_JAL, `OP_REGIMM: funct <= `FUNCT_OR;
      `OP_LB, `OP_LBU, `OP_LW, `OP_LH, `OP_LHU,
      `OP_SB, `OP_SW, `OP_SH, `OP_ADDIU: funct <= `FUNCT_ADDU;
      `OP_ANDI: funct <= `FUNCT_AND;
      `OP_XORI: funct <= `FUNCT_XOR;
      `OP_SLTI: funct <= `FUNCT_SLT;
      `OP_SLTIU: funct <= `FUNCT_SLTU;
      default: funct <= `FUNCT_NOP;
    endcase
  end

endmodule // FunctGen
