// Параметры дискретизации
step = 0.1;

// Параметры рассматривемого объекта
n = 4;
T0 = 1.07;

// Измеренные в первом задании критические значения
Tcr = 6.787;
Kcr = 1.97;

// Настроенные в первом задании оптимальные параметры
K = 0.6 * Kcr - 0.25;
Ti = Tcr / 2 + 0.61;
Td = Ti / 4;
Ts = Td / 8;

// Построение переходной характеристики системы
s = poly(0, 's');
W0 = 1 / (1 + T0 * s)^n; // Переходная характеристика рассматриваемого объекта
W1 = (1 + 1 / (Ti * s) + (Td * s) / (Ts * s + 1)) * W0 * K; // Переходная характеристика звена без обратной связи
W = W1 / (1 + W1); // Переходная характеристика системы
b = 1.4195514 + 5.8607732 * s + 6.399165 * s^2; // Числитель W
a = 1.4195514 + 11.9586 * s + 33.260757 * s^2 + 45.153599 * s^3 + 35.121029 * s^4 + 11.731324 * s^5 + s^6; // Знаменатель W

// Вычисление матрицы A в форме Фробениуса. Она будет иметь размеры 6x6 потому что 6 - степень a(s)
A = [zeros(1, 5); eye(5, 5)];
ac = [1.4195514; 11.9586; 33.260757; 45.153599; 35.121029; 11.731324]; // Коэффициенты из a
A = [A, -ac];
I = eye(A);

// Дискретизация при шаге 1
sys = syslin('c', W);
sysd = dscr(sys, step);
Ad = sysd.A;
spec(Ad)
Hd = lyap(Ad, -I, 'd');
spec(Hd)
max(spec(Hd)) * step
