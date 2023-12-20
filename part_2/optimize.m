more off;
theroad = makeroad;                 %% keep this line at the top of your program.
roadlength = 1000;                  %% do NOT change this. The road is only defined for 1km       

m = 250;
knom = 6000*9.81;
bnom = 5370;
v = 15; % m/s
timetodrive1km =  (roadlength/1000) / (v/3600); % seconds
icz = 0;
iczdot = 0;
t = linspace(0,roadlength/v, length(theroad(:,1)));   
x = v*t;

vel = [15 30 45];
kval = [0.5*knom 0.75*knom knom 1.25*knom 1.5*knom];
bval = [0.5*bnom 0.75*bnom bnom 1.25*bnom 1.5*bnom];


% 5x5 arrays for v = 15 m/s
v = vel(1);
fivebyfive_fifteen_ext = zeros(5,5);
fivebyfive_fifteen_comp = zeros(5,5);
fivebyfive_fifteen_pacc = zeros(5,5);
fivebyfive_fifteen_nacc = zeros(5,5);
[fivebyfive_fifteen_ext, fivebyfive_fifteen_comp, fivebyfive_fifteen_pacc, fivebyfive_fifteen_nacc] = susToolsVerif(kval, bval, t, icz, iczdot, v, m, theroad);


% 5x5 arrays for v = 30 m/s
v = vel(2);
fivebyfive_thirty_ext = zeros(5,5);
fivebyfive_thirty_comp = zeros(5,5);
fivebyfive_thirty_pacc = zeros(5,5);
fivebyfive_thirty_nacc = zeros(5,5);
[fivebyfive_thirty_ext, fivebyfive_thirty_comp, fivebyfive_thirty_pacc, fivebyfive_thirty_nacc] = susToolsVerif(kval, bval, t, icz, iczdot, v, m, theroad);


% 5x5 arrays for v = 45 m/s
v = vel(3);
fivebyfive_fourtyfive_ext = zeros(5,5);
fivebyfive_fourtyfive_comp = zeros(5,5);
fivebyfive_fourtyfive_pacc = zeros(5,5);
fivebyfive_fourtyfive_nacc = zeros(5,5);
[fivebyfive_fourtyfive_ext, fivebyfive_fourtyfive_comp, fivebyfive_fourtyfive_pacc, fivebyfive_fourtyfive_nacc] = susToolsVerif(kval, bval, t, icz, iczdot, v, m, theroad);


function ret = y(theroad,x)
    ret = interp1(theroad(:,1),theroad(:,2),x);
end

function ret = dydx(theroad,x)
    ret = interp1(theroad(:,1),theroad(:,3),x);
end

function xdot = carrhs(t, z, v, m, b, k, yt, dydxt)
    xdot = [z(2); (b/m)*(dydxt-z(2))+(k/m)*(yt-z(1))];
end

function [ext_fivebyfive, comp_fivebyfive, pacc_fivebyfive, nacc_fivebyfive] = susToolsVerif(kval, bval, t, icz, iczdot, v, m, theroad)

    ext_fivebyfive = zeros(5,5);
    comp_fivebyfive = zeros(5,5);
    pacc_fivebyfive = zeros(5,5);
    nacc_fivebyfive = zeros(5,5);

    for i = 1:5
        for j = 1:5

            k = kval(i);
            b = bval(j);

            % run ode45
            [t z] = ode45(@(t,z)carrhs(t,z,v,m,b,k, y(theroad,v*t), v*dydx(theroad,v*t)),t, [icz iczdot]);
            
            % calculate max extension and compression
            ext = max(z(:,1));
            comp = min(z(:,1));

            % calculate accleration
            xdd = (b/m)*((dydx(theroad,v*t)*v)-z(:,2))+(k/m)*(y(theroad, v*t)-z(:,1));
            max_acc = max(xdd);
            min_acc = min(xdd);
            fprintf('Max spring extension: %d\n', ext);
            fprintf('Max spring compression: %d\n', comp);
            fprintf('Max positive acceleration of car body: %d\n', max_acc);
            fprintf('Min negative acceleration of car body: %d\n', min_acc);
            fprintf('k=%d\n', k);
            fprintf('b=%d\n', b);

            fprintf('\n')

            % save to each metric's 5x5 list for given speed
            ext_fivebyfive(j,i) = ext;
            comp_fivebyfive(j,i) = comp;
            pacc_fivebyfive(j,i) = max_acc;
            nacc_fivebyfive(j,i) = min_acc;

        end
    end
end