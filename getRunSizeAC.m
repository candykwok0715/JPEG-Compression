function AC_RUN_SIZE = getRunSizeAC (AC)
% Store RUNLENGTH and SIZE values (with redundancy) of AC coefficients to AC_RUN_SIZE cell
count_AC_RUN_SIZE = 0;
for i=1:length(AC)
    for j=1:length(AC{i})
        count_AC_RUN_SIZE = count_AC_RUN_SIZE + 1;
        AC_RUN_SIZE{count_AC_RUN_SIZE} = strcat(num2str(AC{i}{j}{1}), '|', num2str(AC{i}{j}{2}));
    end
end
end