function irzigzag = getirzigzag(table)
irzigzag = cell(size(table, 1), size(table, 2));
for row = 1:size(table, 1)
    for col = 1:size(table, 2)
        
        count = 0;
        
        for turn = 1:15
            if mod(turn, 2) ~= 0
                if turn < 8
                    for x = turn:-1:1
                        y = (turn + 1) - x;
                        count = count + 1;
%                       zigzag{row, col}(count) = quantized{row, col}(x, y);
						irzigzag{row, col}(x, y) = table{row, col}(count);

                    end
                else
                    for x = 8:-1:(1 + mod(turn, 8))
                        y = (turn + 1) - x;
                        count = count + 1;
%                        zigzag{row, col}(count) = quantized{row, col}(x, y);
    					 irzigzag{row, col}(x, y) = table{row, col}(count);
                    end
                end
            else
                if turn < 8
                    for x = 1:1:turn
                        y = (turn + 1) - x;
                        count = count + 1;
%                        zigzag{row, col}(count) = quantized{row, col}(x, y);
						 irzigzag{row, col}(x, y) = table{row, col}(count);
                    end
                else
                    for x = (1 + mod(turn, 8)):1:8
                        y = (turn + 1) - x;
                        count = count + 1;
%                        zigzag{row, col}(count) = quantized{row, col}(x, y);
						 irzigzag{row, col}(x, y) = table{row, col}(count);
                    end
                end
            end
        end
        
    end
end