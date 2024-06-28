function PlotAcceleration(t,S,C)
Titles = {'X Acceleration','Y Acceleration','Z Acceleration','Total Acceleration'};
XLabel = 'Time (s)';
YLabels = {'a_x ','a_y (g''s)','a_z ','a '};

% Number of time points
n = numel(t);
% Preallocate arrays for acceleration vectors
A = zeros(3, n);
a = zeros(1, n);

% Calculate inertial accelerations and magnitudes
for k = 1:n
    % Position and velocity relative to ground station
    Rcggs = S(1:3,k);
    Vcggs = S(4:6,k);
    E = S(10:12,k);

    % Calculate non-inertial acceleration
    dSdt = TakeOffEom(t(k), S(:,k), C);
    Acggs = dSdt(4:6);

    % Calculate inertial acceleration relative to Earth
    A(:,k) = C.GS.Agse + cross(C.GS.We, cross(C.GS.We, Rcggs)) + 2 * cross(C.GS.We, Vcggs) + Acggs;
    Rcge = C.GS.Rgse + Rcggs;

    % Transform acceleration to local horizontal coordinates
    NedToBody = Ned2Body(Rcge, E, C);
    A(:,k) = NedToBody * A(:,k) / C.E.g;
    % Calculate acceleration magnitude
    a(k) = norm(A(:,k));
end

% Set axis limits and ticks
XLim = [0, ceil(max(t))];
YLim = [floor(min(A,[],2)), ceil(max(A,[],2)); floor(min(a)), ceil(max(a))];
XTicks = linspace(XLim(1), XLim(2), 11);
YTicks = {linspace(YLim(1,1), YLim(1,2), 11); linspace(YLim(2,1), YLim(2,2), 11); ...
          linspace(YLim(3,1), YLim(3,2), 11); linspace(YLim(4,1), YLim(4,2), 11)};

figure('Color', 'w', 'Name', 'PROJECTILE INERTIAL ACCELERATION IN BODY COORDINATES', ...
    'NumberTitle', 'Off', 'OuterPosition', get(0, 'ScreenSize'));

% Create subplots
Axes = zeros(1, 4);
for k = 1:4
    Axes(k) = subplot(2, 2, k, 'FontName', 'Arial', 'FontSize', 8, 'FontWeight', 'Bold', 'NextPlot', 'Add', ...
        'XGrid', 'On', 'YGrid', 'On', 'XLim', XLim, 'YLim', YLim(k, :), 'XTick', XTicks, 'YTick', YTicks{k});
    title(Titles{k}, 'FontSize', 15);
    xlabel(XLabel, 'FontSize', 12);
    ylabel(YLabels{k}, 'FontSize', 12);
end

% Plot data on subplots
for k = 1:3
    plot(Axes(k), t, A(k, :), '.', 'Color', 'k');
end
plot(Axes(4), t, a, '.', 'Color', 'k');

end
