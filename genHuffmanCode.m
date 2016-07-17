% Sub-function to recursively traverse down the nested cell based Huffman tree to generate Huffman table
function genHuffmanCode(huffmantree, codeword)
	% Global cell variable to store cumulative codewords and make it possible to persist through recursive function calls
    global huffmancode
    if isa(huffmantree, 'cell')
		% Recursive cases - nested cell 1 (left branch) = 0, nested cell 2 (right branch) = 1
        genHuffmanCode(huffmantree{1}, [codeword '0']);
        genHuffmanCode(huffmantree{2}, [codeword '1']);
    else
		% Base case - recursion reaches the deepest-level cell (leave node) without further nested cells
        huffmancode{huffmantree} = codeword;
    end
end