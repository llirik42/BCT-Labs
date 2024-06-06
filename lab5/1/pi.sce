// Параметры рассматривемого объекта
n = 4;
T0 = 1.07;

// Измеренные в первом задании критические значения
Tcr = 6.787;
Kcr = 1.97;

// Настроенные в первом задании оптимальные параметры
K = 0.45 * Kcr - 0.2;
Ti = Tcr / 1.2 - 0.7;

// Построение переходной характеристики системы
s = poly(0, 's');
W0 = 1 / (1 + T0 * s)^n; // Переходная характеристика рассматриваемого объекта
W1 = (1 + 1 / (Ti * s)) * W0 * K; // Переходная характеристика звена без обратной связи
W = W1 / (1 + W1); // Переходная характеристика системы
b = 0.105679 + 0.5237276 * s; // Числитель W
a = 0.105679 + 1.2866228 * s + 3.2651915 * s^2 + 5.2406324 * s^3 + 3.7383178 * s^4 + s^5; // Знаменатель W

// Вычисление матрицы A в форме Фробениуса. Она будет иметь размеры 5x5 потому что 5 - степень a(s)
A = [zeros(1, 4); eye(4, 4)];
ac = [0.105679; 1.2866228; 3.2651915; 5.2406324; 3.7383178]; // Коэффициенты из a
A = [A, -ac];

// Вычисление H, нахождение её спектра и запаса устойчивости
H = lyap(A, -eye(A), 'c');
spec(H)
k = max(spec(H));
k
