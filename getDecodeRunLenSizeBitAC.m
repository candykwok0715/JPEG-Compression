function decode_AC_RunLengthSizeBit = getDecodeRunLenSizeBitAC(decode_AC_code,huffmancode_AC_RUN_SIZE,unique_AC_RUN_SIZE)
decode_AC_count=0;
i = 1;
huffmancode = decode_AC_code(i);
while(i<=length(decode_AC_code))
    
    if (strcmp(getValueByCode(huffmancode,huffmancode_AC_RUN_SIZE,unique_AC_RUN_SIZE),''))
        i = i+1;
        huffmancode = strcat(huffmancode,decode_AC_code(i));
    else
        decode_AC_count = decode_AC_count +1;
        runLengthSize = textscan(getValueByCode(huffmancode,huffmancode_AC_RUN_SIZE,unique_AC_RUN_SIZE),'%s', 'delimiter', '|');
        runLength = str2num(runLengthSize{1}{1});
        size = str2num(runLengthSize{1}{2});
        if (size==0)
            actualBit='';
            i = i+1;
            if (i<=length(decode_AC_code))
                huffmancode = strcat(decode_AC_code(i));
            end
        else
            startActualBit = i+1;
            if (i+ size+1<=length(decode_AC_code))
                i = i+ size+1;
                huffmancode = strcat(decode_AC_code(i));
            else
                i = length(decode_AC_code)+1;
            end
            endActualBit = i-1;
            actualBit=decode_AC_code(startActualBit);
            for j=(startActualBit+1):endActualBit
                actualBit = strcat(actualBit,decode_AC_code(j));
            end
        end
        decode_AC_RunLengthSizeBit{decode_AC_count}{1}=runLength;
        decode_AC_RunLengthSizeBit{decode_AC_count}{2}=size;
        decode_AC_RunLengthSizeBit{decode_AC_count}{3}=actualBit;
    end
end
end