% finding boundary elements
close all
clear all
clc

surf_nodes = load('surfNodes3');

elems = load('elem_list3'); % list of elements
   
elem_nums = zeros(length(elems),1);

for k=1:length(surf_nodes)
    for n=1:5
        [row_idx,col_idx] = find(elems==surf_nodes(k,n));
        elem_nums(row_idx)=1;
    end
end
    
idx_P1 = find(elem_nums);
    Part1=elems(idx_P1,:);
    idx_P2 = find(~elem_nums);
    Part2=elems(idx_P2,:);
    
    save(idx_P1,'Part1.mat')
    save(idx_P2,'Part2.mat')