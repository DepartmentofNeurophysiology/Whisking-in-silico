A network model of adaptive whisking. 


This function simulates whisking in rodents. This computational model provides a platform to adjust different parameters of whisking and explore their influence on whisker movements. Moreover, this simulator enables to explore between "adaptive" versus "uniform" whisking paradigms. In addition, user can explore the effect of "comliant" versus "reactive" retraction. 

A computational circuit that could perform adaptive sensorimotor control necessarily requires information from sensory circuits about the stimulus availability as well as motor control circuits that perform phase to motor signal transformation given the current state of the sensory information. In this model output of each node is a transfer function rather than a time and/or rate varying action potentials. Please note that the aim of this model is not to mechanistically explain how the brain performs sensorimotor computation, it is rather to provide the minimal circuit requirements for adaptive control of whisker position. For further explanation please refere to "Development of adaptive motor control for tactile navigation" by Azarfar et.al


How to Run the model
To run the model please select the whisking mode between 'adaptive' or 'uniform', and choose whether you want the model to run under 'reactive' or 'compliant' retraction. User can selcet to plot the results or not (0: do not plot, 1: plot).
Example 1:[tip_nose,waveform,nose_adapt] = whisking_in_silico('mode','adaptive','retraction','reactive','plotting',1)
Example 2: [tip_nose,waveform,nose_adapt] = whisking_in_silico('mode','uniform','retraction','compliant','plotting',1)


Settings
User can modify the whisking parameters in the "initialize" file. Two instance of locomotive path for adaptive vs non adaptive path is provided.

Out put: 
tip_dist: is the distance from the tip of whisker to the target platform
waveform: first column keeps the time, the second column keeps the angular position in relation to midline of whisker, the third and fourth columns contain the alpha of the fitted parabola and x position of the whisker's tip respectively, and finally the fifth column keeps the whisker's tip position in respect to animal's nose.
locomotive_path: is the locomotive path of animal twoards target. It is represented as the nose distance to the target.
