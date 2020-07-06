clear all
clc
%{

All masses are in solar mass units, time is in years, and distance is in AU
%}
G=43.410; % GM in units of AU and years
% Star A
r1=0.9*9.582/2;
m(1)=1.100;
x(1,1)=-r1;
y(1,1)=0;
vx(1,1)=0;
vy(1,1)=-0.9*2.85868/2;
% Star B
r2=1.1*9.582/2;
m(2)=0.900;
x(2,1)=r2;
y(2,1)=0;
vx(2,1)=0;
vy(2,1)=1.1*2.85868/2;

% Planet A (Close orbit around star A)
r3=r1+1;
m(3)=1E-5;
x(3,1)=-1*r3;
y(3,1)=0;
vx(3,1)=0;
vy(3,1)=-1.2*(sqrt(G/(r3-r1)));
% Planet B (Close orbit around star B)
r4=r2+1;
m(4)=1E-5;
x(4,1)=r4;
y(4,1)=0;
vx(4,1)=0;
vy(4,1)=1.2*(sqrt(G/(r4-r2)));
% Planet C (Far orbit)
r5=30;
m(5)=1E-5;
x(5,1)=r5;
y(5,1)=0;
vx(5,1)=0;
vy(5,1)=1.39*(sqrt(G/r5));

dt=0.1;
for i=1:10000 % 1000=1000 years
    for j=1:5 % j is the object being checked
        ax(j,i)=0; % creates a new position in the ax, ay arrays
        ay(j,i)=0;
        for k=1:5
            if j~=k % IF j does not equal k
                r(j,k,i)=sqrt((x(k,i)-x(j,i))^2+(y(k,i)-y(j,i))^2); % finds linear distance 'r' between objects j and k
                ax(j,i)=G*m(k)*(x(k,i)-x(j,i))/r(j,k,i)^3+ax(j,i); % this sums all the x forces of all the objects on object j
                ay(j,i)=G*m(k)*(y(k,i)-y(j,i))/r(j,k,i)^3+ay(j,i); % this sums all the y forces of all the objects on object j
            end
        end
        % update the velocities of all objects
        vx(j,i+1)=vx(j,i)+ax(j,i)*dt;
        vy(j,i+1)=vy(j,i)+ay(j,i)*dt;
        % update the positions of all objects
        x(j,i+1)=x(j,i)+vx(j,i+1)*dt;
        y(j,i+1)=y(j,i)+vy(j,i+1)*dt;
    end
    % un-comment the plot command below to show the objects in motion, this
    % will run slow but looks neat.
    %
    if i<180
        plot (x(1,i),y(1,i),'O', x(2,i),y(2,i),'O', x(3,i),y(3,i),'O', x(4,i),y(4,i),'O', x(5,i),y(5,i),'O')
        legend('Star A','Star B','Planet A','Planet B','Planet C')
        axis equal
        axis ([-60 60 -60 60])
        title('Binary Motion with 3 Planets')
        xlabel('Distance in AU')
        ylabel('Distance in AU')
        pause (.00001)
    end
    %}
end
plot (x(1,:),y(1,:), x(2,:),y(2,:), x(3,:),y(3,:), x(4,:),y(4,:), x(5,:),y(5,:))
legend('Star A','Star B','Planet A','Planet B','Planet C')
axis equal
axis ([-60 60 -60 60])
title('Binary Motion with 3 Planets')
xlabel('Distance in AU')
ylabel('Distance in AU')