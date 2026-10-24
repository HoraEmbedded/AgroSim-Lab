   function p = init_parameters()
   %INIT_PARAMETERS Central parameter set for AgroSim Lab V1.
   %   All values are ILLUSTRATIVE, not field measurements.
   %   Units: depth mm, flux mm/h, water content m^3/m^3, time h.

   p.Zr        = 300;    % mm      effective layer depth
   p.theta0    = 0.25;   % m3/m3   initial water content
   p.theta_sat = 0.45;   % m3/m3   saturation
   p.theta_fc  = 0.30;   % m3/m3   field capacity
   p.theta_w   = 0.12;   % m3/m3   wilting point
   p.theta_ref = 0.30;   % m3/m3   reference level for ET
   p.ET_max    = 0.125;  % mm/h    about 3 mm/day
   p.D_max     = 5;      % mm/h    maximum natural drainage

   % To be defined in the controller mission:
   % p.I_max, p.Dc_max, p.theta_d

   % Sanity checks (fail early with a clear message)
   assert(p.Zr > 0, 'Zr must be positive.');
   assert(0 <= p.theta_w && p.theta_w < p.theta_fc && p.theta_fc < p.theta_sat, ...
       'Order violated: 0 <= theta_w < theta_fc < theta_sat.');
   assert(p.theta_w < p.theta_ref && p.theta_ref <= p.theta_sat, ...
       'Order violated: theta_w < theta_ref <= theta_sat.');
   assert(p.theta0 >= 0 && p.theta0 <= p.theta_sat, ...
       'Initial state must satisfy 0 <= theta0 <= theta_sat.');
   end