% creating material axes for 2 part models using flux vectors from FEBio
close all
clear all
clc

data1 = load('Flux_Radial3'); % radial flux vector
data2 = load('Flux_Axial3'); % axial flux vector

load('Part1_3Int.mat'); % part1
load('Part2_3Int.mat'); % part 2
m=1; n=1;
for k = 1:length(data1)
   
    vectRad(k,:) = data1(k,8:10)./norm(data1(k,8:10));
    vectAx(k,:) = data2(k,8:10)./norm(data2(k,8:10));
    
    
    if ismember(k,idx_P1)
    str1{m} = strcat('<elem lid="',num2str(m),'"> NL',...
        '<a>',num2str(vectRad(k,1)),', ',num2str(vectRad(k,2)),', ',num2str(vectRad(k,3)),'</a> NL',...
        '<d>',num2str(vectAx(k,1)),', ',num2str(vectAx(k,2)),', ',num2str(vectAx(k,3)),'</d> NL',...
        '</elem>');
    m=m+1;
    else
        str2{n} = strcat('<elem lid="',num2str(n),'"> NL',...
        '<a>',num2str(vectRad(k,1)),', ',num2str(vectRad(k,2)),', ',num2str(vectRad(k,3)),'</a> NL',...
        '<d>',num2str(vectAx(k,1)),', ',num2str(vectAx(k,2)),', ',num2str(vectAx(k,3)),'</d> NL',...
        '</elem>');
    n=n+1;
    end
end

fid = fopen('matAxesP1_3.txt', 'wt');
fprintf(fid, '%s\n', str1{:});
fclose(fid);

fid = fopen('matAxesP2_3.txt', 'wt');
fprintf(fid, '%s\n', str2{:});
fclose(fid);