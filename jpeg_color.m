clear;
clc;

% Read the image
% Put the image file in the same folder as the jpeg.m file
imagedata = imread('polyu_color', 'bmp');
imagedata_R = imagedata(:, : , 1); % Get the RED matrix
imagedata_G = imagedata(:, :, 2); % Get the GREEN matrix
imagedata_B= imagedata(:, :, 3); % Get the BLUE matrix

% Show the original image file
%imshow(imagedata);
%imshow(imagedata_R);
%imshow(imagedata_G);
%imshow(imagedata_B);

% Assume the image is 256 x 256 pixels. Divide the image into 8 x 8 blocks.
N = 8 * ones(1, 32);
Red = mat2cell(imagedata_R, N, N);
Green = mat2cell(imagedata_G, N, N);
Blue = mat2cell(imagedata_B, N, N);
clear N; 
clear imagedata;
clear imagedata_R;
clear imagedata_G;
clear imagedata_B;

% Encoding
% Perform 2D DCT.
% Implement your code here.
Red_DCT = convert2DDCT(Red);
Green_DCT = convert2DDCT(Green);
Blue_DCT = convert2DDCT(Blue);
clear Red;
clear Green;
clear Blue;

% Quantization
% Use the luminance quantization table on Slide 40 of Lecture 4.
% Implement your code here.
% quantization table for luminance layer
QuantTable = [17, 18, 24, 47, 99, 99, 99, 99;
18, 21, 26, 66, 99, 99, 99, 99;
24, 26, 56, 99, 99, 99, 99, 99;
47, 66, 22, 99, 99, 99, 99, 99;
99, 99, 99, 99, 99, 99, 99, 99;
99, 99, 99, 99, 99, 99, 99, 99;
99, 99, 99, 99, 99, 99, 99, 99;
99, 99, 99, 99, 99, 99, 99, 99];
quantized_R = applyQuantized(Red_DCT,QuantTable);
quantized_G = applyQuantized(Green_DCT,QuantTable);
quantized_B = applyQuantized(Blue_DCT,QuantTable);
clear Red_DCT;
clear Green_DCT;
clear Blue_DCT;

% Zigzag ordering
% Perform Zigzag ordering to form a bitsteam. Remember, AC and DC coefficients have to be
% encoded separately. Define the format for the bitstream properly.
% Implement your code here.
zigzag_R = applyZigzag(quantized_R);
zigzag_G = applyZigzag(quantized_G);
zigzag_B = applyZigzag(quantized_B);
clear quantized_R;
clear quantized_G;
clear quantized_B;

% Use Huffman coding for AC coefficients and Run-length coding with DPCM for DC coefficients.
% Implement your code here.

% DPCM progress of DC coefficient
DC_R = doDPCMforDC(zigzag_R);
DC_G = doDPCMforDC(zigzag_G);
DC_B = doDPCMforDC(zigzag_B);
% RLC progress of AC coefficient
AC_R = doRLCforAC(zigzag_R);
AC_G = doRLCforAC(zigzag_G);
AC_B = doRLCforAC(zigzag_B);
clear zigzag_R;
clear zigzag_G;
clear zigzag_B;

% get the HuffmanTable of DC coefficient
DC_SIZE_R = getDCsize(DC_R);
unique_DC_SIZE_R = getUnique(DC_SIZE_R);
plist_DC_SIZE_R =  getListOfDCsize(DC_SIZE_R,unique_DC_SIZE_R);
huffmancode_DC_SIZE_R = buildHuffmanTable(plist_DC_SIZE_R);
clear DC_SIZE_R;
clear plist_DC_SIZE_R;

DC_SIZE_G = getDCsize(DC_G);
unique_DC_SIZE_G = getUnique(DC_SIZE_G);
plist_DC_SIZE_G =  getListOfDCsize(DC_SIZE_G,unique_DC_SIZE_G);
huffmancode_DC_SIZE_G = buildHuffmanTable(plist_DC_SIZE_G);
clear DC_SIZE_G;
clear plist_DC_SIZE_G;

DC_SIZE_B = getDCsize(DC_B);
unique_DC_SIZE_B = getUnique(DC_SIZE_B);
plist_DC_SIZE_B =  getListOfDCsize(DC_SIZE_B,unique_DC_SIZE_B);
huffmancode_DC_SIZE_B = buildHuffmanTable(plist_DC_SIZE_B);
clear DC_SIZE_B;
clear plist_DC_SIZE_B;

