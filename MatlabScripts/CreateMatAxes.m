% creating material axes for 1 part models using flux vectors from FEBio
close all
clear all
clc

data1 = load('Flux_Radial3'); % radial flux data
data2 = load('Flux_Axial3'); % axial flux data

for k = 1:length(data1)
   
    vectRad(k,:) = data1(k,8:10)./norm(data1(k,8:10));
    vectAx(k,:) = data2(k,8:10)./norm(data2(k,8:10));
    
    
    str1{k} = strcat('<elem lid="',num2str(k),'"> NL',...
        '<a>',num2str(vectRad(k,1)),', ',num2str(vectRad(k,2)),', ',num2str(vectRad(k,3)),'</a> NL',...
        '<d>',num2str(vectAx(k,1)),', ',num2str(vectAx(k,2)),', ',num2str(vectAx(k,3)),'</d> NL',...
        '</elem>');
end

fid = fopen('matAxes3.txt', 'wt');
fprintf(fid, '%s\n', str1{:});
fclose(fid);
