function after_DPCM_DC = doDPCMforDC (inputMatrix)
after_DPCM_DC = cell(1, size(inputMatrix, 1) * size(inputMatrix, 2));
prev_DC = 0;
for row = 1:size(inputMatrix, 1)
    for col = 1:size(inputMatrix, 2)
        if row == 1 && col == 1
            if inputMatrix{row, col}(1) >=0
                bin_value = dec2bin(uint16(inputMatrix{row, col}(1)));
                if (inputMatrix{row, col}(1) ==0)
                    bin_value='';
                end
            else
                % one's complement value
                bin_value = char(not(dec2bin(uint16(abs(inputMatrix{row, col}(1)))) - 48) + 48);
            end
        else
            if inputMatrix{row, col}(1) - prev_DC >= 0
                bin_value = dec2bin(uint16(inputMatrix{row, col}(1) - prev_DC));
                if ( inputMatrix{row, col}(1) - prev_DC ==0)
                    bin_value='';
                end
            else
                % one's complement value
                bin_value = char(not(dec2bin(uint16(abs(inputMatrix{row, col}(1) - prev_DC))) - 48) + 48);
            end
        end
        after_DPCM_DC{(row - 1) * size(inputMatrix, 2) + col}{1} = length(bin_value);
        after_DPCM_DC{(row - 1) * size(inputMatrix, 2) + col}{2} = bin_value;
        prev_DC = inputMatrix{row, col}(1);
    end
end
end