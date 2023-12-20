%% students: only change two things in this program:
%               1. For your submission, put your a 9-digit number inside rng()
%                   on line 10. This will create a unique road.
%               2. You can change the road quality with the sk0 variable.
%                   Uncomment the line for the road quality you want on
%                   lines 17-21.
%               3. Do NOT change anything else.

function roadprofile = makeroad()
    rng(902142549);     
    min = -2; max = 1;  % min and max wave numbers: bumps from 1cm to 10m
    N = 61;             % how many terms to include in road surface function
    roadlength = 1000;  % 1km track
    wavenos = logspace(min,max,N);
    phi = unifrnd(0,2*pi,1,N);      % individualized phase shifts

    %%% change sk0 to change quality of the road
    %sk0 = (2+8)/2/10^6;     % very good road
    %sk0 = (8+32)/2/10^6;    % good road
    %sk0 = (32+128)/2/10^6;  % average road
    sk0 = (128+512)/2/10^6; % poor road
    %sk0 = (512+2048)/2/10^6;% very poor road

    x = linspace(0,roadlength,ceil(roadlength*100+.9))';
    roadheight = roadfunction(sk0,wavenos,phi,x);
    roadslope = roadfunctionslope(sk0,wavenos,phi,x);
    roadprofile = [x roadheight roadslope];
end

function h = roadfunction(sk0,wavenos,phi,x)
    h = 0; k0 = 1/(2*pi); n1 = -3; n2 = -2.25;
    coef1 = sqrt(2*pi/(length(wavenos)));
    for n=1:length(wavenos)
        wn = wavenos(n);
        coef2 = sqrt(sk0*(wn/k0)^n1*(wn<=k0) + sk0*(wn/k0)^n2*(wn>k0));
        h = h + coef1*coef2*cos(2*pi*wn*x+phi(n));
    end 
    m = (h(length(x))-h(1))/x(length(x)-x(1));
    line = m*x + h(1);
    h = h - line;
end

function dhdx = roadfunctionslope(sk0,wavenos,phi,x)
    dhdx = 0; k0 = 1/(2*pi); n1 = -3; n2 = -2.25;
    coef1 = sqrt(2*pi/(length(wavenos)));
    for n=1:length(wavenos)
        wn = wavenos(n);
        coef2 = sqrt(sk0*(wn/k0)^n1*(wn<=k0) + sk0*(wn/k0)^n2*(wn>k0));
        dhdx = dhdx - 2*pi*wn*coef1*coef2*sin(2*pi*wn*x+phi(n));
    end
end
