function y = phiprimeover2x(x,phi,s)

if (phi==0), % Quadratique
	% pour phi = x^2, 
	% phi_prime = 2*x 
	% phi_prime_over_2x = 1;
	y = ones(size(x));
end

if (phi==1), % Strictement convexe
	% pour phi = sqrt( s^2 + x^2), 
	% phi_prime = x/sqrt( s^2 + x^2), 
	% phi_prime_over_2x = 1/sqrt( s^2 + x^2)/2 
	y = 1/2./sqrt(s^2 + x.^2);
end

if (phi==-1), % Convexe
	% pour phi = |x|, 
	% phi_prime = sign(x), 
	% phi_prime_over_2x = 1/2/x 
	y = 1/2./abs(x);
end

if (phi==2), % Non convexe
	% pour phi = x^2/( s^2 + x^2), 
	% phi_prime = 2xs^2/( s^2 + x^2)^2, 
	% phi_prime_over_2x = s^2/( s^2 + x^2)^2 
	%s = .1;
	y = s^2./(s^2 + x.^2).^2;
end

if sum(isnan(y))>0
%    keyboard;
end