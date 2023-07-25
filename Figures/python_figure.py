# Found at:
#  enicskb/wiki/index.php/
#       Python_-_Making_Article-Quality_Plots
# Here is an example how to plot something 
#    with Matplotlib using Python. 
# This example has two y-axes for two plots.

import numpy as np
import matplotlib.pyplot as plt
import  get_spice_plot_data as gspd

argNames = # Array with the names of my plots
argVecs = # Array with my data 
          # (argVecs[0] is the x-axis, 
          # argVecs[1..n] are the values of n plots)
 

params = {'legend.fontsize': '12',
          'figure.figsize': (7.5, 6.0),
         'axes.labelsize': '15',
         'axes.titlesize':'14',
         'lines.linewidth':'2',
         'xtick.labelsize':'12',
         'ytick.labelsize':'12'}
plt.rcParams.update(params)


fig, ax1 = plt.subplots()
ax1.plot(argVecs[0], argVecs[1], linestyle='-', 
                label="Error msb (out of 19)")
ax1.set_xlabel('Wave Period violation %')
ax1.set_ylabel('Error msb', color='b')
ax1.tick_params('y', colors='b')
ax1.legend(loc=(0.2,0.6))

ax2 = ax1.twinx()
ax2.plot(argVecs[0], argVecs[2], 'r-' , 
                    label="% of error calculations")
ax2.set_ylabel('% of Error calculations', color='r')
ax2.tick_params('y', colors='r')
ax2.legend(loc=(0.2,0.5))

ax1.grid(True, lw = 0.5, ls = '--', c = '.75')

fig.tight_layout()
plt.savefig("plot_wave_period.pdf")
plt.show()