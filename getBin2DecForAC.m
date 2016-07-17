function decode_AC_RunLengthSize = getBin2DecForAC(decode_AC_RunLengthSizeBit)
for i=1:length(decode_AC_RunLengthSizeBit)
    size = decode_AC_RunLengthSizeBit{i}{2};
    actualBit = decode_AC_RunLengthSizeBit{i}{3};
    if (bin2dec(actualBit)<=(2^(size-1)-1))
        decode_AC_RunLengthSize{i}{2} = bin2dec(convertLogicToStr(not(logical(actualBit(:)'-'0')))) * (-1);
    else
        decode_AC_RunLengthSize{i}{2} = bin2dec(actualBit);
    end
    decode_AC_RunLengthSize{i}{1} = decode_AC_RunLengthSizeBit{i}{1};
end
end 