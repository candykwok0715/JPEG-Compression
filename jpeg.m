clear;
clc;

% Read the image
% Put the image file in the same folder as the jpeg.m file
 [imagedata, imagemap] = imread('polyu', 'bmp');

% Show the original image file
% imshow(imagedata);

% Assume the image is 256 x 256 pixels. Divide the image into 8 x 8 blocks.
N = 8 * ones(1, 32);
B = mat2cell(imagedata, N, N);
clear imagedata;
clear N; 

% Encoding
% Perform 2D DCT.
% Implement your code here.
C = convert2DDCT(B);
clear B;

% Quantization
% Use the luminance quantization table on Slide 40 of Lecture 4.
% Implement your code here.

% quantization table for luminance layer
QuantTable = [16, 11, 10, 16, 24, 40, 51, 61;
12, 12, 14, 19, 26, 58, 60, 55;
14, 13, 16, 24, 40, 57, 69, 56;
14, 17, 22, 29, 51, 87, 80, 62;
18, 22, 37, 56, 68, 109, 103, 77;
24, 35, 55, 64, 81, 104, 113, 92;
49, 64, 78, 87, 103, 121, 120, 101;
72, 92, 95, 98, 112, 100, 103, 99];

quantized = applyQuantized(C,QuantTable);
clear C;

% Zigzag ordering
% Perform Zigzag ordering to form a bitsteam. Remember, AC and DC coefficients have to be
% encoded separately. Define the format for the bitstream properly.
% Implement your code here.
zigzag = applyZigzag(quantized);
clear quantized;

% Use Huffman coding for AC coefficients and Run-length coding with DPCM for DC coefficients.
% Implement your code here.

% DPCM progress of DC coefficient
DC = doDPCMforDC(zigzag);
% RLC progress of AC coefficient
AC = doRLCforAC(zigzag);
clear zigzag;

% get the HuffmanTable of DC coefficient
DC_SIZE = getDCsize(DC);
unique_DC_SIZE = getUnique(DC_SIZE);
plist_DC_SIZE =  getListOfDCsize(DC_SIZE,unique_DC_SIZE);
huffmancode_DC_SIZE = buildHuffmanTable(plist_DC_SIZE);
clear DC_SIZE;
clear plist_DC_SIZE;

% get the HuffmanTable of AC coefficient
AC_RUN_SIZE = getRunSizeAC (AC);
unique_AC_RUN_SIZE = getUnique(AC_RUN_SIZE);
plist_AC_RUN_SIZE = getListofRunSizeAC (AC_RUN_SIZE,unique_AC_RUN_SIZE);
huffmancode_AC_RUN_SIZE = buildHuffmanTable(plist_AC_RUN_SIZE);
clear AC_RUN_SIZE;
clear plist_AC_RUN_SIZE;

% get the DC and AC which are represented by logical
DC_code_bin = getDCcodebin(DC,huffmancode_DC_SIZE,unique_DC_SIZE);
AC_code_bin = getACcodebin(AC,huffmancode_AC_RUN_SIZE,unique_AC_RUN_SIZE);
clear DC;
clear AC;
fprintf('Entropy coded DC Coefficients in logical vector: (size: %d bits)\n', length(DC_code_bin));
fprintf('Entropy coded AC Coefficients in logical vector: (size: %d bits)\n', length(AC_code_bin));
fprintf('Entropy coded image: (size: %d bits)\n', length(DC_code_bin)+length(AC_code_bin));
% Decoding
% The whole process is similar to encoding process, but works reversely.
% Decode and restore the AC and DC zigzagged coefficients.
% Implement your code here.

% get DC code String 
decode_DC_code = convertLogicToStr(DC_code_bin);

% get the actaual bit of the each DC Coefficients
decode_DC_SizeBit = getDecodedsizeBitDC (decode_DC_code,huffmancode_DC_SIZE,unique_DC_SIZE);
clear decode_DC_code;

% convert binary to decimal for DC
decode_DPCM_DC = getBin2DecForDC (decode_DC_SizeBit);
clear decode_DC_SizeBit;

% do Inverse the DPCM for DC
decode_DC = getInverseDPCMforDC (decode_DPCM_DC);
clear decode_DPCM_DC;

% get AC code String 
decode_AC_code = convertLogicToStr(AC_code_bin);

% get the actaual bit of the each AC Coefficients
decode_AC_RunLengthSizeBit = getDecodeRunLenSizeBitAC(decode_AC_code,huffmancode_AC_RUN_SIZE,unique_AC_RUN_SIZE);
clear decode_AC_code

% convert binary to decimal for AC
decode_AC_RunLengthSize = getBin2DecForAC(decode_AC_RunLengthSizeBit);
clear decode_AC_RunLengthSizeBit;

% convert to AC
decode_AC = convertDecodeAC (decode_AC_RunLengthSize);
clear decode_AC_RunLengthSize;

%combit DC and AC into 1 block
decode_DCandAC = combitDCAC(decode_DC,decode_AC);
clear decode_DC;
clear decode_AC;

% Inverse zigzag process
% Implement your code here.

irzigzag = getirzigzag(decode_DCandAC);
clear decode_DCandAC;

% De-quantization
% Implement your code here.
DCT = deQuantization(irzigzag,QuantTable);
clear irzigzag;

% Inverse 2D DCT
% Use the DCT coefficients to recover the image.
% implement your code.
inversedDCT = inverse2DDCT(DCT);
clear DCT;

decodedimagedata = cell2mat(inversedDCT);
clear inversedDCT;
% Verify your code by showing the decompressed image.
imshow(decodedimagedata);