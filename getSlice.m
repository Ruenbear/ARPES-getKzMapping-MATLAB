function OUT = getSlice(MAP,direct,num,total)
%输出为标准的CUT格式
%不作归一化
%direct 0=energy,1=theta_x,2=theta_y
%total指向上求和取平均
if nargin == 3
    total = 1;
end
% sszz = size(MAP.map);
% MAP.ini.width = sszz(1);
% MAP.ini.height = sszz(2);
% MAP.ini.depth = sszz(3);
OUT.cut = getSliceOld(MAP.map,direct,num,total);
switch direct
    case 0
        OUT.xxl = MAP.kxl;
        OUT.yyl = MAP.kyl;
    case 1
        OUT.xxl = MAP.kyl;
        OUT.yyl = MAP.eel;
    case 2
        OUT.xxl = MAP.kxl;
        OUT.yyl = MAP.eel;
end

end


function slice = getSliceOld(MAP,sliceDirection,sliceNum,total)
%sliceDirection 0=energy,1=theta_x,2=theta_y
sm = size(MAP);
enum = min(sliceNum+total,sm(sliceDirection+1));

width = sm(1);
height = sm(2);
depth = sm(3);

switch sliceDirection
    case 0
        temp = mean(MAP(sliceNum:enum,:,:),1);
        slice = reshape(temp,height,depth);
        slice = slice'; %让kx落在x轴
    case 1
        slice = reshape(MAP(:,sliceNum,:),width,depth);
    case 2
        slice = reshape(MAP(:,:,sliceNum),width,height);
    otherwise
        slice = reshape(MAP(sliceNum,:,:),height,depth);
end
end
