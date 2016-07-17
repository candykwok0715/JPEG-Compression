function decode_DC = getInverseDPCMforDC (decode_DPCM_DC)
for i=1:length(decode_DPCM_DC)
    if (i==1)
        decode_DC{i}=decode_DPCM_DC{i};
    else
        decode_DC{i}= decode_DPCM_DC{i} + decode_DC{i-1};
    end
end
end