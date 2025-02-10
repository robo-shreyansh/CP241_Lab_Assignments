%RK4 Method
function [t, x] = LA1_RK4(f, tspan, h, x0)
    t = [tspan(1):h:tspan(2)];
    max_samples = length(t);
    x = x0;
    for i = 1:max_samples-1
        k1 = h*f(t(i), x(:,i));
        k2 = h*f(t(i)+h/2, x(:,i)+k1/2);
        k3 = h*f(t(i)+h/2, x(:,i)+k2/2);
        k4 = h*f(t(i), x(:,i)+k3/3);
        x(:,i+1) = x(:,i) + (k1+2*k2+2*k3+k4)*(1/6);
    end
end
