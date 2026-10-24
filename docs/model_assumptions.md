   # Model Assumptions

   Status: initial version, to be updated at each milestone.

   ## Physical assumptions (V1)
   1. The soil is a single homogeneous layer of effective depth Zr.
   2. The only state is the volumetric water content theta (m3/m3), assumed uniform in the layer.
   3. All rainfall infiltrates (Pe = P) and runoff is zero (R = 0).
   4. Evapotranspiration and natural drainage are simple saturating laws, for teaching purposes.
   5. Controlled drainage is an abstraction of an evacuation capacity. It does not protect against river flooding.

   ## Parameter policy
   All parameters are illustrative and centralised in matlab/init_parameters.m with their units. They must never be presented as measurements of Ze or Adjohoun.

   ## Units
   Depth in mm, flux in mm/h, water content in m3/m3, time in h.

   ## Known limitations
   - No spatial or vertical variation.
   - No calibration against field data.
   - No weather forecast.