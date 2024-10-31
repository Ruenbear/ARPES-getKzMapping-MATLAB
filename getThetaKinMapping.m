function MAP = getThetaKinMapping(inp)
    name = inp.name;
    num_arr = inp.num;
    ene_arr = inp.ene; %eV,能量递增方向
    workfcn = inp.workfcn;
    %v0 = inp.v0;

    %kin_arr = ene_arr-workfcn;

    fname = replace(name,'__',num2str(num_arr(1)));
    CUT = readCutText(fname);
    MAP.kyl = ene_arr-workfcn;%kin
    MAP.kxl = CUT.xxl;%theta
    MAP.eel = CUT.yyl-ene_arr(1)+workfcn;%ene
    map = zeros(length(MAP.eel),length(MAP.kxl), ...
        length(MAP.kyl));

    for j = 1:length(num_arr)
        num = num_arr(j);
        fname = replace(name,'__',num2str(num));
        CUT = readCutText(fname);
        cut = CUT.cut;
        mm = mean(max(cut));
        MM = max(max(cut));
        cc = 0.6*mm + 0.4*MM;
        map(:,:,j)  = cut/cc;
        %sz = size(CUT.cut);
    end
    MAP.map = map/max(mean(max(map)));
    MAP.ini = '';
end
