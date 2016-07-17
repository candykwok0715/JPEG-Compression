
% Function to lookup a target SIZE / RUNLENGTH|SIZE values in the Huffman Table specified by the "huffmancode" cell and return its Huffman Code value
% valuelist: a cell containing the distinct SIZE (for DC) or RUNLENGTH|SIZE (for AC) values
% huffmancode: a cell containing the Huffman Code table generated by the buildHuffmanTable() function
function codeword = getCodeByValue(target, huffmancode, valuelist)
	for i=1:length(valuelist)
		if strcmp(target, valuelist{i})
            codeword = huffmancode{i};
		end
	end
end