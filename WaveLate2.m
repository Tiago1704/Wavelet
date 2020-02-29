    [f,fs] = audioread ("01.DO 1.wav");
    J = 10;
    [c,info] = fwt(f,'db8',J);
    plotwavelets(c,info,fs,'dynrange',90);