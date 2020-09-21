%
%% LICENSE
% Copyright (C) 2020  Philip Calado, Ilario Gelmetti, and Piers R. F. Barnes
% Imperial College London
% This program is free software: you can redistribute it and/or modify
% it under the terms of the GNU Affero General Public License as published
% by the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
% 
%% Start code
% Initialise the system
initialise_df
clear all
close all
% Create a parameters object for the PEC device by including a filepath to the 
% appropriate .csv as the arugment to the parameters class PC
par = pc('Input_files/PEC_device_2.csv');

% Find the equilibrium solutions
soleq = equilibrate(par);
%% Plot the equilibrium energy level diagram and electrostatic potential
dfplot.ELx(soleq.ion)
hold on
dfplot.Vx(soleq.ion)
hold off

%% Perform dark and light current-voltage scan at 50 mVs-1 from 0 V to 1.2 V
% Input arguments: 
% sol_CV = doCV(sol_ini, light_intensity, V0, Vmax, Vmin, scan_rate, cycles, tpoints)
CVsol_dk = doCV(soleq.ion, 0, -0.5, -0.2, -0.8, 0.01, 2, 400);
CVsol_1sun = doCV(soleq.ion, 1, -0.5, -0.2, -0.8, 0.01, 2, 400);

%% Plot the current voltage curve
dfplot.JtotVapp(CVsol_dk, 0)
hold on
dfplot.JtotVapp(CVsol_1sun, 0)
ylim([-6e-2, 5e-2])
hold off
% Save the workspace- this is commented out as the filepath should lead to
% a folder on your computer. It is not recommended to store large files in
% the Github repository as they will be cached even when deleted leading to
% a large folder sizes. This filepath may need to be altered for Windows-
% based systems
save('~/MATLAB_Data/temp.mat')
