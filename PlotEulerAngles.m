function PlotEulerAngles(t,E)

    Titles = {'Roll','Pitch','Yaw'};
    XLabels = 'Time (s)';
    YLabels = {'\phi (\circ)','\theta (\circ)','\psi (\circ)'};
    XLim = [0,ceil(max(t))];
    YLim = [ ...
        -180, 180; ...
         -90,  90; ...
        -180, 180];

    E = E * 180 / pi;
    %{deg}Converts all Euler angles from radians to degrees.

  figure('Color', 'w', 'Name', 'PROJECTILE EULER ANGLES', 'NumberTitle', 'Off', 'OuterPosition', get(0, 'ScreenSize'));

Axes = zeros(1, 3);  % Preallocate Axes
for k = 1:3
    Axes(k) = subplot(3, 1, k, 'FontName', 'Arial', 'FontSize', 8, 'FontWeight', 'Bold', 'NextPlot', 'Add', ...
        'XGrid', 'On', 'YGrid', 'On', 'XLim', XLim, 'YLim', YLim(k, :));
    title(Axes(k), Titles{k}, 'FontSize', 16);
    xlabel(Axes(k), XLabels, 'FontSize', 12);
    ylabel(Axes(k), YLabels{k}, 'FontSize', 12);
end

for k = 1:3
    plot(Axes(k), t, E(k, :), 'Color', 'k', 'LineStyle', 'None', 'Marker', '.');
end

save('EulerAngles.mat', 't', 'E');  % Save Euler angles

end