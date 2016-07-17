function decode_DPCM_DC = getBin2DecForDC (decode_DC_SizeBit)
for i=1:length(decode_DC_SizeBit)
    size = decode_DC_SizeBit{i}{1};
    actualBit = decode_DC_SizeBit{i}{2};
    if (size==0 && strcmp(actualBit,''))
        decode_DPCM_DC{i}=0;
    else
        if (bin2dec(actualBit)<=(2^(size-1)-1))
            decode_DPCM_DC{i} = bin2dec(convertLogicToStr(not(logical(actualBit(:)'-'0')))) * (-1);
        else
            decode_DPCM_DC{i} = bin2dec(actualBit);
        end
    end
end
end