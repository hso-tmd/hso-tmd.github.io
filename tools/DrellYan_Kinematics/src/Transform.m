

V0 = 1;
Vx = 1;
Vy = 1;
Vz = 1;
J = 10;

Vp = 1/sqrt(2)*(V0+Vz);
Vm = 1/sqrt(2)*(V0-Vz);
Vmag = sqrt(Vx^2+Vy^2+Vz^2);
k = Vmag;%sqrt(1+(Vx/Vz)^2);
r = Vx/Vz;
a = sqrt(Vx^2+Vz^2);%sqrt(1+(Vy/(sqrt(Vz^2+Vx^2)^2)));
s = Vy/sqrt(Vz^2+Vx^2);
y = 1/2*log(J*abs((V0-sqrt(Vx^2+Vy^2+Vz^2))/(V0+sqrt(Vx^2+Vy^2+Vz^2))));

V_mu = [V0;
    Vx;
    Vy;
    Vz];

V_mu_lc = [Vp;
    Vm;
    Vx;
    Vy];

V_v = [2;
    0.5;
    -1;
    3];
V_v_lc = [1/sqrt(2)*(V_v(1,1)+V_v(4,1)); 
    1/sqrt(2)*(V_v(1,1)-V_v(4,1)); 
    V_v(2,1); 
    V_v(3,1)];

L_lc = [exp(y)*(k+Vz)/(2*k) exp(y)*(k-Vz)/(2*k) exp(y)*(Vx)/(k*sqrt(2)) exp(y)*(Vy)/(k*sqrt(2));
    exp(-y)*(k-Vz)/(2*k) exp(-y)*(k+Vz)/(2*k) -exp(-y)*(Vx)/(k*sqrt(2)) -exp(-y)*(Vy)/(k*sqrt(2));
    -Vx/(a*sqrt(2)) Vx/(a*sqrt(2)) Vz/a 0;
    -Vy*Vz/(sqrt(2)*a*k) Vy*Vz/(sqrt(2)*a*k) -Vx*Vy/(a*k) a/k];

V_mu_lc_p = L_lc*V_mu_lc;
V_mu_lc_p(3,1) = round(V_mu_lc_p(3,1),0);
V_mu_lc_p(4,1) = round(V_mu_lc_p(4,1),0);
V_v_lc_p = L_lc*V_v_lc;

angle = 2*pi - atan(V_v_lc_p(4,1)/V_v_lc_p(3,1));
R_f = [1 0 0 0;
    0 1 0 0;
    0 0 cos(angle) -sin(angle)
    0 0 sin(angle) cos(angle)];
V_mu_ref = R_f*V_mu_lc_p;
V_v_ref = R_f*V_v_lc_p;

point1 = [Vx,Vy,Vz];
point2 = [V_mu_lc_p(3,1),V_mu_lc_p(4,1),1/sqrt(2)*(V_mu_lc_p(1,1)-V_mu_lc_p(2,1))];
point3 = [V_v(2,1) V_v(3,1) V_v(4,1)];
point4 = [V_v_lc_p(3,1),V_v_lc_p(4,1),1/sqrt(2)*(V_v_lc_p(1,1)-V_v_lc_p(2,1))];
point5 = [V_mu_ref(3,1),V_mu_ref(4,1),1/sqrt(2)*(V_mu_ref(1,1)-V_mu_ref(2,1))];
point6 = [V_v_ref(3,1),V_v_ref(4,1),1/sqrt(2)*(V_v_ref(1,1)-V_v_ref(2,1))];
origin = [0,0,0];
figure;hold on;
plot3([origin(1) point1(1)],[origin(2) point1(2)],[origin(3) point1(3)],'r-^', 'LineWidth',1);
%plot3([origin(1) point2(1)],[origin(2) point2(2)],[origin(3) point2(3)],'g-^', 'LineWidth',2);
plot3([origin(1) point3(1)],[origin(2) point3(2)],[origin(3) point3(3)],'b-^', 'LineWidth',1);
%plot3([origin(1) point4(1)],[origin(2) point4(2)],[origin(3) point4(3)],'k-^', 'LineWidth',2);
plot3([origin(1) point5(1)],[origin(2) point5(2)],[origin(3) point5(3)],'c-^', 'LineWidth',2);
plot3([origin(1) point6(1)],[origin(2) point6(2)],[origin(3) point6(3)],'m-^', 'LineWidth',2);
points=[origin' point5' point6']; % using the data given in the question
fill3(points(1,:),points(2,:),points(3,:),'r')
grid on
alpha(0.3)
grid on;
xlabel('X axis'), ylabel('Y axis'), zlabel('Z axis')
set(gca,'CameraPosition',[1 2 3 4]);