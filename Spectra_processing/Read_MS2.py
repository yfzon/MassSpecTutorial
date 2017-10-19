# -*- coding: utf-8 -*-
"""
Created on Sun Oct  8 12:28:44 2017

@author: yfzon
"""
from pyteomics import mgf
#process spectrum
reader=mgf.read('MS2\MS170981-GX-1.mgf')
spectra=[]
for spectrum in reader:
    spectra.append(spectrum)
print(spectrum)
print(spectrum['charge array'][0])

#extract target isotope area 



#calculate ratio





