   function check_environment()
   %CHECK_ENVIRONMENT Print MATLAB release and toolbox availability.
   %   Run this at the start of a session and copy the output into
   %   docs/environment.md for traceability.

   fprintf('MATLAB release: %s\n', version('-release'));
   fprintf('Platform: %s\n\n', computer);

   installed = ver;
   names = {installed.Name};
   versions = {installed.Version};

   required = {'MATLAB', 'Simulink'};
   optional = {'Simulink Test', 'Simulink Requirements', ...
               'Simulink Design Verifier', 'Simulink Control Design', ...
               'Model Predictive Control Toolbox', 'MATLAB Report Generator'};

   fprintf('--- Required ---\n');
   print_status(required, names, versions);
   fprintf('\n--- Optional ---\n');
   print_status(optional, names, versions);
   end

   function print_status(wanted, names, versions)
   for k = 1:numel(wanted)
       idx = find(strcmp(names, wanted{k}), 1);
       if isempty(idx)
           fprintf('[MISSING] %s\n', wanted{k});
       else
           fprintf('[OK]      %s (v%s)\n', wanted{k}, versions{idx});
       end
   end
   end