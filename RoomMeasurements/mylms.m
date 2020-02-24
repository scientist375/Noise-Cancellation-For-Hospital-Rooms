%Step 2 - Writing an adaptive filter

function [dhat,e,w] = mylms(x,d,w0)
    dhat = zeros(size(d));
    e = zeros(size(x));
    w = w0;
    m = length(w0);
    epsilon = 1e-9;
    beta = 0.5;
    
    for k = m:length(x)
       xx = x(k:-1:k-m+1);
       dhat(k) = w'*xx;
       mu = (beta/((norm(xx))^2) + epsilon);
       e(k) = d(k) - dhat(k);
       w = w + mu*e(k)*xx;
    end
end
