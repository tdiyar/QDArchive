
Aircraft profiles of stable isotope ratios in atmospheric total and condensed water 
from the NASA ORACLES mission.

version1.0, (9 February 2022)


Contact
-------
Dean Henze <henzede@oregonstate.edu>
David Noone <david.noone@auckland.ac.nz>


Synopsis
--------

Stable isotope ratios of total water and cloud water in the troposphere from the NASA 
ORACLES campaigns in the south east Atlantic during Sept. 2016, Aug. 2017 and Oct. 2018. The 
ORACLES campaigns are described by Redemann et al., (2021). Further details on the water 
isotope measurements are described in Henze et al., (2021).

Aircraft in-situ data were obtained from cavity enhanced laser absorption spectroscopic 
analyzers. These data are processed into mean latitude-altitude curtains and individual 
vertical profiles for each sampling period. 



Citation
--------
Please site: Henze et al., 2021.

Henze, D., Noone, D., and Toohey, D.: Aircraft measurements of water vapor heavy isotope 
ratios in the marine boundary layer and lower troposphere during ORACLES, Earth Syst. 
Sci. Data Discuss. [preprint], https://doi.org/10.5194/essd-2021-238, in review, 2021.

(Or final in print version)


Funding
-------
National Science Foundation. 
Climate and Large-scale Dynamics, 
Physical and Dynamical Meteorology, 
and Atmospheric Chemistry.

"The Impact of Fire on Entrainment and Precipitation Efficiency Derived from Isotope Ratios"
Grant number 1564670
https://www.nsf.gov/awardsearch/showAward?AWD_ID=1564670


Description
-----------

Aircraft in-situ measurements of water concentration and heavy water isotope ratios D/H and 
18O/16O were collected during the NASA ObseRvations of Aerosols above CLouds and their 
intEractionS (ORACLES) project. Aircraft sampling took place in the southeast Atlantic marine 
boundary layer and lower troposphere (equator to 22 degrees south) over the months of 
Sept. 2016, Aug. 2017, and Oct. 2018. Isotope measurements were made using cavity 
ring-down spectroscopic analyzers integrated into the Water Isotope System for 
Precipitation and Entrainment Research (WISPER). The WISPER data are processed into mean 
latitude-altitude curtains and individual vertical profiles for each sampling period. 

The WISPER data accompanied a suite of other variables including standard meteorological 
quantities (wind, temperature, moisture), trace gas and aerosol concentrations, radar, 
and lidar remote sensing, which can be accessed through the DOIs listed further down. 
The ORACLES campaigns are described by Redemann et al., (2021). The water isotope 
measurements are further described in Henze et al., (2021). The absolute error with 
respect to the SMOW-SLAP scale is explained in detail by Henze et al., (2021).

Total water concentration and isotope ratios were binned and averaged onto 
latitude-altitude grids using a kernel estimation approach, with weighting designed 
to estimate the mean during the approximate month-long duration of each sampling period. 
Standard deviations for each bin are also computed using kernel density estimation. 

Time intervals during aircraft vertical profiling are isolated and averaged onto 50-meter 
vertical levels. The files include water concentration and isotope ratios for both total 
water and cloud water in addition to temperature, pressure, latitude, and longitude.



Latitude-altitude curtains
--------------------------
Total water concentration and isotope ratios were binned and averaged onto latitude-altitude 
grids using a kernel estimation approach, with weighting designed to estimate the 
mean during the approximate month-long duration of each sampling period.

File contents:

	dimensions: 
		lat = latitude, degrees north; 
		alt = altitude, meters;
	variables:
		q(lat, alt) = Total water mixing ratio, g/kg;
		dD(lat, alt) = Total water D/H expressed in delta-notation, permil;
		d18O(lat, alt) = Total water 18O/16O expressed in delta-notation, permil;
		dxs(lat, alt) = Total water deuterium excess, delta-notation, permil;
		sig_q(lat, alt) = Standard deviation in q for each bin, g/kg; 
		sig_dD(lat, alt) = Standard deviation in dD for each bin, permil;
		sig_d18O(lat, alt) = Standard deviation in d18O for each bin, permil;
		sig_dxs(lat, alt) = Standard deviation in dxs for each bin, permil;
		n_obs(lat, lat) = Weighted number of observations for each bin;


Vertical profiles
-----------------
Time intervals during aircraft vertical profiling are isolated and averaged into 50 meter 
vertical bins. The files include water concentration and isotope ratios for both total 
water and cloud water.