% get the HuffmanTable of AC coefficient
AC_RUN_SIZE_R = getRunSizeAC (AC_R);
unique_AC_RUN_SIZE_R = getUnique(AC_RUN_SIZE_R);
plist_AC_RUN_SIZE_R = getListofRunSizeAC (AC_RUN_SIZE_R,unique_AC_RUN_SIZE_R);
huffmancode_AC_RUN_SIZE_R = buildHuffmanTable(plist_AC_RUN_SIZE_R);
clear AC_RUN_SIZE_R;
clear plist_AC_RUN_SIZE_R;

AC_RUN_SIZE_G = getRunSizeAC (AC_G);
unique_AC_RUN_SIZE_G = getUnique(AC_RUN_SIZE_G);
plist_AC_RUN_SIZE_G = getListofRunSizeAC (AC_RUN_SIZE_G,unique_AC_RUN_SIZE_G);
huffmancode_AC_RUN_SIZE_G = buildHuffmanTable(plist_AC_RUN_SIZE_G);
clear AC_RUN_SIZE_G;
clear plist_AC_RUN_SIZE_G;

AC_RUN_SIZE_B = getRunSizeAC (AC_B);
unique_AC_RUN_SIZE_B = getUnique(AC_RUN_SIZE_B);
plist_AC_RUN_SIZE_B = getListofRunSizeAC (AC_RUN_SIZE_B,unique_AC_RUN_SIZE_B);
huffmancode_AC_RUN_SIZE_B = buildHuffmanTable(plist_AC_RUN_SIZE_B);
clear AC_RUN_SIZE_B;
clear plist_AC_RUN_SIZE_B;

% get the DC and AC which are represented by logical
DC_code_bin_R = getDCcodebin(DC_R,huffmancode_DC_SIZE_R,unique_DC_SIZE_R);
DC_code_bin_G = getDCcodebin(DC_G,huffmancode_DC_SIZE_G,unique_DC_SIZE_G);
DC_code_bin_B = getDCcodebin(DC_B,huffmancode_DC_SIZE_B,unique_DC_SIZE_B);
AC_code_bin_R = getACcodebin(AC_R,huffmancode_AC_RUN_SIZE_R,unique_AC_RUN_SIZE_R);
AC_code_bin_G = getACcodebin(AC_G,huffmancode_AC_RUN_SIZE_G,unique_AC_RUN_SIZE_G);
AC_code_bin_B = getACcodebin(AC_B,huffmancode_AC_RUN_SIZE_B,unique_AC_RUN_SIZE_B);
clear DC_R;
clear DC_G;
clear DC_B;
clear AC_R;
clear AC_G;
clear AC_B;
fprintf('Entropy coded DC Coefficients for Red in logical vector: (size: %d bits)\n', length(DC_code_bin_R));
fprintf('Entropy coded DC Coefficients for Green in logical vector: (size: %d bits)\n', length(DC_code_bin_G));
fprintf('Entropy coded DC Coefficients for Blue in logical vector: (size: %d bits)\n', length(DC_code_bin_B));
fprintf('Entropy coded AC Coefficients for Red in logical vector: (size: %d bits)\n', length(AC_code_bin_R));
fprintf('Entropy coded AC Coefficients for Green in logical vector: (size: %d bits)\n', length(AC_code_bin_G));
fprintf('Entropy coded AC Coefficients for Blue in logical vector: (size: %d bits)\n', length(AC_code_bin_B));
fprintf('Entropy coded image: (size: %d bits)\n', length(DC_code_bin_R)+length(DC_code_bin_G)+length(DC_code_bin_B)+length(AC_code_bin_R)+length(AC_code_bin_G)+length(AC_code_bin_B));
% Decoding
% The whole process is similar to encoding process, but works reversely.
% Decode and restore the AC and DC zigzagged coefficients.
% Implement your code here.

% get DC code String 
decode_DC_code_R = convertLogicToStr(DC_code_bin_R);
decode_DC_code_G = convertLogicToStr(DC_code_bin_G);
decode_DC_code_B = convertLogicToStr(DC_code_bin_B);

% get the actaual bit of the each DC Coefficients
decode_DC_SizeBit_R = getDecodedsizeBitDC (decode_DC_code_R,huffmancode_DC_SIZE_R,unique_DC_SIZE_R);
decode_DC_SizeBit_G = getDecodedsizeBitDC (decode_DC_code_G,huffmancode_DC_SIZE_G,unique_DC_SIZE_G);
decode_DC_SizeBit_B = getDecodedsizeBitDC (decode_DC_code_B,huffmancode_DC_SIZE_B,unique_DC_SIZE_B);
clear decode_DC_code_R;
clear decode_DC_code_G;
clear decode_DC_code_B;

% convert binary to decimal for DC
decode_DPCM_DC_R = getBin2DecForDC (decode_DC_SizeBit_R);
decode_DPCM_DC_G = getBin2DecForDC (decode_DC_SizeBit_G);
decode_DPCM_DC_B = getBin2DecForDC (decode_DC_SizeBit_B);
clear decode_DC_SizeBit_R;
clear decode_DC_SizeBit_G;
clear decode_DC_SizeBit_B;

