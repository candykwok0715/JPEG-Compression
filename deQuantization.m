function DCT = deQuantization(quantized,QTable)
	for row = 1:size(quantized, 1)
		for col = 1:size(quantized, 2)
			% change to double to operate .*
			DCTmatrix{row, col} = round(double(quantized{row, col}) .* QTable);
		end
	end
	DCT = DCTmatrix;
end 