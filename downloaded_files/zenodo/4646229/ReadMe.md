================================================================================

**Title:** Rapid accretion state transitions following the tidal disruption 
    event AT2018fyk

**Authors:** Wevers T., Pasham D.R., van Velzen S., Miller-Jones J.C., 
    Uttley P., Gendreau K.C., Remillard R., Arzoumanian Z., Lowenstein M., 
    Chiti A.

================================================================================

**Description of contents:** This deposit contains the data related to
    Figures 2, 3, 4, 6, 7 and 11 in the accepted version of the manuscript
    listed above. It includes complimentary files.



**System requirements:** 
The files are provided in plain text formats with the following file names
    and delimiters:

	AT2018fyk_RT.dat                       Tab-delimited, w/header 
	AT2018fyk_UVOTlc.dat                   Space-delimited fixed-width, w/header
	AT2018fyk_binned_UVOTlc.dat            Space-delimited fixed-width, w/header
	UVW1_lightcurve_alphaox.dat            Space-delimited fixed-width, no header
	XMM_lc_0831790201_1500_10000_200.dat   Tab-delimited, w/header 
	XMM_lc_0831790201_300_10000_200.dat    Tab-delimited, w/header 
	XMM_lc_0831790201_300_1500_200.dat     Tab-delimited, w/header 
	XMM_lc_0853980201_1500_10000_200.dat   Tab-delimited, w/header 
	XMM_lc_0853980201_300_10000_200.dat    Tab-delimited, w/header 
	XMM_lc_0853980201_300_1500_200.dat     Tab-delimited, w/header 
	XRT_lightcurve.dat                     Tab-delimited, w/header 
	XRT_lightcurve_150_1000.dat            Tab-delimited, no header 
	XRT_lightcurve_30_150.dat              Tab-delimited, no header 
	XRT_lightcurve_alphaox.dat             Tab-delimited, w/header 
	alphaox_fedd_lightcurve.dat            Comma-delimited, w/header
	plfrac_40_200.dat                      Tab-delimited, w/header 
	plfrac_bol.dat                         Tab-delimited, w/header 


**Additional comments:** 
Detailed notes for each data file are provided here:

**AT2018fyk_RT.dat**
These are the results of blackbody fitting the UV/optical lightcurves. Data
    can be used to reproduce grey datapoints in Figure 2 (col1 and col5 for
    top panel, col1 and col7 for bottom panel) and Figure 3 (col3 and col7)
    in the accepted version of this manuscript.

	Col1: Modified Julian Date, JD-2,400,000.5
	Col2: phase with respect to the discovery epoch
	Col3: log(10) of the integrated luminosity, in units of erg/s
	Col4: uncertainty on col3
	Col5: Blackbody radius, in units of cm
	Col6: uncertainty on col5
	Col7: Blackbody temperature, in units of Kelvin
	Col8: uncertainty on col7


**AT2018fyk_UVOTlc.dat**
This contains the *Swift* UV/optical lightcurves at full time-resolution
    using 7.0" aperture. Host-subtracted but not corrected for Galactic
    extinction. Only including observations with SNR>0.5 and positive
    host-subtracted flux. This file is included for completeness.

	Col1: UVOT filter
	Col2: Modified Julian Date, JD-2,400,000.5
	Col3: host-subtracted AB magnitudes, not corrected for Galactic extinction in filter
	Col4: uncertainty in col3
	Col5: total counts/s as based on "CORR_RATE" from uvotsource and thus include the host contribution
	Col6: uncertainty in col5
	Col7: exposure


**AT2018fyk_binned_UVOTlc.dat**
This contains the *Swift* UV/optical lightcurves, with measurements taken
    within a day of each other binned together. Host subtracted and
    corrected for Galactic extinction.

	Col1: filter name
	Col2: Modified Julian Date, JD-2,400,000.5
	Col3: AB mag
	Col4: uncertainty on col3


**UVW1_lightcurve_alphaox.dat**
The *Swift* UVW1 lightcurve (green points in Figure 4 top left panel) that
    was used to compute the alpha-ox diagram in Figure 4 (top right panel).

	Col1: filter name
	Col2: Modified Julian Date, JD-2,400,000.5
	Col3: AB mag
	Col4: uncertainty on col3


**XMM_lc_0831790201_1500_10000_200.dat**
*XMM* lightcurve of observation with ID 0831790201 (XMM1 in the manuscript)
    in the 1.5-10 keV band. Figure 7 lower left panel can be reproduced by
    taking the data in this file (col2) and dividing it by the data in
    *XMM_lc_0831790201_300_10000_200.dat* (col2).

	Col1: XMM mission elapsed time, in seconds
	Col2: source count rate in the 1.5-10 keV band, in units of counts/second
	Col3: uncertainty on col2
	Col4: background count rate in the 1.5-10 keV band, in units of
	counts/second
	Col5: uncertainty on col4


**XMM_lc_0831790201_300_10000_200.dat**
*XMM* lightcurve of observation with ID 0831790201 (“XMM1” in the
    manuscript) in the **0.3-10 keV** band. Data (col2) corresponds to lower
    left panel of Figure 4.

	Col1: XMM mission elapsed time, in seconds
	Col2: source count rate in the 0.3-10 keV band, in units of counts/second
	Col3: uncertainty on col2
	Col4: background count rate in the 0.3-10 keV band, in units of
	counts/second
	Col5: uncertainty on col4


