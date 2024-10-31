function textCell = readTextIntoCell(ffname)

fid=fopen(ffname);       %首先打开文本文件coordinate.txt
temp = {};
mc = 1;
while ~feof(fid)    % while循环表示文件指针没到达末尾，则继续
    % 每次读取一行, str是字符串格式
    str = fgetl(fid);     
    temp{mc} = str;
    mc = mc + 1;
end
fclose(fid);
textCell = temp;

end
