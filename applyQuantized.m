function afterQuantized = applyQuantized(inputMatix,QuantTable)  
    afterQuantized = cell(size(inputMatix, 1), size(inputMatix, 2));

    for row = 1:size(inputMatix, 1)
        for col = 1:size(inputMatix, 2)
            % cast back to int8 to avoid "negative zero" values in the matrix
            afterQuantized{row, col} = int8(round(inputMatix{row, col} ./ QuantTable));
        end
    end
end