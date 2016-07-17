function AC_code_bin = getACcodebin(AC,huffmancode_AC_RUN_SIZE,unique_AC_RUN_SIZE)
AC_code = '';
for i=1:length(AC)
	for j=1:length(AC{i})
		lookupValue = strcat(num2str(AC{i}{j}{1}), '|', num2str(AC{i}{j}{2}));
		AC_code = strcat(AC_code, getCodeByValue(lookupValue, huffmancode_AC_RUN_SIZE, unique_AC_RUN_SIZE), AC{i}{j}{3});
	end
end
AC_code_bin = logical(AC_code(:)'-'0');
end