#include "Utils.h"

bool utils::skip_blank(const string line) {
	// If line is empty, skip it.
	if (line.size() == 0)
		return true;

	// Iterate through and check if the line is only tabs and spaces.
	for (int i = 0; i < line.length(); i++) {
		if (line[i] != '\t' && line[i] != ' ' && line[i] != '#') {
			return false;
		}
		else if (line[i] == '#') {
			return true;
		}
	}
	return true;
}

int utils::find_char(const string str, const int index, const string find) {
	// Find char will search the input string and return the index of the first
	// match with a char in the second string. 
	int string_length = str.length();

	// Iterate through each char in the input string,
	for (int i = index; i < string_length; i++) {
		// Check with each char in the second string.
		for (int j = 0; j < find.length(); j++) {
			if (str[i] == find[j])
				return i;
		}
	}
	return string_length;
}

vector<string> utils::parse_cmds(const string line) {
	// Will split a string of commands into each separate keyword.
	vector<string> commands;
	int index = 0;
	int end_index = line.size();

	// Skip all the tabs and spaces at the start of the line.
	while (true) {
		if (line[index] == '\t' || line[index] == ' ')
			index++;
		else
			break;
	}

	// If the line is a LABEL:, handle separately.
	if (line.find_first_of(":") != std::string::npos) {
		commands.push_back("label");
		commands.push_back(line.substr(index, line.find_first_of(":")));
		return commands;
	}
	
	// Iterate through the line.
	while (true) {
		// Remove comments.
		if (line[index] == '#')
			return commands;

		// Find the end of the keyword. It will end in a tab, bracket or comma.
		int end_of_command = find_char(line, index, "\t (,");

		// Create a substring with the two indices.
		string command = line.substr(index, end_of_command - index);
		commands.push_back(command);

		// If we're at the end of the line, break.
		if (end_of_command == end_index)
			break;

		index = end_of_command;

		// Skip all the tabs, spaces, etc.
		while (line[index] == '\t' || line[index] == ' ' || line[index] == '(' || line[index] == ',')
			index++;
	}
	return commands;
}

int utils::to_dec(const string hex){
	int len = hex.length();

	// Initializing base value to 1, i.e 16^0 
	int base = 1;

	int dec_val = 0;

	// Extracting characters as digits from last character 
	for (int i = len - 1; i >= 0; i--)
	{
		// if character lies in '0'-'9', converting  
		// it to integral 0-9 by subtracting 48 from 
		// ASCII value. 
		if (hex[i] >= '0' && hex[i] <= '9')
		{
			dec_val += (hex[i] - 48)*base;

			// incrementing base by power 
			base = base * 16;
		}

		// if character lies in 'A'-'F' , converting  
		// it to integral 10 - 15 by subtracting 55  
		// from ASCII value 
		else if (hex[i] >= 'A' && hex[i] <= 'F')
		{
			dec_val += (hex[i] - 55)*base;

			// incrementing base by power 
			base = base * 16;
		}
	}

	return dec_val;
}

bool utils::is_hex(const string str) {
	if (str[0] == '0' && str[1] == 'x')
		return true;
	else
		return false;
}

void utils::write_to_file(const vector<mem_item> binary_cmds) {
	vector<string> output;

	// Initialize the memory to all zeros.
	for (int i = 0; i < MEM_SIZE; i++) {
		output.push_back(ZEROS_32);
	}

	// Write the instructions.
	for (int i = 0; i < binary_cmds.size(); i++) {
		mem_item command = binary_cmds[i];
		unsigned int address = command.adr;
		string binary = command.bin;

		output[address] = binary;
	}

	// Write to the text file.
	ofstream output_file(OUT_FILE_NAME);
	for (int i = 0; i < output.size(); i++) {
		output_file << output[i] << "\n";
	}
}

string utils::to_bin_str(const unsigned int decimal_number, const type type) {
	string binary_num;

	// If we're setting a register number it's 4 bits.
	if (type == reg) 
		binary_num = bitset<4>(decimal_number).to_string();

	// If we're setting a immidiate value it's 19 bits.
	else if (type == immidiate)
		binary_num = bitset<19>(decimal_number).to_string();

	// If we're setting a whole word value it's 32 bits.
	else if (type == word_)
		binary_num = bitset<32>(decimal_number).to_string();

	// Else some compile error.
	else
		binary_num = "";

	return binary_num;
}

unsigned int utils::get_reg_num(const string str) {
	// Parse string and retrieve the register number.
	string number = str.substr(1, str.length() - 1);
	return stoi(number);
}

unsigned int utils::get_immid_num(const string str) {
	// Parse string and retrieve the immid number.
	unsigned int number = stoi(str);
	if (utils::is_hex(str))
		number = utils::to_dec(str);
	return number;
}

string utils::get_condition(const string str) {
	// Parse command and retrieve the condition number.
	if (str.compare("brzr") == 0)
		return "0000";
	else if (str.compare("brnz") == 0)
		return "0001";
	else if (str.compare("brmi") == 0)
		return "0010";
	else if (str.compare("brpl") == 0)
		return "0011";
	else
		return "";
}