File contents:

	dimensions: 
		profile = integer profile number for the sampling period;
		alt = altitude, meters;
	variables:
		q(profile, alt) = Total water mixing ratio, g/kg;
		dD(profile, alt) = Total water D/H ratio, expressed in delta-notation, permil;
		d18O(profile, alt) = Total water 18O/16O ratio, expressed in delta-notation, permil; 
		dxs(profile, alt) = Total water deuterium excess, in delta-notation, permil;
		P(profile, alt) = Static air pressure, hPa; 
		T(profile, alt) = Static air temperature, K;
		lat(profile, alt) = Latitude, degrees north;
		lon(profile, alt) = Longitude, degrees east;
		date(profile) = Sampling UTC date, "yyyymmdd"; 
		t_start(profile) = Start time of profile, seconds since UTC midnight;
		t_end(profile) = End time of profile, seconds since UTC midnight;
		asc_desc_flag(profile) = Flag value for whether the aircraft was ascending vs. 
                	descending during the profile. 1 = ascending, 0 = descending;  

Uncertainties
-------------
The absolute error with respect to the SMOW-SLAP scale is explained in detail by 
Henze et al., (2021).


References
----------

Henze, D., Noone, D., and Toohey, D.: Aircraft measurements of water vapor heavy isotope 
ratios in the marine boundary layer and lower troposphere during ORACLES, Earth Syst. 
Sci. Data Discuss. [preprint], https://doi.org/10.5194/essd-2021-238, in review, 2021.

Redemann, J., Wood, R., Zuidema, P., Doherty, S. J., Luna, B., LeBlanc, S. E., Diamond, M. S., 
Shinozuka, Y., Chang, I. Y., Ueyama, R., Pfister, L., Ryoo, J.-M., Dobracki, A. N., da Silva, 
A. M., Longo, K. M., Kacenelenbogen, M. S., Flynn, C. J., Pistone, K., Knox, N. M., Piketh, 
S. J., Haywood, J. M., Formenti, P., Mallet, M., Stier, P., Ackerman, A. S., Bauer, S. E., 
Fridlind, A. M., Carmichael, G. R., Saide, P. E., Ferrada, G. A., Howell, S. G., Freitag, S., 
Cairns, B., Holben, B. N., Knobelspiesse, K. D., Tanelli, S., L'Ecuyer, T. S., Dzambo, A. M., 
Sy, O. O., McFarquhar, G. M., Poellot, M. R., Gupta, S., O'Brien, J. R., Nenes, A., Kacarab, 
M., Wong, J. P. S., Small-Griswold, J. D., Thornhill, K. L., Noone, D., Podolske, J. R., 
Schmidt, K. S., Pilewskie, P., Chen, H., Cochrane, S. P., Sedlacek, A. J., Lang, T. J., 
Stith, E., Segal-Rozenhaimer, M., Ferrare, R. A., Burton, S. P., Hostetler, C. A., Diner, D. J., 
Seidel, F. C., Platnick, S. E., Myers, J. S., Meyer, K. G., Spangenberg, D. A., Maring, H., 
and Gao, L.: An overview of the ORACLES (ObseRvations of Aerosols above CLouds and their 
intEractionS) project: aerosol–cloud–radiation interactions in the southeast Atlantic basin, 
Atmos. Chem. Phys., 21, 1507–1563, https://doi.org/10.5194/acp-21-1507-2021, 2021.

The complete archive of ORACLES data are accessible via the digital object identifiers 
(DOIs) provided under ORACLES Science Team references as follows:

ORACLES Science Team: Suite of Aerosol, Cloud, and Related Data Acquired Aboard P3 During 
ORACLES 2018, Version 2, NASA Ames Earth Science Project Office, 
https://doi.org/10.5067/Suborbital/ORACLES/P3/2018_V2, 2020a. 

ORACLES Science Team: Suite of Aerosol, Cloud, and Related Data Acquired Aboard P3 During 
ORACLES 2017, Version 2, NASA Ames Earth Science Project Office, 
https://doi.org/10.5067/Suborbital/ORACLES/P3/2017_V2, 2020b. 

ORACLES Science Team: Suite of Aerosol, Cloud, and Related Data Acquired Aboard P3 During 
ORACLES 2016, Version 2, NASA Ames Earth Science Project Office, 
https://doi.org/10.5067/Suborbital/ORACLES/P3/2016_V2, 2020c. 

ORACLES Science Team: Suite of Aerosol, Cloud, and Related Data Acquired Aboard ER2 During 
RACLES 2016, Version 2, NASA Ames Earth Science Project Office, 
https://doi.org/10.5067/Suborbital/ORACLES/ER2/2016_V2, 2020d. 


------------
End of file
