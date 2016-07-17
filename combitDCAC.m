function decode_DCandAC = combitDCAC(decode_DC,decode_AC)
countDC = 1;
countAC = 2;
decode_DCandAC = cell(sqrt(length(decode_DC)) , sqrt(length(decode_DC)));
for row = 1:size(decode_DCandAC, 1)
    for col = 1:size(decode_DCandAC, 2)
        decode_DCandAC{row,col}(1)=decode_DC{countDC};
        for (j = 1:63)
            decode_DCandAC{row,col}(countAC)=decode_AC{countDC}{j};
            countAC = countAC+1;
        end
        countDC = countDC+1;
        countAC = 2;
    end
end
end