% do Inverse the DPCM for DC
decode_DC_R = getInverseDPCMforDC (decode_DPCM_DC_R);
decode_DC_G = getInverseDPCMforDC (decode_DPCM_DC_G);
decode_DC_B = getInverseDPCMforDC (decode_DPCM_DC_B);
clear decode_DPCM_DC_R;
clear decode_DPCM_DC_G;
clear decode_DPCM_DC_B;

% get AC code String 
decode_AC_code_R = convertLogicToStr(AC_code_bin_R);
decode_AC_code_G = convertLogicToStr(AC_code_bin_G);
decode_AC_code_B = convertLogicToStr(AC_code_bin_B);

% get the actaual bit of the each AC Coefficients
decode_AC_RunLengthSizeBit_R = getDecodeRunLenSizeBitAC(decode_AC_code_R,huffmancode_AC_RUN_SIZE_R,unique_AC_RUN_SIZE_R);
decode_AC_RunLengthSizeBit_G = getDecodeRunLenSizeBitAC(decode_AC_code_G,huffmancode_AC_RUN_SIZE_G,unique_AC_RUN_SIZE_G);
decode_AC_RunLengthSizeBit_B = getDecodeRunLenSizeBitAC(decode_AC_code_B,huffmancode_AC_RUN_SIZE_B,unique_AC_RUN_SIZE_B);
clear decode_AC_code_R;
clear decode_AC_code_G;
clear decode_AC_code_B;

% convert binary to decimal for AC
decode_AC_RunLengthSize_R = getBin2DecForAC(decode_AC_RunLengthSizeBit_R);
decode_AC_RunLengthSize_G = getBin2DecForAC(decode_AC_RunLengthSizeBit_G);
decode_AC_RunLengthSize_B = getBin2DecForAC(decode_AC_RunLengthSizeBit_B);
clear decode_AC_RunLengthSizeBit_R;
clear decode_AC_RunLengthSizeBit_G;
clear decode_AC_RunLengthSizeBit_B;

% convert to AC
decode_AC_R = convertDecodeAC (decode_AC_RunLengthSize_R);
decode_AC_G = convertDecodeAC (decode_AC_RunLengthSize_G);
decode_AC_B = convertDecodeAC (decode_AC_RunLengthSize_B);
clear decode_AC_RunLengthSize_R;
clear decode_AC_RunLengthSize_G;
clear decode_AC_RunLengthSize_B;

%combit DC and AC into 1 block
decode_DCandAC_R = combitDCAC(decode_DC_R,decode_AC_R);
decode_DCandAC_G = combitDCAC(decode_DC_G,decode_AC_G);
decode_DCandAC_B = combitDCAC(decode_DC_B,decode_AC_B);
clear decode_DC_R;
clear decode_DC_G;
clear decode_DC_B;
clear decode_AC_R;
clear decode_AC_G;
clear decode_AC_B;

% Inverse zigzag process
% Implement your code here.
irzigzag_R = getirzigzag(decode_DCandAC_R);
irzigzag_G = getirzigzag(decode_DCandAC_G);
irzigzag_B = getirzigzag(decode_DCandAC_B);
clear decode_DCandAC_R;
clear decode_DCandAC_G;
clear decode_DCandAC_B;

% De-quantization
% Implement your code here.
DCT_R = deQuantization(irzigzag_R,QuantTable);
DCT_G = deQuantization(irzigzag_G,QuantTable);
DCT_B = deQuantization(irzigzag_B,QuantTable);
clear irzigzag_R;
clear irzigzag_G;
clear irzigzag_B;

% Inverse 2D DCT
% Use the DCT coefficients to recover the image.
% implement your code.
inversedDCT_R = inverse2DDCT(DCT_R);
inversedDCT_G = inverse2DDCT(DCT_G);
inversedDCT_B = inverse2DDCT(DCT_B);
clear DCT_R;
clear DCT_G;
clear DCT_B;

decodedimagedata_R = cell2mat(inversedDCT_R);
decodedimagedata_G = cell2mat(inversedDCT_G);
decodedimagedata_B = cell2mat(inversedDCT_B);
decodedimagedata = cat(3,decodedimagedata_R,decodedimagedata_G,decodedimagedata_B);
clear inversedDCT_R;
clear inversedDCT_G;
clear inversedDCT_B;

% Verify your code by showing the decompressed image.
%imshow(decodedimagedata_R);
%imshow(decodedimagedata_G);
%imshow(decodedimagedata_B);
imshow(decodedimagedata);