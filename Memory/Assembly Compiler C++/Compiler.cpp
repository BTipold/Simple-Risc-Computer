/*
	Brian Tipold
		- .org works.
		- .word works.
		- Compile error will crash the program.
		- Might have bugs.
		- Comments allowed with #.

	Will take assembly instructions and turn it into a 32 bit
	binary string that can be interpreted by my VHDL RISC computer.
*/

#include "InstructionFormats.h"
#include "assembly.h"
#include "Utils.h"
#include "mem_info.h"

using namespace std;

int main(void) {
	ifstream input_file(IN_FILE_NAME);
	vector<mem_item> memory;
	unsigned int address = 0;
	unordered_map<string, unsigned int> memory_labels;

	// Parse the starting parameters.
	while (!input_file.eof()) {
		assem::cmd_list cmd_map;
		string line;
		vector<string> commands;
		
		string binary;

		// Get new line.
		getline(input_file, line);
		
		// Skip blank lines.
		if (utils::skip_blank(line))
			continue;
		
		// Parse the commands.
		commands = utils::parse_cmds(line);
		
		// Decode instruction.
		string opcode;
		switch (cmd_map.vals[commands[0]]) {
		case ld:
			opcode = "00000";
			binary = format::load_store(commands, opcode);
			break;

		case ldi:
			opcode = "00001";
			binary = format::load_store(commands, opcode);
			break;

		case st:
			opcode = "00010";
			binary = format::load_store(commands, opcode);
			break;

		case add:
			opcode = "00011";
			binary = format::three_reg(commands, opcode);
			break;

		case sub:
			opcode = "00100";
			binary = format::three_reg(commands, opcode);
			break;

		case _and:
			opcode = "00101";
			binary = format::three_reg(commands, opcode);
			break;

		case _or:
			opcode = "00110";
			binary = format::three_reg(commands, opcode);
			break;

		case shr:
			opcode = "00111";
			binary = format::three_reg(commands, opcode);
			break;

		case shra:
			opcode = "01000";
			binary = format::three_reg(commands, opcode);
			break;

		case shl:
			opcode = "01001";
			binary = format::three_reg(commands, opcode);
			break;

		case ror:
			opcode = "01010";
			binary = format::three_reg(commands, opcode);
			break;

		case rol:
			opcode = "01011";
			binary = format::three_reg(commands, opcode);
			break;

		case addi:
			opcode = "01100";
			binary = format::immid(commands, opcode);
			break;

		case andi:
			opcode = "01101";
			binary = format::immid(commands, opcode);
			break;

		case ori:
			opcode = "01110";
			binary = format::immid(commands, opcode);
			break;

		case mul:
			opcode = "01111";
			binary = format::mul_div(commands, opcode);
			break;

		case _div:
			opcode = "10000";
			binary = format::mul_div(commands, opcode);
			break;

		case neg:
			opcode = "10001";
			binary = format::mul_div(commands, opcode);
			break;

		case _not:
			opcode = "10010";
			binary = format::mul_div(commands, opcode);
			break;

		case brzr:
			opcode = "10011";
			binary = format::branch(commands, opcode, memory_labels);
			break;

		case brnz:
			opcode = "10011";
			binary = format::branch(commands, opcode, memory_labels);
			break;

		case brmi:
			opcode = "10011";
			binary = format::branch(commands, opcode, memory_labels);
			break;

		case brpl:
			opcode = "10011";
			binary = format::branch(commands, opcode, memory_labels);
			break;

		case jr:
			opcode = "10100";
			binary = format::one_reg(commands, opcode);
			break;

		case jal:
			opcode = "10101";
			binary = format::one_reg(commands, opcode);
			break;

		case input:
			opcode = "10110";
			binary = format::one_reg(commands, opcode);
			break;

		case output:
			opcode = "10111";
			binary = format::one_reg(commands, opcode);
			break;

		case mfhi:
			opcode = "11000";
			binary = format::one_reg(commands, opcode);
			break;

		case mflo:
			opcode = "11001";
			binary = format::one_reg(commands, opcode);
			break;

		case nop:
			opcode = "11010";
			binary = format::no_reg(commands, opcode);
			break;

		case halt:
			opcode = "11011";
			binary = format::no_reg(commands, opcode);
			break;

		case word: {
			unsigned int value = stoi(commands[1]);
			binary = utils::to_bin_str(value, word_);	}
			break;

		case label: 
			memory_labels[commands[1]] = address;
			continue;

		case org:
			string num = commands[1];
			address = stoi(num);
			if (utils::is_hex(num)) {
				address = utils::to_dec(num);
			}
			address--;	// Subtract one from the address because it's about to increase by one anyways.
			break;
		}
		mem_item new_cmd;
		new_cmd.bin = binary;
		new_cmd.adr = address;
		if (binary.size() > 0)
			memory.push_back(new_cmd);
		address++;
	}
	utils::write_to_file(memory);
}