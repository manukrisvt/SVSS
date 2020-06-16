# Order Magnitudes of Chirp with Four Orders


Create a simulated signal sampled at 600 Hz for 5 seconds. The system that is being tested increases its rotational speed from 10 to 40 revolutions per second (or, equivalently, from 600 to 2400 revolutions per minute) during the observation period.




Generate the tachometer readings.



```matlab:Code
fs = 600;
t1 = 5;
t = 0:1/fs:t1;

f0 = 10;
f1 = 40;
rpm = 60*linspace(f0,f1,length(t));
```



The signal consists of four harmonically related chirps with orders 1, 0.5, 4, and 6. The amplitudes of the chirps are 1, 1/2, 2, and 2, respectively. To generate the chirps, use the trapezoidal rule to express the phase as the integral of the rotational speed.



```matlab:Code
o1 = 1;
o2 = 0.5;
o3 = 4;
o4 = 6;

a1 = 1;
a2 = 0.5;
a3 = sqrt(2);
a4 = 2;

ph = 2*pi*cumtrapz(rpm/60)/fs;
ph2=2*pi*(rpm/60);
x = [a1 a2 a3 a4]*cos([o1 o2 o3 o4]'*ph);
x2=[a1 a2 a3 a4]*cos([o1 o2 o3 o4]'*ph2);
```



Extract and visualize the magnitudes of the orders.



```matlab:Code
ordertrack(x,fs,rpm,[o1 o2 o3 o4])
```


![figure_0.eps](latexchk_images/figure_0.eps)

  


*Copyright 2012 The MathWorks, Inc.*


