function afterDCTMatix = convert2DDCT(inputMatix)  
    afterDCTMatix = cell(size(inputMatix, 1), size(inputMatix, 2));
    
    % # of row = 32, # of col = 32 for an 256x256 image
    for row = 1:size(inputMatix, 1)
        for col = 1:size(inputMatix, 2)
		% Pre-processing: Subtract 128 from the 8x8 block first
		% Note: B{row, col} is a vector of unsigned integer, so cast it to double first
    		B_temp = double(inputMatix{row, col}) - 128;
		% Apply 2D DCT to the 8x8 block
    		afterDCTMatix{row, col} = dct2(B_temp);
        end
    end
end