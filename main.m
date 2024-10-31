clc;clear;
inp.name = 'data\CS00100__.txt';
inp.num = 43:1:52;
inp.ene = (24:1:33); %eV,能量递增方向
inp.workfcn = 4.1;
inp.v0 = 15.43;

MAP = getKxKzMapping(inp);
save("nmap.mat",'MAP')




