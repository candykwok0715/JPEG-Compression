function str = convertLogicToStr(log)
    str='';
    for i=1:length(log)
      if (log(i))
          str = strcat(str,'1');
      else
          str = strcat(str,'0');
      end
    end
end