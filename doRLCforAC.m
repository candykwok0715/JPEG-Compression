function afterRLC = doRLCforAC(inputMatrix)
afterRLC = cell(1, size(inputMatrix, 1) * size(inputMatrix, 2));

for row = 1:size(inputMatrix, 1)
	for col = 1:size(inputMatrix, 2)
		runlength = 0;
		AC_count = 0;
		idx_last_non_zero = length(inputMatrix{row, col});
        % Find the index of the last non-zero value in the current block of zigzag vector
        idx_last_non_zero = find(inputMatrix{row, col}, 1, 'last');
		% First element is DC coefficient
		if idx_last_non_zero < 2
			idx_last_non_zero = 2;
        end
		for i = 2:idx_last_non_zero
			if inputMatrix{row, col}(i) == 0
				% It means the current zero is the 16th zero
				if runlength == 15
					AC_count = AC_count + 1;
					afterRLC{(row - 1) * size(inputMatrix, 2) + col}{AC_count}{1} = runlength;
					afterRLC{(row - 1) * size(inputMatrix, 2) + col}{AC_count}{2} = 0;
					afterRLC{(row - 1) * size(inputMatrix, 2) + col}{AC_count}{3} = '';
					runlength = 0;
				else
					runlength = runlength + 1;
				end
			else
				AC_count = AC_count + 1;
				if inputMatrix{row, col}(i) > 0
					bin_value = dec2bin(uint16(inputMatrix{row, col}(i)));
				else
					bin_value = char(not(dec2bin(uint16(abs(inputMatrix{row, col}(i)))) - 48) + 48);
				end
				afterRLC{(row - 1) * size(inputMatrix, 2) + col}{AC_count}{1} = runlength;
				afterRLC{(row - 1) * size(inputMatrix, 2) + col}{AC_count}{2} = length(bin_value);
				afterRLC{(row - 1) * size(inputMatrix, 2) + col}{AC_count}{3} = bin_value;
				runlength = 0;
			end
        end
        % append EOB special code (runlength 0, size 0) at the end
        AC_count = AC_count + 1;
		afterRLC{(row - 1) * size(inputMatrix, 2) + col}{AC_count}{1} = 0;
		afterRLC{(row - 1) * size(inputMatrix, 2) + col}{AC_count}{2} = 0;
		afterRLC{(row - 1) * size(inputMatrix, 2) + col}{AC_count}{3} = '';  
	end
end
end