function decode_AC = convertDecodeAC (decode_AC_RunLengthSize)
pixelCount = 1;
blcokCount=1;
for i=1:length(decode_AC_RunLengthSize)
   if(decode_AC_RunLengthSize{i}{1}==0 && not(isempty(decode_AC_RunLengthSize{i}{2})))
       decode_AC{blcokCount}{pixelCount} = decode_AC_RunLengthSize{i}{2};
       pixelCount = pixelCount +1;
   end
   if(not(decode_AC_RunLengthSize{i}{1}==0) && not(isempty(decode_AC_RunLengthSize{i}{2})))
        for(j=1:decode_AC_RunLengthSize{i}{1})
             decode_AC{blcokCount}{pixelCount} = 0;
            pixelCount = pixelCount +1;
        end
        decode_AC{blcokCount}{pixelCount} = decode_AC_RunLengthSize{i}{2};
        pixelCount = pixelCount +1;
   end
   % For 63 pixel, it not has EOB
   if (pixelCount==63) 
       pixelCount=1;
       blcokCount = blcokCount+1;
   end
   if(decode_AC_RunLengthSize{i}{1}==0 && isempty(decode_AC_RunLengthSize{i}{2}))
       for j=pixelCount:63
            decode_AC{blcokCount}{j} = 0;
       end
       pixelCount=1;
       blcokCount = blcokCount+1;
   end
end
end