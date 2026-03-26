# DynamicLanduse_SWAT_Borracho

This repository describes the work in Nervi, E., Alonso, J., Baethgen, W., & Vervoort, R. W. (2026). A modelling framework to support decisions on impacts of forestry on water quantity [Manuscript submitted for publication].

1. Provides the input data and results of the workflow used to (1) generate spatially explicit transition maps of forestry change across the Tacuarembó River Catchment (TRC) and (2) implement dynamic land-use and staggered plantations in SWAT through automated modification of HRU management files (.mgt).
<img src="Figure_5_Sup_w.png" alt="Strategy description" width="500">

2. The GEE codes used to
   a.Find polygons in MAPBIOMAS that are classified as forest (silvopastoral) and pasture from 2003 o 2024 -
   b. Exports polygon-mean and centroid-pixel MODIS signal and match patchid with Subbasin location number

The code of this repository was originally developed by myself and using the assistance of ChatGPT (OpenAI) for code structuring, cleaning and debugging.
