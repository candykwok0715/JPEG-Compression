function RawImage = inverse2DDCT(DCT)
    for row = 1:size(DCT, 1)
        for col = 1:size(DCT, 2)
            B_temp = idct2(DCT{row,col});
            imagedata{row,col} = uint8(B_temp + 128);
    	end
    end
    RawImage = imagedata;
end