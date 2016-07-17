function huffmancode = buildHuffmanTable(plist)
	% Make the vector variable global so that it persists through recursive function calls of genHuffmanCode
    global huffmancode;
    huffmancode = cell(length(plist), 1);
    if length(plist) > 1
        plist = plist / sum(plist);
        huffmantree = genHuffmanTree(plist);
        genHuffmanCode(huffmantree, []);
    else
        huffmancode = {'1'};
    end
end