function DC_code_bin = getDCcodebin(DC,huffmancode_DC_SIZE,unique_DC_SIZE)
DC_code = '';
for i=1:length(DC)
	DC_code = strcat(DC_code, getCodeByValue(num2str(DC{i}{1}), huffmancode_DC_SIZE, unique_DC_SIZE), DC{i}{2});
end
DC_code_bin = logical(DC_code(:)'-'0');
end 