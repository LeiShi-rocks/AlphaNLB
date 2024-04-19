% mu: a matrix with dimension K x 2^K; 

function f = AlphaLowerFun(x, mu, p, Js, Ds) 

% global mu p Js Ds;
mux = mu;
mux(isnan(mux)) = x;
Jmu = sum(p .* sum(mux, 2).^2) - sum(p .* sum(mux, 2)).^2;
Dmu = sum(sum(p .* mux.^2)) - sum(sum(p .* mux, 1).^2);
f = (Jmu + Js)/(Dmu + Ds);

end