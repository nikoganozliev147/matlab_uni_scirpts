%1
 
 %1.1
fileID = fopen('velocity.txt', 'r');
formatSpec = '%f';
noisy_velocity_vector = transpose(fscanf(fileID,formatSpec));
fclose(fileID);

 %1.2
deltaTime = 0.5;
delta_noisy_velocity_vector = zeros;
for i = 2 : length(noisy_velocity_vector) 
    delta_noisy_velocity_vector(i) = noisy_velocity_vector(i) - noisy_velocity_vector(i-1);
end
noisy_acceleration_vector = delta_noisy_velocity_vector / deltaTime;

 %1.3 
time_vector = 0 : deltaTime : (length(noisy_velocity_vector) - 1) / 2;

figure
plot(time_vector,noisy_velocity_vector, "o-")
title("Noisy Velocity vs Time")
xlabel("Time [s]")
ylabel("Velocity [km/h]")

figure
plot(time_vector, noisy_acceleration_vector, "o-")
title("Noisy Acceleration vs Time")
xlabel("Time [s]")
ylabel("Acceleration [(km/h)/s]")

%2

 %2.1
for m = 1 : 2
    p = polyfit(time_vector, noisy_velocity_vector, m * 2);
    smooth_velocity_matrix(m, :) = polyval(p, time_vector);
end
 
 %2.2
delta_smooth_velocity_matrix = zeros;
for i = 2 : length(smooth_velocity_matrix(1, :))
    delta_smooth_velocity_matrix(1, i) = smooth_velocity_matrix(1, i) - smooth_velocity_matrix(1, i - 1);
    delta_smooth_velocity_matrix(2, i) = smooth_velocity_matrix(2, i) - smooth_velocity_matrix(2, i - 1);
end
smooth_acceleration_matrix = delta_smooth_velocity_matrix / deltaTime;

 %2.3
figure
hold on
plot(time_vector,noisy_velocity_vector, "o", "DisplayName", "Noisy Velocity")
plot(time_vector, smooth_velocity_matrix(1, :), "DisplayName", "Smooth Velocity (2nd Order Polynomial)")
plot(time_vector, smooth_velocity_matrix(2, :), "DisplayName", "Smooth Velocity (4th Order Polynomial)")
xlabel("Time [s]")
ylabel("Velocity [km/h]")
title("Noisy Velocity vs Smooth Velocity")
legend()
hold off

figure
hold on
plot(time_vector, noisy_acceleration_vector, "o", "DisplayName", "Noisy Acceleration")
plot(time_vector, smooth_acceleration_matrix(1, :), "DisplayName", "Smooth Acceleration (2nd Order Polynomial)")
plot(time_vector, smooth_acceleration_matrix(2, :), "DisplayName", "Smooth Acceleration (4th Order Polynomial)")
xlabel("Time [s]")
ylabel("Acceleration [(km/h)/s]")
title("Noisy Acceleration vs Smooth Acceleration")
legend()
hold off
