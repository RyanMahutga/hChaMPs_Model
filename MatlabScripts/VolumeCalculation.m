% calculate volume

% close all
clear all
clc

cont_mag = 25.0; % contraction magnitude in kPa

surf_nodes1 = load('RV_coarse.txt'); % RV inner surface node #s
surf_nodes2 = load('LV_coarse.txt'); % LV inner surface node #s

nodes = load('nodes_half_coarse_inner.txt'); % all node coordinates at each time step
time = load('time_half_coarse_inner.txt'); % time steps

contraction = cont_mag.*time';

for k =2:(size(nodes,2)-1)/3+1

coords1(:,1) = nodes(surf_nodes1,3*k-4);
coords1(:,2) = nodes(surf_nodes1,3*k-3);
coords1(:,3) = nodes(surf_nodes1,3*k-2);
coords2(:,1) = nodes(surf_nodes2,3*k-4);
coords2(:,2) = nodes(surf_nodes2,3*k-3);
coords2(:,3) = nodes(surf_nodes2,3*k-2);

h1=tetramesh(surf_nodes1,nodes);
h2=tetramesh(surf_nodes2,nodes);

[~, RV_V(k-1)] = convhull(coords1(:,1),coords1(:,2),coords1(:,3));
[~, LV_V(k-1)] = convhull(coords2(:,1),coords2(:,2),coords2(:,3));

end

V = RV_V+LV_V;

% figure
% trisurf(TriIdx, coords(:,1),coords(:,2),coords(:,3));
% axis square

LSV=LV_V(1)-LV_V;
RSV=RV_V(1)-RV_V;
SV = (V(1)-V);
EF = SV./V(1);
EF_LV = (LSV)/LV_V(1);
EF_RV = (RSV)/RV_V(1);

figure
plot(contraction,RV_V,'r-','LineWidth',2)
hold on
plot(contraction,LV_V,'b-','LineWidth',2)
plot(contraction,V,'k-','LineWidth',2)
xlabel('Contraction, [kPa]')
ylabel('Volume, \muL')
legend('RV','LV','Total')
set(gca,'FontSize',16)

figure
plot(contraction,RSV,'r-','LineWidth',2)
hold on
plot(contraction,LSV,'b-','LineWidth',2)
plot(contraction,SV,'k-','LineWidth',2)
xlabel('Contraction, [kPa]')
ylabel('Stroke Volume, \muL')
legend('RV','LV','Total')
set(gca,'FontSize',16)

figure
plot(contraction,EF_RV,'r-','LineWidth',2)
hold on
plot(contraction,EF_LV,'b-','LineWidth',2)
plot(contraction,EF,'k-','LineWidth',2)
xlabel('Contraction, [kPa]')
ylabel('Ejection Fraction')
legend('RV','LV','Total')
set(gca,'FontSize',16)

