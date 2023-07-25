% Find this at 
enicskb/wiki/index.php/Matlab_-_Making_Article-Quality_Plots

% Get your aspect ratio, font sizes, and line widths set 
% to look right on a 2-column IEEE template.
% -------------------------------------------------------
plotsPath='where/to/save/my/plot/'
fontSize = 12;
figurePosition=[0 0 513 404];
axisPosition=[0.12 0.110 0.85 0.85];   
lineWidth=1;
xLabel='My X Label [UNITS]';
yLabel='My Y Label [UNITS]';
outfilename=strcat([plotsPath 'my_plot_name.pdf']);
    
fig=figure();
set(gcf,'Position',figurePosition);
set(gca,'Position',axisPosition)
set(gca,'GridLineStyle','-')
set(gca,'MinorGridLineStyle','-')
set(gca, 'FontSize',fontSize)
set(fig,'Units','Inches');
pos = get(fig,'Position');
set(gca,'GridLineStyle',':')
set(fig,'PaperPositionMode','Auto','PaperUnits',
         'Inches','PaperSize',[pos(3), pos(4)])

% Now plot the graph
% ------------------
h=plot(xVector,yVector,'LineWidth',lineWidth);
ylabel(yLabel, 'FontSize', fontSize,'FontWeight','bold');
xlabel(xLabel, 'FontSize', fontSize,'FontWeight','bold');
grid on
set(gca,'GridLineStyle',':')

% To add a legend when you have a few plots:
% ------------------------------------------
plot1=plot(xVector,yVector1,'LineWidth',lineWidth,
      'LineStyle','--','DisplayName','First Plot');
plot2=plot(xVector,yVector1,'LineWidth',lineWidth,
        'DisplayName','Second Plot');
legendVector = [plot1 plot2];
legend(legendVector, 'Location','NW')

% Exporting your figure to a PDF file
% -----------------------------------
print(fig, '-painters', '-dpdf', '-r0',outfilename);
