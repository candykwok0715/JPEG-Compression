function DCsize = getDCsize(DC)
% Store SIZE value (with redundancy) of DC coefficients to DC_SIZE cell
for i=1:length(DC)
    DCsize{i} = num2str(DC{i}{1});
end
end 