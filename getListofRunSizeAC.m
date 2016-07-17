function plist_AC_RUN_SIZE = getListofRunSizeAC (AC_RUN_SIZE,unique_AC_RUN_SIZE)
% Count the occurrences of each distinct RUNLENGTH + SIZE combination in AC_RUN_SIZE cell
plist_AC_RUN_SIZE = zeros(1, length(unique_AC_RUN_SIZE));
for i=1:length(unique_AC_RUN_SIZE)
	for j=1:length(AC_RUN_SIZE)
		if strcmp(AC_RUN_SIZE{j}, unique_AC_RUN_SIZE{i})
			plist_AC_RUN_SIZE(i) = plist_AC_RUN_SIZE(i) + 1;
		end
	end
	%fprintf('AC RUNLENGTH|SIZE: %s \tFREQ: %d\n', unique_AC_RUN_SIZE{i}, plist_AC_RUN_SIZE(i));
end
end