function plist_DC_SIZE = getListOfDCsize(DC_SIZE,unique_DC_SIZE)
% Count the occurrences of each distinct SIZE value in DC_SIZE cell
plist_DC_SIZE = zeros(1, length(unique_DC_SIZE));
for i=1:length(unique_DC_SIZE)
	for j=1:length(DC_SIZE)
		if strcmp(DC_SIZE{j}, unique_DC_SIZE{i})
			plist_DC_SIZE(i) = plist_DC_SIZE(i) + 1;
		end
	end
	%fprintf('DC SIZE: %s \tFREQ: %d\n', unique_DC_SIZE{i}, plist_DC_SIZE(i));
end
end