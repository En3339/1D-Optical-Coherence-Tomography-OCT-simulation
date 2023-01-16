zs = 200e-6 + rand(1,3)*10^(-4);%or you could use the function rand()
%zs=200e-6;
%It's a vector of a mirror with distance
%Then specify the position of the reference mirror:

zr = 0;
E0=1
%Then, for each mirror, you need to calculate the complex amplitude at the detector, of the field reflected by that mirror.

kvec = linspace( 2*pi/(1300e-9+150e-9), 2*pi/(1300e-9-150e-9), 2048);%vector of wave numbers
Esc = zeros(size(kvec));%scattered field
Er = zeros(size(kvec));%reference field

for ik=1:numel(kvec)    
        Esc(ik) = E0/sqrt(2)*sum(exp(-1i* kvec(ik) * 2 * zs));
end

for ik=1:numel(kvec)    
        Er(ik) = 10*E0/sqrt(2)*exp(-1i* kvec(ik) * zr);
end

       Ik = 1/2*abs((Esc+Er).^2); %spectral interferogram
       A = fft(Ik); %make sure you read the OCT book so that all of this is understandable

zbar = (0:(numel(A)-1))/numel(A)/diff(kvec(900:901)/2/pi)/2;
plot(zbar,abs(A))