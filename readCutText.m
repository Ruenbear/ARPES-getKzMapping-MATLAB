function CUT = readCutText(fname)
LINES = readTextIntoCell(fname);
for j = 1:length(LINES)
    str = LINES{j};
    if contains(str,'Dimension 1 scale=')
        yyl = replace(str,'Dimension 1 scale=','');
        yyl = str2num(yyl);
    end
    if contains(str,'Dimension 2 scale=')
        xxl = replace(str,'Dimension 2 scale=','');
        xxl = str2num(xxl);
    end
    if contains(str,'[Data 1]')
        break;
    end
end
cut = zeros(length(yyl),length(xxl));
for l = j+1:j+length(yyl)
    temp = str2num(LINES{l});
    cut(l-j,:) = temp(2:end); 
end
CUT.yyl = yyl;
CUT.xxl = xxl;
CUT.cut = cut;
end

