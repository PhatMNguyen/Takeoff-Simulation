function PlotMass(t,m,C)
    m = m - C.AC.me;
    %set X-Y limits
    XLim = [0,ceil(max(t))];
    YLim = [floor(min(m))-20,ceil(max(m))];


   figure('Color', 'w', 'Name', 'PROJECTILE ALTITUDE ABOVE MEAN EQUATOR', 'OuterPosition', get(0, 'ScreenSize'));

    Axes = axes( 'FontSize',10,'FontWeight','Bold','XLim',XLim, 'YLim',YLim','nextplot', 'Add');
    % 'NextPlot','Add' to plot the next plot on same Axes, instead of being replaced
    title('Aircraft Fuel Mass During Takeoff', 'FontSize', 16, 'Parent', Axes); %Add title
    xlabel('Time (s)', 'FontSize', 12, 'Parent', Axes); %Add X-axis label
    ylabel('Mass (Kg)', 'FontSize', 12, 'Parent', Axes); %Add Y-axis label
    
    plot(t,m,'Color','k','Marker','.','Parent',Axes) %plot Altitude 
    grid on
end