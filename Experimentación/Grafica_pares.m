function Grafica_pares(X1, YMatrix1)
%CREATEFIGURE(X1, YMatrix1)
%  X1:  vector of x data
%  YMATRIX1:  matrix of y data

%  Auto-generated by MATLAB on 23-Jan-2019 14:05:04

% Create figure
figure1 = figure;

% Create axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');

% Create multiple lines using matrix input to plot
plot1 = plot(X1,YMatrix1,'LineWidth',2);
set(plot1(1),'DisplayName','Par motor 1',...
    'Color',[0.450980395078659 0.26274511218071 0.26274511218071]);
set(plot1(2),'DisplayName','Par motor 2','Color',[1 0.843137264251709 0]);

% Create ylabel
ylabel('Intensidad (A)');

% Create xlabel
xlabel('Tiempo (s)');

% Create title
title('Intensidad aplicada en los actuadores');

box(axes1,'on');
grid(axes1,'on');
% Set the remaining axes properties
set(axes1,'FontSize',18);
% Create legend
legend(axes1,'show');

