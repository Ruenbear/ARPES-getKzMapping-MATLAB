function MAP = getKxKzMapping(inp)
    MAP = getThetaKinMapping(inp);

    sz = size(MAP.map);
    n_ene = sz(1);
    n_kx = round(2*sz(2));
    n_kz = round(2*sz(3));
    kz_low = kkz(MAP.kxl,MAP.kyl(1),inp.v0);
    kz_high = kkz(MAP.kxl,MAP.kyl(end),inp.v0);
    kx_high = kkx(MAP.kxl,MAP.kyl(end));


    kx_min = min(kx_high);
    kx_max = max(kx_high);
    kz_min = min(kz_low);
    kz_max = max(kz_high);

    nmap = zeros(n_ene,n_kx,n_kz);

    eel = MAP.eel;
    kxl = linspace(kx_min,kx_max,n_kx);
    kzl = linspace(kz_min,kz_max,n_kz);


    sm = size(MAP.map);

    [kxg,kzg] = meshgrid(kxl,kzl);
    [xg,yg] = backToRaw(kxg,kzg,inp.v0);
    %[xg,yg] = meshgrid(xx,yy);

    [raw_xg,raw_yg] = meshgrid(MAP.kxl,MAP.kyl);
    for ll = 1:n_ene
        gg = reshape(MAP.map(ll,:,:),sm(2),sm(3))';
        ggg = interp2(raw_xg,raw_yg,gg,xg,yg);
        nmap(ll,:,:) = reshape(ggg',1,n_kx,n_kz);
    end

    MAP.map = nmap;
    MAP.eel = eel;
    MAP.kxl = kxl;
    MAP.kyl = kzl;
    MAP.ini = '';


    function r = kkz(theta,kin,v0)
        r = 0.512*sqrt(kin*cos(theta/180*pi).^2+v0);
    end

    function r = kkx(theta,kin)
        r = 0.512*sqrt(kin)*sin(theta/180*pi);
    end

    function [theta,kin] = backToRaw(kx,kz,v0)
        kin = (kx/0.512).^2+(kz/0.512).^2-v0;
        theta = asin(kx/0.512./sqrt(kin))/pi*180;
    end


end