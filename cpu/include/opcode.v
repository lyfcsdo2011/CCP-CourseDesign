`ifndef TINYMIPS_OPCODE_V_
`define TINYMIPS_OPCODE_V_

// r-type (SPECIAL)
`define OP_SPECIAL    6'b000000

// j-type
`define OP_JAL        6'b000011
`define OP_J          6'b000010     // 扩展J

// branch
`define OP_BEQ        6'b000100
`define OP_BNE        6'b000101
`define OP_REGIMM     6'b000001     // bgez、bltz、bgezal、bltzal的op字段相同
`define OP_BGTZ       6'b000111     // 扩展bgtz
`define OP_BLEZ       6'b000110     // 扩展blez
// 根据指令16-20位进一步判断是哪个跳转指令
`define INST_BGEZ     5'b00001
`define INST_BLTZ     5'b00000
`define INST_BGEZAL   5'b10001
`define INST_BLTZAL   5'b10000

// arithmetic
`define OP_ADDIU      6'b001001
`define OP_SLTI       6'b001010     // 扩展SLTI
`define OP_SLTIU      6'b001011     // 扩展sltiu


// immediate
`define OP_LUI        6'b001111

// coprocessor
`define OP_CP0        6'b010000

// logic
`define OP_ORI        6'b001101
`define OP_ANDI       6'b001100
`define OP_XORI       6'b001110     // 扩展xori

// memory accessing
`define OP_LB         6'b100000
`define OP_LW         6'b100011
`define OP_LBU        6'b100100
`define OP_SB         6'b101000
`define OP_SW         6'b101011
`define OP_SH         6'b101001     // 扩展SH
`define OP_LH         6'b100001     // 扩展LH
`define OP_LHU        6'b100101     // 扩展LHU

`endif  // TINYMIPS_OPCODE_V_