**XMM_lc_0831790201_300_1500_200.dat**
*XMM* lightcurve of observation with ID 0831790201 (“XMM1” in the
    manuscript) in the **0.3-1.5 keV** band.

	Col1: XMM mission elapsed time, in seconds
	Col2: source count rate in the 0.3-1.5 keV band, in units of counts/second
	Col3: uncertainty on col2
	Col4: background count rate in the 0.3-1.5 keV band, in units of
	counts/second
	Col5: uncertainty on col4


**XMM_lc_0853980201_1500_10000_200.dat**
Same as above, but for observation with ID 0853980201 (“XMM2” in the
    manuscript). Figure 7 lower right panel can be reproduced by taking the
    data in this file (col2) and dividing it by the data in
    *XMM_lc_0853980201_300_10000_200.dat* (col2).

**XMM_lc_0853980201_300_10000_200.dat**
Same as above, but for observation with ID 0853980201 (“XMM2” in the
    manuscript). Data (col2) corresponds to lower right panel of Figure 4.

**XMM_lc_0853980201_300_1500_200.dat**
Same as above, but for observation with ID 0853980201 (“XMM2” in the
    manuscript).

**XRT_lightcurve.dat**
The full *Swift* XRT lightcurves in 2 energy bands (0.3-1.5 and 1.5-10 keV).
    See also *XRT_lightcurve_alphaox.dat* for explanation. The difference
    with *XRT_lightcurve_alphaox.dat* is that this file contains all
    available datapoints, while the *XRT_lightcurve_alphaox.dat* file
    contains only datapoints with contemporaneous UVW1 *Swift* measurements.
    Figure 7 top panel can be reproduced as: col6 / (col6+col4)


**XRT_lightcurve_150_1000.dat**
These are the full output of the *Swift* XRT pipeline in the 1.5-10 keV
    band, and are provided for completeness. In principle everything one
    needs is in the *XRT_lightcurve.dat* and *XRT_lightcurve_alphaox.dat*
    files.

	Col1:  Observation id
	Col2:  XRT count rate (in the 1.5-10 keV band), in units of counts/second
	Col3:  uncertainty of col2
	Col4:  rate2
	Col5:  error on rate2
	Col6:  column
	Col7:  Modified Julian Date, JD-2,400,000.5
	Col8:  Swift mission elapsed time, in seconds
	Col9:  XRT exposure time
	Col10: column


**XRT_lightcurve_30_150.dat**
These are the full output of the Swift XRT pipeline in the 0.3-1.5 keV band,
    and are added for completeness. In principle everything one needs is in
    the *XRT_lightcurve.dat* and *XRT_lightcurve_alphaox.dat* files.

	Col1:  Observation id
	Col2:  XRT count rate (in the 0.3-1.5 keV band), in units of counts/second
	Col3:  error on rate1
	Col4:  rate2
	Col5:  error on rate2
	Col6:  column
	Col7:  Modified Julian Date, JD-2,400,000.5
	Col8:  Swift mission elapsed time, in seconds
	Col9:  XRT exposure time
	Col10: column


**XRT_lightcurve_alphaox.dat**
The *Swift* XRT lightcurves (black points in Figure 4 top left panel) in 2
    energy bands (0.3-1.5 and 1.5-10 keV). To reproduce Figure 4 top left
    panel, the count rates in both bands need to be summed per epoch, and
    then a conversion factor (determined based on the spectral state) should
    be applied to convert count rates to luminosities. To clarify: this is
    the exact counterpart of *UVW1_lightcurve_alphaox.dat*, but for
    *Swift*/XRT.

	Col1: Swift mission elapsed time, in seconds
	Col2: Modified Julian Date, JD-2,400,000.5
	Col3: XRT exposure time
	Col4: XRT count rate (in the 0.3-1.5 keV band), in units of counts/second
	Col5: uncertainty of col4
	Col6: XRT count rate (in the 1.5-10 keV band), in units of counts/second
	Col7: uncertainty of col6
                                            

**alphaox_fedd_lightcurve.dat**
Bolometrically corrected X-ray and UV luminosities, derived Eddington
    fractions, and alpha-ox as plotted in Figure 4 top right panel.

	Col1: Modified Julian Date, JD-2,400,000.5
	Col2: X-ray luminosity in the 0.03-10 keV band, in units of erg/s
	Col3: uncertainty on col2.
	Col4: Bolometrically corrected UV luminosity in the 0.03-3 micron band,
	in units of erg/s
	Col5: uncertainty on col4
	Col6: Bolometric Eddington fraction, in log10 units. Can be computed as:
	(col2+col4) / (L_Edd), where L_Edd = 1.28 * 10**38 * M_bh in units of
	erg/s and M_bh = 10**7.7 solar masses. It is plotted on the x-axis of
	Figures 4, 11.
	Col7: uncertainty on col6, in dex
	Col8: Alpha-ox parameter as plotted in Figure 4 top right panel.
	Col9: uncertainty on col8


**plfrac_40_200.dat**
X-ray power-law fraction of emission, in the 0.4-2 keV band. Plotted in
    Figure 6 left panel.

	Col1: Mission name
	Col2: phase with respect to discovery epoch
	Col3: power-law fraction of emission
	Col4: uncertainty of col3


**plfrac_bol.dat**
This file contains the power-law fraction of bolometric emission. This data
    corresponds to Figure 6 right panel. Col2 is also plotted on the y-axis
    of Figure 11.

	Col1: phase with respect to discovery epoch
	Col2: power-law fraction of bolometric emission (i.e. L_powerlaw /
	L_bol), in log10 units
	Col3: uncertainty on col2


================================================================================
