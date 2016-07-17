function decode_DC_SizeBit = getDecodedsizeBitDC (decode_DC_code,huffmancode_DC_SIZE,unique_DC_SIZE)
decode_DC_count=0;
i = 1;
huffmancode = decode_DC_code(i);
while(i<=length(decode_DC_code))
    if (strcmp(getValueByCode(huffmancode,huffmancode_DC_SIZE,unique_DC_SIZE),''))
        i = i+1;
        huffmancode = strcat(huffmancode,decode_DC_code(i));
    else
        decode_DC_count = decode_DC_count +1;
        size=str2num(getValueByCode(huffmancode,huffmancode_DC_SIZE,unique_DC_SIZE));
        startActualBit = i+1;
        if (i+ size+1<=length(decode_DC_code))
            i = i+ size+1;
            huffmancode = strcat(decode_DC_code(i));
        else
            i = length(decode_DC_code)+1;
        end
        endActualBit = i-1;
        if (size==0)
            actualBit='';
        else
            actualBit=decode_DC_code(startActualBit);
            for j=(startActualBit+1):endActualBit
                actualBit = strcat(actualBit,decode_DC_code(j));
            end
        end
        decode_DC_SizeBit{decode_DC_count}{1}=size;
        decode_DC_SizeBit{decode_DC_count}{2}=actualBit;
    end
end
end 