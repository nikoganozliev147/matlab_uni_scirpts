%3

 %3.1
SID = [1, 1, 6, 4, 0, 8, 5, 1];
A = sum(SID);
B = A / 5;
T_1 = mean(SID) / 10;
T_2 = T_1 / 5;
phi_1 = sum(SID) * pi / 180;
phi_2 = pi;
y_1 = zeros;
y_2 = zeros;
y = zeros;
i = 0;
time_vector = zeros;

for t = 0 : 0.006 : 3 * T_1
    i = i + 1;
    time_vector(i) = t;
    y_1(i) = A * sin( (2 * pi) / T_1 * t - phi_1);
    y_2(i) = B * cos( (2 * pi) / T_2 * t - phi_2);
    y(i) = y_1(i) - y_2(i);
end

figure
hold on
plot(time_vector, y_1, "DisplayName", "y_1")
plot(time_vector, y_2, "DisplayName", "y_2")
plot(time_vector, y, "DisplayName", "y")
xlabel("Time [s]")
ylabel("Displacement [m]")
title("y1/y2/y vs Time")
legend
hold off


 %3.2
c = zeros;
for m = 1 : length(y)
    if y(m) > 0 && y_1(m) > 0 && y_2(m) > 0
        c(m) = max(y);
    elseif y(m) < 0 && y_1(m) < 0 && y_2(m) < 0
        c(m) = min(y);
    else
        c(m) = 0;
    end
end

figure
plot(time_vector, c, "DisplayName", "c")
title("c vs Time")
xlabel("Time [s]")
ylabel("c")
legend