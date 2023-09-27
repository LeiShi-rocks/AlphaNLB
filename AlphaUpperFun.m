% mu: a matrix with dimension K x 2^K; 

function f = AlphaUpperFun(x, mu, p, SigmaUB, SigmaClever) 

% global mu p SigmaUB SigmaClever;
mux = mu;
SigmaUBx = SigmaUB;
SigmaCleverx = SigmaClever;

muind = sum(sum(isnan(mux)));

mux(isnan(mux)) = x(1:muind); 
SigmaUBx(isnan(SigmaUBx)) = x((muind+1):end);
SigmaCleverx(isnan(SigmaCleverx)) = x((muind+1):end);

Jmu = sum(p .* sum(mux, 2).^2) - sum(p .* sum(mux, 2)).^2; 
Dmu = sum(sum(p .* mux.^2)) - sum(sum(p .* mux, 2).^2); 

Js = sum(p .* sum(SigmaCleverx, 2).^2);
Ds = sum(p .* sum(SigmaUBx.^2, 2));

f = (Jmu + Js)/(Dmu + Ds);

end