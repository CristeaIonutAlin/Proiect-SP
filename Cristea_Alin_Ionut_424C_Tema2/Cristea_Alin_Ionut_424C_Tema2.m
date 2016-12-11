
T=40;                                                          % perioada semnalului x
D=4;                                                           % durata semnalului x_triunghi

w0=2*pi/T;                                                     % pulsatia semnalului x
timp_triunghi=0:0.02:D;                                        % vectorul timp pt bucata triunghiulara (rezolutia acestuia)
Semnal_triunghiular= sawtooth((pi/2)*timp_triunghi,0.5)/2+0.5; % generarea partii triunghiulare
t = 0:0.02:T;                                                  % vectorul de timp pe o perioada (este rezolutia perioadei)
x = zeros(1,length(t));                                        % initializarea vectorului x
x(t<=D)=Semnal_triunghiular;                                   % creearea semnalului pe o perioada prin suprapunere
figure(1);
plot(t,x);                                                     % afisarea semnalului x(t)
title('x(t)(linie continua) si reconstructia (linie punctata)');
hold on;


for k=-50:50
    x_t = Semnal_triunghiular;
    x_t = x_t .* exp(-j*k*w0*timp_triunghi);                   % vectorul ce trebuie integrat
    X(k+51)=0;                                                 % initializarea coeficientului Xk
    for i = 1: length(timp_triunghi)-1
        X(k+51) = X(k+51) + (timp_triunghi(i+1)-timp_triunghi(i))* (x_t(i)+x_t(i+1))/2; % integrare folosind metoda dreptunghiurilor
    end
end
    


for i = 1: length(t)
    x_reconstruit(i) = 0;                                            % initializarea elementelor vectorului reconstruit
    for k=-50:50
        x_reconstruit(i) = x_reconstruit(i) + (1/T)*X(k+51)*exp(j*k*w0*t(i)); % calcularea sumei
    end
end
plot(t,x_reconstruit,'--');                                          % afisarea semnalului reconstruit cu linie punctata pe acelasi grafic cu semnalul original

figure(2);
w=-50*w0:w0:50*w0;                                                   % generarea vectorului de pulsatii corespunzatoare coeficientilor Xk
stem(w/(2*pi),abs(X));                                               % afisarea spectrului
title('Spectrul de amplitudini al semnalului')


% Cele doua semnale , reconstrui si initial nu vor fi identice deoarece selectarea nr finit de coef. duce 
% la modificarea spectrului, il limite. Semnalele periodice pot fi descrise printr-o suma de cos si sin 
% inmultite cu coef. corespunzatori  Forma de unda a semanlului reconstrui va fi cu atat mai fidela fata
% de cea originala cu cat adaugam mai multi coeficienti in suma, totodata semnalul devine mai abrupt, timpul
% de crestere si descrestere este mai mic

