% Accepts a vector of frequencies of occurrences to generate a nested cell based Huffman tree
function huffmantree = genHuffmanTree(plist)
    huffmantree = cell(length(plist),1);
	% Label each element in the cell with the indices of frequency vector (plist)
    for i=1:length(plist)
        huffmantree{i} = i;
    end
    while numel(huffmantree) > 2
		% Sort the frequency list from smallest to largest
        [plist, pos] = sort(plist, 'ascend');
        plist(2) = plist(1) + plist(2);
        plist(1) = [];
		% Order the corresponding elements of huffmantree in the same sequence as plist
        huffmantree = huffmantree(pos);
        huffmantree{2} = {huffmantree{1}, huffmantree{2}};
        huffmantree(1) = [];
    end
end